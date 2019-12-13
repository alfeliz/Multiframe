input = "/home/gonzalo/Documents/04-Calculations/2018-04-16/ALEX729-Cordin/RAW/";
output = replace(input,"/RAW/","/RAW-good/");
File.makeDirectory(output);


setBatchMode(true); 
list = getFileList(input);

for (i = 0; i < list.length; i++) {
        frame = substring(list[i],6,8);
        print(frame);
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



function rotation01(input, output, filename) {        
        run("Raw...", 'open=' + input + filename +' width=2048 height=2048 offset=0 number=1 gap=0 little-endian"');
        run("Rotate... ", "angle=180 grid=1 interpolation=Bilinear");
        saveAs("RAW",output+filename);  
        malena_profile(output,filename);      
}

function rotation02(input, output, filename) {        
        run("Raw...", 'open=' + input + filename +' width=2048 height=2048 offset=0 number=1 gap=0 little-endian"');
        run("Rotate... ", "angle=270 grid=1 interpolation=Bilinear");
		run("Flip Horizontally");       
        saveAs("RAW",output+filename);
        malena_profile(output,filename);      
}


function malena_profile(output, filename) {        
    run("Rotate 90 Degrees Right");
		
	makeRectangle(315, 780, 1733, 1268);
	profile = getProfile();
		
	for (i=0; i<profile.length; i++)
		setResult("Value", i, profile[i]);
						
	updateResults;
		
	path = output+filename+".csv";
		
	saveAs("Results", path);
}




