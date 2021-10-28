using CatalogService from '_base/srv/catalog-service';
using Z_testingsaasappscap.db as db from '../db/new';
using Z_testingsaasappscap.dbexising as extend from '../db/extend';
using Z_testingsaasappscap.db.Z_Products as Products from '../db/new';

extend service CatalogService with {

    @readonly
    entity Z_Products @(restrict : [{to : 'Viewer'}]) as select * from db.Z_Products;

    action Z_moveToNext() returns Z_Products;
};

annotate CatalogService.Sales with {
    Z_city        @title            : '{i18n>city}';
    Z_totalAmount @title            : '{i18n>totalAmount}';
    Z_phone       @title            : '{i18n>phone}';

    Z_toProduct   @Common.ValueList : {
        CollectionPath  : 'Z_Products',
        Label           : 'Products',
        Parameters      : [
            {
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : 'Z_toProduct/ID',
                ValueListProperty : 'ID'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'title'
            }
        ],
        SearchSupported : true
    };
};

annotate CatalogService.Z_Products with {
    ID      @title : '{i18n>productID}';
    title   @title : '{i18n>title}';
};

annotate CatalogService.Sales with @(UI : {
    //Identification : [ { $Type: 'UI.DataFieldForAction', Action: 'CatalogService.moveToNext', Label: 'Move'}],
    FieldGroup #Description : {Data : [
        {
            $Type : 'UI.DataField',
            Value : region
        },
        {
            $Type : 'UI.DataField',
            Value : country
        },
        {
            $Type : 'UI.DataField',
            Value : Z_toProduct.ID
        },
        {
            $Type : 'UI.DataField',
            Value : Z_toProduct.title
        },
    ]},
    FieldGroup #Details     : {Data : [
        {
            $Type : 'UI.DataField',
            Value : region
        },
        {
            $Type : 'UI.DataField',
            Value : country
        },
        {
            $Type : 'UI.DataField',
            Value : amount
        },
        {
            $Type : 'UI.DataField',
            Value : comments
        },
        {
            $Type : 'UI.DataField',
            Value : Z_toProduct.ID
        },
        {
            $Type : 'UI.DataField',
            Value : Z_toProduct.title
        }
    ]},
    Facets                  : [{
        $Type  : 'UI.CollectionFacet',
        ID     : 'PODetails',
        Label  : '{i18n>salesInfo}',
        Facets : [{
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>salesInfo}',
            Target : '@UI.FieldGroup#Details'
        }]
    }]
});
