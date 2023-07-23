page 50138 "Auto Rent Header List"
{
    Caption = 'Auto Rent Header List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Header";
    CardPageId = "Auto Rent Header Card";
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Client No.';
                }
                field("Drivers License"; Rec."Drivers License")
                {
                    ToolTip = 'Drivers License';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                }
                field("Car No."; Rec."Car No.")
                {
                    ToolTip = 'Car No.';
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ToolTip = 'Reserved From Date';
                }
                field("Reserved Until"; Rec."Reserved Until")
                {
                    ToolTip = 'Reserved Until';
                }
                field(Sum; Rec.Sum)
                {
                    ToolTip = 'Sum';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Status';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportDriversLicense)
            {
                ToolTip = 'Import Drivers License';
                Caption = 'Import Drivers License';
                ApplicationArea = All;
                Image = Import;

                trigger OnAction()
                var
                    AutoRentHeaderManagement: Codeunit "Auto Rent Header - Management";
                begin
                    AutoRentHeaderManagement.ImportDriverLicense(Rec);
                end;
            }
            action(DeleteDriversLicense)
            {
                ToolTip = 'Delete Drivers License';
                Caption = 'Delete Drivers License';
                ApplicationArea = All;
                Image = Delete;

                trigger OnAction()
                var
                    AutoRentHeaderManagement: Codeunit "Auto Rent Header - Management";
                begin
                    AutoRentHeaderManagement.DeleteDriverLicense(Rec);
                end;
            }
            action(ChangeStatusToIssued)
            {
                Caption = 'Change Status To Issued';
                ToolTip = 'Change Status To Issued';

                trigger OnAction()
                var
                    AutoRentHeaderManagement: Codeunit "Auto Rent Header - Management";
                begin
                    AutoRentHeaderManagement.ChangeStatusToIssued(Rec);
                end;
            }
            action(Return)
            {
                Caption = 'Return Car';
                ToolTip = 'Return Car';
                Image = Return;
                trigger OnAction()
                var
                    AutoRentHeaderManagement: Codeunit "Auto Rent Header - Management";
                    CarReturnedMsg: Label 'The car has been returned';
                begin
                    AutoRentHeaderManagement.InsertAutoDamage(Rec);
                    AutoRentHeaderManagement.InsertFinishedAutoRentHeader(Rec);
                    AutoRentHeaderManagement.InsertFinishedAutoRentLine(Rec);
                    AutoRentHeaderManagement.DeleteAutoRentContract(Rec);
                    Message(CarReturnedMsg);
                end;
            }
        }
    }
}