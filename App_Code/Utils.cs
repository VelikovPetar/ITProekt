using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for Utils
/// </summary>
public class Utils
{
    public Utils()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string CalculateMD5Hash(string input)
    {
        StringBuilder hash = new StringBuilder();
        MD5CryptoServiceProvider provider = new MD5CryptoServiceProvider();
        byte[] bytes = provider.ComputeHash(new UTF8Encoding().GetBytes(input));
        foreach (byte b in bytes)
        {
            hash.Append(b.ToString("x2"));
        }
        return hash.ToString();
    }
}