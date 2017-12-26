﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Appointment
{
    public string Id { get; private set; }
    public string PatientId { get; private set; }
    public string PatientName { get; private set; }
    public string PatientSurname { get; private set; }
    public string PatientSsn { get; private set; }
    public string DoctorId { get; private set; }
    public string DoctorName { get; private set; }
    public string DoctorSurname { get; private set; }
    private string DateTime;
    public bool HasReport { get; private set; }
    public string Date
    {
        get { return DateTime.Split(' ')[0]; }
    }
    public string Time
    {
        get { return DateTime.Split(' ')[1]; }
    }

    public Appointment(string id, string patientId, string patientName, string patientSurname, string patientSsn, 
        string doctorId, string doctorName, string doctorSurname, string dateTime, bool hasReport)
    {
        this.Id = id;
        this.PatientId = patientId;
        this.PatientName = patientName;
        this.PatientSurname = patientSurname;
        this.PatientSsn = patientSsn;
        this.DoctorId = doctorId;
        this.DoctorName = doctorName;
        this.DoctorSurname = doctorSurname;
        this.DateTime = dateTime;
        this.HasReport = hasReport;
    }
}