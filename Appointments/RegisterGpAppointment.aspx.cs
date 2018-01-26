using System;
using System.Data;

public partial class Appointments_RegisterGpAppointment : System.Web.UI.Page
{
    private const string MSG_ERROR_SAVING_APPOINTMENT = "[Something went wrong while saving the appointment!]";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsUserLoggedIn())
        {
            // Redirect to error page
            Response.Redirect("~/ErrorPages/NotLoggedIn.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }
        if (!IsGeneralPractionerLoggedIn())
        {
            // Redirect to error page
            Response.Redirect("~/ErrorPages/NotAuthorized.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }
        if (!IsPostBack)
        {
            ReadPatients();
        }
    }

    private bool IsUserLoggedIn()
    {
        return Session["user_id"] != null && Session["user_type"] != null;
    }

    private bool IsGeneralPractionerLoggedIn()
    {
        UserType userType = (UserType)Session["user_type"];
        return userType == UserType.DOCTOR_GP;
    }

    private void ReadPatients()
    {
        string id = (string)Session["user_id"];
        DataSet dataSet = DBUtils.GetPatientsForGp(id);
        ddlPatient.DataSource = dataSet;
        ddlPatient.DataTextField = "full_name";
        ddlPatient.DataValueField = "id";
        ddlPatient.DataBind();
    }

    protected void btnSaveAppointment_Click(object sender, EventArgs e)
    {
        string patientId = ddlPatient.SelectedItem.Value.ToString();
        string doctorId = (string)Session["user_id"];
        string date = txtDate.Text;
        string time = txtTime.Text;
        string dateTime = date + " " + time;
        bool success = DBUtils.AttemptSaveAppointment(patientId, doctorId, dateTime);
        if (success)
        {
            Response.Redirect("~/Home/GeneralPractitionerHomePage.aspx");
        }
        else
        {
            lblInfo.Text = MSG_ERROR_SAVING_APPOINTMENT;
            lblInfo.ForeColor = System.Drawing.Color.DarkRed;
        }
    }
}