package ma.tcp;

/*
 * #%L
 * tcp-ip
 * %%
 * Copyright (C) 2013 - 2014 Software Engineering, RWTH Aachen University
 * %%
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Lesser Public License for more details.
 * 
 * You should have received a copy of the GNU General Lesser Public
 * License along with this program.  If not, see
 * <http://www.gnu.org/licenses/lgpl-3.0.html>.
 * #L%
 */


import java.io.UnsupportedEncodingException;

/**
 * This static class is a set of helpful methods for the work with data in byte array formats. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class HelpCollection {
    
    /**
     * Encodes a String into a utf8 encoded byte array
     * 
     * @param unencoded the String that should be encoded
     * @return The utf8 represenation of the inserted String.
     * @throws UnsupportedEncodingException
     */
    public static byte[] utf8Encode(String unencoded) throws UnsupportedEncodingException {
        byte[] b = unencoded.getBytes("UTF-8");
        return b;
    }
    
    /**
     * @param encoded The utf8 representation which we want to encode
     * @return The String which was formally in the utf8 representation.
     * @throws UnsupportedEncodingException
     */
    public static String utf8Decode(byte[] encoded) throws UnsupportedEncodingException {
        String decoded = new String(encoded, "US-ASCII");
        return decoded;
    }
    
    /**
     * Converts a byte to 8bit binary string eg. -86 to "10101010"
     * 
     * @param b The byte that should be binary encoded
     * @return The String containing the binary representation of the byte
     */
    public static String convertToBinary(byte b) {
        String a = Integer.toBinaryString(b);
        if (a.length() > 8) { // if String longer than 8bit, we just need the last 8bit, because the
                              // rest is padding
            return a.substring(Integer.SIZE - Byte.SIZE);
        }
        else if (a.length() < 8) { // if String is shorter than 8 bit, we have to pad
            String help = "";
            for (int i = 0; i < 8 - a.length(); i++) {
                help = "0" + help;
            }
            return help + a;
        }
        else {
            return a;
        }
    }
    
    /**
     * Convering of a byte array into a string containing the binary represenation of the array
     * 
     * @param a the array, that should be giben in binary representation
     * @return the string containing the binary representation of the given array.
     */
    public static String convertToBinary(byte[] a) {
        String converted = "";
        for (int i = 0; i < a.length; i++) {
            converted += convertToBinary(a[i]);
        }
        return converted;
    }
    
    /**
     * converts a long to a binary string padded to the next multiple of 8
     * 
     * @param a the long, that should be binary represented
     * @return the string containing the padded binary representation of the long value.
     */
    public static String convertToBinary(long a) {
        String b = Long.toBinaryString(a);
        if (b.length() % 8 != 0) {
            int len = 8 - (b.length() % 8);
            for (int i = 0; i < len; i++) {
                b = "0" + b;
            }
        }
        return b;
    }
    
    /**
     * convert binary string to byte, eg "10101010" to -86
     * 
     * @param binary The String containing the binary represenation
     * @return the byte value of the binary String
     */
    public static byte convertToByte(String binary) {
        return (byte) Integer.parseInt(binary, 2);
    }
    
    /**
     * convert binary string to byte array eg. "1010101010101010" to [-86, -86]
     * 
     * @param binary the binary String
     * @return The array of byte values of the binary represenation.
     */
    public static byte[] convertToByteArray(String binary) {
        int len;
        String expand = binary; // we want to expand the string to a multiple of 8
        if (binary.length() % 8 == 0) {
            len = binary.length() / 8;
        }
        else {
            len = binary.length() / 8 + 1;
            for (int i = 0; i < 8 - binary.length() % 8; i++) {
                expand = "0" + expand;
            }
        }
        String[] split = new String[len];
        for (int i = 0; i < split.length; i++) {
            split[i] = expand.substring(8 * i, 8 * i + 8); // we split the string into parts of
                                                           // length 8 each
        }
        byte[] b = new byte[split.length];
        for (int i = 0; i < b.length; i++) {
            b[i] = convertToByte(split[i]);
        }
        return b;
    }
    
    /**
     * Converts a binary string to an array with given length. If the wanted length is shorter, the
     * front difference is dropped, else it is padded with 0s
     * 
     * @param binary The binary String.
     * @param len the length the output array should have
     * @return The array of the resultion byte values in the given length
     */
    public static byte[] convertToByteArray(String binary, int len) {
        byte[] array = convertToByteArray(binary);
        byte[] result = new byte[len];
        if (len < array.length) {
            for (int i = 0; i < len; i++) {
                result[i] = array[array.length - len + i];
            }
        }
        if (len > array.length) {
            for (int i = 0; i < len; i++) {
                if (i < len - array.length) {
                    result[i] = 0;
                }
                else {
                    result[i] = array[i - (len - array.length)];
                }
            }
        }
        if (array.length == len) {
            result = array;
        }
        return result;
    }
}
