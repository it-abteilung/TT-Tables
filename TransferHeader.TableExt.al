#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50039 tableextension50039 extends "Transfer Header"
{
    fields
    {
        field(60000; "Job No"; Code[20])
        {
            Caption = 'Projekt Nr.';
            Description = 'G-ERP';
            TableRelation = Job where(SumProject = const(false));

            trigger OnValidate()
            var
                Job_l: Record Job;
                Error_JobNo: label 'Das Projekt %1 konnte nicht gefunden werden.';
                Error_SumProject: label 'Ein Summenprojket kann nicht eingetragen werden.';
            begin
                //G-ERP.RS 2019-10-21 +++ Anfrage#233369
                if "Job No" <> '' then
                    if Job_l.Get("Job No") then
                        if not Job_l.SumProject then begin
                            "Transfer-to Code" := 'PROJEKT';
                            "Transfer-to Name" := Job_l.Description;
                            "Transfer-to Name 2" := Job_l."Description 2";
                        end else
                            Error(Error_SumProject)
                    else
                        Error(Error_JobNo);
                //G-ERP.RS 2019-10-21 --- Anfrage#233369
            end;
        }
        field(60010; Ressource; Code[20])
        {
            Caption = 'Mitarbeiter';
            Description = 'G-ERP';
            TableRelation = Employee;
        }
    }
}

