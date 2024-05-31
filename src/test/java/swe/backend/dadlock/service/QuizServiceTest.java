package swe.backend.dadlock.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.PageRequest;
import swe.backend.dadlock.dto.quiz.QuizRequestDTO;
import swe.backend.dadlock.dto.quiz.QuizResponseDTO;
import swe.backend.dadlock.entity.*;
import swe.backend.dadlock.repository.QuizAttemptRepository;
import swe.backend.dadlock.repository.QuizRepository;
import swe.backend.dadlock.repository.UserRepository;
import swe.backend.dadlock.repository.WebAppRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

public class QuizServiceTest {

    @Mock
    private QuizRepository quizRepository;

    @Mock
    private QuizAttemptRepository quizAttemptRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private WebAppRepository webAppRepository;

    @InjectMocks
    private QuizService quizService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    private User createUser(String userGoogleId) {
        return User.builder().googleId(userGoogleId).build();
    }

    private Quiz createQuiz(Long quizId, Subject subject, Quiz.QuizLevel level, String correctAnswer) {
        return Quiz.builder()
                .quizId(quizId)
                .subject(subject)
                .level(level)
                .question("Sample question")
                .optionA("Option A")
                .optionB("Option B")
                .optionC("Option C")
                .optionD("Option D")
                .optionE("Option E")
                .correctAnswer(correctAnswer)
                .build();
    }

    private QuizAttempt createQuizAttempt(User user, Quiz quiz, boolean isCorrect) {
        return QuizAttempt.builder()
                .quiz(quiz)
                .user(user)
                .isCorrect(isCorrect)
                .attemptTime(LocalDateTime.now())
                .level(quiz.getLevel())
                .build();
    }

    @Test
    public void testGetRandomQuizBySubject() {
        // Given
        String userGoogleId = "minbory925@gmail.com";
        String appUrl = "testAppUrl";
        Subject subject = Subject.SCIENCE;
        User user = createUser(userGoogleId);
        WebApp webApp = WebApp.builder()
                .user(user)
                .appUrl(appUrl)
                .timeLimit(30)
                .subject(subject)
                .build();
        Quiz.QuizLevel level = Quiz.QuizLevel.EZ;
        Quiz quiz = createQuiz(1L, subject, level, "Option A");

        when(webAppRepository.findWebAppByUserGoogleIdAndAppUrl(userGoogleId, appUrl))
                .thenReturn(Optional.of(webApp));
        when(quizAttemptRepository.countByUserGoogleIdAndSubjectAndIsCorrectFalse(userGoogleId, subject))
                .thenReturn(0L);
        when(quizRepository.findQuizzesBySubjectAndLevel(subject, level, PageRequest.of(0, 1)))
                .thenReturn(List.of(quiz));

        // When
        QuizResponseDTO.CommonDTO result = quizService.getRandomQuizBySubject(userGoogleId, appUrl);

        // Then
        assertEquals(quiz.getQuizId(), result.getId());
        assertEquals(quiz.getQuestion(), result.getQuestion());
        verify(webAppRepository, times(1)).findWebAppByUserGoogleIdAndAppUrl(userGoogleId, appUrl);
        verify(quizAttemptRepository, times(1)).countByUserGoogleIdAndSubjectAndIsCorrectFalse(userGoogleId, subject);
        verify(quizRepository, times(1)).findQuizzesBySubjectAndLevel(subject, level, PageRequest.of(0, 1));
    }

