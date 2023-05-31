#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82004 "CRM+ Actual/Nominal Code"
{
    Caption = 'CRM+ Actual/Nominal Code';
    //LookupPageID = UnknownPage82008;

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "belongs to Code"; Option)
        {
            Caption = 'belongs to Code';
            OptionMembers = Code1,Code2,Code3,Code4,Code5,Code6;
        }
    }

    keys
    {
        key(Key1; "belongs to Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Contact.SetRange("Nominal 1", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Nominal 1");

        Contact.SetRange("Nominal 2", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Nominal 2");

        Contact.SetRange("Nominal 3", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Nominal 3");

        Contact.SetRange("Nominal 4", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Nominal 4");

        Contact.SetRange("Nominal 5", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Nominal 5");

        Contact.SetRange("Nominal 6", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Nominal 6");

        Contact.SetRange("Actual 1", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Actual 1");

        Contact.SetRange("Actual 2", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Actual 2");

        Contact.SetRange("Actual 3", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Actual 3");

        Contact.SetRange("Actual 4", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Actual 4");

        Contact.SetRange("Actual 5", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Actual 5");

        Contact.SetRange("Actual 6", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Actual 6");

        if ErrorFound then
            Error(Text001, Code);
    end;

    var
        Contact: Record Contact;
        Text001: label '%1 cannot be deleted, because records exist.';
        ErrorFound: Boolean;
}

