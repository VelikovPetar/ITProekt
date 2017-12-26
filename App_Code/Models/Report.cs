public class Report
{
    public string Id { get; private set; }
    public string Diagnosis { get; private set; }
    public string Therapy { get; private set; }
    public string Remark { get; private set; }
    public string AppointmentId { get; private set; }

    public Report(string id, string diagnosis, string therapy, string remark, string appoinmentId)
    {
        this.Id = id;
        this.Diagnosis = diagnosis;
        this.Therapy = therapy;
        this.Remark = remark;
        this.AppointmentId = appoinmentId;
    }
}