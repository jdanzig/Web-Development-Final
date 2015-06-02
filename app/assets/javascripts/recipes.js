// With help from the jQuery API
//= require tooltipsy.source
//= require ionrangeslider
//= require select2
//= require bootstrap-touchspin/src/jquery.bootstrap-touchspin

// Taken from https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/repeat#Polyfill
if (!String.prototype.repeat) {
  String.prototype.repeat = function(count) {
    'use strict';
    if (this == null) {
      throw new TypeError('can\'t convert ' + this + ' to object');
    }
    var str = '' + this;
    count = +count;
    if (count != count) {
      count = 0;
    }
    if (count < 0) {
      throw new RangeError('repeat count must be non-negative');
    }
    if (count == Infinity) {
      throw new RangeError('repeat count must be less than infinity');
    }
    count = Math.floor(count);
    if (str.length == 0 || count == 0) {
      return '';
    }
    // Ensuring count is a 31-bit integer allows us to heavily optimize the
    // main part. But anyway, most current (August 2014) browsers can't handle
    // strings 1 << 28 chars or longer, so:
    if (str.length * count >= 1 << 28) {
      throw new RangeError('repeat count must not overflow maximum string size');
    }
    var rpt = '';
    for (;;) {
      if ((count & 1) == 1) {
        rpt += str;
      }
      count >>>= 1;
      if (count == 0) {
        break;
      }
      str += str;
    }
    return rpt;
  }
}

$(function() {
  $('i.crud').tooltipsy();
  $('div.favorite-icon').each(function() {
    $(this).append($('<i/>'));

    $(this).on('change', function() {
      icon_tag = $(this).find('i');
      favorited = $(this).data('current');
      tt = icon_tag.data('tooltipsy');
      if(tt) tt.destroy();
      if(favorited) {
        icon_tag.attr('title', "You have favorited this item. Click to remove from Favorites.");
        icon_tag.addClass('fa').removeClass('fa-heart-o').addClass('fa-heart');
      } else {
        icon_tag.attr('title', "Click to add to Favorites.");
        icon_tag.addClass('fa').removeClass('fa-heart').addClass('fa-heart-o');        
      }
      icon_tag.tooltipsy();
    });
    $(this).trigger('change');

    $(this).on('click', function() {
      favorited = $(this).data('current');
      method = favorited ? 'DELETE' : 'POST';
      icon = $(this);
      $.ajax({
        cache: false,
        method: method,
        url: location.href + '/favorite'
      }).done(function(data, textStatus, jqXHR) {
        icon.data('current', !icon.data('current'));
        icon.trigger('change');
      });
    });    
  });
  
  $('input#recipe_review_rating').ionRangeSlider({
    min: 1,
    max: 5,
    from: 1,
    to: 5,
    force_edges: true,
    grid: true,
    grid_num: 4,
    prettify: function(num) {
      return '<i class="fa fa-star"></i>'.repeat(num);
    }
  });

  $('select#recipe_category').select2();

  $('input#recipe_quantity_served').TouchSpin({
    min: 1,
    max: 1000,
    step: 1,
    boostat: 5,
    maxboostedstep: 50,
    decimals: 0,
    postfix: 'people'
  });

});