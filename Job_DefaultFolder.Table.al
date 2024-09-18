#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50016 Job_DefaultFolder
{

    fields
    {
        field(1; "Code"; Option)
        {
            OptionCaption = 'Projekt,Unterprojekt';
            OptionMembers = Project,Subproject;
        }
        field(2; Index; Integer)
        {
        }
        field(10; "Folder Name"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code", Index)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

