#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82009 Competency
{
    Caption = 'Competency';
    //DrillDownPageID = UnknownPage82019;
    //LookupPageID = UnknownPage82019;

    fields
    {
        field(1; "Contactno."; Code[20])
        {
            Caption = 'Contactno.';
            TableRelation = Contact;
        }
        field(2; "Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = "Competency Code";
        }
        field(3; Description; Text[50])
        {
            CalcFormula = lookup("Competency Code".Description where(Code = field(Code)));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Contactno.", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

