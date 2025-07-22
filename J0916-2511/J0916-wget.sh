#! /bin/sh
cat <<EOF
************************************************
*
*    Date: Tue Jul 22 12:58:26 PDT 2025
*
*    Download SPHEREx from IRSA
*
************************************************

EOF
    download_file() {

      href="$1"
      targetDir="$2"
      baseFileName="$3"
      suffix="$4"

      startDir=$(pwd)

      # create temp dir
      tmpDir=$(mktemp -d)
      cd "$tmpDir" || return 1

      echo ">> downloading ${href} ..."
      cmd="wget --content-disposition"
      $cmd "$href" || {
        echo ">> ERROR: failed to download ${href}"
        cd "$startDir"
        rm -rf "$tmpDir"
        return 1
      }

      # get most recently modified file
      downloadedFile=$(ls -t | head -n 1)

      # determine filename
      if [ -n "$baseFileName" ]; then
        ext="${baseFileName##*.}"
        name="${baseFileName%.*}"
      else
        ext="${downloadedFile##*.}"
        name="${downloadedFile%.*}"
      fi

      # Apply suffix, if available
      finalName="$name"
      [ -n "$suffix" ] && finalName="${finalName}-$suffix"
      finalFile="${finalName}.${ext}"

      # create target dir in current directory
      if [ -n "$targetDir" ]; then
        destDir="$startDir/$targetDir"
      else
        destDir="$startDir"
      fi
      mkdir -p "$destDir"

      # resolve naming conflicts
      destPath="$destDir/$finalFile"
      count=1
      while [ -e "$destPath" ]; do
        destPath="$destDir/${finalName} (${count}).${ext}"
        count=$((count + 1))
      done

      # move file to main directory and cleanup
      mv "$downloadedFile" "$destPath"
      echo ">> Saved as $destPath"

      cd "$startDir"
      rm -rf "$tmpDir"
    }

download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/2/level2_2025W18_2B_0217_3D2_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/2/level2_2025W18_2B_0217_4D2_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/3/level2_2025W18_2B_0298_1D3_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/6/level2_2025W18_2B_0298_1D6_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/2/level2_2025W18_2B_0420_1D2_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/5/level2_2025W18_2B_0420_1D5_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/2/level2_2025W18_2B_0420_2D2_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/5/level2_2025W18_2B_0420_2D5_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/2/level2_2025W18_2B_0420_3D2_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/5/level2_2025W18_2B_0420_3D5_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/2/level2_2025W18_2B_0420_4D2_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W18_2B/l2b-v12-2025-164/5/level2_2025W18_2B_0420_4D5_spx_l2b-v12-2025-164.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/6/level2_2025W19_2B_0339_1D6_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/3/level2_2025W19_2B_0339_1D3_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/6/level2_2025W19_2B_0339_2D6_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/3/level2_2025W19_2B_0339_2D3_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/6/level2_2025W19_2B_0339_3D6_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/3/level2_2025W19_2B_0339_3D3_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/3/level2_2025W19_2B_0339_4D3_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/4/level2_2025W19_2B_0402_1D4_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/1/level2_2025W19_2B_0402_1D1_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/1/level2_2025W19_2B_0402_2D1_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W19_2B/l2b-v11-2025-163/4/level2_2025W19_2B_0402_2D4_spx_l2b-v11-2025-163.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/4/level2_2025W20_1C_0117_3D4_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/1/level2_2025W20_1C_0117_3D1_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/4/level2_2025W20_1C_0117_4D4_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/1/level2_2025W20_1C_0117_4D1_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/1/level2_2025W20_1C_0161_1D1_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/4/level2_2025W20_1C_0161_1D4_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/4/level2_2025W20_1C_0161_2D4_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/1/level2_2025W20_1C_0161_2D1_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/4/level2_2025W20_1C_0161_3D4_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/1/level2_2025W20_1C_0161_3D1_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/4/level2_2025W20_1C_0161_4D4_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/1/level2_2025W20_1C_0161_4D1_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/5/level2_2025W20_1C_0192_1D5_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_1C/l2b-v12-2025-175/2/level2_2025W20_1C_0192_1D2_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/3/level2_2025W20_2D_0203_1D3_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/3/level2_2025W20_2D_0203_2D3_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/3/level2_2025W20_2D_0203_3D3_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-176/6/level2_2025W20_2D_0203_3D6_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/3/level2_2025W20_2D_0203_4D3_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/4/level2_2025W20_2D_0437_1D4_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/1/level2_2025W20_2D_0437_1D1_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/1/level2_2025W20_2D_0437_2D1_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/4/level2_2025W20_2D_0437_2D4_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/4/level2_2025W20_2D_0437_3D4_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/1/level2_2025W20_2D_0437_3D1_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/4/level2_2025W20_2D_0437_4D4_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W20_2D/l2b-v12-2025-175/1/level2_2025W20_2D_0437_4D1_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_1B/l2b-v12-2025-175/2/level2_2025W21_1B_0307_1D2_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_1B/l2b-v12-2025-176/5/level2_2025W21_1B_0307_1D5_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_1B/l2b-v12-2025-175/2/level2_2025W21_1B_0307_2D2_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_1B/l2b-v12-2025-176/5/level2_2025W21_1B_0307_2D5_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_1B/l2b-v12-2025-176/5/level2_2025W21_1B_0307_3D5_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_1B/l2b-v12-2025-175/2/level2_2025W21_1B_0307_3D2_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_1B/l2b-v12-2025-175/2/level2_2025W21_1B_0307_4D2_spx_l2b-v12-2025-175.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/5/level2_2025W21_2C_0223_3D5_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/2/level2_2025W21_2C_0223_3D2_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/5/level2_2025W21_2C_0223_4D5_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/2/level2_2025W21_2C_0223_4D2_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/1/level2_2025W21_2C_0517_1D1_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/4/level2_2025W21_2C_0517_1D4_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/1/level2_2025W21_2C_0517_2D1_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/4/level2_2025W21_2C_0517_2D4_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/4/level2_2025W21_2C_0517_3D4_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/1/level2_2025W21_2C_0517_3D1_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/4/level2_2025W21_2C_0517_4D4_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W21_2C/l2b-v12-2025-176/1/level2_2025W21_2C_0517_4D1_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W22_2B/l2b-v12-2025-177/4/level2_2025W22_2B_0594_1D4_spx_l2b-v12-2025-177.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W22_2B/l2b-v12-2025-176/1/level2_2025W22_2B_0594_1D1_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W22_2B/l2b-v12-2025-176/1/level2_2025W22_2B_0594_2D1_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W22_2B/l2b-v12-2025-177/4/level2_2025W22_2B_0594_2D4_spx_l2b-v12-2025-177.fits' '' '' 'cutout'
download_file 'https://irsa.ipac.caltech.edu/ibe/cutout?ra=139.23200000000003&dec=-25.196052777777776&size=0.01&path=spherex/qr/level2/2025W22_2B/l2b-v12-2025-176/1/level2_2025W22_2B_0594_3D1_spx_l2b-v12-2025-176.fits' '' '' 'cutout'
