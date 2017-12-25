using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using MySql.Data.MySqlClient;

public partial class Auth_RegisterDoctor : System.Web.UI.Page
{

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
        if (response.Ex != null)
        {
            lblInfo.Text = response.Ex.ToString();
        }
        else
        {
            foreach (ListItem i in response.Hospitals)
            {
                ddlHospital.Items.Add(i);
            }
        }
    }



    protected void btnRegister_Click(object sender, EventArgs e)
    {
        AttemptRegisterDoctor();
    }

    private void AttemptRegisterDoctor()
    {
        string name = txtName.Text;
        string surname = txtSurname.Text;
        string email = txtEmail.Text;
        string hospitalId = ddlHospital.SelectedValue;
        bool isGeneralPractitioner = chkIsGeneralPractitioner.Checked;
        string password = Utils.CalculateMD5Hash(txtPassword.Text);
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
}