namespace Z_testingsaasappscap.dbexising;
using testingsaasappscap.db from '_base/db/data-model.cds';
using Z_testingsaasappscap.db.Z_Products as Products from './new';

extend entity db.Sales with {
    Z_city  : String(60);
    Z_phone : String(12);
    Z_totalAmount : Decimal(15, 2);
    Z_toProduct: Composition of many Products
                              on Z_toProduct.toSales = $self;
};
