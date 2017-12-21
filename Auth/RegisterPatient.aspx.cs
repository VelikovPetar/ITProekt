﻿using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using MySql.Data.MySqlClient;

public partial class Auth_RegisterPatient : System.Web.UI.Page
{

    private const string EMPTY_FIELD = "-----";
    private const string MSG_EMAIL_IN_USE = "Email is already used!";
    private const string MSG_ERROR_REGISTERING = "An error occured while creating the account!";
    private const string MSG_SUCCESSFUL_REGISTER = "Account successfully created!";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadHospitals();
        }
    }

    private void LoadHospitals()
    {
        DBUtils.HospitalsResponseWrapper response = DBUtils.GetAllHospitals();
        if (response.ex != null)
        {
            lblInfo.Text = response.ex.ToString();
        }
        else
        {
            ListItem item = new ListItem();
            item.Value = EMPTY_FIELD;
            item.Text = EMPTY_FIELD;
            ddlHospital.Items.Add(item);
            foreach (ListItem i in response.hospitals)
            {
                ddlHospital.Items.Add(i);
            }
        }
        if (ddlHospital.Items.Count > 0)
        {
            PopulateGeneralPractionersForHospital(ddlHospital.Items[0].Value);
        }
    }

    // TODO Mozebi so AJAX Povik do web service
    protected void ddlHospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        PopulateGeneralPractionersForHospital(ddlHospital.SelectedValue);
    }

    private void PopulateGeneralPractionersForHospital(string id)
    {
        ddlGeneralPractioner.Items.Clear();
        if (id == EMPTY_FIELD)
        {
            ListItem item = new ListItem();
            item.Value = EMPTY_FIELD;
            item.Text = EMPTY_FIELD;
            ddlGeneralPractioner.Items.Add(item);
            return;
        }
        string cString = ConfigurationManager.ConnectionStrings["ezdravstvoDb"].ConnectionString;
        MySqlConnection con = new MySqlConnection(cString);
        try
        {
            con.Open();
            string sql = "select id, name, surname from doctor " +
                "where hospital_id=@id and is_gp=1";
            MySqlCommand command = new MySqlCommand(sql, con);
            command.Parameters.AddWithValue("@id", id);
            MySqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                ListItem item = new ListItem();
                item.Value = reader["id"].ToString();
                item.Text = "Dr. " + reader["name"] + " " + reader["surname"];
                ddlGeneralPractioner.Items.Add(item);
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


    protected void btnRegister_Click(object sender, EventArgs e)
    {
        AttemptRegisterPatient();
    }

    private void AttemptRegisterPatient()
    {
        string name = txtName.Text;
        string surname = txtSurname.Text;
        string email = txtEmail.Text;
        string dateOfBirth = txtDateOfBirth.Text; lblInfo.Text = dateOfBirth;
        string ssn = txtSsn.Text;
        string password = Utils.CalculateMD5Hash(txtPassword.Text);
        string gpId = ddlGeneralPractioner.SelectedValue;
        string phoneNumber = txtPhoneNumber.Text;
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