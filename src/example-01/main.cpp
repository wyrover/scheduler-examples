#include <Windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <scheduler/scheduler.h>
#include <boost/bind.hpp>
#include <boost/thread.hpp>

void doSomething()
{
	printf("hello world!\n");
}

void doSomething2()
{
	printf("hello world------!\n");
}

class TaskA
{
public:
	TaskA()	{

	}
	~TaskA() {

	}
public:
	void func(int i) {
		printf("hello %d\n", i);
	}
};

int main(int argc, char** argv)
{
	TaskA task;
	
	 CScheduler* s = new CScheduler();
	 s->scheduleFromNow(doSomething, 5000); // Assuming a: void doSomething() { }
	 s->scheduleFromNow(boost::bind(&TaskA::func, task, 5), 1000);
	 s->scheduleEvery(doSomething2, 10000);


	 boost::thread_group* group = new boost::thread_group();
	 for (int num = 0; num < 5; num++)
		 group->create_thread(boost::bind(&CScheduler::serviceQueue, s));
	 

	 //boost::thread* t = new boost::thread(boost::bind(&CScheduler::serviceQueue, s));
	
	 group->join_all();
	 delete group;
	 delete s; // Must be done after thread is interrupted/joined.

	system("pause");
	
}
