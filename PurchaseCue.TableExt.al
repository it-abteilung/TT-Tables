#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50056 tableextension50056 extends "Purchase Cue" 
{
    fields
    {
        field(50000;"freigegebene Marialanfordrg.";Integer)
        {
            CalcFormula = count(Materialanforderungskopf where (Status=filter(freigegeben)));
            FieldClass = FlowField;
        }
    }
}

