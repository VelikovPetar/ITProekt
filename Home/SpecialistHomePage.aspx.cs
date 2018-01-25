using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Home_SpecialistDefaultPage : System.Web.UI.Page
{

    private const string MSG_ERROR_READING_HOSPITAL = "[Something went wrong while reading hospital data!]";
    private const string MSG_ERROR_READING_PATIENTS = "[Something went wrong while reading patients data!]";
    private const string MSG_ERROR_READING_APPOINTMENTS = "[Something went wrong while reading appointments data!]";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsUserLoggedIn())
        {
            // Redirect to error page
            Response.Redirect("~/ErrorPages/NotLoggedIn.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }
        if (!IsSpecialistLoggedIn())
        {
            // Redirect to error page
            Response.Redirect("~/ErrorPages/NotAuthorized.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }
        if (!Page.IsPostBack)
        {
            tabPersonalInfo.CssClass = "clicked";
            multiView.ActiveViewIndex = 0;
            ReadDoctorFromDb();
        }
    }

    private bool IsUserLoggedIn()
    {
        return Session["user_id"] != null && Session["user_type"] != null;
    }

    private bool IsSpecialistLoggedIn()
    {
        UserType userType = (UserType)Session["user_type"];
        return userType == UserType.DOCTOR_SPECIALIST;
    }

    protected void tabPersonalInfo_Click(object sender, EventArgs e)
    {
        tabPersonalInfo.CssClass = "clicked";
        tabPastAppointments.CssClass = "initial";
        tabUpcomingAppointments.CssClass = "initial";
        tabAllPatients.CssClass = "initial";
        multiView.ActiveViewIndex = 0;
    }

    protected void tabPastAppointments_Click(object sender, EventArgs e)
    {
        tabPersonalInfo.CssClass = "initial";
        tabPastAppointments.CssClass = "clicked";
        tabUpcomingAppointments.CssClass = "initial";
        tabAllPatients.CssClass = "initial";
        multiView.ActiveViewIndex = 1;
        ReadPastAppointments();
    }

    protected void tabUpcomingAppointments_Click(object sender, EventArgs e)
    {
        tabPersonalInfo.CssClass = "initial";
        tabPastAppointments.CssClass = "initial";
        tabUpcomingAppointments.CssClass = "clicked";
        tabAllPatients.CssClass = "initial";
        multiView.ActiveViewIndex = 2;
        ReadUpcomingAppointments();
    }

    protected void tabAllPatients_Click(object sender, EventArgs e)
    {
        tabPersonalInfo.CssClass = "initial";
        tabPastAppointments.CssClass = "initial";
        tabUpcomingAppointments.CssClass = "initial";
        tabAllPatients.CssClass = "clicked";
        multiView.ActiveViewIndex = 3;
        ReadAllPatients();
    }

    private void ReadDoctorFromDb()
    {
        string id = (string)Session["user_id"];
        Doctor doctor = DBUtils.FindDoctorById(id);
        if (doctor != null)
        {
            lblName.Text = doctor.Name;
            lblSurname.Text = doctor.Surname;
            lblEmail.Text = doctor.Email;
            lblDoctorType.Text = "Specialist";
            Hospital hospital = DBUtils.FindHospitalById(doctor.HospitalId);
            if (hospital != null)
            {
                lblHospital.Text = hospital.Name;
                lblHospital.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                lblHospital.Text = MSG_ERROR_READING_HOSPITAL;
                lblHospital.ForeColor = System.Drawing.Color.DarkRed;
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
        DataSet dataSet = DBUtils.GetAppointmentsForSpecialist(id, upcoming: false);
        if (dataSet == null)
        {
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

    protected void gvPastAppointments_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPastAppointments.PageIndex = e.NewPageIndex;
        gvPastAppointments.SelectedIndex = -1;
        DataSet dataSet = (DataSet)ViewState["past_appointments"];
        gvPastAppointments.DataSource = dataSet;
        gvPastAppointments.DataBind();
    }

    private void ReadUpcomingAppointments()
    {
        string id = (string)Session["user_id"];
        DataSet dataSet = DBUtils.GetAppointmentsForSpecialist(id, upcoming: true);
        if (dataSet == null)
        {
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

    protected void gvUpcomingAppointments_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvUpcomingAppointments.PageIndex = e.NewPageIndex;
        gvUpcomingAppointments.SelectedIndex = -1;
        DataSet dataSet = (DataSet)ViewState["upcoming_appointments"];
        gvUpcomingAppointments.DataSource = dataSet;
        gvUpcomingAppointments.DataBind();
    }

    private void ReadAllPatients()
    {
        string id = (string)Session["user_id"];
        DataSet dataSet = DBUtils.GetPatientsForSpecialist(id);
        if (dataSet == null)
        {
            lblAllPatientsInfo.Text = MSG_ERROR_READING_PATIENTS;
        }
        else
        {
            gvAllPatients.DataSource = dataSet;
            gvAllPatients.DataBind();
            ViewState["all_patients"] = dataSet;
            lblAllPatientsInfo.Text = "";
        }
    }


    protected void gvAllPatients_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAllPatients.PageIndex = e.NewPageIndex;
        gvAllPatients.SelectedIndex = -1;
        DataSet dataSet = (DataSet)ViewState["all_patients"];
        gvAllPatients.DataSource = dataSet;
        gvAllPatients.DataBind();
    }

    protected void gvPastAppointments_SelectedIndexChanged(object sender, EventArgs e)
    {
        string id = gvPastAppointments.SelectedDataKey.Value.ToString();
        Response.Redirect("~/Appointments/AppointmentDetails.aspx?appId=" + Server.UrlEncode(id));
    }


    protected void gvUpcomingAppointments_SelectedIndexChanged(object sender, EventArgs e)
    {
        string id = gvUpcomingAppointments.SelectedDataKey.Value.ToString();
        Response.Redirect("~/Appointments/AppointmentDetails.aspx?appId=" + Server.UrlEncode(id));
    }


    protected void gvAllPatients_SelectedIndexChanged(object sender, EventArgs e)
    {
        string id = gvAllPatients.SelectedDataKey.Value.ToString();
        Response.Redirect("~/Home/PatientDetails.aspx?patientId=" + Server.UrlEncode(id));
    }
}