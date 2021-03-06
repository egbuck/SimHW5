BEGIN;
            CREATE:    30;
            ASSIGN:    JobType=1;
            DELAY:     2:NEXT(Drills);
            CREATE:    20;
            ASSIGN:    JobType=2;
            DELAY:     10:NEXT(Drills);
Drills      QUEUE,     DrillQ;
            SEIZE:     Drill;
            DELAY:     NORM(10,1);
            RELEASE:   Drill;
            BRANCH,    1:
                          IF, JobType==1, Straighten:
                          ELSE, Finish;
Straighten  QUEUE,     StraightenQ;
            SEIZE:     Straightener;
            DELAY:     EXPO(15);
            RELEASE:   Straightener:Next(Finish);
Finish      QUEUE,     FinishQ;
            SEIZE:     Finisher;
            DELAY:     5;
            RELEASE:   Finisher;
            BRANCH,    1:
                          WITH, .1, Finish:
                          WITH, .9, Done;
Done        COUNT:     JobType;
	    DISPOSE;
END;