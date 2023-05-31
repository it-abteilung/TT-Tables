#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82007 History
{
    Caption = 'History';

    fields
    {
        field(1;"Contactno.";Code[20])
        {
            Caption = 'Contactno.';
            TableRelation = Contact;
        }
        field(2;"Line No.";Integer)
        {
            Caption = 'Line No.';
        }
        field(3;Date;Date)
        {
            Caption = 'Date';
        }
        field(4;History;Text[70])
        {
            Caption = 'History';
        }
    }

    keys
    {
        key(Key1;"Contactno.","Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //SearchManagement.DeleteCRMPHistory("Contactno.","Line No.");
    end;

    trigger OnInsert()
    begin
        //SearchManagement.ParseCRMPHistory(Rec,FALSE);
    end;

    trigger OnModify()
    begin
        //SearchManagement.ParseCRMPHistory(Rec,FALSE);
    end;

    var
        rHistory: Record History;


    procedure newLine()
    begin
        rHistory := Rec;
        rHistory.SetRecfilter;
        rHistory.SetRange("Line No.");
        if not rHistory.Find('-') then
          Date := WorkDate;
    end;
}

