#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82008 "Competency Code"
{
    Caption = 'Competency Code';
    //LookupPageID = UnknownPage82018;

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
        rCompetency.SetRange(rCompetency.Code, Code);
        if rCompetency.Find('-') then
            Error(Text100, FieldCaption(Code), Code);
    end;

    var
        rCompetency: Record Competency;
        Text100: label 'You cannot delete %1 %2 because there are one or more contacts with this value.';
}

