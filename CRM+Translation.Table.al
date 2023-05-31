#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82003 "CRM+ Translation"
{
    Caption = 'CRM+ Translation';
    //DrillDownPageID = UnknownPage82007;

    fields
    {
        field(1; "Field ID"; Integer)
        {
            Caption = 'Field ID';
            NotBlank = true;
        }
        field(2; "Language ID"; Integer)
        {
            Caption = 'Language ID';
            NotBlank = true;
            TableRelation = "Windows Language";

            trigger OnValidate()
            begin
                CalcFields("Language Name");
            end;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(6; "Language Name"; Text[80])
        {
            CalcFormula = lookup("Windows Language".Name where("Language ID" = field("Language ID")));
            Caption = 'Language Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Field ID", "Language ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

