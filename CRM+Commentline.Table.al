#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82012 "CRM+ Commentline"
{
    Caption = 'CRM+ Commentline';

    fields
    {
        field(1;"Comment Type";Option)
        {
            Caption = 'Comment Type';
            OptionCaption = 'Partner,Ist1,Ist2,Ist3,Ist4,Ist5,Ist6,Präsentation,cri1,cri2,cri3,cri4,cri5,cri6,cri7,co1,co2,co3,Soll1,Soll2,Soll3,Soll4,Soll5,Soll6,AngbText,qualifText';
            OptionMembers = Partner,Ist1,Ist2,Ist3,Ist4,Ist5,Ist6,"Präsentation",cri1,cri2,cri3,cri4,cri5,cri6,cri7,co1,co2,co3,Soll1,Soll2,Soll3,Soll4,Soll5,Soll6,AngbText,qualifText;
        }
        field(2;"Contactno.";Code[20])
        {
            Caption = 'Contactno.';
            Editable = false;
            TableRelation = Contact;
        }
        field(3;"Lineno.";Integer)
        {
            Caption = 'Lineno.';
            Editable = false;
        }
        field(4;Date;Date)
        {
            Caption = 'Date';
        }
        field(6;Comment;Text[80])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(Key1;"Comment Type","Contactno.","Lineno.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //SearchManagement.DeleteCRMPComments(FORMAT("Comment Type"),"Contactno.","Lineno.");
    end;

    trigger OnInsert()
    begin
        //SearchManagement.ParseCRMPComments(Rec,FALSE);
    end;

    trigger OnModify()
    begin
        //SearchManagement.ParseCRMPComments(Rec,FALSE);
    end;


    procedure NewLine()
    var
        rCommentline: Record "CRM+ Commentline";
    begin
        rCommentline := Rec;
        rCommentline.SetRecfilter;
        rCommentline.SetRange("Lineno.");
        if not rCommentline.Find('-') then
          Date := WorkDate;
    end;
}

