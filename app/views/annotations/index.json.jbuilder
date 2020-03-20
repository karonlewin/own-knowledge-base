# frozen_string_literal: true

json.array! @annotations, partial: 'annotations/annotation', as: :annotation
