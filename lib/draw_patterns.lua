
function draw_checkerboard(x, y, width, height, square_size, color1, color2)
  local end_x = x + width
  local end_y = y + height

  for i = x, end_x - 1, square_size do
      for j = y, end_y - 1, square_size do
          local is_color1_square = ((i + j) // square_size) % 2 == 0
          if is_color1_square then
              rectfill(i, j, i + square_size - 1, j + square_size - 1, color1)
          elseif color2 then
              rectfill(i, j, i + square_size - 1, j + square_size - 1, color2)
          end
      end
  end
end
function draw_horizontal_stripes(x, y, width, height, stripe_height, color1, color2)
  local end_y = y + height

  for j = y, end_y - 1, stripe_height * 2 do
      rectfill(x, j, x + width - 1, j + stripe_height - 1, color1)
      if color2 then
          rectfill(x, j + stripe_height, x + width - 1, j + stripe_height * 2 - 1, color2)
      end
  end
end
function draw_vertical_stripes(x, y, width, height, stripe_width, color1, color2)
  local end_x = x + width

  for i = x, end_x - 1, stripe_width * 2 do
      rectfill(i, y, i + stripe_width - 1, y + height - 1, color1)
      if color2 then
          rectfill(i + stripe_width, y, i + stripe_width * 2 - 1, y + height - 1, color2)
      end
  end
end

function draw_diagonal_stripes(x, y, width, height, stripe_width, color1, color2)
  local end_x = x + width
  local end_y = y + height

  for i = -end_y, end_x, stripe_width * 2 do
      for j = y, end_y - 1, stripe_width * 2 do
          local sx = math.max(x, i + j)
          local ex = math.min(end_x - 1, i + j + stripe_width - 1)
          if sx <= ex then
              rectfill(sx, j, ex, j + stripe_width - 1, color1)
          end
          if color2 then
              sx = math.max(x, i + j + stripe_width)
              ex = math.min(end_x - 1, i + j + stripe_width * 2 - 1)
              if sx <= ex then
                  rectfill(sx, j + stripe_width, ex, j + stripe_width * 2 - 1, color2)
              end
          end
      end
  end
end
function draw_opposite_diagonal_stripes(x, y, width, height, stripe_width, color1, color2)
  local end_x = x + width
  local end_y = y + height

  for i = -end_y, end_x, stripe_width * 2 do
      for j = y, end_y - 1, stripe_width * 2 do
          if color2 then
              local sx = math.max(x, i + j)
              local ex = math.min(end_x - 1, i + j + stripe_width - 1)
              if sx <= ex then
                  rectfill(sx, j, ex, j + stripe_width - 1, color2)
              end
          end
          local sx = math.max(x, i + j + stripe_width)
          local ex = math.min(end_x - 1, i + j + stripe_width * 2 - 1)
          if sx <= ex then
              rectfill(sx, j + stripe_width, ex, j + stripe_width * 2 - 1, color1)
          end
      end
  end
end
function draw_halftone_dot_pattern(x, y, width, height, dot_radius, color1, color2)
  local end_x = x + width
  local end_y = y + height
  local spacing = dot_radius * 2

  for i = x, end_x - 1, spacing do
      for j = y, end_y - 1, spacing do
          if color2 then
              rectfill(i, j, i + spacing - 1, j + spacing - 1, color2)
          end
          circfill(i + dot_radius, j + dot_radius, dot_radius, color1)
      end
  end
end

function print_with_shadow(text, x, y, color, highlight_color, shadow_color)
  print(text, x + 1, y + 1, shadow_color)
  print(text, x - 1, y - 1, highlight_color)
  print(text, x, y, color)
end

function draw_gradient_fill(x, y, width, height, color1, color2)
  local end_x = x + width
  local end_y = y + height
  local step_r, step_g, step_b

  -- If color2 is not provided, use transparent as the second color
  if not color2 then
      color2 = 0
  end

  -- Calculate color steps
  local r1, g1, b1 = (color1 >> 16) & 0xFF, (color1 >> 8) & 0xFF, color1 & 0xFF
  local r2, g2, b2 = (color2 >> 16) & 0xFF, (color2 >> 8) & 0xFF, color2 & 0xFF
  step_r = (r2 - r1) / height
  step_g = (g2 - g1) / height
  step_b = (b2 - b1) / height

  for j = y, end_y - 1 do
      local r = r1 + step_r * (j - y)
      local g = g1 + step_g * (j - y)
      local b = b1 + step_b * (j - y)
      local color = (r << 16) + (g << 8) + b
      rectfill(x, j, end_x - 1, j, color)
  end
end