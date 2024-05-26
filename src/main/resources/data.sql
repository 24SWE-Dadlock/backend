-- MySQL의 문자 집합 설정 (UTF-8로 인코딩하도록)
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET character_set_connection=utf8mb4;

CREATE TABLE IF NOT EXISTS Quiz (
                                    quiz_id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                    subject ENUM('SCIENCE', 'ECONOMY', 'HISTORY', 'PREVIEW', 'ENG_WORD', 'HEALTH') NOT NULL,
                                    type ENUM('MC', 'TF', 'SA') NOT NULL,
                                    level ENUM('EZ', 'MD', 'HD') NOT NULL,
                                    question TEXT NOT NULL,
                                    correctAnswer VARCHAR(255) NOT NULL,
                                    optionA VARCHAR(255),
                                    optionB VARCHAR(255),
                                    optionC VARCHAR(255),
                                    optionD VARCHAR(255),
                                    optionE VARCHAR(255)
);


-- Quiz 테이블에 데이터 삽입 (ENUM 반영)
INSERT INTO Quiz (subject, type, level, question, correctAnswer, optionA, optionB, optionC, optionD, optionE) VALUES
                                                                                                                  ('PREVIEW', 'MC', 'EZ', '2022년 기준 한국의 고령화 지수(65세 이상 인구비율)는 약?', '25%', '8%', '15%', '25%', '33%', '40%'),
                                                                                                                  ('SCIENCE', 'TF', 'MD', '인간의 유전자는 46개의 염색체로 구성되어 있다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('ECONOMY', 'SA', 'HD', '정부가 재정 적자를 메우기 위해 발행하는 것은 무엇인가요?', '국채', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HISTORY', 'MC', 'HD', '중세 유럽에서 "흑사병"이 대규모로 발생한 시기는 언제인가요?', '14세기', '11세기', '12세기', '13세기', '14세기', '15세기'),
                                                                                                                  ('ENG_WORD', 'TF', 'MD', 'Envy는 시기심을 뜻하는 영단어이다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'EZ', '폐 기능 향상을 위한 운동은?', '조깅', NULL, NULL, NULL, NULL, NULL),

                                                                                                                  ('SCIENCE', 'MC', 'EZ', '태양계에서 가장 큰 행성은?', '목성', '지구', '화성', '금성', '목성', '토성'),
                                                                                                                  ('SCIENCE', 'TF', 'MD', '알루미늄은 철보다 무겁다.', 'False', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('SCIENCE', 'SA', 'HD', '지구의 대기권 중 가장 외부에 있는 층은 무엇인가요?', '외기권', NULL, NULL, NULL, NULL, NULL),

                                                                                                                  ('ECONOMY', 'MC', 'EZ', '경제학에서 "수요"란 무엇을 의미하는가?', '소비자의 구매 의사', '공급', '시장', '소비자의 구매 의사', '생산자의 판매 의사', '정부의 정책'),
                                                                                                                  ('ECONOMY', 'TF', 'MD', '경제 성장률은 한 나라의 경제가 성장하는 속도를 나타낸다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('ECONOMY', 'SA', 'HD', '주식시장에서 주가의 장기적 상승 추세를 무엇이라 하나요?', '강세장', NULL, NULL, NULL, NULL, NULL),

                                                                                                                  ('HISTORY', 'MC', 'EZ', '미국의 초대 대통령은 누구인가요?', '조지 워싱턴', '토머스 제퍼슨', '존 애덤스', '조지 워싱턴', '제임스 매디슨', '앤드류 잭슨'),
                                                                                                                  ('HISTORY', 'TF', 'MD', '중국의 진시황은 만리장성을 건설했다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HISTORY', 'SA', 'HD', '페르시아 전쟁에서 그리스 연합군이 페르시아 군을 물리친 결정적인 전투는 무엇인가요?', '플라타이아 전투', NULL, NULL, NULL, NULL, NULL),

                                                                                                                  ('PREVIEW', 'MC', 'EZ', '다음 중 2022년 한국의 인구는?', '6천만 명', '5천만 명', '5천5백만 명', '6천만 명', '6천5백만 명', '7천만 명'),
                                                                                                                  ('PREVIEW', 'TF', 'MD', '2050년 경제협력개발기구(OECD) 국가의 평균 노인 부양비는 현재의 2배에 육박할 것이다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('PREVIEW', 'SA', 'HD', '4차 산업혁명 시대 세계 경제를 이끌 주력 산업 분야는?', '데이터, AI, 로보틱스 등', NULL, NULL, NULL, NULL, NULL),

                                                                                                                  ('ENG_WORD', 'MC', 'EZ', '다음 중 "가족"이라는 뜻의 영단어는?', 'family', 'kids', 'parents', 'family', 'relatives', 'friends'),
                                                                                                                  ('ENG_WORD', 'TF', 'MD', 'Arrogant는 거만한을 뜻하는 영단어이다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('ENG_WORD', 'SA', 'HD', 'Ambiguous의 뜻은?', '모호한', NULL, NULL, NULL, NULL, NULL),

--                                                                                                                건강, 객관식, 쉬움
                                                                                                                  ('HEALTH', 'MC', 'EZ', '비타민 C가 풍부한 과일은?', '오렌지', '사과', '바나나', '오렌지', '망고', '키위'),
                                                                                                                  ('HEALTH', 'MC', 'EZ', '오메가 3 지방산이 풍부한 해산물은?', '고등어', '새우', '문어', '고등어', '꽁치', '홍합'),
                                                                                                                  ('HEALTH', 'MC', 'EZ', '뼈 건강에 좋은 음료는?', '우유', '우유', '녹차', '커피', '탄산음료', '에너지 드링크'),
                                                                                                                  ('HEALTH', 'MC', 'EZ', '다음 중 피로 회복에 가장 좋은 음식은?', '달걀', '달걀', '과일', '채소', '곡물', '육류'),
                                                                                                                  ('HEALTH', 'MC', 'EZ', '변비 예방에 도움이 되는 음식은?', '현미', '현미', '밀가루', '설탕', '고기', '우유'),
                                                                                                                  ('HEALTH', 'MC', 'EZ', '빈혈 예방에 도움이 되는 야채는?', '양배추', '시금치', '문어', '고등어', '꽁치', '홍합'),
                                                                                                                  ('HEALTH', 'MC', 'EZ', '골다공증 예방에 도움이 되는 음식은?', '우유', '우유', '생선', '달걀', '콩', '고기'),
                                                                                                                  ('HEALTH', 'MC', 'EZ', '체중 조절에 도움이 되는 곡물은?', '쌀', '보리', '쌀', '옥수수', '귀리', '밀'),
                                                                                                                  ('HEALTH', 'MC', 'EZ', '뇌 건강에 좋은 견과류는?', '호두', '땅콩', '깨', '호두', '아몬드', '개암'),
                                                                                                                  ('HEALTH', 'MC', 'EZ', '피부 미용에 도움이 되는 과일은?', '키위', '사과', '바나나', '오렌지', '키위', '망고'),

--                                                                                                                 건강, 객관식, 보통
                                                                                                                  ('HEALTH', 'MC', 'MD', '고지혈증 예방에 도움이 되는 음식은?', '가지', '계란노른자', '쇠고기', '돼지고기', '새우', '가지'),
                                                                                                                  ('HEALTH', 'MC', 'MD', '다음 중 뇌졸중 발병 위험을 높이지 않는 식습관은?', '저염식 음식 섭취', '고지방 음식 섭취', '고칼로리 음식 섭취', '고단백질 음식 섭취', '고탄수화물 음식 섭취', '저염식 음식 섭취'),
                                                                                                                  ('HEALTH', 'MC', 'MD', '빈혈증을 예방하는데 도움이 되는 영양소는?', '철분', '칼슘', '아연', '철분', '비타민C', '엽산'),
                                                                                                                  ('HEALTH', 'MC', 'MD', '위궤양 증상을 완화시키는 음식은?', '호박', '커피', '고기', '콩', '우유', '호박'),
                                                                                                                  ('HEALTH', 'MC', 'MD', '위암 발병 위험을 낮추기 위해 섭취하는 것이 좋은 음식은?', '적은 양의 육류', '짠 음식', '적은 양의 육류', '달걀', '우유', '커피'),
                                                                                                                  ('HEALTH', 'MC', 'MD', '비만을 예방하거나 체중 조절에 도움이 되는 운동은?', '조깅', '스트레칭', '등산', '요가', '수영', '조깅'),
                                                                                                                  ('HEALTH', 'MC', 'MD', '당뇨병 예방을 위해 피하는 것이 좋은 음식은?', '고당식', '고당식', '고지방식', '고단백식', '고칼로리식', '저탄수화물식'),
                                                                                                                  ('HEALTH', 'MC', 'MD', '아래 중 노화 방지 효과가 가장 큰 안티오키시던트는?', '비타민E', '비타민C', '비타민E', '베타카로틴', '리코펜', '폴리페놀'),
                                                                                                                  ('HEALTH', 'MC', 'MD', '골다공증 예방에 도움이 되는 영양소는?', '칼슘', '칼슘', '철분', '아연', '셀레늄', '망간'),
                                                                                                                  ('HEALTH', 'MC', 'MD', '위장 건강을 위해 섭취하는 것이 좋은 음식은?', '과일', '짠 음식', '달걀', '커피', '과일', '육류'),


--                                                                                                                 건강, 객관식, 어려움
                                                                                                                  ('HEALTH', 'MC', 'HD', '비타민 중 눈의 발달과 시력 유지에 도움을 주는 비타민은?', '비타민 A', '비타민 A', '비타민 B', '비타민 C', '비타민 D', '비타민 E'),
                                                                                                                  ('HEALTH', 'MC', 'HD', '다음 중 뇌세포의 손상을 막고 인지 기능 향상에 도움을 주는 영양소는?', 'DHA', 'DHA', '라이노산', '티아민', '비오틴', '콜린'),
                                                                                                                  ('HEALTH', 'MC', 'HD', '다음 중 폐기능 향상에 가장 좋은 운동은?', '조깅', '조깅', '스쿼트', '윗몸일으키기', '아령', '줄넘기'),
                                                                                                                  ('HEALTH', 'MC', 'HD', '만성적인 변비를 예방하거나 완화시키기 위한 식품은?', '콩', '밀가루', '계란', '콩', '쇠고기', '돼지고기'),
                                                                                                                  ('HEALTH', 'MC', 'HD', '다음 중 치매 예방에 도움이 되는 음식은?', '현미', '현미', '우유', '달걀', '콩', '고기'),
                                                                                                                  ('HEALTH', 'MC', 'HD', '아래 중 뇌졸중 발병 위험을 높이는 식습관은?', '고지방 음식 섭취', '고지방 음식 섭취', '고칼로리 음식 섭취', '고단백질 음식 섭취', '고탄수화물 음식 섭취', '저염식 음식 섭취'),
                                                                                                                  ('HEALTH', 'MC', 'HD', '다음 중 콜레스테롤 수치를 높이지 않는 지방은?', '단일불포화지방', '포화지방', '트랜스지방', '콜레스테롤', '단일불포화지방', '다중불포화지방'),
                                                                                                                  ('HEALTH', 'MC', 'HD', '빈혈증을 예방하는데 도움이 되는 영양소는?', '철분', '칼슘', '아연', '철분', '비타민C', '엽산'),
                                                                                                                  ('HEALTH', 'MC', 'HD', '중년기 이후에 추천되는 운동 시간은?', '30분', '30분 미만', '30분', '1시간', '1시간 30분', '2시간 이상'),
                                                                                                                  ('HEALTH', 'MC', 'HD', '다음 중 치매 예방에 도움이 되는 음식은?', '현미', '현미', '계란', '우유', '콩', '고기'),

--                                                                                                                 건강, 참/거짓, 쉬움
                                                                                                                  ('HEALTH', 'TF', 'EZ', '우유는 칼슘이 풍부해 뼈 건강에 좋다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'EZ', '달걀은 철분을 많이 함유하고 있다.', 'False', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'EZ', '견과류는 심장 건강에 좋다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'EZ', '요거트는 유산균이 풍부해 장 건강에 좋다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'EZ', '콩은 섬유소가 많아 변비 예방에 도움이 된다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'EZ', '시금치에는 철분이 풍부하다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'EZ', '사탕은 치아 건강을 해친다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'EZ', '탄산음료는 뼈 건강을 해친다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'EZ', '햇빛을 쬐면 비타민 D가 생성돼 뼈 건강에 좋다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'EZ', '토마토는 비타민 C가 풍부해 피부에 좋다.', 'True', 'True', 'False', NULL, NULL, NULL),

--                                                                                                                 건강, 참/거짓, 보통
                                                                                                                  ('HEALTH', 'TF', 'MD', '우혈액 순환을 돕는 아연은 콩에 많이 들어있다.', 'False', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'MD', '마그네슘은 근육 조절 기능 향상에 도움을 준다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'MD', '오메가3 지방산은 뇌 건강에 좋다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'MD', '흰쌀보다 현미가 당뇨 예방에 더 효과적이다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'MD', '청량음료의 카페인 섭취량이 많으면 불면증이 올 수 있다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'MD', '혈중 콜레스테롤 수치를 높이는 지방은 포화지방이다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'MD', '유산균은 장 내 유해 박테리아를 억제하는 효과가 있다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'MD', '혈압이 높은 사람은 나트륨 섭취를 줄이는 것이 좋다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'MD', '햇빛을 쬐면 비타민 D가 생성돼 뼈 건강에 좋다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'MD', '고구마에는 베타카로틴이 풍부해 암 예방에 도움이 된다.', 'False', 'True', 'False', NULL, NULL, NULL),

--                                                                                                                 건강, 참/거짓, 어려움
                                                                                                                  ('HEALTH', 'TF', 'HD', '셀레늄은 갑상선 기능 개선에 도움을 준다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'HD', '루테인과 지아잔틴은 시력 보호에 도움을 준다.' 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'HD', '비타민 B1은 신경 기능 유지에 도움을 주는 비타민이다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'HD', '카페인 섭취는 철분 흡수를 방해한다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'HD', '당뇨병에서 알부민 누출은 신장 기능 이상의 징후이다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'HD', '비오틴은 두피와 모발 건강 유지에 도움이 된다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'HD', '구연산은 치아 우식 예방에 도움이 된다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'HD', '철분 과다 섭취는 간 기능 이상을 일으킬 수 있다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'HD', '아연은 전립선 건강 유지에 도움을 준다.', 'True', 'True', 'False', NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'TF', 'HD', '조단백은 골다공증 예방에 도움이 된다.', 'True', 'True', 'False', NULL, NULL, NULL),

--                                                                                                                 건강, 주관식/단답형, 쉬움
                                                                                                                  ('HEALTH', 'SA', 'EZ', '빈혈증 예방에 좋은 야채는?', '시금치', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'EZ', '변비 예방에 도움을 주는 곡물은?', '현미', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'EZ', '뼈 건강을 위한 음료는?', '우유', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'EZ', '위장 건강을 위한 발효식품은?', '요거트', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'EZ', '피로 회복에 좋은 견과류는?', '호두', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'EZ', '고혈압 예방에 좋은 해산물은?', '새우', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'EZ', '다이어트를 위한 식사 방법은?', '부식 식사', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'EZ', '치매 예방에 도움되는 음식은?', '현미', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'EZ', '노화 방지 효과가 큰 비타민은?', '비타민E', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'EZ', '폐 기능 향상을 위한 운동은?', '조깅', NULL, NULL, NULL, NULL, NULL),

--                                                                                                                 건강, 주관식/단답형, 보통
                                                                                                                  ('HEALTH', 'SA', 'MD', '위장 건강을 위해 피하는 것이 좋은 음식은?', '짠 음식', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'MD', '골다공증 예방에 도움되는 영양소는?', '칼슘', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'MD', '심장병 예방에 도움되는 나트륨 섭취량은?', '하루에 2,300밀리그램 이하', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'MD', '당뇨병 예방을 위해 피하는 것이 좋은 음식 유형은?', '고당식', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'MD', '위암 발병 위험을 낮추기 위한 좋은 식생활 습관은?', '육류 적게 먹기', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'MD', '체중 조절을 위한 하루 권장 운동 시간은?', '30분에서 1시간', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'MD', '고혈압 환자를 위한 체중관리 지수(BMI) 기준은?', '23 이하', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'MD', '임산부를 위한 하루 권장 엽산 섭취량은?', '0.4밀리', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'MD', '철분 흡수를 위해 섭취하는 것이 좋은 영양소는?', '비타민C', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'MD', '고령자를 위한 하루 권장 비타민 D 섭취량은?', '15마이크로그램(600IU) 이상', NULL, NULL, NULL, NULL, NULL),

--                                                                                                                 건강, 주관식/단답형, 어려움
                                                                                                                  ('HEALTH', 'SA', 'HD', '성인 남성의 하루 권장 아연 섭취량은?', '11밀리그램', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'HD', '여성의 하루 권장 칼슘 섭취량은?', '1,000밀리그램(폐경기 이후는 1,200밀리그램)', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'HD', '성인의 하루 권장 셀레늄 섭취량은?', '55마이크로그램', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'HD', '임신부의 하루 권장 엽산 섭취량은?', '0.6밀리그램', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'HD', '성인의 하루 권장 비타민 K 섭취량은?', '남성 120마이크로그램, 여성 90마이크로그램', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'HD', '성인의 하루 권장 비타민 B12 섭취량은?', '2.4마이크로그램', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'HD', '성인의 하루 권장 나이아신 섭취량은?', '남성 16밀리그램, 여성 14밀리그램', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'HD', '임산부의 하루 권장 철분 섭취량은?', '27밀리그램', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'HD', '고령자의 하루 권장 비타민 B6 섭취량은?', '남성 1.7밀리그램, 여성 1.5밀리그램', NULL, NULL, NULL, NULL, NULL),
                                                                                                                  ('HEALTH', 'SA', 'HD', '영유아의 하루 권장 아연 섭취량은?', '2세 미만 5밀리그램, 2-5세 10밀리그램', NULL, NULL, NULL, NULL, NULL),



;





