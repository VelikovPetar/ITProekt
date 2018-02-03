using System;
using System.Web.UI;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class Auth_LoginPage : System.Web.UI.Page
{
    private const string EMPTY_FIELD = "-----";
    private const string PATIENTS_TABLE_NAME = "patient";
    private const string DOCTORS_TABLE_NAME = "doctor";
    private const string MSG_EMAIL_IN_USE = "Email is already used!";
    private const string MSG_ERROR_REGISTERING = "An error occured while creating the account!";
    private const string MSG_WRONG_CREDENTIALS = "Wrong credentials entered!";
    private const string MSG_SUCCESSFUL_REGISTER = "Account successfully created!";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadHospitals();
        }
        else
        {
            ddlGeneralPractioner.Items.Clear();
            ListItem selectedDoctor = new ListItem { Value = hiddenFieldDoctorId.Value, Text = hiddenFieldDoctorName.Value };
            ddlGeneralPractioner.Items.Add(selectedDoctor);
        }
    }

    private void LoadHospitals()
    {
        DBUtils.HospitalsResponseWrapper response = DBUtils.GetAllHospitals();
        if (response.Ex != null)
        {
            lblInfo.Text = response.Ex.ToString();
        }
        else
        {
            ListItem item = new ListItem();
            item.Value = EMPTY_FIELD;
            item.Text = EMPTY_FIELD;
            ddlHospitalPatient.Items.Add(item);
            foreach (ListItem i in response.Hospitals)
            {
                ddlHospitalPatient.Items.Add(i);
                ddlHospitalDoctor.Items.Add(i);
            }
        }
        ddlGeneralPractioner.Items.Add(new ListItem(EMPTY_FIELD, EMPTY_FIELD));
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        // TODO Validate input
        string email = txtEmail.Text;
        string hash = Utils.CalculateMD5Hash(txtPassword.Text); // Utils is in App_Code folder
        SearchExistingUser(email, hash);
    }

    private void SearchExistingUser(string email, string hash)
    {
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            MySqlDataReader reader = SearchUserInTable(
                new string[] { "email", "password" },
                new string[] { email, hash },
                PATIENTS_TABLE_NAME, con);
            if (reader.HasRows)
            {
                // Save user id and type to Session (consider as logged in)
                // Redirect to appropriate home page
                reader.Read();
                Session["user_id"] = reader["id"].ToString();
                Session["user_type"] = UserType.PATIENT;
                Response.Redirect("~/Home/PatientHomePage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                reader.Close();
                reader = SearchUserInTable(
                    new string[] { "email", "password" },
                    new string[] { email, hash },
                    DOCTORS_TABLE_NAME, con);
                if (reader.HasRows)
                {
                    // Save user id and type to Session (consider as logged in)
                    // Redirect to appropriate home page
                    reader.Read();
                    Session["user_id"] = reader["id"].ToString();
                    string isGp = reader["is_gp"].ToString();
                    if (isGp == "True")
                    {
                        Session["user_type"] = UserType.DOCTOR_GP;
                        Response.Redirect("~/Home/GeneralPractitionerHomePage.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                    }
                    else
                    {
                        Session["user_type"] = UserType.DOCTOR_SPECIALIST;
                        Response.Redirect("~/Home/SpecialistHomePage.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                    }
                    lblInfo.Text = isGp;
                    lblInfo.ForeColor = System.Drawing.Color.Black;
                }
                else
                {
                    lblInfo.Text = MSG_WRONG_CREDENTIALS;
                    lblInfo.ForeColor = System.Drawing.Color.DarkRed;
                }
            }
        }
        catch (Exception ex)
        {
            lblInfo.Text = ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }

    private MySqlDataReader SearchUserInTable(string[] columns, string[] values, string tableName, MySqlConnection con)
    {
        string sql = "select * from " + tableName + " where ";
        for (int i = 0; i < columns.Length; ++i)
        {
            sql += columns[i] + "=@" + columns[i];
            if (i < columns.Length - 1)
            {
                sql += " and ";
            }
        }
        MySqlCommand command = new MySqlCommand(sql, con);
        for (int i = 0; i < columns.Length; ++i)
        {
            command.Parameters.AddWithValue("@" + columns[i], values[i]);
        }
        return command.ExecuteReader();
    }

    protected void btnRegisterPatient_Click(object sender, EventArgs e)
    {
        AttemptRegisterPatient();
    }

    protected void btnRegisterDoctor_Click(object sender, EventArgs e)
    {
        AttemptRegisterDoctor();
    }

    private void AttemptRegisterDoctor()
    {
        string name = txtNameDoctor.Text;
        string surname = txtSurnameDoctor.Text;
        string email = txtEmailDoctor.Text;
        string hospitalId = ddlHospitalDoctor.SelectedValue;
        bool isGeneralPractitioner = chkIsGeneralPractitioner.Checked;
        string password = Utils.CalculateMD5Hash(txtPasswordDoctor.Text);
        if (DBUtils.EmailExists(email))
        {
            lblInfo.Text = MSG_EMAIL_IN_USE;
            return;
        }
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "insert into doctor(name, surname, email, hospital_id, is_gp, password) " +
                "values(@name, @surname, @email, @hospital_id, @is_gp, @password)";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@name", name);
            command.Parameters.AddWithValue("@surname", surname);
            command.Parameters.AddWithValue("@email", email);
            command.Parameters.AddWithValue("@hospital_id", hospitalId);
            command.Parameters.AddWithValue("@is_gp", isGeneralPractitioner);
            command.Parameters.AddWithValue("@password", password);
            int rows = command.ExecuteNonQuery();
            if (rows > 0)
            {
                lblInfo.Text = MSG_SUCCESSFUL_REGISTER;
                string doctorId = GetDoctorIdByEmail(email, con);
                if (doctorId != null)
                {
                    // Save user id and type to Session (consider as logged in)
                    // Redirect to appropriate home page
                    Session["user_id"] = doctorId;
                    if (isGeneralPractitioner)
                    {
                        Session["user_type"] = UserType.DOCTOR_GP;
                        Response.Redirect("~/Home/GeneralPractitionerHomePage.aspx");
                    }
                    else
                    {
                        Session["user_type"] = UserType.DOCTOR_SPECIALIST;
                        Response.Redirect("~/Home/SpecialistHomePage.aspx");
                    }
                }
                else
                {
                    lblInfo.Text = MSG_ERROR_REGISTERING;
                }
            }
            else
            {
                lblInfo.Text = MSG_ERROR_REGISTERING;
            }
        }
        catch (Exception ex)
        {
            lblInfo.Text = ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }

    private string GetDoctorIdByEmail(string email, MySqlConnection con)
    {
        string sql = "select id from doctor where email=@email";
        MySqlCommand command = new MySqlCommand(sql, con);
        command.Parameters.AddWithValue("@email", email);
        object result = command.ExecuteScalar();
        string id = null;
        if (result != null)
        {
            id = Convert.ToString(result);
        }
        return id;
    }

    private void AttemptRegisterPatient()
    {
        string name = txtNamePatient.Text;
        string surname = txtSurnamePatient.Text;
        string email = txtEmailPatient.Text;
        string dateOfBirth = txtDateOfBirthPatient.Text; lblInfo.Text = dateOfBirth;
        string ssn = txtSsnPatient.Text;
        string password = Utils.CalculateMD5Hash(txtPasswordPatient.Text);
        string gpId = ddlGeneralPractioner.SelectedValue;
        string phoneNumber = txtPhoneNumberPatient.Text;
        if (DBUtils.EmailExists(email))
        {
            lblInfo.Text = MSG_EMAIL_IN_USE;
            return;
        }
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "insert into patient(name, surname, email, date_of_birth, ssn, password, doctor_id) " +
                "values(@name, @surname, @email, @date_of_birth, @ssn, @password, @doctor_id)";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@name", name);
            command.Parameters.AddWithValue("@surname", surname);
            command.Parameters.AddWithValue("@email", email);
            command.Parameters.AddWithValue("@date_of_birth", dateOfBirth);
            command.Parameters.AddWithValue("@ssn", ssn);
            command.Parameters.AddWithValue("@password", password);
            command.Parameters.AddWithValue("@doctor_id", gpId == EMPTY_FIELD || gpId == "" ? null : gpId);
            int rows = command.ExecuteNonQuery();
            if (rows > 0)
            {
                lblInfo.Text = MSG_SUCCESSFUL_REGISTER;
                string patientId = GetPatientIdByEmail(email, con);
                if (patientId != null)
                {
                    if (phoneNumber != "")
                    {
                        sql = "insert into phone_number(number, patient_id) " +
                            "values(@number, @patient_id)";
                        command = new MySqlCommand(sql, con);
                        command.Parameters.AddWithValue("@number", phoneNumber);
                        command.Parameters.AddWithValue("@patient_id", patientId);
                        command.ExecuteNonQuery();
                    }
                    // Save user id and type to Session (consider as logged in)
                    // Redirect to appropriate home page
                    Session["user_id"] = patientId;
                    Session["user_type"] = UserType.PATIENT;
                    Response.Redirect("~/Home/PatientHomePage.aspx");
                }
                else
                {
                    lblInfo.Text = MSG_ERROR_REGISTERING;
                }
            }
            else
            {
                lblInfo.Text = MSG_ERROR_REGISTERING;
            }

        }
        catch (Exception ex)
        {
            lblInfo.Text = ex.ToString();
        }
        finally
        {
            con.Close();
        }
    }

    private string GetPatientIdByEmail(string email, MySqlConnection con)
    {
        string sql = "select id from patient where email=@email";
        MySqlCommand command = new MySqlCommand(sql, con);
        command.Parameters.AddWithValue("@email", email);
        object result = command.ExecuteScalar();
        string id = null;
        if (result != null)
        {
            id = Convert.ToString(result);
        }
        return id;
    }
}