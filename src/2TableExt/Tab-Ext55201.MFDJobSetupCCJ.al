tableextension 55201 "MFD Job Setup CCJ" extends "Jobs Setup"
{
    fields
    {
        field(55200; "Customer No. CCJ"; Code[20])
        {
            Caption = 'Nº Cliente predeterm.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin

            end;
        }
        field(55210; "Job Posting Group CCJ"; Code[20])
        {
            Caption = 'Grupo Registro Proyecto';
            DataClassification = ToBeClassified;
            TableRelation = "Job Posting Group";

        }
        field(55220; "Method WIP CCJ"; Code[20])
        {
            Caption = 'Método WIP';
            DataClassification = ToBeClassified;
            TableRelation = "Job WIP Method";
        }
        field(55230; "Multi-Jobs per Item CCJ"; Boolean)
        {
            Caption = 'Multi-Proyectos por Producto';
            DataClassification = ToBeClassified;
        }

        field(55240; "Job Task No CCJ"; Code[20])
        {
            Caption = 'No. Tarea Proyecto CRS';
            DataClassification = ToBeClassified;
        }
        field(55250; "Job Type Line Default CCJ"; Option)
        {
            Caption = 'Tipo línea proyecto por defecto';
            OptionMembers = " ",Budget,Billable,"Both Budget and Billable";
            OptionCaption = ' ,Presupuesto,Facturable,Presupuesto y Facturable';
        }
        field(55260; "Self-fullfill Puchase Doc. Job"; Boolean)
        {
            Caption = 'Autocumplimentar Doc. Proyectos';
            DataClassification = ToBeClassified;
        }

    }
}
