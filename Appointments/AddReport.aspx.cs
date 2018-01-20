using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Appointments_AddReport : System.Web.UI.Page
{

    private const string MSG_ERROR_ADDING_REPORT = "An error occurred while saving the report!";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (!IsUserLoggedIn())
            {
                Response.Redirect("~/ErrorPages/NotLoggedIn.aspx");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            string appId = Request.QueryString["appId"];
            if (appId == null || appId.Trim() == "")
            {
                Response.Redirect("~/ErrorPages/PageNotFound.aspx");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            ViewState["appId"] = appId; // Store the appointment id in case the user modifies the query string!
            Appointment appointment = DBUtils.GetAppointmentById(appId);
            if (appointment == null)
            {
                Response.Redirect("~/ErrorPages/PageNotFound.aspx");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            string userId = (string)Session["user_id"];
            if (userId != appointment.DoctorId)
            {
                Response.Redirect("~/ErrorPages/NotAuthorized.aspx");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            DisplayAppointmentDetails(appointment);
        }
    }

    private bool IsUserLoggedIn()
    {
        if (Session["user_id"] == null || Session["user_type"] == null)
        {
            return false;
        }
        return true;
    }

    private void DisplayAppointmentDetails(Appointment app)
    {
        lblPatientName.Text = app.PatientName + " " + app.PatientSurname;
        lblDoctorName.Text = "Dr. " + app.DoctorName + " " + app.DoctorSurname;
        lblDateTime.Text = app.Time + " " + app.Date;
    }

    protected void btnAddReport_Click(object sender, EventArgs e)
    {
        string appId = (string)ViewState["appId"];
        string diagnosis = txtDiagnosis.Text;
        string therapy = txtTherapy.Text;
        string remark = txtRemark.Text;
        bool success = DBUtils.AttemptSaveReport(diagnosis, therapy, remark, appId);
        if (success)
        {
            Response.Redirect("~/Appointments/AppointmentDetails.aspx?appId=" + appId, false);
            Context.ApplicationInstance.CompleteRequest();
        }
        else
        {
            lblError.Text = MSG_ERROR_ADDING_REPORT;
        }
    }
}