<%@ Page Title="Payroll" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Payroll.aspx.cs" Inherits="PayrollApplication.Payroll" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <table style="margin-top: 20px; width: 100%">
        <tr>
            <td style="width: 10%">
                <label>Employee<span class="requiredmsg">*</span></label>
            </td>
            <td>
                <asp:DropDownList runat="server" CssClass="form-control required" ID="Employee" autocomplete="off">
                </asp:DropDownList>
            </td>
            <td style="width: 10%">
                <label>Month<span class="requiredmsg">*</span></label>
            </td>
            <td>
                <asp:DropDownList runat="server" CssClass="form-control required" ID="Month" autocomplete="off">
                </asp:DropDownList>
            </td>

        </tr>
        <tr>
            <td style="width: 10%">
                <label>Year<span class="requiredmsg">*</span></label>
            </td>
            <td>
                <asp:DropDownList runat="server" CssClass="form-control required" ID="Year" autocomplete="off">
                </asp:DropDownList>
            </td>
            <td style="width: 10%">
                <label>Working Hours<span class="requiredmsg">*</span></label>
            </td>
            <td>
                <asp:TextBox runat="server" CssClass="form-control numeric required" ID="Hours" autocomplete="off"></asp:TextBox>
            </td>
            <td style="width: 20%">
                <asp:Button runat="server" ID="btnSave" Text="Generate Payroll" CssClass="btn btn-primary btn-lg" OnClick="btnSave_Click" OnClientClick="return Js_Save(event);" />
                <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="btn btn-default btn-lg" style="background-color:darkgoldenrod;color:white;font:bolder" OnClientClick="Js_Clear();" />
                <asp:Label runat="server" ID="lblmsg" CssClass="lblmsg"></asp:Label>
            </td>

        </tr>

        <tr style="width:100%">
            <td colspan="15">
                <div id="panel" style="height: 500px; background-color: White; padding: 0px; overflow: auto;width:100%">
                    <asp:GridView ID="GridView" runat="server" CssClass="EU_DataTable" AutoGenerateColumns="false" PageSize="25" AllowPaging="true" OnPageIndexChanging="GridView_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderStyle-CssClass="grdHdr" HeaderText="SR.NO" ItemStyle-CssClass="grdItem">
                                <ItemTemplate>
                                    <asp:Label ID="lblID" runat="server"
                                        Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Code" HeaderText="Code" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="Duration" HeaderText="No Of Year" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="JobCode" HeaderText="Job Code" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="Description" HeaderText="Job Title" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="WorkingHours" HeaderText="Total Working Hours" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="WagesPerHour" HeaderText="Wages Per Hour" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="TotalSalary" HeaderText="Total Salary" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="BasicSalary" HeaderText="Basic Salary" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="Housing" HeaderText="Housing" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="Transport" HeaderText="Transport" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="TaxableAmt" HeaderText="Taxable Amount" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField DataField="tax" HeaderText="Tax" ItemStyle-CssClass="grdItem" HeaderStyle-CssClass="grdHdr"/>
                            <asp:BoundField Visible="false" DataField="AutoID" />
                            <asp:BoundField Visible="false" DataField="Month" />
                            <asp:BoundField Visible="false" DataField="Year" />
                            <asp:HyperLinkField ItemStyle-CssClass="grdItem" Target="_blank" HeaderStyle-CssClass="grdHdr" DataNavigateUrlFields="Name, Code, TotalSalary, BasicSalary, Housing,Transport,tax,Month,Year" DataNavigateUrlFormatString="PaySlipReport.aspx?Name={0}&Code={1}&TotalAmt={2}&Basic={3}&Housing={4}&Transport={5}&Tax={6}&Month={7}&Year={8}" Text="PaySlip" />

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

        .requiredmsg {
            color: red;
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
            $('[id*="Employee"]').val('');
            $('[id*="Month"]').val('');
            $('[id*="Year"]').val('');
            $('[id*="Hours"]').val('');
            $("table[id$='GridView']").html("");
        }
        function Js_Save(e) {
            $('[id*="lblmsg"]').removeClass('requiredmsg');
            $('[id*="lblmsg"]').text('');
            var cont = true;
            var list = "";
            $(".required").each(function () {
                if ($(this).val() == "" || $(this).val() == "0") {
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
            //LoadYears();
            function LoadYears() {
                var nowY = new Date().getFullYear(),
                    options = "";

                for (var Y = nowY; Y >= 1950; Y--) {
                    options += "<option value='"+Y+"'>" + Y + "</option>";
                }

                $('[id*="Year"]').append(options);
            }
            //loadMonth();
            function loadMonth() {
                var date = new Date();
                date.setMonth(date.getMonth());
                var months = 12;
                var monthNames = ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"
                ];
                var select = document.getElementById('Month');
                var html = '';
                for (var i = 0; i < months; i++) {
                    var m = date.getMonth();
                    html += '<option value="' + monthNames[m] + '">' + monthNames[m] + '</option>'
                    date.setMonth(date.getMonth()+1);
                }
                $('[id*="Month"]').append(html);
            }
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
