// tableextension 61011 "Werkzeuganforderungzeile" extends Werkzeuganforderungzeile
// {
//     fields
//     {

//     }

// trigger OnAfterInsert()
// var
//     Item: Record Item;
//     Werkzeuganforderungskopf: Record Werkzeuganforderungskopf;
// begin
//     Werkzeuganforderungskopf.Reset();
//     Item.Reset();
//     Item.SetRange("No.", "Artikel Nr");
//     if NOT Item.IsEmpty() then
//         if Item.FindFirst() then begin
//             Rec."Contains Hazardous Substance" := Item."Hazardous Substance";
//             Rec.Modify();
//         end;
// end;

// }
