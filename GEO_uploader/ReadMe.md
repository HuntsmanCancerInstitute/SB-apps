# GEO upload 

An extremely simple tool for uploading files directly from SB to GEO. Useful when files 
are archived on SB. 

## Build Docker image

On your local machine, you need Docker installed and running.

- Log in to Seven Bridges Docker images

	You will need your SB Developer token for your current lab division. Note that 
	your login name is `<division>/<username>`. 
	
		$ docker login -u username images.sbgenomics.com

- Build the image

	You will need the `Dockerfile` downloaded from here and stored in a folder; you will 
	need the path to this folder. Make sure Docker is running on your current machine. 
	Substitute `<division>/<username>` with your parameters. This should go fairly quickly. 
	
		$ docker build -t images.sbgenomics.com/<division>/<username>/geo_uploader:1 path/to/GEO_uploader
	
	If you're curious, you can run the image to check things.
		
		$ docker run -ti images.sbgenomics.com/<division>/<username>/geo_uploader:1 
		root@b1296410a011:/# which ncftp
		/usr/bin/ncftp
		root@b1296410a011:/# exit
	
- Commit the image
	
	Just like with Git, you need to first commit the changes locally before pushing 
	them to the repository, in this case the SB images repository. However, you need 
	the docker image ID. It should be the machine name in the prompt as you watched 
	the docker image build or run. You can also check the recent images; the most 
	recent image is usually the one you want.
	
		$ docker ps -a
		CONTAINER ID        IMAGE                                          COMMAND             CREATED             STATUS                      PORTS               NAMES
		b1296410a011        images.sbgenomics.com/xxx/xxx/geo_uploader:1   "/bin/bash"         23 seconds ago      Exited (0) 15 seconds ago                       nifty_fermi
	
	In the above example, the container ID `b1296410a011` is the ID I want.
	
		$ docker commit b1296410a011 
	
	There should be a commit `sha256` digest.

- Push the image

	Now the image is pushed to the repository.
	
		$ docker push images.sbgenomics.com/<division>/<username>/geo_uploader:1

## Create the tool

Back on the SB website, navigate to your project, go to the Apps tab, and create a new 
tool. Give it a name.

You should start in the Visual Editor for the tool. There are two other tabs: **App Info**, 
and **Code** in the upper left.

Enter your Docker image name and tag, `images.sbgenomics.com/<division>/<username>/geo_uploader:1` 
in the space provided. There's no mechanism to pick and choose from a list.

You can manually enter the *Base Command*, *Arguments*, and *Input Ports*. Alternatively, 
open the `geo_uploader.cwl` file from here into a text editor on your local computer 
(it's just a JSON text file). Go to the **Code** tab and replace and/or add the following 
sections from the JSON CWL file into the code editor on the SB web page.

- `Inputs`

- `baseCommand`

- `arguments`

The final command in the **Visual Editor** tab at the bottom of the page should look like 
this:

	ncftpput -V -z -m -B 33554432 -u user-string-value -p password-string-value ftp-private.ncbi.nlm.nih.gov remote-dir-string-value /path/to/file.ext

Be sure to save your working version (use the floppy disk icon in the upper right corner).
You will enter a commit comment. You may need to save in order to go back and forth 
between the **Visual Editor** and **Code** tabs. 

## Run the tool

You can run the tool with one input file. Enable Spot instance. The machine requirements 
are pretty minimal (I set minimum RAM to 100 and minimum Cores to 1). Select a file from 
your project and enter the parameters and submit. A succesful run on a spot instance 
should cost a few pennies, depending on the size of the file.

Once you've verified it works with one file, submit the remaining files as batch job, 
selecting files as the job batch parameter. Each file will be launched in a separate 
instance. 




