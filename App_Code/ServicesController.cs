using System.Collections.Generic;
using System.Web.Http;

public class ServicesController : ApiController
{
    public IEnumerable<Doctor> GetDoctorsForHospital(string hospitalId)
    {
        if (hospitalId == "-----")
        {
            return new List<Doctor>();
        }
        List<Doctor> doctors = DBUtils.GetDoctorsForHospital(hospitalId);
        return doctors;
    }
}
