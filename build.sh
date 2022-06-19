#!/bin/bash

# inspired by 
# https://www.digitalocean.com/community/tutorials/how-to-build-go-executables-for-multiple-platforms-on-ubuntu-16-04

# main variables
package_name=bbee
platforms=("darwin/arm64" "darwin/amd64" "linux/arm64" "linux/amd64")

# clear previous build
rm -rf build/

# go to source folder
cd aliasengine

for platform in "${platforms[@]}"
do
	platform_split=(${platform//\// })
	GOOS=${platform_split[0]}
	GOARCH=${platform_split[1]}
  echo $GOOS $GOARCH

  # final name cleanup
  if [ $GOOS = "darwin" ]; then
    os="Darwin"
  elif [ $GOOS = "linux" ]; then 
    os="Linux"
  fi
	
  if [ $GOARCH = "amd64" ]; then 
    arch="x86_64"
  elif [ $GOARCH = "arm64" ]; then 
    arch="arm64"
  fi

	output_name=$package_name'-'$os'-'$arch
	env GOOS=$GOOS GOARCH=$GOARCH go build -o ../build/$output_name $package
	if [ $? -ne 0 ]; then
   		echo 'An error has occurred! Aborting the script execution...'
		exit 1
	fi
done