    @Test
    public void testGetRandomQuizBySubject_InvalidUrl() {
        // Given
        String userGoogleId = "minbory925@gmail.com";
        String appUrl = "invalidAppUrl";

        when(webAppRepository.findWebAppByUserGoogleIdAndAppUrl(userGoogleId, appUrl))
                .thenReturn(Optional.empty());

        // When
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            quizService.getRandomQuizBySubject(userGoogleId, appUrl);
        });

        // Then
        assertEquals("해당 사용자가 설정한 주제가 없습니다.", exception.getMessage());

        verify(webAppRepository, times(1)).findWebAppByUserGoogleIdAndAppUrl(userGoogleId, appUrl);
        verify(quizAttemptRepository, never()).countByUserGoogleIdAndSubjectAndIsCorrectFalse(anyString(), any(Subject.class));
        verify(quizRepository, never()).findQuizzesBySubjectAndLevel(any(Subject.class), any(Quiz.QuizLevel.class), any());
    }

    @Test
    public void testDetermineQuizLevel_MD() {
        // Given
        String userGoogleId = "minbory925@gmail.com";
        Subject subject = Subject.SCIENCE;

        when(quizAttemptRepository.countByUserGoogleIdAndSubjectAndIsCorrectFalse(userGoogleId, subject))
                .thenReturn(1L);

        // When
        Quiz.QuizLevel level = determineQuizLevel(userGoogleId, subject);

        // Then
        assertEquals(Quiz.QuizLevel.MD, level);

        verify(quizAttemptRepository, times(1)).countByUserGoogleIdAndSubjectAndIsCorrectFalse(userGoogleId, subject);
    }

    @Test
    public void testDetermineQuizLevel_HD() {
        // Given
        String userGoogleId = "minbory925@gmail.com";
        Subject subject = Subject.SCIENCE;

        when(quizAttemptRepository.countByUserGoogleIdAndSubjectAndIsCorrectFalse(userGoogleId, subject))
                .thenReturn(2L);

        // When
        Quiz.QuizLevel level = determineQuizLevel(userGoogleId, subject);

        // Then
        assertEquals(Quiz.QuizLevel.HD, level);

        verify(quizAttemptRepository, times(1)).countByUserGoogleIdAndSubjectAndIsCorrectFalse(userGoogleId, subject);
    }

    @Test
    public void testSaveQuizAttempt_CorrectAnswer() {
        // Given
        String userGoogleId = "minbory925@gmail.com";
        Long quizId = 1L;
        QuizRequestDTO.AttemptDTO attemptDTO = QuizRequestDTO.AttemptDTO.builder()
                .answer("Option A")
                .build();

        User user = createUser(userGoogleId);
        Quiz quiz = createQuiz(quizId, Subject.SCIENCE, Quiz.QuizLevel.EZ, "Option A");
        QuizAttempt quizAttempt = createQuizAttempt(user, quiz, true);

        when(userRepository.findById(userGoogleId)).thenReturn(Optional.of(user));
        when(quizRepository.findById(quizId)).thenReturn(Optional.of(quiz));
        when(quizRepository.getCorrectAnswer(quizId)).thenReturn(Optional.of("Option A"));
        when(quizAttemptRepository.save(any(QuizAttempt.class))).thenReturn(quizAttempt);

        // When
        QuizResponseDTO.AttemptDTO result = quizService.saveQuizAttempt(userGoogleId, quizId, attemptDTO);

        // Then
        assertEquals(quizAttempt.getAttemptId(), result.getAttemptId());
        assertEquals(quizAttempt.getQuiz().getQuizId(), result.getQuizId());
        assertEquals(quizAttempt.getIsCorrect(), result.getIsCorrect());

        verify(userRepository, times(1)).findById(userGoogleId);
        verify(quizRepository, times(1)).findById(quizId);
        verify(quizRepository, times(1)).getCorrectAnswer(quizId);
        verify(quizAttemptRepository, times(1)).save(any(QuizAttempt.class));
        verify(quizAttemptRepository, times(1)).resetIncorrectCount(userGoogleId, quiz.getSubject());
    }

    @Test
    public void testSaveQuizAttempt_IncorrectAnswer() {
        // Given
        String userGoogleId = "minbory925@gmail.com";
        Long quizId = 1L;
        QuizRequestDTO.AttemptDTO attemptDTO = QuizRequestDTO.AttemptDTO.builder()
                .answer("Option B")
                .build();

        User user = createUser(userGoogleId);
        Quiz quiz = createQuiz(quizId, Subject.SCIENCE, Quiz.QuizLevel.EZ, "Option A");
        QuizAttempt quizAttempt = createQuizAttempt(user, quiz, false);

        when(userRepository.findById(userGoogleId)).thenReturn(Optional.of(user));
        when(quizRepository.findById(quizId)).thenReturn(Optional.of(quiz));
        when(quizRepository.getCorrectAnswer(quizId)).thenReturn(Optional.of("Option A"));
        when(quizAttemptRepository.save(any(QuizAttempt.class))).thenReturn(quizAttempt);

        // When
        QuizResponseDTO.AttemptDTO result = quizService.saveQuizAttempt(userGoogleId, quizId, attemptDTO);

        // Then
        assertEquals(quizAttempt.getAttemptId(), result.getAttemptId());
        assertEquals(quizAttempt.getQuiz().getQuizId(), result.getQuizId());
        assertEquals(quizAttempt.getIsCorrect(), result.getIsCorrect());

        verify(userRepository, times(1)).findById(userGoogleId);
        verify(quizRepository, times(1)).findById(quizId);
        verify(quizRepository, times(1)).getCorrectAnswer(quizId);
        verify(quizAttemptRepository, times(1)).save(any(QuizAttempt.class));
        verify(quizAttemptRepository, never()).resetIncorrectCount(userGoogleId, quiz.getSubject());
    }

    private Quiz.QuizLevel determineQuizLevel(String userGoogleId, Subject subject) {
        long incorrectCount = quizAttemptRepository.countByUserGoogleIdAndSubjectAndIsCorrectFalse(userGoogleId, subject);

        if (incorrectCount >= 2) {
            return Quiz.QuizLevel.HD;
        } else if (incorrectCount == 1) {
            return Quiz.QuizLevel.MD;
        } else {
            return Quiz.QuizLevel.EZ;
        }
    }
}
