<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegisterPatient.aspx.cs" Inherits="Auth_RegisterPatient" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-3.2.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        function getGpsForHospital(hospitalId) {
            $.getJSON("/api/services/GetDoctorsForHospital?hospitalId=" + hospitalId,
                function (data) {
                    console.log(data);
                    $('#ddlGeneralPractioner').find('option').remove();
                    if (data.length == 0) {
                        var option = '<option value="-----">-----</option>';
                        $('#ddlGeneralPractioner').append(option);
                    } else {
                        $.each(data, function (key, value) {
                            var id = value.Id;
                            var name = value.Name;
                            var surname = value.Surname;
                            var option = '<option value=' + id + '>' + "Dr. " + name + " " + surname + '</option>';
                            $('#ddlGeneralPractioner').append(option);
                        });
                    }
                });
        }

        function saveHospitalToHiddenField() {
            var id = $('#ddlGeneralPractioner').find(':selected').val();
            var name = $('#ddlGeneralPractioner').find(':selected').text();
            $('#hiddenFieldDoctorId').val(id);
            $('#hiddenFieldDoctorName').val(name);
        }

        $(document).ready(function () {
            $('#ddlHospital').change(function () {
                var hospitalId = $('#ddlHospital').find(':selected').val();
                getGpsForHospital(hospitalId);
            });

            $('#btnRegister').click(function () {
                saveHospitalToHiddenField();
            });
        });
    </script>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }

        .auto-style2 {
            width: 179px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h3>Fill this form to register as a new patient:</h3>
            <p>
                <asp:HiddenField ID="hiddenFieldDoctorId" runat="server" />
                <asp:HiddenField ID="hiddenFieldDoctorName" runat="server" />
            </p>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" Display="None" ErrorMessage="You must enter your name!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblSurname" runat="server" Text="Surname"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtSurname" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSurname" Display="None" ErrorMessage="You must enter your surname!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" Display="None" ErrorMessage="You must enter your email!"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" Display="None" ErrorMessage="You must enter a valid email!" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblDateOfBirth" runat="server" Text="Date of birth"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDateOfBirth" runat="server" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDateOfBirth" Display="None" ErrorMessage="You must enter your date of birth!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblSsn" runat="server" Text="SSN"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtSsn" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtSsn" Display="None" ErrorMessage="You must enter your SSN!"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtSsn" Display="None" ErrorMessage="You must enter a valid Ssn(13 digits)!" ValidationExpression="^[0-9]{13}$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblPhoneNumber" runat="server" Text="Phone number"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPhoneNumber" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtPassword" Display="None" ErrorMessage="You must enter a password!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm password"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtConfirmPassword" Display="None" ErrorMessage="You must confirm your password!"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" Display="None" ErrorMessage="Passwords must match!"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblHospital" runat="server" Text="Hospital"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlHospital" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblGeneralPractitioner" runat="server" Text="General practioner"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlGeneralPractioner" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Button ID="btnRegister" runat="server" OnClick="btnRegister_Click" Text="Register" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>

        </div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#CC0000" />
        <asp:Label ID="lblInfo" runat="server"></asp:Label>
    </form>
</body>
</html>
