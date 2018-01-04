using System;

public class Hospital
{
    public string Id { get; private set; }
    public string Name { get; private set; }
    public string Address { get; private set; }

    public Hospital(string id, string name, string address)
    {
        this.Id = id;
        this.Name = name;
        this.Address = address;
    }
}