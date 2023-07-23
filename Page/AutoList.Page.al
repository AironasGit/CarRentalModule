page 50133 "Auto List"
{
    Caption = 'Auto List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Auto;
    CardPageId = "Auto Card";
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
                field(Name; Rec.Name)
                {
                    ToolTip = 'Name';
                }
                field(Brand; Rec.Brand)
                {
                    ToolTip = 'Brand';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Model';
                }
                field("Manufacture Year"; Rec."Manufacture Year")
                {
                    ToolTip = 'Manufacture Year';
                }
                field("Civil Insurance"; Rec."Civil Insurance")
                {
                    ToolTip = 'Civil insurance is valid until';
                }
                field(TA; Rec.TA)
                {
                    ToolTip = 'TA is valid until';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Location Code';
                }
                field("Rental Service"; Rec."Rental Service")
                {
                    ToolTip = 'Rental Service';
                }
                field("Rental Price"; Rec."Rental Price")
                {
                    ToolTip = 'Rental Price';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ReservationList)
            {
                Caption = 'Reservation List';
                ToolTip = 'Reservation List';
                Image = Action;

                ApplicationArea = All;

                RunObject = Page "Reservation List";
            }
        }
    }
}