// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import java.nio.ByteBuffer;

void setup(){
  myData();
}

void myData() {
  // Int 2d array to encode: brushStroke.lines.points, where each point w/in ponits are in triplets x,y,z
  int[][] brushStroke = {
                  { 100, 200, 300, 1000, 2000, 3000 },
                  { 101, 201, 301, 1001, 2001, 3001 }
                };
               
  for (int i = 0; i < brushStroke.length; i++)
  {
    byteTest(brushStroke[i]);    
  }
}


void byteTest(int[] partialData){
  // Number of bytes for an int
  int size = 4;
  
  // Size is 4*4 = 16 bytes to encode 4 integers
  println("partialData.length: " + partialData.length);
  ByteBuffer byteBuffer = ByteBuffer.allocate(partialData.length * size);
  
  //Encode
  for(int i=0; i < partialData.length; i++){
    byteBuffer.putInt(i*size,  partialData[i]);
  }
  
  //Decode
  for(int i=0; i < partialData.length; i++){
    //We get 4 bytes at the time to read integers one by one
    byte[] byteBufferTemp = new byte[size];
    byteBuffer.get(byteBufferTemp, 0, size);
    int intByte = ByteBuffer.wrap(byteBufferTemp).getInt();
    println("decode: " +i+": " + intByte);
  }
}