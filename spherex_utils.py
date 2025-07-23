import numpy as np
import matplotlib.pyplot as plt
from astropy.io import fits
from scipy.interpolate import RegularGridInterpolator
import astropy.units as u
import glob

def extract_spherex(directory, mask2 = None, cr_thresh=10.0):
    """
    Extract spectrophotometry from a directory full of SPHEREx quick release cutouts
    
    Args:
        directory (str):
            Directory where cutouts are stored.
        mask2 (`numpy.ndarray`_):
            Boolean mask for pixels where another object lives. Experimental
        cr_thresh (float):
            Cutoff in extracted flux (MJy/sr) above which the exposure is tossed out.
            
    Returns:
        wave (`numpy.ndarray`_):
            Central wavelengths in microns
        flux (`numpy.ndarray`_):
            Extracted flux in MJy/sr
        dwave (`numpy.ndarray`_):
            FWHM of the corresponding bandpass, in microns
        var (`numpy.ndarray`_):
            Variance of the extracted flux, in (MJy/sr)**2
    
    """

    # Ensure there is a trailing / in the directory string
    if directory[-1] != "/"
        directory = directory + "/"

    # Grab the file names and initiate arrays
    files = glob.glob(directory+"level2*cutout.fits")
    flux = np.zeros(len(files))
    wave = np.zeros(len(files))
    dwave = np.zeros(len(files))
    if mask2 is not None:
        flux2 = np.zeros(len(files))
    var = np.zeros(len(files))

    good = np.ones(len(files),dtype=bool)

    for ii in range(len(files)):
        hdul = fits.open(files[ii])
        img = hdul[1].data
        # For now, we only use images where the object is more than 3 pixels away from any edge
        if len(img.flatten()) == 36:
        
            # Object extraction mask, central 2x2 pixels of cutout
            # definitely suboptimal (PSF FWHM can be <1 pixel)
            # but should capture most of the light even at the long wavelength end
            mask = np.zeros_like(img,dtype=bool)
            mask[2:4,2:4] = True
            mask[np.isnan(img)] = False # remove phantom pixels

            # Sky mask is everything else
            sky = ~mask
            if mask2 is not None: # In case there is a second contaminating object
                sky = sky & ~mask2
            sky[np.isnan(sky)] = False # remove phantom pixels
            
            # "Aperture photometry"
            # Sum the flux inside the object mask, remove the median sky times the number of object pixels
            flux[ii] = np.sum(img[mask])-np.median(img[sky])*(np.sum(mask))
            if mask2 is not None:
                flux2[ii] = np.sum(img[mask2])-np.median(img[sky])*(np.sum(mask2))
                
            # Determine wavelength at center of cutout
            # Wavelength map is provided as a 2D interpolation map
            wx = hdul[2].data['X'][0]
            wy = hdul[2].data['Y'][0]
            wval = hdul[2].data['VALUES'][0][:,:,0]
            dwval = hdul[2].data['VALUES'][0][:,:,1]
            interp_wave = RegularGridInterpolator((wx,wy),wval)
            interp_dwave = RegularGridInterpolator((wx,wy),dwval)
            wave[ii] = interp_wave((3-hdul[1].header['CRPIX2W'],3-hdul[1].header['CRPIX1W']))
            dwave[ii] = interp_dwave((3-hdul[1].header['CRPIX2W'],3-hdul[1].header['CRPIX1W']))
            
            # Extremely rough estimate of the variance (full images have a proper variance map, but not cutouts...)
            # First remove the highest and lowest pixels from the sky (sort of like outlier masking)
            skymask = sky & (img > img[sky].min()) & (img < img[sky].max())
            # Variance of each pixel is first approximated by variance of sky pixels
            var[ii] = np.sum(mask)*np.var(img[skymask])
            # Now we adjust the variance higher assuming that variance is proportional to flux
            # but we only include the pixels above the sky background to avoid decreasing it
            posmask = img[mask] > np.median(img[sky])
            var[ii] *= 1+np.sum(((img[mask]-np.median(img[sky]))/np.median(img[sky]))[posmask])
            
        else:
            good[ii] = False
    
    # Remove any fluxes that are "bad" for some reason.
    # Default value of cr_thresh is good for faint high-z objects
    # Set it to a higher value if your object is super bright
    good = good & (~np.isnan(flux)) & (~np.isnan(wave)) & (np.abs(flux) < cr_thresh)
    
    print(str(np.sum(good)) + " out of " + str(len(files)) + " exposures are good.")
    
    wave = wave[good]
    dwave = dwave[good]
    flux = flux[good]
    var = var[good]

    if mask2 is None:
        return wave, dwave, flux, var
    else:
        flux2 = flux2[good]
        return wave, dwave, flux, var, flux2

