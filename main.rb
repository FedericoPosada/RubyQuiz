class Quiz

  attr_accessor :questionfile, :questions, :answers

  def initialize(file)
    @questionfile=file
  end

  def set_quiz
    return "" unless File.file?(@questionfile)
    @questions = Queue.new
    @answers = Queue.new
    line_counter = 0
    File.open(@questionfile,"r").each_line do |line|
      if line_counter % 3 == 0 # es pregunta
        @questions.enq(line.to_s)
      elsif line.length > 1 # es respuesta
        @answers.enq(line.to_s)
      end
      line_counter+=1
    end
    if @questions.size != @answers.size
      raise 'El número de preguntas y respuestas no coincide' 
    end
  end

  def run_quiz
    current_question = ""
    current_answer = ""
    while @questions.size > 0
      current_question = @questions.deq
      current_answer = @answers.deq
      puts current_question
      user_answer=gets
      while user_answer.casecmp(current_answer) != 0
        puts 'Incorrecto! Intenta de nuevo '+user_answer
        user_answer=gets
      end
      puts 'Correcto!'
    end
  end

  def main
    set_quiz
    run_quiz
  end

end

nueva=Quiz.new("questions.txt")
nueva.main