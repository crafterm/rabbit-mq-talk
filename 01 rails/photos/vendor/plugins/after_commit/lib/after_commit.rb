module AfterCommit
  # COMMITTED_RECORDS[connection_object_id][event]
  COMMITTED_RECORDS = Hash.new do |h, k|
    h[k] = Hash.new do |h2, k2|
      h2[k2] = []
    end
  end

  class <<self
    def record_created(connection, record)
      COMMITTED_RECORDS[connection.object_id][:created] << record
    end

    def record_updated(connection, record)
      COMMITTED_RECORDS[connection.object_id][:updated] << record
    end

    def record_destroyed(connection, record)
      COMMITTED_RECORDS[connection.object_id][:destroyed] << record
    end

    def created_records(connection)
      COMMITTED_RECORDS[connection.object_id][:created]
    end

    def updated_records(connection)
      COMMITTED_RECORDS[connection.object_id][:updated]
    end

    def destroyed_records(connection)
      COMMITTED_RECORDS[connection.object_id][:destroyed]
    end

    def touched_records(connection)
      COMMITTED_RECORDS[connection.object_id].values.flatten
    end

    def cleanup(connection)
      COMMITTED_RECORDS.delete(connection.object_id)
    end
  end
end
