using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using System.Globalization;

public partial class Appointments_AddAppointment : System.Web.UI.Page
{

    private const string MSG_ERROR_MAKING_APPOINTMENT = "[An error occurred while saving the appointment!]";

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
        if (!Page.IsPostBack)
        {
            LoadPatients();
            LoadDates();
            LoadHospitals();
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

    private void LoadPatients()
    {
        string id = (string)Session["user_id"];
        DataSet dataSet = DBUtils.GetPatientsForGp(id);
        ddlPatient.DataSource = dataSet;
        ddlPatient.DataTextField = "full_name";
        ddlPatient.DataValueField = "id";
        ddlPatient.DataBind();
    }

    private void LoadHospitals()
    {
        List<Hospital> hospitals = DBUtils.GetHospitals();
        ddlHospital.Items.Clear();
        foreach (Hospital h in hospitals)
        {
            ddlHospital.Items.Add(new ListItem { Value = h.Id, Text = h.Name });
        }
        if (ddlHospital.Items.Count > 0)
        {
            LoadSpecialistsForHospital(ddlHospital.Items[0].Value.ToString());
        }
        if (ddlDoctor.Items.Count > 0 && ddlDate.Items.Count > 0)
        {
            LoadAvailableTimes(ddlDoctor.SelectedValue.ToString(), ddlDate.SelectedValue.ToString());
        }
    }

    private void LoadDates()
    {
        string[] dates = GetNextDays(10);
        ddlDate.Items.Clear();
        foreach (String date in dates)
        {
            ddlDate.Items.Add(new ListItem { Value = date, Text = date });
        }
    }


    protected void ddlHospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        string hospitalId = ddlHospital.SelectedValue.ToString();
        LoadSpecialistsForHospital(hospitalId);
        if (ddlDoctor.Items.Count > 0 && ddlDate.Items.Count > 0)
        {
            LoadAvailableTimes(ddlDoctor.SelectedValue.ToString(), ddlDate.SelectedValue.ToString());
        }
    }

    private void LoadSpecialistsForHospital(string hospitalId)
    {
        List<Doctor> doctors = DBUtils.GetDoctorsForHospital(hospitalId, isGp: "0");
        ddlDoctor.Items.Clear();
        foreach (Doctor d in doctors)
        {
            ddlDoctor.Items.Add(new ListItem { Value = d.Id, Text = "Dr. " + d.Name + " " + d.Surname });
        }
    }

    private string[] GetNextDays(int days)
    {
        string[] dates = new string[days];
        DateTime date = DateTime.Today;
        for (int i = 0; i < days; ++i)
        {
            date = date.AddDays(1);
            dates[i] = date.ToString("yyyy-MM-dd");
        }
        return dates;
    }

    protected void ddlDoctor_SelectedIndexChanged(object sender, EventArgs e)
    {
        string doctorId = ddlDoctor.SelectedValue.ToString();
        string date = ddlDate.SelectedValue.ToString();
        LoadAvailableTimes(doctorId, date);
    }

    protected void ddlDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        string doctorId = ddlDoctor.SelectedValue.ToString();
        string date = ddlDate.SelectedValue.ToString();
        LoadAvailableTimes(doctorId, date);
    }

    private void LoadAvailableTimes(string doctorId, string date)
    {
        List<Appointment> appointments = DBUtils.GetAppointmentsForDoctorOnDate(doctorId, date);
        IEnumerable<String> notAvailable = appointments.Select(it => it.Time);
        //lblInfo.Text = String.Join("--", notAvailable.ToArray());
        DateTime initial = DateTime.ParseExact("08:00:00", "HH:mm:ss", CultureInfo.InvariantCulture);
        ddlTime.Items.Clear();
        for (int i = 0; i < 24; ++i)
        {
            string stringRep = initial.ToString("HH:mm:ss");
            if (!notAvailable.Contains(stringRep))
            {
                ddlTime.Items.Add(new ListItem { Value = stringRep, Text = stringRep });
            }
            initial = initial.AddMinutes(20);
        }
    }

    protected void btnMakeAppointment_Click(object sender, EventArgs e)
    {
        AttemptMakeAppointment();
    }

    private void AttemptMakeAppointment()
    {
        string patientId = ddlPatient.SelectedValue.ToString();
        string doctorId = ddlDoctor.SelectedValue.ToString();
        string date = ddlDate.SelectedValue.ToString();
        string time = ddlTime.SelectedValue.ToString();
        string dateTime = date + " " + time;
        bool success = DBUtils.AttemptSaveAppointment(patientId, doctorId, dateTime);
        if (success)
        {
            lblInfo.Text = "Success";
            lblInfo.ForeColor = System.Drawing.Color.Black;
        }
        else
        {
            lblInfo.Text = MSG_ERROR_MAKING_APPOINTMENT;
            lblInfo.ForeColor = System.Drawing.Color.DarkRed;
        }
    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        UserType userType = (UserType)Session["user_type"];
        if (userType == UserType.DOCTOR_GP)
        {
            Response.Redirect("~/Home/GeneralPractitionerHomePage.aspx");
            return;
        }
        if (userType == UserType.DOCTOR_SPECIALIST)
        {
            Response.Redirect("~/Home/SpecialistHomePage.aspx");
            return;
        }
    }
}