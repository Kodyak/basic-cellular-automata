import javax.swing.JOptionPane;

// prints screen - requires a name...
void mousePressed() {
  String in = getSaveInput();

  if(in == null){return;}
    else{save(in+".png");}
    
}

String getSaveInput() {
  return JOptionPane.showInputDialog("saved file name =");
}


int cols = 450;
int rows = 450;  
int[][] coords = new int[cols][rows];

void setup() {
  size(450, 450); 
  background(0);
  stroke(5);
  smooth();
  for (int i=0; i< cols; i++){
    for (int j=0; j< rows; j++){
          coords[i][j] = Math.round(random(1));
    }
  }
}

float iteration = 1;

void draw(){

  for (int i=1; i< cols-1; i++){
      for (int j=1; j< rows-1; j++){
        // I commented out some other fun weights for experimenting with
        //float[] weights = {2,4,2,1,1,1,14};
        float[] weights = {2,10*sin(iteration/30),2,11,1,1,10*cos(iteration/30)};
        //float[] weights = {1 ,2 ,3, 4, 5,6,7};
        //float[] weights = {1 * sin(iteration/12),2 * cos(iteration/11),3,-2,10,14 * sin(iteration/21),5 * cos(iteration/665)};
        float weight_sum = 0;
        for (int k=0; k< weights.length; k++){ weight_sum += weights[k]; }

        float[] values = { coords[i-1][j-1], coords[i-1][j], coords[i][j-1], coords[i][j], coords[i][j+1], coords[i+1][j], coords[i+1][j+1] };
        float vote = 0;
        for (int k=0; k< values.length; k++){ vote += weights[k] * values[k]; }
        vote = (vote/ weight_sum);
        
        coords[i][j] = Math.round((vote));
        stroke(255*coords[i][j]); 
        // right now, coloring is coming from stroke values outside of the range 0-255, a 'bug'
        // albeit one I'm happy with for the moment due to it's predictably beautiful nature
        rect(i,j,2,2);
      }
  }
 
  
  iteration++;
  
}