using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_PatientDetails : System.Web.UI.Page
{
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
            else
            {
                ViewState["patient_id"] = patientId;
                lblPatientId.Text = patientId;
            }
        }
    }
}