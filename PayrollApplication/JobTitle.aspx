<%@ Page Title="Job Title" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JobTitle.aspx.cs" Inherits="PayrollApplication.JobTitle" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   
    <h2><%: Title %>.</h2>
   
    <table style="margin-top: 20px; width: 100%">
        <tr style="width: 100%">
            <td style="width: 10%">
                <label>Job Code<span class="requiredmsg">*</span></label>
            </td>
            <td>
                <asp:TextBox runat="server" CssClass="form-control required" ID="JobCode" MaxLength="49" autocomplete="off"></asp:TextBox>
            </td>
            <td style="width: 10%">
                <label>Description<span class="requiredmsg">*</span></label>
            </td>
            <td>
                <asp:TextBox runat="server" CssClass="form-control required" ID="Description" MaxLength="499" TextMode="MultiLine" autocomplete="off"></asp:TextBox>
            </td>
            <td style="width: 10%">
                <label>Salary<span class="requiredmsg">*</span></label>
            </td>
            <td>
                <asp:TextBox runat="server" CssClass="form-control numeric required" ID="Salary" MaxLength="21" autocomplete="off"></asp:TextBox>
            </td>
            <td>
                <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="btn btn-primary btn-lg" OnClick="btnSave_Click" OnClientClick="return Js_Save(event);"/>
                <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="btn btn-default btn-lg" style="background-color:darkgoldenrod;color:white;font:bolder" OnClientClick="Js_Clear();" />
                <asp:HiddenField ID="AutoID" runat="server" />
            </td>
            <td>
                <asp:Label runat="server" ID="lblmsg" CssClass="lblmsg"></asp:Label>
            </td>
        </tr>

        <tr>
            <td colspan="10">
                <div id="panel" style="height: 500px; background-color: White; padding: 10px; overflow: auto">
                    <asp:GridView ID="GridView" runat="server" CssClass="EU_DataTable" AutoGenerateColumns="false" OnRowEditing="GridView_RowEditing"
                        OnRowUpdating="GridView_RowUpdating" DataKeyNames="AutoID" OnRowCancelingEdit="GridView_RowCancelingEdit" OnRowDeleting="GridView_RowDeleting" PageSize="25" AllowPaging="true" OnPageIndexChanging="GridView_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr" HeaderText="SR.NO">
                                <ItemTemplate>
                                    <asp:Label ID="lblID" runat="server"
                                         Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="200px" HeaderText="Code" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr">
                                <ItemTemplate>
                                    <asp:Label ID="lblCode" runat="server" Text='<%#Eval("Code")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCode" CssClass="form-control" runat="server" Text='<%#Eval("Code")%>'></asp:TextBox>
                                </EditItemTemplate>
                                
                            </asp:TemplateField>
                             <asp:TemplateField ItemStyle-Width="600px" HeaderText="Description" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr">
                                <ItemTemplate>
                                    <asp:Label ID="lblDescription" runat="server" Text='<%#Eval("Description")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDescription" CssClass="form-control" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField ItemStyle-Width="200px" HeaderText="Salary" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr">
                                <ItemTemplate>
                                    <asp:Label ID="lblSalary" runat="server" Text='<%#Eval("Salary")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control numeric" Text='<%#Eval("Salary")%>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkRemove" runat="server" CommandArgument='<%#  
                                         Eval("AutoID")%>'
                                        OnClientClick="return confirm('Do you want to delete?')"
                                        Text="Delete" OnClick="lnkRemove_Click"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:CommandField ShowEditButton="True" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField Visible="false" DataField="AutoID" />
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
        </tr>
    </table>
    <style>
        tr, td {
            padding: 15px;
            text-align: left;
        }

        .lblmsg {
            font-weight: bold;
        }
        .requiredmsg{
            color:red;
        }
        .grdHdr{
            background-color:darkcyan;
            font-weight:bold;
            color:white;
            text-align:center;
            height:50px;
            width:150px;
        }
        .grdItem{
            background-color:white;
            color:black;
            text-align:center;
            width:150px;
        }
    </style>
    <script>
        function Js_Clear() {
            $('[id*="lblmsg"]').text('');
            $('[id*="JobCode"]').val('');
            $('[id*="Description"]').val('');
            $('[id*="Salary"]').val('');
            //$("table[id$='GridView']").html("");
        }
        function Js_Save(e) {
            debugger;
            $('[id*="lblmsg"]').removeClass('requiredmsg');
            $('[id*="lblmsg"]').text('');
            var cont = true;
            var list = "";
            $(".required").each(function () {
                if ($(this).val() == "") {
                    cont = false;
                    if (list == "") {
                        list = $(this).attr('id').replace('MainContent_', '');
                    }
                    else {
                        list = list + ' , ' + $(this).attr('id').replace('MainContent_', '');
                    }
                    console.log(list);
                    $('[id*="lblmsg"]').text(list + ' required');
                    $('[id*="lblmsg"]').addClass('requiredmsg');
                }
            });
            return cont;
        }
        $(document).ready(function () {
            $(".numeric").keydown(function (event) {


                if (event.shiftKey == true) {
                    event.preventDefault();
                }

                if ((event.keyCode >= 48 && event.keyCode <= 57) ||
                    (event.keyCode >= 96 && event.keyCode <= 105) ||
                    event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
                    event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190) {

                } else {
                    event.preventDefault();
                }

                if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
                    event.preventDefault();
            });

        });
    </script>
</asp:Content>
