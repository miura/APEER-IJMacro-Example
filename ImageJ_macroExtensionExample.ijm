/*
  ImageJ Macro Extension or APEER, Example code
  MIT License, Copyright (c) 2020 Kota Miura
 */
//========= preamble ======= 
//install Macro Extensions for APEER environment
run("APEER MacroExtensions");

//set path to local WFE parameter file
wfeparam_path = "/params/WFE_input_params.json";
Ext.setWFE_Input_FilePath( wfeparam_path );

//check if parameters can be captured
wfejson = Ext.captureWFE_JSON();
Ext.shout( wfejson );

//=== set parameters ===
inputdir = "/input/";
outputdir = "/output/";
INPUT_IMAGE = Ext.getValue("input_image");
excludeEdgeParticles = Ext.getValue("exclude_Edge_Particles");
JSONOUT_NAME = Ext.getValue("WFE_output_params_file");

//========= open image ======= 
Ext.shout( "Open: " + INPUT_IMAGE );
open( INPUT_IMAGE );
orgID = getImageID();

//========= Core ======= 
if (excludeEdgeParticles)
	opt = "display exclude clear";
else 
	opt = "display clear";
	
run("Auto Threshold", "method=Otsu white");
run("Analyze Particles...", opt);

//========= Saving Files ======= 
//save binary image data
selectImage( orgID );
outputFileKey = "binarized";
outfullpath = outputdir + utputFileKey + ".tif";
Ext.saveTiffAPEER(outputFileKey, outfullpath);
Ext.shout("...saved: " + outfullpath );

//save analysis results data
outputResultFileKey = "particleAnalysis_results";
outResultsfullpath = outputdir + outputResultFileKey + ".csv";
Ext.saveResultsAPEER( outputResultFileKey, outResultsfullpath);
Ext.shout("...saved: " + outResultsfullpath );

//=== saving WFE JSON out ===
Ext.saveJSON_OUT( outputdir + JSONOUT_NAME);
Ext.shout("...saved: " + JSONOUT_NAME);
Ext.shout("JOB DONE.");
Ext.exit();