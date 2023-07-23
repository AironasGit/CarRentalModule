page 50141 "Issued Auto Contracts"
{
    Caption = 'Issued Auto Contracts';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Header";
    Editable = false;
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
    trigger OnOpenPage()
    begin
        Rec.SetRange(Status, Rec.Status::Issued);
    end;
}