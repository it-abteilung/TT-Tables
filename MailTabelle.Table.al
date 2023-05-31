Table 50020 "Mail Tabelle"
{

    fields
    {
        field(1;Zeilennr;Integer)
        {
        }
        field(10;Erstellungsdatum;DateTime)
        {
        }
        field(20;Sendedatum;DateTime)
        {
        }
        field(30;UserID;Code[50])
        {
        }
        field(40;"Empfängermail";Text[250])
        {
        }
        field(50;"CC Mail";Text[250])
        {
        }
        field(60;"BCC Mail";Text[250])
        {
        }
        field(70;Absendermail;Text[50])
        {
        }
        field(80;Betreff;Text[250])
        {
        }
        field(90;Body;Text[250])
        {
        }
        field(140;TableID;Integer)
        {
        }
        field(150;Key1;Text[30])
        {
        }
        field(160;Key2;Text[30])
        {
        }
        field(170;Key3;Text[30])
        {
        }
        field(180;Dateiname;Text[250])
        {
        }
    }

    keys
    {
        key(Key1;Zeilennr)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

