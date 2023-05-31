Table 50009 "Job Type"
{
    Caption = 'Job Type';
    // DrillDownPageID = "Job Type";
    // LookupPageID = "Job Type";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(20; "Default Status"; Option)
        {
            Caption = 'Default Status';
            Description = 'Planning,Quote,Order,Completed';
            OptionCaption = 'Planning,Quote,Order,Completed';
            OptionMembers = Planning,Quote,"Order",Completed;
        }
        field(31; "List Sorting"; Integer)
        {
            Caption = 'List Sorting';
        }
        field(50; "Job Type when Order"; Code[10])
        {
            Caption = 'Job Type when Order';
            Description = 'TR Job Type';
            // TableRelation = "Job Type";
        }
        field(100; "Job Nos."; Code[10])
        {
            Caption = 'Job Nos.';
            Description = 'TR "No. Series"';
            TableRelation = "No. Series";
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
}

