report 50130 "Car Rent Report"
{
    Caption = 'Car Rent Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Main;

    dataset
    {
        dataitem(AutoRentHeader; "Auto Rent Header")
        {
            PrintOnlyIfDetail = true;
            column(Car_No; "Car No.")
            {
            }
            dataitem(DataItemName; Auto)
            {
                DataItemLink = "No." = field("Car No.");
                column(Brand; Brand)
                {
                }
                column(Model; Model)
                {
                }
            }
            column(Reserved_From; "Reserved From")
            {
            }
            column(Reserved_Until; "Reserved Until")
            {
            }
            dataitem(AutoRentLine; "Auto Rent Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Price; Price)
                {
                }
                column(Line_Sum; Sum)
                {
                }
            }
            // column(First_Line_Sum;)
            // {
            // }
            // column(Other_Line_Sum;)
            // { 
            // }
            column(Total_Sum; Sum)
            {
            }
        }
    }

    rendering
    {
        layout(Main)
        {
            Type = RDLC;
            LayoutFile = './Layout/Car Rent.rdl';
        }
    }
}