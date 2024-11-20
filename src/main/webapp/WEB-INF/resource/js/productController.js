var app = angular.module("myapp", []).controller(
		"myController",
		function($scope, $http) {

			var BASE_PATH = "http://localhost:8080";

			$scope.processingButtons = {};
			$scope.quantityButtons = {};

			$scope.getProductList = function() {
				$http.get(BASE_PATH + "/getProductsList")
						.success(function(data) {
							$scope.products = data;
						});
			}

			$scope.addToCart = function(productId) {
				$scope.processingButtons[productId] = true;
				$http.put(BASE_PATH + "/cart/add/" + productId)
						.success(function() {
							$scope.processingButtons[productId] = false;
							$scope.getCart(1);
							alert("Added Successfully");
						})
			}

			$scope.refreshCart = function() {
				$http.get(BASE_PATH + "/cart/getCart/"
								+ $scope.cartId).success(function(data) {

					$scope.carts = data;

					var total = data.cartItem.length;

					if( total > 0 ) {
						$('#total-item').show().html(total);
					}
					else
					{
						$('#total-item').hide();
					}
				})
			}

			$scope.getCart = function(cartId) {
				$scope.cartId = cartId;
				$scope.refreshCart(cartId);
			}
			$scope.removeFromCart = function(cartItemId) {
				$http.put(BASE_PATH +"/cart/removeCartItem/"
								+ cartItemId).success(function() {
					$scope.refreshCart();
				});
			}

			$scope.changeQuantity = function(productId, cartItemId, event) {
				$scope.quantityButtons[productId] = true;
				var quantity = $(event.currentTarget).prev().val();

				$http.put(BASE_PATH + "/cart/add/" + productId + "?quantity=" + quantity)
					.success(function() {
						$scope.refreshCart();
						$scope.quantityButtons[productId] = false;
						alert('Update successfully');
					})
			}

			$scope.clearCart = function() {
				$http.put(BASE_PATH + "/cart/removeAllItems/"
								+ $scope.cartId).success(function() {
					$scope.refreshCart();
				});
			}

			$scope.calculateGrandTotal = function() {
				var grandTotal = 0.0;
				for (var i = 0; i < $scope.carts.cartItem.length; i++)
					grandTotal = grandTotal + $scope.carts.cartItem[i].price;
				return grandTotal;

			}
		});
