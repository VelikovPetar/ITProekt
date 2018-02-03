using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using System.Configuration;
using MySql.Data.MySqlClient;

public partial class Home_PatientDefaultPage : System.Web.UI.Page
{

    private const string MSG_ERROR_READING_USER_INFO = "Error reading user info.";
    private const string MSG_ERROR_READING_APPOINTMENTS = "[Something went wrong while reading appointments]";

    private Patient patient;
    private Doctor doctor;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPatientLoggedId())
        {
            // Redirect to error page
            Response.Redirect("~/ErrorPages/NotLoggedIn.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }
        if (!Page.IsPostBack)
        {
            //tabPersonalInfo.CssClass = "clicked";
            //multiView.ActiveViewIndex = 0;
            ReadPatientFromDb();
            DisplayPatient();
            ReadPastAppointments();
            ReadUpcomingAppointments();
        }
    }

    private void ReadPatientFromDb()
    {
        string id = (string)Session["user_id"];
        patient = DBUtils.FindPatientById(id);
        if (patient != null)
        {
            ViewState["patient"] = patient;
            if (patient.DoctorId != null && patient.DoctorId != "")
            {
                doctor = DBUtils.FindDoctorById(patient.DoctorId);
                if (doctor != null)
                {
                    ViewState["gp_doctor"] = doctor;
                }
            }
        }
        else
        {
            // Redirect to error
            Response.Redirect("~/ErrorPages/Oops.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }

    private void ReadPastAppointments()
    {
        string id = (string)Session["user_id"];
        DataSet dataSet = DBUtils.GetAppointmentsForPatient(id, upcoming: false);
        if (dataSet == null)
        {
            dataSet = new DataSet();
            lblPastAppointmentsInfo.Text = MSG_ERROR_READING_APPOINTMENTS;
        }
        else
        {
            gvPastAppointments.DataSource = dataSet;
            gvPastAppointments.DataBind();
            ViewState["past_appointments"] = dataSet;
            lblPastAppointmentsInfo.Text = "";
        }
    }

    private void ReadUpcomingAppointments()
    {
        string id = (string)Session["user_id"];
        DataSet dataSet = DBUtils.GetAppointmentsForPatient(id, upcoming: true);
        if (dataSet == null)
        {
            dataSet = new DataSet();
            lblUpcomingAppointmentsInfo.Text = MSG_ERROR_READING_APPOINTMENTS;
        }
        else
        {
            gvUpcomingAppointments.DataSource = dataSet;
            gvUpcomingAppointments.DataBind();
            ViewState["upcoming_appointments"] = dataSet;
            lblUpcomingAppointmentsInfo.Text = "";
        }
    }

    //private void LoadPatient()
    //{
    //    patient = (Patient)ViewState["patient"];
    //    if (patient.DoctorId != null && patient.DoctorId != "")
    //    {
    //        doctor = (Doctor)ViewState["gp_doctor"];
    //    }
    //}

    private void DisplayPatient()
    {
        lblName.Text = patient.Name;
        lblSurname.Text = patient.Surname;
        lblSsn.Text = patient.Ssn;
        lblAddress.Text = patient.Address;
        lblEmail.Text = patient.Email;
        lblDateOfBirth.Text = patient.DateOfBirth;
        lblDoctor.Text = doctor == null ? "<i>No general practitioner</i>" : "Dr. " + doctor.Name + " " + doctor.Surname;
    }

    private bool IsPatientLoggedId()
    {
        if (Session["user_id"] == null || Session["user_type"] == null)
        {
            return false;
        }
        string id = (string)Session["user_id"];
        UserType userType = (UserType)Session["user_type"];
        if (userType != UserType.PATIENT)
        {
            return false;
        }
        return true;
    }

    protected string GetAppointmentDetailsUrl(object id)
    {
        string url = "~/Appointments/AppointmentDetails.aspx?appId=" + Server.UrlEncode(id.ToString());
        return url;
    }

    protected void gvPastAppointments_SelectedIndexChanged(object sender, EventArgs e)
    {
        string id = gvPastAppointments.SelectedDataKey.Value.ToString();
        Response.Redirect("~/Appointments/AppointmentDetails.aspx?appId=" + Server.UrlEncode(id.ToString()));
    }

    protected void gvUpcomingAppointments_SelectedIndexChanged(object sender, EventArgs e)
    {
        string id = gvUpcomingAppointments.SelectedDataKey.Value.ToString();
        Response.Redirect("~/Appointments/AppointmentDetails.aspx?appId=" + Server.UrlEncode(id.ToString()));
    }

    protected void gvPastAppointments_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPastAppointments.PageIndex = e.NewPageIndex;
        gvPastAppointments.SelectedIndex = -1;
        DataSet ds = (DataSet)ViewState["past_appointments"];
        gvPastAppointments.DataSource = ds;
        gvPastAppointments.DataBind();
    }

    protected void gvUpcomingAppointments_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvUpcomingAppointments.PageIndex = e.NewPageIndex;
        gvUpcomingAppointments.SelectedIndex = -1;
        DataSet ds = (DataSet)ViewState["upcoming_appointments"];
        gvUpcomingAppointments.DataSource = ds;
        gvUpcomingAppointments.DataBind();
    }
}