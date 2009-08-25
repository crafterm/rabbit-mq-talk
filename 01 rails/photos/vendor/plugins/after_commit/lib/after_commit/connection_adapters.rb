module AfterCommit
  module ConnectionAdapters
    def self.included(base)
      base.class_eval do
        # The commit_db_transaction method gets called when the outermost
        # transaction finishes and everything inside commits. We want to
        # override it so that after this happens, any records that were saved
        # or destroyed within this transaction now get their after_commit
        # callback fired.
        def commit_db_transaction_with_callback          
          begin
            commit_db_transaction_without_callback
            trigger_after_commit_callbacks
            trigger_after_commit_on_create_callbacks
            trigger_after_commit_on_update_callbacks
            trigger_after_commit_on_destroy_callbacks
          ensure
            AfterCommit.cleanup(self)
          end
        end 
        alias_method_chain :commit_db_transaction, :callback

        # In the event the transaction fails and rolls back, nothing inside
        # should recieve the after_commit callback.
        def rollback_db_transaction_with_callback
          begin
            rollback_db_transaction_without_callback
          ensure
            AfterCommit.cleanup(self)
          end
        end
        alias_method_chain :rollback_db_transaction, :callback
        
        protected        

        def trigger_after_commit_callbacks
          # Trigger the after_commit callback for each of the committed
          # records.
          AfterCommit.touched_records(self).each do |record|
            record.after_commit_callback
          end 
        end

        def trigger_after_commit_on_create_callbacks
          # Trigger the after_commit_on_create callback for each of the committed
          # records.
          AfterCommit.created_records(self).each do |record|
            record.after_commit_on_create_callback
          end 
        end

        def trigger_after_commit_on_update_callbacks
          # Trigger the after_commit_on_update callback for each of the committed
          # records.
          AfterCommit.updated_records(self).each do |record|
            record.after_commit_on_update_callback
          end 
        end

        def trigger_after_commit_on_destroy_callbacks
          # Trigger the after_commit_on_destroy callback for each of the committed
          # records.
          AfterCommit.destroyed_records(self).each do |record|
            record.after_commit_on_destroy_callback
          end 
        end
      end 
    end 
  end
end
