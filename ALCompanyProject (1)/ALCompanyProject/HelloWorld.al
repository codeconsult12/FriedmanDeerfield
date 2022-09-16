// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!
table 50141 CompanywiseProjectDetail
{
    Caption = 'Company Project Account Mapping';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }

        field(3; CompanyName; Text[150])
        {
            Caption = 'Company Name';
            // FieldClass = FlowField;
            TableRelation = Company.Name;
            //  CalcFormula = lookup("Company Information".Name where("Primary Key" = field(CompanyId)));
        }

        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = "G/L Account"."No.";


        }

        field(6; ProjectName; Text[100])
        {

            Caption = 'ProjectName';
            //  FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = filter('PROJECT'));
            // CalcFormula = lookup( "Dimension Value".Name WHERE ("Dimension Code"=filter('VENDOR')));
            ValidateTableRelation = false;
        }
        field(7; CompanyCode; Text[100])
        {
            Caption = 'Company Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = filter('COMPANY'));
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = false;
        }
        // key(Key1; CompanyId, ProjectId) //secondary key
        // {

        // }
    }

}
page 50142 CompanyWiseProjects
{

    AutoSplitKey = true;

    DelayedInsert = true;
    PageType = Worksheet;

    PromotedActionCategories = 'New,Process,Report,Page,Post/Print,Line,Account';
    SaveValues = true;

    UsageCategory = Tasks;

    ApplicationArea = All;

    Caption = 'Company Project Account Mapping';
    SourceTable = CompanywiseProjectDetail;

    AdditionalSearchTerms = 'Company Project Account Mapping,Company, projects, companywiseproject, Company Wise Projects';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(CompanyName; Rec.CompanyName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of company';
                }
                field(CompanyCode; Rec.CompanyCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of company';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the account number that the entry on the journal line will be posted to.';
                }
                field(ProjectName; Rec.ProjectName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please specify project name';

                }
            }
        }
    }
}