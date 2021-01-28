@EndUserText.label: 'Projection view for customers'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_CUSTOMER_918
  as projection on ZI_CUSTOMER_918
{
  key CustomerUUID,
      Id,
      FirstName,
      LastName,
      Street,
      City,
      Postcode,
      Company,
      ContactPerson,

      /*-- Admin data --*/
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt
      
}
