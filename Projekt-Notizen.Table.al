#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50001 "Projekt-Notizen"
{

    fields
    {
        field(1;"Job No.";Code[20])
        {
            Caption = 'No.';
        }
        field(100;"Anfrage über1";Text[250])
        {
        }
        field(110;"Anfrage über2";Text[250])
        {
        }
        field(120;"Anfrage über3";Text[250])
        {
        }
        field(200;"Zu beachten1";Text[250])
        {
        }
        field(210;"Zu beachten2";Text[250])
        {
        }
        field(220;"Zu beachten3";Text[250])
        {
        }
        field(300;Montagegruppe1;Text[250])
        {
        }
        field(310;Montagegruppe2;Text[250])
        {
        }
        field(320;Montagegruppe3;Text[250])
        {
        }
    }

    keys
    {
        key(Key1;"Job No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

