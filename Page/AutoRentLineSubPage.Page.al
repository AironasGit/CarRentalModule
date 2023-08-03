page 50142 "Auto Rent Line SubPage"
{
    Caption = 'Auto Rent Line SubPage';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Auto Rent Line";

    AutoSplitKey = true;
    LinksAllowed = false;
    DelayedInsert = true;
    DeleteAllowed = false;
    MultipleNewLines = true;
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
                    trigger OnValidate()
                    begin
                        FillDescrption();
                        FillPrice();
                    end;
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
    local procedure FillDescrption()
    var
        Item: Record Item;
        Resource: Record Resource;
    begin
        case Rec.Type of
            Rec.Type::Item:
                if Item.Get(Rec."No.") then
                    Rec.Description := Item.Description;
            Rec.Type::Resource:
                if Resource.Get(Rec."No.") then
                    //Resource does not have a Description field so Name is used instead
                    Rec.Description := Resource.Name;
        end;
    end;

    local procedure FillPrice()
    var
        Item: Record Item;
        Resource: Record Resource;
    begin
        case Rec.Type of
            Rec.Type::Item:
                if Item.Get(Rec."No.") then
                    Rec.Price := Item."Unit Price";
            Rec.Type::Resource:
                if Resource.Get(Rec."No.") then
                    Rec.Price := Resource."Unit Price";
        end;
    end;
}