using System.Security.Cryptography;
using System.Text;

public class Utils
{
    public Utils()
    {

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