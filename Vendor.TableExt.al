#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50003 tableextension50003 extends Vendor 
{
    fields
    {
        field(50000;"Contact No.";Code[20])
        {
            CalcFormula = lookup("Contact Business Relation"."Contact No." where ("No."=field("No."),
                                                                                  "Business Relation Code"=filter('KRED')));
            Caption = 'Kontakt Nr.';
            FieldClass = FlowField;
        }
        field(50010;"Senden der Bestellung per";Option)
        {
            OptionCaption = ' ,Mail,Fax';
            OptionMembers = " ",Mail,Fax;
        }
        field(50020;Latitude;Decimal)
        {
            DecimalPlaces = 6:8;
            Description = 'G-ERP';
        }
        field(50030;Longitude;Decimal)
        {
            DecimalPlaces = 6:8;
            Description = 'G-ERP';
        }
        field(50050;Leistungsart;Option)
        {
            Description = 'G-ERP';
            OptionMembers = " ",Fremdlieferung,Fremdleistung,Transport,Reisekosten,Hotelkosten,Personal,Beistellung;
        }
        field(60000;DATEV;Code[20])
        {
            Caption = 'DATEV';
            Description = 'G-ERP';
        }
        field(82002;"Dialing Code";Text[30])
        {
            Caption = 'Dialing Code';
            CharAllowed = '09--';

            trigger OnValidate()
            begin
                // + 01 crm+ *********************************
                //generatePhoneNo;
                // - 01 crm+ *********************************
            end;
        }
        field(82007;"Name 3";Text[50])
        {
            Caption = 'Name 3';
        }
        field(83801;"Complete Phone No.";Text[90])
        {
            Caption = 'Complete Phone No.';
        }
    }
}

