local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node -- Также добавим insert_node на всякий случай

-- Определение доступных значений размеров (values)
local sizes_strings = { "0", "3xs", "2xs", "xs", "s", "m", "l", "xl", "2xl", "3xl", "4xl" }

-- !!! ПРЕОБРАЗУЕМ массив строк в массив текстовых узлов (nodes) !!!
local sizes_nodes = {}
for _, size_str in ipairs(sizes_strings) do
  table.insert(sizes_nodes, t(size_str))
end

return {
  -- Верхний отступ (Margin Top)
  s("mrt", {
    t("sui-mrt-"),
    ls.choice_node(1, sizes_nodes), -- Теперь используем массив узлов
  }),
  -- Правый отступ (Margin Right)
  s("mrr", {
    t("sui-mrr-"),
    ls.choice_node(1, sizes_nodes),
  }),
  -- Нижний отступ (Margin Bottom)
  s("mrb", {
    t("sui-mrb-"),
    ls.choice_node(1, sizes_nodes),
  }),
  -- Левый отступ (Margin Left/Inline Start)
  s("mri", {
    t("sui-mri-"),
    ls.choice_node(1, sizes_nodes),
  }),
}
