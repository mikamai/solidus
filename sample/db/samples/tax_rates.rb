north_america = Spree::Zone.find_by!(name: "North America")
clothing = Spree::TaxCategory.find_by!(name: "Default")
tax_rate = Spree::TaxRate.create(
  name: "North America",
  zone: north_america,
  amount: 0.05,
  tax_category: clothing)
tax_rate.calculator = Spree::Calculator::DefaultTax.create!
tax_rate.save!
