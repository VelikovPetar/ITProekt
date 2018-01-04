using System;

[Serializable()]
public class Doctor
{
    public string Id { get; set; }
    public string Name { get; set; }
    public string Surname { get; set; }
    public string IsGp { get; private set; }
    public string Email { get; private set; }
    public string HospitalId { get; private set; }

    public Doctor()
    {

    }

    public Doctor(string id, string name, string surname, string isGp, string email, string hospitalId)
    {
        this.Id = id;
        this.Name = name;
        this.Surname = surname;
        this.IsGp = isGp;
        this.Email = email;
        this.HospitalId = hospitalId;
    }
}