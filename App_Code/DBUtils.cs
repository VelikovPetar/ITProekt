using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Web.UI.WebControls;
using System.Configuration;


public class DBUtils
{

    public DBUtils()
    {

    }

    public static HospitalsResponseWrapper GetAllHospitals()
    {
        List<ListItem> hospitals = new List<ListItem>();
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select id, name from hospital";
            MySqlCommand command = new MySqlCommand(sql, con);
            MySqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                ListItem item = new ListItem();
                item.Value = reader["id"].ToString();
                item.Text = reader["name"].ToString();
                hospitals.Add(item);
            }
            return new HospitalsResponseWrapper(hospitals);

        }
        catch (Exception e)
        {
            return new HospitalsResponseWrapper(e);
        }
        finally
        {
            con.Close();
        }
    }

    public static bool EmailExists(string email)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            // Check if there is a patient using that mail
            string sql = "select count(*) from patient where email=@email";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@email", email);
            object result = command.ExecuteScalar();
            if (result != null)
            {
                int count = Convert.ToInt32(result);
                if (count > 0)
                {
                    return true;
                }
            }

            // Check if there is a doctor using that mail
            sql = "select count(*) from doctor where email=@email";
            command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@email", email);
            result = command.ExecuteScalar();
            if (result != null)
            {
                int count = Convert.ToInt32(result);
                if (count > 0)
                {
                    return true;
                }
            }
            return false;
        }
        catch (Exception)
        {
            return false;
        }
        finally
        {
            con.Close();
        }
    }

    public class HospitalsResponseWrapper
    {
        public Exception ex { get; set; }
        public List<ListItem> hospitals { get; set; }

        public HospitalsResponseWrapper(List<ListItem> hospitals)
        {
            this.ex = null;
            this.hospitals = hospitals;
        }

        public HospitalsResponseWrapper(Exception ex)
        {
            this.ex = ex;
            this.hospitals = null;
        }

    }
}