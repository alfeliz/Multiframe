// Script to change the orientation of the Cordin multiframe cameras with 8 frames.
// Cordin data are agrupated in folders withinf the chosen directory, with the same 
//structure that the Cordin camera saving data program uses.

  //Get the folder with all the shots raw data folder:
  dir = getDirectory("Choose a Directory ");

  //Within this folder, look for the folder with the Cordin data shots folders, identified because it has the word "Cordin" on its name
  list = getFileList(dir);
  
  for (i=0; i< list.length; i++) {
    if ( ( endsWith(list[i],"/") + indexOf(list[i],"Cordin") >= 1) && endsWith(list[i],"/") ){
	  path = list[i];
	  }
  }
  
  //Make the shots list:
  list_shots = getFileList(dir+path);
  
  //For each shot, run the function Cordin, that reorientates, saves and extract the radius for each frame.
//  for (i=0; i<list_shots.length; i++){
for (i=0; i<1; i++){
    Cordin(dir+path+list_shots[i]);
    print(list_shots[i]);
    }




  
//////////////////////////////////////////////////////
//
//		Functions
////////////////////////////////////////////////////// 


//Function to reorientate, save and find a profile for each picture within a shot on a Cordin data:
function Cordin(dir_shot){

//Directory of RAw photos is called "RAW":
input = dir_shot + "RAW/";
//Output is saved in a different folder:
output = replace(input,"/RAW/","/RAW-good/");
File.makeDirectory(output);


setBatchMode(true); 
//Files within RAW:
list = getFileList(input);

//For every file frame, choose the adequate reorientation and work the data follwing the appropiate function. 
//  Here, for Malena, just find a profiles and save it.
for (i = 0; i < list.length; i++) {
        frame = substring(list[i],6,8);
        if (frame=="10") {
          rotation01(input,output,list[i]);
          }
        else if (frame=="11") {
          rotation01(input,output,list[i]);         
          }
        else if (frame=="12") {
          rotation01(input,output,list[i]);         
          }
        else if (frame=="13") {
          rotation02(input,output,list[i]);         
          }
       else if (frame=="14") {
          rotation02(input,output,list[i]);         
          }
        else if (frame=="15") {
          rotation02(input,output,list[i]);         
          }
        else if (frame=="16") {
          rotation02(input,output,list[i]);         
          }
        else if (frame=="1_") {
          rotation01(input,output,list[i]);         
          }
        else if (frame=="2_") {
          rotation01(input,output,list[i]);         
          }
        else if (frame=="3_") {
          rotation01(input,output,list[i]);         
          }
        else if (frame=="4_") {
          rotation01(input,output,list[i]);         
          }
        else if (frame=="5_") {
          rotation02(input,output,list[i]);         
          }
        else if (frame=="6_") {
          rotation02(input,output,list[i]);         
          }
        else if (frame=="7_") {
          rotation02(input,output,list[i]);         
          }
        else if (frame=="8_") {
          rotation02(input,output,list[i]);         
          }
        else if (frame=="9_") {
          rotation01(input,output,list[i]);         
          }
        }
setBatchMode(false);

}




function rotation01(input, output, filename) {        
        run("Raw...", 'open=' + input + filename +' width=2048 height=2048 little-endian"');
        run("Rotate... ", "angle=180 grid=1 interpolation=Bilinear");
        saveAs("RAW",output+filename);
		//malena_profile(output,filename);      
}


function rotation02(input, output, filename) {        
        run("Raw...", 'open=' + input + filename +' width=2048 height=2048 little-endian"');
        run("Rotate... ", "angle=270 grid=1 interpolation=Bilinear");
		run("Flip Horizontally");       
        saveAs("RAW",output+filename);
        //malena_profile(output,filename);      
}


function malena_profile(output, filename) {        
    run("Rotate 90 Degrees Right");
    run("Clear Results");

	makeRectangle(0, 1024, 2048, 1024);
   
   path = output+filename+".csv";	
   	
	profile = getProfile();
		
	for (i=0; i<profile.length; i++)
		setResult("Value", i, profile[i]);
						
	updateResults;
		
	saveAs("Results", path);
}

