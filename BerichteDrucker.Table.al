#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50002 "Berichte Drucker"
{

    fields
    {
        field(1;ReportID;Integer)
        {
        }
        field(2;TableID;Integer)
        {
        }
        field(3;RecordKey1;Code[20])
        {
        }
        field(4;RecordKey2;Code[20])
        {
        }
        field(5;RecordKey3;Code[20])
        {
        }
        field(6;RecordKey4;Code[20])
        {
        }
        field(7;RecordKey5;Code[20])
        {
        }
        field(8;"Auftrag Datum";DateTime)
        {
        }
        field(9;"Auftrag UserId";Code[50])
        {
        }
        field(10;Druckername;Text[250])
        {
        }
        field(20;Erledigt;Boolean)
        {
        }
        field(30;"Gedruckt Datum";DateTime)
        {
        }
        field(40;Anzahl;Integer)
        {
        }
    }

    keys
    {
        key(Key1;ReportID,TableID,RecordKey1,RecordKey2,RecordKey3,RecordKey4,RecordKey5,"Auftrag Datum")
        {
            Clustered = true;
        }
        key(Key2;"Auftrag Datum")
        {
        }
    }

    fieldgroups
    {
    }
}