def get_flam(wave,flux,omega_pix=37.932): # convert MJy/sr to flam in cgs
    nu = 2.998e8/(wave*1e-6)
    flam = flux*(1e6*1e-23)*(nu/(wave*1e4))/(u.sr.to(u.arcsec*u.arcsec))*omega_pix
    return flam
    
def get_fnu_from_flam(wave,flam): # return fnu in mJy
    nu = 2.998e8/(wave*1e-6)
    fnu = flam*((wave*1e4)/nu)
    return 1000*fnu*1e23
    
def rebin_spherex(wave,flam,std,dwave,tol=0.1): # very basic binning scheme
    sort = np.argsort(wave)
    wave = wave[sort]
    flam = flam[sort]
    std = std[sort]
    dwave = dwave[sort]
    used = np.zeros_like(wave)
    ii = 0
    wave_bin = []
    flam_bin = []
    std_bin = []
    dwave_bin = []
    while ii < len(wave):
        close = (np.abs(wave-wave[ii])<tol*dwave[ii]) & (used == 0)
        wave_bin.append(np.mean(wave[close]))
        flam_bin.append(np.mean(flam[close]))
        std_bin.append(np.sqrt(np.sum(std[close]**2)/np.sum(close)**2))
        dwave_bin.append(np.max(wave[close]+0.5*dwave[close])-np.min(wave[close]-0.5*dwave[close]))
        used[close] = 1
        ii = np.arange(len(wave))[close][-1]+1

    return np.array(wave_bin), np.array(flam_bin), np.array(std_bin), np.array(dwave_bin)


line_list = [6564.6,5008.2,4862.7,2800.0,1908.7,1550.0,1215.67]

def plot_spherex_flam(wave,flam,std,dwave,zqso=None,label=None,wave_old=None,flam_old=None,flam2=None):
    fig,ax = plt.subplots(1,1,figsize=(9,5))
    plt.errorbar(wave,flam,c='k',fmt='o',xerr=0.5*dwave,yerr=std,label=label,ms=3.5)
    if flam2 is not None:
        plt.errorbar(wave,flam2,c='r',fmt='x',xerr=0.5*dwave,label='other',ms=4)
    if flam_old is not None:
        plt.plot(wave_old,flam_old,c='k',lw=0.15,alpha=0.15)
    plt.axhline(0.0,c='darkorange',lw=0.5,linestyle='dashed')
    plt.legend(fontsize=16)
    plt.ylim(-0.2*flam.max(),1.2*flam.max())
    plt.xlim(0.65,5.05)
    if zqso is not None:
        for line in line_list:
            plt.axvline(line*(1+zqso)*1e-4,c='k',linestyle='dotted')
    plt.ylabel('Flam [cgs]',fontsize=18)
    plt.xlabel('Wavelength [um]',fontsize=18)
    plt.tick_params(which='both',top=True,right=True,direction='in',labelsize=13)
    plt.minorticks_on()
    plt.tight_layout()
    plt.show()

def plot_spherex_fnu(wave,fnu,std,dwave,zqso=None,label=None,wave_old=None,fnu_old=None,fnu2=None):
    fig,ax = plt.subplots(1,1,figsize=(9,5))
    plt.errorbar(wave,fnu,c='k',fmt='o',xerr=0.5*dwave,yerr=std,label=label,ms=3.5)
    if fnu2 is not None:
        plt.errorbar(wave,fnu2,c='r',fmt='x',xerr=0.5*dwave,label='other',ms=4)
    if fnu_old is not None:
        plt.plot(wave_old,fnu_old,c='k',lw=0.15,alpha=0.15)
    plt.axhline(0.0,c='darkorange',lw=0.5,linestyle='dashed')
    plt.legend(fontsize=16,loc='upper left')
    plt.ylim(-0.2*fnu.max(),1.2*fnu.max())
    plt.xlim(0.65,5.05)
    if zqso is not None:
        for line in line_list:
            plt.axvline(line*(1+zqso)*1e-4,c='k',linestyle='dotted')
    plt.ylabel('Fnu [mJy]',fontsize=18)
    plt.xlabel('Wavelength [um]',fontsize=18)
    plt.tick_params(which='both',top=True,right=True,direction='in',labelsize=13)
    plt.minorticks_on()
    plt.tight_layout()
    plt.show()
