using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Data;
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
        public Exception Ex { get; private set; }
        public List<ListItem> Hospitals { get; private set; }

        public HospitalsResponseWrapper(List<ListItem> hospitals)
        {
            this.Ex = null;
            this.Hospitals = hospitals;
        }

        public HospitalsResponseWrapper(Exception ex)
        {
            this.Ex = ex;
            this.Hospitals = null;
        }

    }

    public static Patient FindPatientById(string id)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select * from patient where id=@id";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@id", id);
            MySqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                string name = reader["name"].ToString();
                string surname = reader["surname"].ToString();
                string ssn = reader["ssn"].ToString();
                string address = reader["address"].ToString();
                string email = reader["email"].ToString();
                string dateOfBirth = reader["date_of_birth"].ToString();
                string doctorId = reader["doctor_id"].ToString();
                return new Patient(id, name, surname, ssn, address, email, dateOfBirth, doctorId);
            }
            else
            {
                return null;
            }
        }
        catch (Exception)
        {
            return null;
        }
        finally
        {
            con.Close();
        }
    }

    public static Doctor FindDoctorById(string id)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select * from doctor where id=@id";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@id", id);
            MySqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                string name = reader["name"].ToString();
                string surname = reader["surname"].ToString();
                string isGp = reader["is_gp"].ToString();
                string email = reader["email"].ToString();
                string hospitalId = reader["hospital_id"].ToString();
                return new Doctor(id, name, surname, isGp, email, hospitalId);
            }
            else
            {
                return null;
            }
        }
        catch (Exception)
        {
            return null;
        }
        finally
        {
            con.Close();
        }
    }

    public static DataSet GetAppointmentsForPatient(string patientId, bool upcoming)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select app.id, date_time, has_report, doctor_id, name, surname, concat(name, ' ', surname) as full_name " +
                "from ezdravstvo.appointment as app inner join ezdravstvo.doctor as doc on app.doctor_id = doc.id " +
                "where app.patient_id=@id and app.date_time" + (upcoming ? ">" : "<") + "now()";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@id", patientId);
            MySqlDataAdapter adapter = new MySqlDataAdapter(command);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet, "appointments");
            return dataSet;
        }
        catch (Exception)
        {
            return null;
        }
        finally
        {
            con.Close();
        }
    }
}