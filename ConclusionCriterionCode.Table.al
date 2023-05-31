#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82013 "Conclusion Criterion Code"
{
    Caption = 'Conclusion Criterion Code';
    //LookupPageID = UnknownPage82017;

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
        field(3; Rating; Decimal)
        {
            Caption = 'Rating';
            MaxValue = 100;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Contact.SetRange("Conclusion Criterion Code 1", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Conclusion Criterion Code 1");
        Contact.SetRange("Conclusion Criterion Code 2", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Conclusion Criterion Code 2");
        Contact.SetRange("Conclusion Criterion Code 3", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Conclusion Criterion Code 3");
        Contact.SetRange("Conclusion Criterion Code 4", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Conclusion Criterion Code 4");
        Contact.SetRange("Conclusion Criterion Code 5", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Conclusion Criterion Code 5");
        Contact.SetRange("Conclusion Criterion Code 6", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Conclusion Criterion Code 6");
        Contact.SetRange("Conclusion Criterion Code 7", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Conclusion Criterion Code 7");
        if ErrorFound then
            Error(Text001, Code);
    end;

    var
        Contact: Record Contact;
        Text001: label '%1 cannot be deleted, because records exist.';
        ErrorFound: Boolean;
}

