using System;
using System.Web.UI;
using MySql.Data.MySqlClient;
using System.Configuration;

public partial class Auth_LoginPage : System.Web.UI.Page
{
    private const string PATIENTS_TABLE_NAME = "patient";
    private const string DOCTORS_TABLE_NAME = "doctor";
    private const string MSG_WRONG_CREDENTIALS = "Wrong credentials entered!";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lblInfo.Text = "Not postback";
        }
        else
        {
            lblInfo.Text = "Postback";
        }
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
                Response.Redirect("~/Home/PatientHomePage.aspx");
                lblInfo.Text = "Patient";
                lblInfo.ForeColor = System.Drawing.Color.Black;
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
                        Response.Redirect("~/Home/GeneralPractitionerHomePage.aspx");
                    }
                    else
                    {
                        Session["user_type"] = UserType.DOCTOR_SPECIALIST;
                        Response.Redirect("~/Home/SpecialistHomePage.aspx");
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
        lblQuery.Text = command.CommandText;
        return command.ExecuteReader();
    }

    protected void btnRegisterPatient_Click(object sender, EventArgs e)
    {
        lblInfo.Text = "Redirecting to patients...";
        Response.Redirect("~/Auth/RegisterPatient.aspx");
    }

    protected void btnRegisterDoctor_Click(object sender, EventArgs e)
    {
        lblInfo.Text = "Redirecting to doctors...";
        Response.Redirect("~/Auth/RegisterDoctor.aspx");
    }
}