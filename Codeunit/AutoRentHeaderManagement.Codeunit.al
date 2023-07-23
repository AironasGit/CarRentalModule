codeunit 50130 "Auto Rent Header - Management"
{
    TableNo = "Auto Rent Header";
    procedure ChangeStatusToIssued(var AutoRentHeader: Record "Auto Rent Header")
    begin
        AutoRentHeader.Status := AutoRentHeader.Status::Issued;
        AutoRentHeader.Modify(true);
    end;

    procedure DeleteDriverLicense(var AutoRentHeader: Record "Auto Rent Header")
    var
        TenantMedia: Record "Tenant Media";
        Answer: Boolean;
        SuccessMsg: Label 'Drivers License image has been removed';
        QuestionMsg: Label 'Are you sure you want to delete the drivers license image?';
    begin
        if TenantMedia.Get(AutoRentHeader."Drivers License".MediaId) then begin
            TenantMedia.CalcFields(Content);
            if TenantMedia.Content.HasValue then begin
                Answer := Dialog.Confirm(QuestionMsg, true);
                if Answer then begin
                    TenantMedia.Delete();
                    AutoRentHeader.Modify(true);
                    Message(SuccessMsg);
                end;
            end;
        end;
    end;

    procedure ImportDriverLicense(var AutoRentHeader: Record "Auto Rent Header")
    var
        FromFileName: Text;
        InS: InStream;
        SuccessMsg: Label 'Drivers License image has been added';
    begin
        if UploadIntoStream('Import', '', '', FromFileName, InS) then begin
            AutoRentHeader."Drivers License".ImportStream(InS, FromFileName);
            AutoRentHeader.Modify(true);
            Message(SuccessMsg);
        end;
    end;

    procedure InsertFinishedAutoRentHeader(var AutoRentHeader: Record "Auto Rent Header")
    var
        FinishedAutoRentHeader: Record "Finished Auto Rent Header";
    begin
        FinishedAutoRentHeader.Init();

        FinishedAutoRentHeader."No." := AutoRentHeader."No.";
        FinishedAutoRentHeader."Client No." := AutoRentHeader."Client No.";
        FinishedAutoRentHeader."Driver License" := AutoRentHeader."Drivers License";
        FinishedAutoRentHeader.Date := AutoRentHeader.Date;
        FinishedAutoRentHeader."Car No." := AutoRentHeader."Car No.";
        FinishedAutoRentHeader."Reserved From" := AutoRentHeader."Reserved From";
        FinishedAutoRentHeader."Reserved Until" := AutoRentHeader."Reserved Until";
        FinishedAutoRentHeader.Sum := AutoRentHeader.Sum;

        FinishedAutoRentHeader.Insert(true);
    end;

    procedure InsertAutoDamage(var AutoRentHeader: Record "Auto Rent Header")
    var
        AutoDamage: Record "Auto Damage";
        AutoRentDamage: Record "Auto Rent Damage";
    begin
        if AutoRentDamage.Get(AutoRentHeader."No.") then begin
            AutoDamage.Init();

            AutoDamage."Car No." := AutoRentDamage."Document No.";
            AutoDamage.Date := AutoRentDamage.Date;
            AutoDamage.Description := AutoRentDamage.Description;

            AutoDamage.Insert(true);
        end;
    end;

    procedure InsertFinishedAutoRentLine(var AutoRentHeader: Record "Auto Rent Header")
    var
        AutoRentLine: Record "Auto Rent Line";
        FinishedAutoRentLine: Record "Finished Auto Rent Line";
    begin
        AutoRentLine.Reset();
        AutoRentLine.SetFilter("Document No.", AutoRentHeader."No.");

        if AutoRentLine.FindSet() then
            repeat
                FinishedAutoRentLine.Init();

                FinishedAutoRentLine."Document No." := AutoRentLine."Document No.";
                FinishedAutoRentLine."Line No." := AutoRentLine."Line No.";
                FinishedAutoRentLine.Type := AutoRentLine.Type;
                FinishedAutoRentLine."No." := AutoRentLine."No.";
                FinishedAutoRentLine.Description := AutoRentLine.Description;
                FinishedAutoRentLine.Quantity := AutoRentLine.Quantity;
                FinishedAutoRentLine.Price := AutoRentLine.Price;
                FinishedAutoRentLine.Sum := AutoRentLine.Sum;

                FinishedAutoRentLine.Insert(true);
            until AutoRentLine.Next() = 0;
    end;

    procedure DeleteAutoRentContract(var AutoRentHeader: Record "Auto Rent Header")
    var
        AutoRentLine: Record "Auto Rent Line";
    begin
        AutoRentLine.Reset();
        AutoRentLine.SetFilter("Document No.", AutoRentHeader."No.");
        AutoRentHeader.Reset();
        AutoRentHeader.SetFilter("No.", AutoRentHeader."No.");

        AutoRentHeader.DeleteAll();
        AutoRentLine.DeleteAll();
    end;
}