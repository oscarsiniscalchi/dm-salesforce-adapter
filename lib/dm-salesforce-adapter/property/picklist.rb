module SalesforceAdapter::Property
  class Picklist < ::DataMapper::Property::String

    # TODO: Are these values supposed to be read-only or settable?  Need example
    #       to play with.
    # TODO: Are these values ever supposed to include more than label or value?
    #       If not, why not return a hash?

    # Data should be cached in this class, not the Adapter/Connection layer.
    def self.dump
      @metadata ||= model.repository.adapter.metadata(self)
      @values   ||= @metadata.fields.select { |f| f.type =~ /picklist$/ && (f.name =~ /#{self.field}/i || f.name =~ /#{self.name.to_s}/i)}.first.picklistValues rescue []
      @ret      ||= @values.map {|value| {:value => value.value, :label => value.label}}
    end

    def dump
      self.class.dump
    end
    alias :values_for_picklist :dump

    def custom?
      true
    end

  end
end
