using System;

[Serializable()]
public class Patient
{
    public string Id { get; private set; }
    public string Name { get; private set; }
    public string Surname { get; private set; }
    public string Ssn { get; private set; }
    public string Address { get; private set; }
    public string Email { get; private set; }
    public string DateOfBirth { get; private set; }
    public string DoctorId { get; private set; }

    public Patient(string id, string name, string surname, string ssn, string address, string email, string dateOfBirth, string doctorId)
    {
        this.Id = id;
        this.Name = name;
        this.Surname = surname;
        this.Ssn = ssn;
        this.Address = address;
        this.Email = email;
        this.DateOfBirth = dateOfBirth;
        this.DoctorId = doctorId;
    }

}