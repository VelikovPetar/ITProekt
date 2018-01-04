using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;

public partial class Appointments_AddAppointment : System.Web.UI.Page
{
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
            Response.Redirect("~/ErrorPages/NotAuthorized.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }
        if (!Page.IsPostBack)
        {
            LoadPatients();
            LoadHospitals();
            LoadDates();
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
}