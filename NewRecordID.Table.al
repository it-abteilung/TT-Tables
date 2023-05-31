#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50025 "New RecordID"
{

    fields
    {
        field(1;"Table No";Integer)
        {
            Caption = 'Tabellen Nummer';
        }
        field(2;"Table Name";Text[50])
        {
            Caption = 'Tabellen Name';
        }
        field(3;"Entry No";Integer)
        {
            Caption = 'Lfd. Nr.';
        }
        field(10;"File Name";Text[250])
        {
            Caption = 'Datei Name';
        }
        field(20;RecordID;Text[80])
        {
        }
    }

    keys
    {
        key(Key1;"Table No","Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

