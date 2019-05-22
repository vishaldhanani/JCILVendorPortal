function CheckLogIn()
{
    if ($('#username').val() == '')
    {
        alert('Please enter User Name');
    }
    else if ($('#password').val() == '') {
        alert('Please enter password.');
    }
    else
    {
        
        var Name = $('#username').val();
        var Pass = $('#password').val();
        try
        {
            $.ajax({
                type: "POST",
                url: "ClientSideWebMethod.aspx/LoginCredential",
                data: JSON.stringify({ 'Username': Name, 'Password': Pass }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    //alert(data.d);
                    if (data.d == 'Success') {
                        //window.location.href = "AgentCompany.aspx";
                        window.location.href = "frmDashboard.aspx";
                    }
                    else if (data.d == 'SuccessApp') {
                        //window.location.href = "AgentCompany.aspx";
                        window.location.href = "ChangePassword.aspx";
                    }
                    else {
                        alert('Please enter correct credentials.');
                        $('#tb_Password').val('');
                    }
                },
                error: function (data) {
                   alert(data.responseText);
                   // console.log(data);
                    //alert('Error');
                }
            });
        }
        catch(e)
        {
            alert(e);
        }
    }
}