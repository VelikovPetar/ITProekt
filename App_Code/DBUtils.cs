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

    public static List<Hospital> GetHospitals()
    {
        List<Hospital> hospitals = new List<Hospital>();
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select * from hospital";
            MySqlCommand command = new MySqlCommand(sql, con);
            MySqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                string id = reader["id"].ToString();
                string name = reader["name"].ToString();
                string address = reader["address"].ToString();
                Hospital hospital = new Hospital(id, name, address);
                hospitals.Add(hospital);
            }
            return hospitals;
        }
        catch (Exception)
        {
            return hospitals;
        }
        finally
        {
            con.Close();
        }
    }

    public static List<Doctor> GetDoctorsForHospital(string hospitalId, string isGp = "1")
    {
        List<Doctor> doctors = new List<Doctor>();
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select id, name, surname from doctor " +
                "where hospital_id=@id and is_gp=@isGp";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@id", hospitalId);
            command.Parameters.AddWithValue("@isGp", isGp);
            MySqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                string id = reader["id"].ToString();
                string name = reader["name"].ToString();
                string surname = reader["surname"].ToString();
                Doctor doctor = new Doctor { Id = id, Name = name, Surname = surname };
                doctors.Add(doctor);
            }
            return doctors;
        }
        catch (Exception ex)
        {
            return doctors;
        }
        finally
        {
            con.Close();
        }
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

    public static DataSet GetAppointmentsForDoctor(string doctorId)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select app.id, date_time, ssn, concat(name, ' ', surname) as full_name " +
                "from appointment as app inner join patient on app.patient_id=patient.id " +
                "where app.doctor_id=@doctorId";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@doctorId", doctorId);
            DataSet dataSet = new DataSet();
            MySqlDataAdapter adapter = new MySqlDataAdapter(command);
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

    public static List<Appointment> GetAppointmentsForDoctorOnDate(string doctorId, string date)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = @"select * from appointment where doctor_id=@doctorId and date_time like @date;";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@doctorId", doctorId);
            command.Parameters.AddWithValue("@date", "%" + date + "%");
            MySqlDataReader reader = command.ExecuteReader();
            List<Appointment> appointments = new List<Appointment>();
            while (reader.Read())
            {
                string id = reader["id"].ToString();
                string date_time = reader["date_time"].ToString();
                string has_report = reader["has_report"].ToString();
                string patient_id = reader["patient_id"].ToString();
                string doctor_id = reader["doctor_id"].ToString();
                Appointment app = new Appointment
                {
                    Id = id,
                    DateTime = date_time,
                    HasReport = has_report == "1",
                    PatientId = patient_id,
                    DoctorId = doctor_id
                };
                appointments.Add(app);
            }
            return appointments;
        }
        catch (Exception ex)
        {
            return null;
        }
        finally
        {
            con.Close();
        }
    }

    public static Appointment GetAppointmentById(string id)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select app.id, patient.id as p_id, patient.name as p_name, patient.surname as p_surname, patient.ssn, doctor.id as d_id, doctor.name as d_name, doctor.surname as d_surname, app.date_time, app.has_report " +
                "from ((select * from appointment where id=@id) as app inner join patient on app.patient_id = patient.id) " +
                "inner join doctor on app.doctor_id = doctor.id";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@id", id);
            MySqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                string patientId = reader["p_id"].ToString();
                string patientName = reader["p_name"].ToString();
                string patientSurname = reader["p_surname"].ToString();
                string patientSsn = reader["ssn"].ToString();
                string doctorId = reader["d_id"].ToString();
                string doctorName = reader["d_name"].ToString();
                string doctorSurname = reader["d_surname"].ToString();
                string dateTime = reader["date_time"].ToString();
                bool hasReport = Convert.ToBoolean(reader["has_report"].ToString());
                return new Appointment(id, patientId, patientName, patientSurname, patientSsn, doctorId, doctorName, doctorSurname, dateTime, hasReport);
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

    public static bool AttemptSaveAppointment(string patientId, string doctorId, string dateTime, string hasReport = "0")
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "insert into appointment(patient_id, doctor_id, date_time, has_report) " +
                "values(@patientId, @doctorId, @dateTime, @hasReport)";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@patientId", patientId);
            command.Parameters.AddWithValue("@doctorId", doctorId);
            command.Parameters.AddWithValue("@dateTime", dateTime);
            command.Parameters.AddWithValue("@hasReport", hasReport);
            int rows = command.ExecuteNonQuery();
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        catch (Exception)
        {
            return true;
        }
        finally
        {
            con.Close();
        }
    }

    public static Report GetReportForAppointmentId(string appId)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select * from report where appointment_id=@appId limit 1";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@appId", appId);
            MySqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                string id = reader["id"].ToString();
                string diagnosis = reader["diagnosis"].ToString();
                string therapy = reader["therapy"].ToString();
                string remark = reader["remark"].ToString();
                return new Report(id, diagnosis, therapy, remark, appId);
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

    public static bool AttemptSaveReport(string diagnosis, string therapy, string remark, string appId)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "insert into report(diagnosis, therapy, remark, appointment_id) " +
                "values(@diagnosis, @therapy, @remark, @appId)";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@diagnosis", diagnosis);
            command.Parameters.AddWithValue("@therapy", therapy);
            command.Parameters.AddWithValue("@remark", remark);
            command.Parameters.AddWithValue("@appId", appId);
            int rows = command.ExecuteNonQuery();
            return rows > 0;
        } catch (Exception)
        {
            return false;
        } finally
        {
            con.Close();
        }
    }

    public static bool UpdateReport(string id, string diagnosis, string therapy, string remark)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "update report set diagnosis=@diagnosis, therapy=@therapy, remark=@remark " +
                "where id=@id";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@id", id);
            command.Parameters.AddWithValue("@diagnosis", diagnosis);
            command.Parameters.AddWithValue("@therapy", therapy);
            command.Parameters.AddWithValue("@remark", remark);
            int rows = command.ExecuteNonQuery();
            return rows > 0;
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

    public static bool DeleteReport(string id)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "delete from report where id=@id";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@id", id);
            int rows = command.ExecuteNonQuery();
            return rows > 0;
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

    public static Hospital FindHospitalById(string id)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select * from hospital where id=@id";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@id", id);
            MySqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                string name = reader["name"].ToString();
                string adress = reader["address"].ToString();
                Hospital hospital = new Hospital(id, name, adress);
                return hospital;
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

    public static DataSet GetPatientsForGp(string gpId)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select id, name, surname, concat(name, ' ', surname) as full_name, ssn, email, date_of_birth " +
                "from patient where doctor_id=@gpId";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@gpId", gpId);
            MySqlDataAdapter adapter = new MySqlDataAdapter(command);
            DataSet ds = new DataSet();
            adapter.Fill(ds, "patients");
            return ds;
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

    public static DataSet GetPatientsWithoutGp()
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select id, name, surname, concat(name, ' ', surname) as full_name, ssn, email, date_of_birth " +
                "from patient where doctor_id is null";
            MySqlCommand command = new MySqlCommand(sql, con);
            MySqlDataAdapter adapter = new MySqlDataAdapter(command);
            DataSet ds = new DataSet();
            adapter.Fill(ds, "patients");
            return ds;
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