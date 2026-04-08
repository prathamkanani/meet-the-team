import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/error.dart';
import '../common/error_dialog.dart';
import '../common/loader.dart';
import '../config/app_spacing.dart';
import 'widgets/add_task_button.dart';
import 'widgets/add_task_sheet.dart';
import 'widgets/closing_timer_badge.dart';
import 'widgets/cycle_toggle.dart';
import '../../infrastructure/app_injector.dart';
import '../../application/logic/daily_task/task_bloc.dart';
import '../../application/logic/daily_task/task_event.dart';
import '../../application/logic/daily_task/task_state.dart';
import '../common/error_page.dart';
import 'widgets/task_list.dart';

class DailyTaskHomePage extends StatefulWidget {
  const DailyTaskHomePage({super.key});

  @override
  State<DailyTaskHomePage> createState() => _DailyTaskHomePageState();
}

class _DailyTaskHomePageState extends State<DailyTaskHomePage> {
  late final TaskBloc _taskBloc;
  bool _isErrorPageOpen = false;
  final TimeOfDay current = TimeOfDay.now();
  late DayPeriod dayPeriod = current.period;

  @override
  void initState() {
    super.initState();
    _taskBloc = locator.get();
  }

  @override
  void dispose() {
    _taskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = ColorScheme.of(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => _taskBloc.add(LoadTasksEvent(dayPeriod)),
          child: CustomScrollView(
            slivers: [
              const _DailyTaskAppBar(),

              AMPMCycle(taskBloc: _taskBloc),

              ClosingTimer(taskBloc: _taskBloc),

              SliverPadding(
                padding: const EdgeInsetsGeometry.all(16),
                sliver: BlocConsumer<TaskBloc, TaskState>(
                  bloc: _taskBloc,
                  listener: (context, state) {
                    if (state is TaskErrorState && !_isErrorPageOpen) {
                      errorDialog(context, state.exception);
                      // navigateToErrorPage(context, state);
                    } else if (state is TaskLoadedState && _isErrorPageOpen) {
                      Navigator.pop(context);
                    }
                  },
                  builder: (_, state) {
                    final Widget loader = const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Loader(),
                    );

                    return switch (state) {
                      TaskInitialState() => loader,
                      TaskLoadingState() => loader,
                      TaskLoadedState() => TaskList(
                        tasks: state.tasks,
                        dayPeriod: state.dayPeriod,
                        onAdd: () => _showAddTaskSheet(context),
                      ),
                      TaskErrorState() => const SliverToBoxAdapter(
                        child: SizedBox.shrink(),
                      ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AddTaskButton(onTap: _showAddTaskSheet),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //region Custom Methods
  void navigateToErrorPage(BuildContext context, TaskErrorState state) {
    _isErrorPageOpen = true;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ErrorPage(
          exception: state.exception,
          retry: () async {
            _taskBloc.add(LoadTasksEvent(state.dayPeriod));
            return;
          },
        ),
      ),
    ).then((_) => _isErrorPageOpen = false);
  }

  void errorDialog(BuildContext context, AppException exception) {
    showDialog(
      context: context,
      builder: (context) {
        return ErrorDialog(exception: exception);
      },
    );
  }

  void _showAddTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          BlocProvider.value(value: _taskBloc, child: const AddTaskSheet()),
    );
  }

  //endregion
}

class _DailyTaskAppBar extends StatelessWidget {
  const _DailyTaskAppBar();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = ColorScheme.of(context);

    return SliverAppBar(
      pinned: true,
      surfaceTintColor: cs.surfaceContainerHighest,
      backgroundColor: cs.surfaceContainerHighest,
      title: Row(
        children: [
          const Icon(Icons.menu_rounded),
          AppSpacing.w08,
          const Expanded(child: Text('Daily Task')),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: cs.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_rounded, color: cs.onPrimary),
          ),
        ],
      ),
    );
  }
}
