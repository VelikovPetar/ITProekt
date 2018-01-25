using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_PatientDetails : System.Web.UI.Page
{

    private const string MSG_ERROR_READING_DOCTOR = "<i>Error while reading doctor info!</i>";
    private const string MSG_NO_GENERAL_PRACTITIONER = "<i>No genereal practioner</i>";
    private const string MSG_ERROR_READING_APPOINTMENTS = "[Something went wrong while reading appointments data!]";
    private const string MSG_ERROR_READING_PATIENT = "[Something went wrong while reading patient data!]";
    private const string MSG_ERROR_UPDATING_GP = "[Something went wrong while updating the patient's GP!]";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string patientId = Request.QueryString["patientId"];
            if (patientId == null || patientId.Trim() == "")
            {
                Response.Redirect("~/ErrorPages/PageNotFound.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            if (!IsUserLoggedIn())
            {
                Response.Redirect("~/ErrorPages/NotLoggedIn.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            if (!IsDoctorLoggedIn())
            {
                Response.Redirect("~/ErrorPages/NotAuthorized.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            ViewState["patient_id"] = patientId;
            ReadPatient();
            ReadPastAppointments();
            ReadUpcomingAppointments();
        }
    }

    private bool IsUserLoggedIn()
    {
        return Session["user_id"] != null && Session["user_type"] != null;
    }

    private bool IsDoctorLoggedIn()
    {
        UserType userType = (UserType)Session["user_type"];
        return userType == UserType.DOCTOR_GP || userType == UserType.DOCTOR_SPECIALIST;
    }

    private void SetupGpOptions(Patient patient)
    {
        if (patient == null)
        {
            btnAssignGp.Visible = false;
            btnRemoveGp.Visible = false;
            return;
        }
        string loggedDoctorId = (string)Session["user_id"];
        UserType loggedDoctorType = (UserType)Session["user_type"];
        if (loggedDoctorType != UserType.DOCTOR_GP)
        {
            btnAssignGp.Visible = false;
            btnRemoveGp.Visible = false;
            return;
        }
        if ((patient.DoctorId == null || patient.DoctorId == "") && loggedDoctorType == UserType.DOCTOR_GP)
        {
            btnAssignGp.Visible = true;
            btnRemoveGp.Visible = false;
            return;
        }
        if (patient.DoctorId != null && patient.DoctorId != "" && patient.DoctorId == loggedDoctorId)
        {
            btnAssignGp.Visible = false;
            btnRemoveGp.Visible = true;
        }
    }

    private void ReadPatient()
    {
        string id = (string)ViewState["patient_id"];
        Patient patient = DBUtils.FindPatientById(id);
        if (patient != null)
        {
            DisplayPatient(patient);
            if (patient.DoctorId != null && patient.DoctorId != "")
            {
                Doctor doctor = DBUtils.FindDoctorById(patient.DoctorId);
                if (doctor != null)
                {
                    lblGeneralPractitioner.Text = "Dr. " + doctor.Name + " " + doctor.Surname;
                }
                else
                {
                    lblGeneralPractitioner.Text = MSG_ERROR_READING_DOCTOR;
                }
            }
            else
            {
                lblGeneralPractitioner.Text = MSG_NO_GENERAL_PRACTITIONER;
            }
        }
        else
        {
            lblPersonalInfo.Text = MSG_ERROR_READING_PATIENT;
        }
        SetupGpOptions(patient);
    }

    private void DisplayPatient(Patient patient)
    {
        lblName.Text = patient.Name;
        lblSurname.Text = patient.Surname;
        lblSsn.Text = patient.Ssn;
        lblAddress.Text = patient.Address;
        lblEmail.Text = patient.Email;
        lblDateOfBirth.Text = patient.DateOfBirth;
        lblPersonalInfo.Text = "";
    }

    private void ReadPastAppointments()
    {
        string id = (string)ViewState["patient_id"];
        DataSet dataSet = DBUtils.GetAppointmentsForPatient(id, upcoming: false);
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

    protected void gvPastAppointments_SelectedIndexChanged(object sender, EventArgs e)
    {
        string id = gvPastAppointments.SelectedDataKey.Value.ToString();
        Response.Redirect("~/Appointments/AppointmentDetails.aspx?appId=" + Server.UrlEncode(id));
    }

    private void ReadUpcomingAppointments()
    {
        string id = (string)ViewState["patient_id"];
        DataSet dataSet = DBUtils.GetAppointmentsForPatient(id, upcoming: true);
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

    protected void gvUpcomingAppointments_SelectedIndexChanged(object sender, EventArgs e)
    {
        string id = gvUpcomingAppointments.SelectedDataKey.Value.ToString();
        Response.Redirect("~/Appointments/AppointmentDetails.aspx?appId=" + Server.UrlEncode(id));
    }

    protected void btnAssignGp_Click(object sender, EventArgs e)
    {
        string patientId = (string)ViewState["patient_id"];
        string doctorId = (string)Session["user_id"];
        bool success = DBUtils.UpdatePatientGp(patientId, doctorId);
        if (success)
        {
            Response.Redirect(Request.RawUrl);
        }
        else
        {
            lblGpInfo.Text = MSG_ERROR_UPDATING_GP;
        }
    }

    protected void btnRemoveGp_Click(object sender, EventArgs e)
    {
        string patientId = (string)ViewState["patient_id"];
        bool success = DBUtils.UpdatePatientGp(patientId, null);
        if (success)
        {
            Response.Redirect(Request.RawUrl);
        }
        else
        {
            lblGpInfo.Text = MSG_ERROR_UPDATING_GP;
        }
    }
}