@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for waste types'
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['Id']
define root view entity ZC_WASTE_TYPE_918
  as projection on ZI_WASTE_TYPE_918 as Waste
{
  key Id,
      Name,
      Description,
      PriceKg,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt
}
