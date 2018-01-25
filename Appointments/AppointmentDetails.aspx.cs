using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Appointments_AppointmentDetails : System.Web.UI.Page
{
    private const string MSG_ERROR_READING_REPORT = "[Something went wrong while reading the report!]";
    private const string MSG_ERROR_UPDATE_REPORT = "[Something went wrong while updating the report!]";
    private const string MSG_ERROR_DELETE_REPORT = "[Something went wrong while deleting the report!]";
    private const string MSG_UPDATE_SUCCESS = "[Success!]";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            btnAdd.Visible = false;
            btnDelete.Visible = false;
            btnSave.Visible = false;
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
            else
            {
                ViewState["app_id"] = appId; // Store the appointment id in case the user modifies the query string!
                Appointment app = DBUtils.GetAppointmentById(appId);
                if (app == null)
                {
                    Response.Redirect("~/ErrorPages/PageNotFound.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }
                if (!CanViewPage(app))
                {
                    Response.Redirect("~/ErrorPages/NotAuthorized.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }
                DisplayAppointment(app);
                ViewState["patient_id"] = app.PatientId;
                if (app.HasReport)
                {
                    Report report = DBUtils.GetReportForAppointmentId(app.Id);
                    if (report == null)
                    {
                        lblReportInfo.Text = MSG_ERROR_READING_REPORT;
                        lblReportInfo.ForeColor = System.Drawing.Color.DarkRed;
                    }
                    else
                    {
                        DisplayReport(report);
                        ViewState["report_id"] = report.Id;
                        if (IsPatientLoggedIn())
                        {
                            DisableEdit();
                        }
                        else if (IsDoctorLoggedIn() && ((string)Session["user_id"]) == app.DoctorId)
                        {
                            EnableEdit();
                        }
                        else
                        {
                            DisableEdit();
                        }
                    }
                }
                else
                {
                    lblReport.Visible = false;
                    tableReport.Visible = false;
                    if (IsDoctorLoggedIn() && ((string)Session["user_id"]) == app.DoctorId)
                    {
                        btnAdd.Visible = true;
                    }
                }
            }
        }
    }

    private bool CanViewPage(Appointment app)
    {
        string userId = (string)Session["user_id"];
        if (IsPatientLoggedIn())
        {
            return userId == app.PatientId;

        }
        if (IsDoctorLoggedIn())
        {
            return true;
        }
        return false;
    }

    private bool IsUserLoggedIn()
    {
        if (Session["user_id"] == null || Session["user_type"] == null)
        {
            return false;
        }
        return true;
    }

    private bool IsPatientLoggedIn()
    {
        UserType userType = (UserType)Session["user_type"];
        return userType == UserType.PATIENT;
    }

    private bool IsDoctorLoggedIn()
    {
        UserType userType = (UserType)Session["user_type"];
        return userType == UserType.DOCTOR_GP || userType == UserType.DOCTOR_SPECIALIST;
    }

    private void DisplayAppointment(Appointment app)
    {
        lblPatientName.Text = app.PatientName;
        lblPatientSurname.Text = app.PatientSurname;
        lblPatientSsn.Text = app.PatientSsn;
        lblDoctorName.Text = app.DoctorName;
        lblDoctorSurname.Text = app.DoctorSurname;
        lblDate.Text = app.Date;
        lblTime.Text = app.Time;
        if (IsDoctorLoggedIn())
        {
            btnPatientDetails.Visible = true;
        } 
        else
        {
            btnPatientDetails.Visible = false;
        }
    }

    private void DisplayReport(Report report)
    {
        txtDiagnosis.Text = report.Diagnosis;
        txtTherapy.Text = report.Therapy;
        txtRemark.Text = report.Remark;
    }

    private void DisableEdit()
    {
        txtDiagnosis.Enabled = false;
        txtTherapy.Enabled = false;
        txtRemark.Enabled = false;
        btnSave.Visible = false;
        btnDelete.Visible = false;
        btnAdd.Visible = false;
    }

    private void EnableEdit()
    {
        txtDiagnosis.Enabled = true;
        txtTherapy.Enabled = true;
        txtRemark.Enabled = true;
        btnSave.Visible = true;
        btnDelete.Visible = true;
        btnAdd.Visible = false;
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string appId = (string)ViewState["app_id"];
        Response.Redirect("~/Appointments/AddReport.aspx?appId=" + appId, false);
        Context.ApplicationInstance.CompleteRequest();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string reportId = (string)ViewState["report_id"];
        string newDiagnosis = txtDiagnosis.Text;
        string newTherapy = txtTherapy.Text;
        string newRemark = txtRemark.Text;
        bool success = DBUtils.UpdateReport(reportId, newDiagnosis, newTherapy, newRemark);
        if (success)
        {
            lblReportInfo.Text = MSG_UPDATE_SUCCESS;
            lblReportInfo.ForeColor = System.Drawing.Color.ForestGreen;
        }
        else
        {
            lblReportInfo.Text = MSG_ERROR_UPDATE_REPORT;
            lblReportInfo.ForeColor = System.Drawing.Color.DarkRed;
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string reportId = (string)ViewState["report_id"];
        bool success = DBUtils.DeleteReport(reportId);
        if (success)
        {
            Response.Redirect(Request.RawUrl);
        }
        else
        {
            lblReportInfo.Text = MSG_ERROR_DELETE_REPORT;
            lblReportInfo.ForeColor = System.Drawing.Color.DarkRed;
        }
    }

    protected void btnPatientDetails_Click(object sender, EventArgs e)
    {
        string patientId = (string)ViewState["patient_id"];
        Response.Redirect("~/Home/PatientDetails.aspx?patientId=" + Server.UrlEncode(patientId));
    }
}