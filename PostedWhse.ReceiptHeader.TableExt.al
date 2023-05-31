#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50053 tableextension50053 extends "Posted Whse. Receipt Header" 
{
    fields
    {
        field(60000;"Job No";Code[20])
        {
            Caption = 'Projekt Nr.';
            Description = 'G-ERP';
            TableRelation = Job where (SumProject=const(false));

            trigger OnValidate()
            var
                Job_l: Record Job;
                Error_JobNo: label 'Das Projekt %1 konnte nicht gefunden werden.';
                Error_SumProject: label 'Ein Summenprojket kann nicht eingetragen werden.';
            begin
            end;
        }
        field(60010;Ressource;Code[20])
        {
            Caption = 'Mitarbeiter';
            Description = 'G-ERP';
            TableRelation = Employee;
        }
    }
}

