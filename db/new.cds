namespace Z_testingsaasappscap.db;
using testingsaasappscap.db.Sales as Sales from './extend';

entity Z_Products {
    key ID          : Integer;
        title       : String(100);
        toSales     : Association to Sales;
};
