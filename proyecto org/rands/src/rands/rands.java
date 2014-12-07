/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rands;

import java.io.*;
import java.util.ArrayList;
import java.util.Random;

/**
 *
 * @author Kevin
 */
public class rands {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Writer writer = null;
        ArrayList<String> rands = new ArrayList<String>();
        
        for(int i=0;i<500;i++){
            rands.add(Integer.toString(randInt(0,32500)));
        }
            

        try {
            writer = new BufferedWriter(new OutputStreamWriter(
                  new FileOutputStream("numeros.txt"), "utf-8"));
            for(int i=0;i<rands.size();i++){
                if(i==0)
                    writer.write("[");
                writer.write(rands.get(i));
                if(i<rands.size()-1)
                    writer.write(",");
                if(i==rands.size()-1)
                    writer.write("]");
            }
        } catch (IOException ex) {
          // report
        } finally {
           try {writer.close();} catch (Exception ex) {}
        }
    }
    
    public static int randInt(int min, int max) {

    // NOTE: Usually this should be a field rather than a method
    // variable so that it is not re-seeded every call.
    Random rand = new Random();

    // nextInt is normally exclusive of the top value,
    // so add 1 to make it inclusive
    int randomNum = rand.nextInt((max - min) + 1) + min;

    return randomNum;
}
    
}
