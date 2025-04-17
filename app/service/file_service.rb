class FileService
  MB_SIZE = 4096 # 4 mb
  TAIL_NUMBER = 10

  def initialize(file_path = "#{Rails.root}/log/dummy.log")
    @file_path = file_path
    @last_position = 0
  end

  def read_initial_logs
    log_lines = ""
    begin
      # refactor
      File.open(@file_path) do |file|
        @last_position = [ 0, file.size - MB_SIZE ].max
        file.seek(@last_position)
        log_lines = file.read.split("\n").last(TAIL_NUMBER)
        @last_position = file.pos
      end
    rescue => error
      puts error.message
    end
    log_lines
  end

  def read_subsequent_logs
    log_lines = ""
    begin
      File.open(@file_path) do |file|
        file.seek(@last_position)
        log_lines = file.read.split("\n")
        @last_position = file.pos
      end
    rescue => error
      puts error.message
    end
    log_lines
  end
end
