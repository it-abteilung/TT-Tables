#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82016 "CRM Cue"
{
    Caption = 'Sales Cue';

    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2;"Sales Quotes - Open";Integer)
        {
            CalcFormula = count("Sales Header" where ("Document Type"=filter(Quote),
                                                      Status=filter(Open),
                                                      "Salesperson Code"=field(filter("Salesperson Filter"))));
            Caption = 'Sales Quotes - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3;"Sales Orders - Open";Integer)
        {
            CalcFormula = count("Sales Header" where ("Document Type"=filter(Order),
                                                      Status=filter(Open),
                                                      "Salesperson Code"=field(filter("Salesperson Filter"))));
            Caption = 'Sales Orders - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4;"To-Dos - Open";Integer)
        {
            CalcFormula = count("To-do" where ("Salesperson Code"=field("Salesperson Filter"),
                                               Date=field("Date Filter"),
                                               "System To-do Type"=filter(Organizer|"Salesperson Attendee"),
                                               Closed=const(false),
                                               Canceled=const(false)));
            Caption = 'Sales Quotes - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5;"To-Dos - Future";Integer)
        {
            CalcFormula = count("To-do" where ("Salesperson Code"=field(filter("Salesperson Filter")),
                                               Date=field(filter("Date Filter2")),
                                               "System To-do Type"=filter(Organizer|"Salesperson Attendee"),
                                               Closed=const(false),
                                               Canceled=const(false)));
            Caption = 'Sales Orders - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20;"Date Filter";Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21;"Date Filter2";Date)
        {
            Caption = 'Date Filter2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(30;"Salesperson Filter";Code[10])
        {
            Caption = 'Verkäuferfilter';
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser".Code;
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

