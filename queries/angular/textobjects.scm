; inherits: html

; --- OUTER ---
(attribute) @attribute.outer

; --- INNER (Значения) ---

; 1. Стандартные HTML атрибуты: class="value"
; Явно указываем путь через quoted_attribute_value
(attribute
  (quoted_attribute_value
    (attribute_value) @attribute.inner))

; 2. Angular Property Binding: [prop]="value"
(attribute
  (property_binding
    [
      (expression)
      (ternary_expression)
      (string)
    ] @attribute.inner))

; 3. Event Binding: (click)="handler()"
(attribute
  (event_binding
    (expression) @attribute.inner))

; 4. Two-way Binding: [(ngModel)]="value"
(attribute
  (two_way_binding
    (expression) @attribute.inner))

; --- ИМЯ (только если нет значения) ---

; 5. Используем предикат #not-any-of?, который более стабилен в 2026 году.
; Мы говорим: захватывать имя как inner только если внутри attribute 
; НЕТ узлов, отвечающих за значения.
((attribute
  (attribute_name) @attribute.inner)
  (#not-any-of? @attribute.inner "quoted_attribute_value" "property_binding" "event_binding" "two_way_binding"))
