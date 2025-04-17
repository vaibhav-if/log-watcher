class LogsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "LogsChannel"
    @new_thread = start_logging
  end

  def unsubscribed
    @new_thread&.exit
  end

  private
  def start_logging
    Thread.new do
      @file_service = FileService.new
      log_lines = @file_service.read_initial_logs

      log_lines.each do |log|
        # ActionCable.server.broadcast("LogsChannel", log) if log.present?
        transmit(log) if log.present?
      end

      loop do
        log_lines = @file_service.read_subsequent_logs
        if log_lines.present?
          log_lines.each do |log|
            # ActionCable.server.broadcast("LogsChannel", log) if log.present?
            transmit(log) if log.present?
          end
        end
        sleep(0.5)
      end
    end
  end
end
