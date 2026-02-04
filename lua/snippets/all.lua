-- local ls = require("luasnip")
-- local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node -- Также добавим insert_node на всякий случай
--
-- -- Определение доступных значений размеров (values)
-- local sizes_strings = { "0", "3xs", "2xs", "xs", "s", "m", "l", "xl", "2xl", "3xl", "4xl" }
--
-- -- !!! ПРЕОБРАЗУЕМ массив строк в массив текстовых узлов (nodes) !!!
-- local sizes_nodes = {}
-- for _, size_str in ipairs(sizes_strings) do
--   table.insert(sizes_nodes, t(size_str))
-- end
--
-- return {
--   -- Верхний отступ (Margin Top)
--   s("mrt", {
--     t("sui-mrt-"),
--     ls.choice_node(1, sizes_nodes), -- Теперь используем массив узлов
--   }),
--   -- Правый отступ (Margin Right)
--   s("mrr", {
--     t("sui-mrr-"),
--     ls.choice_node(1, sizes_nodes),
--   }),
--   -- Нижний отступ (Margin Bottom)
--   s("mrb", {
--     t("sui-mrb-"),
--     ls.choice_node(1, sizes_nodes),
--   }),
--   -- Левый отступ (Margin Left/Inline Start)
--   s("mrl", {
--     t("sui-mrl-"),
--     ls.choice_node(1, sizes_nodes),
--   }),
-- }

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

-- Определение данных: ключ (то, что вставится) и описание (для подсказки)
local sizes_data = {
  { "0", "0px" },
  { "3xs", "4px" },
  { "2xs", "8px" },
  { "xs", "12px" },
  { "s", "16px" },
  { "m", "24px" },
  { "l", "32px" },
  { "xl", "40px" },
  { "2xl", "48px" },
  { "3xl", "64px" },
  { "4xl", "96px" },
}

-- Функция генерации узлов.
-- Для каждого элемента создается snippet_node.
-- В списке выбора (choice_node) вы увидите "s (16px)",
-- но реально вставится только "s", так как это значение insert_node.
local function get_size_nodes()
  local nodes = {}
  for _, pair in ipairs(sizes_data) do
    local code = pair[1]
    local pixels = pair[2]
    -- Формат "код (пиксели)" для отображения в меню
    local label = string.format("%-4s -- %s", code, pixels)

    table.insert(nodes, sn(nil, { i(1, code, { desc = label }) }))
  end
  return nodes
end

local sizes_nodes = get_size_nodes()

return {
  -- Верхний отступ
  s("mrt", {
    t("sui-mrt-"),
    c(1, sizes_nodes),
  }),

  -- Правый отступ
  s("mrr", {
    t("sui-mrr-"),
    c(1, sizes_nodes),
  }),

  -- Нижний отступ
  s("mrb", {
    t("sui-mrb-"),
    c(1, sizes_nodes),
  }),

  -- Левый отступ
  s("mrl", {
    t("sui-mrl-"),
    c(1, sizes_nodes),
  }),
}
