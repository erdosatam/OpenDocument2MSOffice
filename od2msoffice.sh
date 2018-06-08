#!/bin/bash

##		OD2MSOFFICE		##
#	OpenDocument converter script	 #
#	   (c) 2017 Erdos Attila         #
#	       version 1.8      	 #
##					##


dir="/"
logDir="/"

if [ ! -d $logDir ]; then
{
	mkdir -p $logDir
}; fi

IFS="
"

for i in `find $dir -type f -name '*.odt' -printf '%p\n'`; do
{
	actualDir=$(dirname "${i}")
	cd $actualDir
	ad=`echo $actualDir | tail -c 4`	
	if [ "$ad" != "odt" ]; then
	{
		if [ ! -d $actualDir/odt ]; then
		{
			mkdir $actualDir/odt
		}; fi 		
		libreoffice --headless --convert-to docx $i	2>> $logDir/odt_error.log

		dF=`echo "$i" | sed 's/.\{4\}$//'`
		docxFile=$dF.docx
		
		if [ -f $docxFile ]; then
		{
			mv $i $actualDir/odt
		}; fi
		echo "ODT --  $i - done" >> $logDir/log.txt
	}; fi
}; done

echo "ODT - done" >> $logDir/done.log

for i in `find $dir -type f -name '*.ods' -printf '%p\n'`; do
{
	actualDir=$(dirname "${i}")
	cd $actualDir
	ad=`echo $actualDir | tail -c 4`	
	if [ "$ad" != "ods" ]; then
	{		
		if [ ! -d $actualDir/ods ]; then
		{
			mkdir $actualDir/ods
		}; fi 		
		libreoffice --headless --convert-to xlsx $i	2>> $logDir/ods_error.log

		xF=`echo "$i" | sed 's/.\{4\}$//'`
		xlsxFile=$xF.xlsx

		if [ -f $xlsxFile ]; then
		{
			mv $i $actualDir/ods
		}; fi		

		echo "ODS --  $i done" >> $logDir/log.txt
	}; fi
}; done
echo "ODS - done" >> $logDir/done.log
