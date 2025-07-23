from spherex_utils import *

# Example script demonstrating usage of spherex_utils

directory = 'J0916-2511/'
wave, dwave, flux, var = extract_spherex(directory)
flam = get_flam(wave,flux)
std = get_flam(wave,np.sqrt(var))

# Existing spectrum of the object
# Wavelength converted to microns, flam converted to cgs
xsp = np.loadtxt('J091656-251146_stitched.txt')
wave_old = xsp[:,0]/1e4
flam_old = xsp[:,1]*1e-16

# Plotting scripts
# Only wave, flam, std, and dwave are required inputs, the rest are optional
zqso = 4.85
label = 'J0916-2511, z=4.85'
plot_spherex_flam(wave,flam,std,dwave,zqso=zqso,label=label,wave_old=wave_old,flam_old=flam_old)

fnu = get_fnu_from_flam(wave,flam)
std_fnu = get_fnu_from_flam(wave,std)
fnu_old = get_fnu_from_flam(wave_old,flam_old)
plot_spherex_fnu(wave,fnu,std_fnu,dwave,zqso=zqso,label=label,wave_old=wave_old,fnu_old=fnu_old)

