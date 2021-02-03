function count (){
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  
  itemPrice.addEventListener("input",() => {
    itemPriceValue = itemPrice.value;
    addTaxPriceValue = Math.floor(itemPriceValue / 10);
    addTaxPrice.innerHTML = addTaxPriceValue;
    profit.innerHTML = itemPriceValue - addTaxPriceValue;
  })
}
addEventListener('load',count);