# README

Overall, the code you've provided looks quite well organized and easy to understand. Here are some suggestions for improvements:

    Use of instance variables: Instead of defining variables like @product in each action method, you can use instance variables in your before_action method. This will allow you to avoid redundant code, and make your code more DRY (Don't Repeat Yourself). For example, you could define an instance variable @product in the set_product method and then use it in the add_remove_product, add, and remove methods.

    Using Rails scopes: You have defined a ordered scope on the Product model, which is a good practice. You could consider using other scopes to make your code more concise and expressive. For example, you could define a scope to find a product by its name, or to find a cart by its user.

    Using partials: You are rendering the same partial in each of your actions that update the cart, which is another opportunity for you to avoid redundant code. You could create a partial for that and render it in each of those actions, and any other actions that require it.

    Consistent use of callbacks: You have used an after_create callback in your User model, which is a good practice to keep your code organized. You could consider using callbacks in other models as well, for example, to update the total of a cart after a product is added or removed.

    Using strong parameters: In your CheckoutController, you are accessing the total parameter directly, which is not a safe practice. You should use strong parameters to ensure that only the parameters you expect are permitted.

I hope these suggestions are helpful!


Overall, your models seem well-organized and follow good practices. Here are some specific suggestions for improvement:

    In Cart, the validates_uniqueness_of method doesn't seem to be relevant to the Cart model. It appears to be trying to ensure that a product can only be added to a cart once, but this validation should be done in the Orderable model instead.

    In Orderable, the validates method ensures that quantity is present and greater than or equal to 1. This is a good validation, but it might also be useful to add a validation that ensures that the product_id and cart_id are both present.

    In Product, the validates method for price ensures that it is greater than 0, which is good, but it might also be useful to add a validation that ensures it is a numeric value.

    In User, the name method splits the email address to get the user's name. This might not always work, especially if the user has a complex email address with multiple "@" symbols. Instead, you might consider adding a name attribute to the User model and allowing users to set it when they register.

    In User, the welcome_send method sends a welcome email after a user signs up. This is a good feature, but you might consider moving this logic to a background job (using a gem like Sidekiq or ActiveJob) so that the user doesn't have to wait for the email to be sent before being redirected to the home page.


    <div class="container">
  <div class="row">
    <div class="col-md-6 offset-md-3">
      <br><br><br>
      <%= form_for resource, as: resource_name, url: registration_path(resource_name), html: { class: "form-signin mt-3" } do |f| %>
        <h1 class="h3 mb-3 font-weight-normal text-center">Sign up</h1>
        <%= devise_error_messages! %>
        <div class="form-group">
          <%= f.label :email, "Email" %><br />
          <%= f.email_field :email, autofocus: true, autocomplete: "email", class: "form-control" %>
        </div>
        <div class="form-group">
          <%= f.label :password %>
          <% if @minimum_password_length %>
          <em><%= @minimum_password_length %> characters minimum)</em>
          <% end %><br />
          <%= f.password_field :password, autocomplete: "new-password", class: "form-control" %>
        </div>
        <div class="form-group">
          <%= f.label :password_confirmation %><br />
          <%= f.password_field :password_confirmation, autocomplete: "new-password", class: "form-control" %>
        </div>
        <div class="actions mt-5">
          <%= f.submit "Sign up", class: "btn btn-lg btn-primary btn-block" %>
        </div>
      <% end %>
      <%= render "devise/shared/links" %>
    </div>
  </div>
</div>

<!--
<%= f.label :email %><br />
<%= f.email_field :email, autofocus: true, autocomplete: "email" %>
-->


<div class="table-responsive">
  <table class="table table-striped">
    <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col">Name</th>
        <th scope="col">Price</th>
        <th scope="col">Actions</th>
      </tr>
    </thead>
    <tbody>
      <% @products.sort{|a,b| b.created_at <=> a.created_at}.each do |product| %>
        <tr>
          <th scope="row"><%= link_to product.id, admin_product_path(product) %></th>
          <td><%= product.name%></td>
          <td>$<%= product.price %></td>
          <td>
            <%= link_to "Edit", edit_admin_product_path(product) %>
            /
            <%= link_to "Destroy", admin_product_path(product), data: { turbo_method: :delete,
                                                                        turbo_confirm: "Are you sure?"
                                                                      } %>
          </td>
        </tr>
      <% end %>
    </tbody>
  </table> 
</div>


         <img src="https://picsum.photos/200/200" class="card-img-top" alt="picsum" width="100%" height="200">
  <div class="card-body">
    <h5 class="card-title"><%=link_to product.name, admin_product_path(product), data: { turbo_frame: "_top" } %></h5>
    <p class="card-text"><%= product.description %></p>
    <div class="d-flex justify-content-between align-items-center">
      <div>
      <%= link_to "Edit", edit_admin_product_path(product), class:"btn btn-warning" %> 
      <%= link_to "Destroy", admin_product_path(product), class:"btn btn-danger", data: { turbo_method: :delete,
                                                                                           turbo_confirm: "Are you sure?"
                                                                                          } %>
       
      </div>
      <small class="text-body-secondary">$<%= product.price %></small>
      
    </div>
  </div>


   public_target = "product_#{product.id}_public_likes"
    broadcast_replace_later_to 'public_likes',
                                target: public_target,
                                partial:'likes/like_count',
                                locals: {product: product}

                                <%= turbo_stream_from "public_likes" %>