tableextension 55202 "MFDP urchase Line CCJ" extends "Purchase Line"
{
    fields
    {
        modify("Job No.")
        {
            //rglh comprobacion modificación propiedad con modify keyword. En la page seguro tambien tiene el caption y no se cambia
            Caption = 'No. Proyecto CCJ';

            trigger OnAfterValidate()
            begin
                JobSetup.Get();

                if JobSetup."Self-fullfill Puchase Doc. Job" then begin
                    JobTask.SetRange("Job No.", "Job No.");
                    if JobTask.FindFirst() then begin
                        "Job Task No." := JobTask."Job Task No.";
                        "Job Line Type" := JobSetup."Job Type Line Default CCJ";

                    end;

                end;

            end;
        }
    }

    var
        JobSetup: Record "Jobs Setup";
        JobTask: Record "Job Task";

}