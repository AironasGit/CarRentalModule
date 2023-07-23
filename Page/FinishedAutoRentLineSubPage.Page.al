page 50144 "Finished Auto Rent LineSubPage"
{
    Caption = 'Auto Rent Line SubPage';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Finished Auto Rent Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantity';
                }
                field(Price; Rec.Price)
                {
                    ToolTip = 'Price';
                }
                field(Sum; Rec.Sum)
                {
                    ToolTip = 'Sum';
                }
            }
        }
    }
}