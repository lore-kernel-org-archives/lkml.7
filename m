Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C152CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBFB2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfK2GEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:04:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48037 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfK2GDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:03 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMm-0008Li-PE; Fri, 29 Nov 2019 07:02:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 82FF61C2108;
        Fri, 29 Nov 2019 07:02:52 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf thread: Rename thread->mg to thread->maps
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-69vcr8pubpym90skxhmbwhiw@git.kernel.org>
References: <tip-69vcr8pubpym90skxhmbwhiw@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737244.21853.16029950095543348694.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     fe87797dea79b59e97a4ea67441bf91f2905bf23
Gitweb:        https://git.kernel.org/tip/fe87797dea79b59e97a4ea67441bf91f2905bf23
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 25 Nov 2019 22:07:43 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:46 -03:00

perf thread: Rename thread->mg to thread->maps

One more step on the merge of 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-69vcr8pubpym90skxhmbwhiw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     |  2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c   |  2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c |  2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c     |  2 +-
 tools/perf/builtin-report.c                  |  2 +-
 tools/perf/tests/code-reading.c              |  2 +-
 tools/perf/tests/thread-mg-share.c           | 12 ++++----
 tools/perf/ui/stdio/hist.c                   |  2 +-
 tools/perf/util/db-export.c                  |  2 +-
 tools/perf/util/event.c                      |  4 +--
 tools/perf/util/machine.c                    | 16 +++++-----
 tools/perf/util/map.c                        |  2 +-
 tools/perf/util/thread-stack.c               |  4 +--
 tools/perf/util/thread.c                     | 30 +++++++++----------
 tools/perf/util/thread.h                     |  2 +-
 tools/perf/util/unwind-libdw.c               |  2 +-
 tools/perf/util/unwind-libunwind-local.c     |  4 +--
 tools/perf/util/unwind-libunwind.c           |  4 +--
 tools/perf/util/vdso.c                       |  2 +-
 19 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index 0267372..ff0bea6 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -26,7 +26,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_ARM_SP];
 
-	map = maps__find(thread->mg, (u64)sp);
+	map = maps__find(thread->maps, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index 8864896..8510843 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -26,7 +26,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_ARM64_SP];
 
-	map = maps__find(thread->mg, (u64)sp);
+	map = maps__find(thread->maps, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index b38117c..30658e3 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -27,7 +27,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_POWERPC_R1];
 
-	map = maps__find(thread->mg, (u64)sp);
+	map = maps__find(thread->maps, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index f52132e..418969c 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -27,7 +27,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_X86_SP];
 
-	map = maps__find(thread->mg, (u64)sp);
+	map = maps__find(thread->maps, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 729d684..830d563 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -790,7 +790,7 @@ static void task__print_level(struct task *task, FILE *fp, int level)
 
 	fprintf(fp, "%s\n", thread__comm_str(thread));
 
-	maps__fprintf_task(thread->mg, comm_indent, fp);
+	maps__fprintf_task(thread->maps, comm_indent, fp);
 
 	if (!list_empty(&task->children)) {
 		list_for_each_entry(child, &task->children, list)
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 1f017e1..6fe221d 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -276,7 +276,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		len = al.map->end - addr;
 
 	/* Read the object code using perf */
-	ret_len = dso__data_read_offset(al.map->dso, thread->mg->machine,
+	ret_len = dso__data_read_offset(al.map->dso, thread->maps->machine,
 					al.addr, buf1, len);
 	if (ret_len != len) {
 		pr_debug("dso__data_read_offset failed\n");
diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-mg-share.c
index 7f15eed..6032061 100644
--- a/tools/perf/tests/thread-mg-share.c
+++ b/tools/perf/tests/thread-mg-share.c
@@ -42,13 +42,13 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	TEST_ASSERT_VAL("failed to create threads",
 			leader && t1 && t2 && t3 && other);
 
-	mg = leader->mg;
+	mg = leader->maps;
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 4);
 
 	/* test the map groups pointer is shared */
-	TEST_ASSERT_VAL("map groups don't match", mg == t1->mg);
-	TEST_ASSERT_VAL("map groups don't match", mg == t2->mg);
-	TEST_ASSERT_VAL("map groups don't match", mg == t3->mg);
+	TEST_ASSERT_VAL("map groups don't match", mg == t1->maps);
+	TEST_ASSERT_VAL("map groups don't match", mg == t2->maps);
+	TEST_ASSERT_VAL("map groups don't match", mg == t3->maps);
 
 	/*
 	 * Verify the other leader was created by previous call.
@@ -70,10 +70,10 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	machine__remove_thread(machine, other);
 	machine__remove_thread(machine, other_leader);
 
-	other_mg = other->mg;
+	other_mg = other->maps;
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 2);
 
-	TEST_ASSERT_VAL("map groups don't match", other_mg == other_leader->mg);
+	TEST_ASSERT_VAL("map groups don't match", other_mg == other_leader->maps);
 
 	/* release thread group */
 	thread__put(leader);
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 2d9c484..161d834 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -885,7 +885,7 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		}
 
 		if (h->ms.map == NULL && verbose > 1) {
-			maps__fprintf(h->thread->mg, fp);
+			maps__fprintf(h->thread->maps, fp);
 			fprintf(fp, "%.10s end\n", graph_dotted_line);
 		}
 	}
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index d029faf..e726922 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -251,7 +251,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		 */
 		al.sym = node->ms.sym;
 		al.map = node->ms.map;
-		al.mg  = thread->mg;
+		al.mg  = thread->maps;
 		al.addr = node->ip;
 
 		if (al.map && !al.sym)
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0181790..2f0b773 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -457,7 +457,7 @@ int perf_event__process(struct perf_tool *tool __maybe_unused,
 struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al)
 {
-	struct maps *mg = thread->mg;
+	struct maps *mg = thread->maps;
 	struct machine *machine = mg->machine;
 	bool load_map = false;
 
@@ -523,7 +523,7 @@ struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
 				struct addr_location *al)
 {
 	struct map *map = thread__find_map(thread, cpumode, addr, al);
-	struct machine *machine = thread->mg->machine;
+	struct machine *machine = thread->maps->machine;
 	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode, addr);
 
 	if (map || addr_cpumode == cpumode)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d646aea..b351476 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -412,28 +412,28 @@ static void machine__update_thread_pid(struct machine *machine,
 	if (!leader)
 		goto out_err;
 
-	if (!leader->mg)
-		leader->mg = maps__new(machine);
+	if (!leader->maps)
+		leader->maps = maps__new(machine);
 
-	if (!leader->mg)
+	if (!leader->maps)
 		goto out_err;
 
-	if (th->mg == leader->mg)
+	if (th->maps == leader->maps)
 		return;
 
-	if (th->mg) {
+	if (th->maps) {
 		/*
 		 * Maps are created from MMAP events which provide the pid and
 		 * tid.  Consequently there never should be any maps on a thread
 		 * with an unknown pid.  Just print an error if there are.
 		 */
-		if (!maps__empty(th->mg))
+		if (!maps__empty(th->maps))
 			pr_err("Discarding thread maps for %d:%d\n",
 			       th->pid_, th->tid);
-		maps__put(th->mg);
+		maps__put(th->maps);
 	}
 
-	th->mg = maps__get(leader->mg);
+	th->maps = maps__get(leader->maps);
 out_put:
 	thread__put(leader);
 	return;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 4c9fd06..39bfed4 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -819,7 +819,7 @@ out:
  */
 int maps__clone(struct thread *thread, struct maps *parent)
 {
-	struct maps *mg = thread->mg;
+	struct maps *mg = thread->maps;
 	int err = -ENOMEM;
 	struct map *map;
 
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index cd8a948..0885967 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -134,8 +134,8 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 	if (err)
 		return err;
 
-	if (thread->mg && thread->mg->machine) {
-		struct machine *machine = thread->mg->machine;
+	if (thread->maps && thread->maps->machine) {
+		struct machine *machine = thread->maps->machine;
 		const char *arch = perf_env__arch(machine->env);
 
 		ts->kernel_start = machine__kernel_start(machine);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b672a2a..28b7193 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -24,16 +24,16 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 	pid_t pid = thread->pid_;
 
 	if (pid == thread->tid || pid == -1) {
-		thread->mg = maps__new(machine);
+		thread->maps = maps__new(machine);
 	} else {
 		struct thread *leader = __machine__findnew_thread(machine, pid, pid);
 		if (leader) {
-			thread->mg = maps__get(leader->mg);
+			thread->maps = maps__get(leader->maps);
 			thread__put(leader);
 		}
 	}
 
-	return thread->mg ? 0 : -1;
+	return thread->maps ? 0 : -1;
 }
 
 struct thread *thread__new(pid_t pid, pid_t tid)
@@ -86,9 +86,9 @@ void thread__delete(struct thread *thread)
 
 	thread_stack__free(thread);
 
-	if (thread->mg) {
-		maps__put(thread->mg);
-		thread->mg = NULL;
+	if (thread->maps) {
+		maps__put(thread->maps);
+		thread->maps = NULL;
 	}
 	down_write(&thread->namespaces_lock);
 	list_for_each_entry_safe(namespaces, tmp_namespaces,
@@ -251,7 +251,7 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
 		list_add(&new->list, &thread->comm_list);
 
 		if (exec)
-			unwind__flush_access(thread->mg);
+			unwind__flush_access(thread->maps);
 	}
 
 	thread->comm_set = true;
@@ -324,19 +324,19 @@ int thread__comm_len(struct thread *thread)
 size_t thread__fprintf(struct thread *thread, FILE *fp)
 {
 	return fprintf(fp, "Thread %d %s\n", thread->tid, thread__comm_str(thread)) +
-	       maps__fprintf(thread->mg, fp);
+	       maps__fprintf(thread->maps, fp);
 }
 
 int thread__insert_map(struct thread *thread, struct map *map)
 {
 	int ret;
 
-	ret = unwind__prepare_access(thread->mg, map, NULL);
+	ret = unwind__prepare_access(thread->maps, map, NULL);
 	if (ret)
 		return ret;
 
-	maps__fixup_overlappings(thread->mg, map, stderr);
-	maps__insert(thread->mg, map);
+	maps__fixup_overlappings(thread->maps, map, stderr);
+	maps__insert(thread->maps, map);
 
 	return 0;
 }
@@ -345,13 +345,13 @@ static int __thread__prepare_access(struct thread *thread)
 {
 	bool initialized = false;
 	int err = 0;
-	struct maps *maps = thread->mg;
+	struct maps *maps = thread->maps;
 	struct map *map;
 
 	down_read(&maps->lock);
 
 	maps__for_each_entry(maps, map) {
-		err = unwind__prepare_access(thread->mg, map, &initialized);
+		err = unwind__prepare_access(thread->maps, map, &initialized);
 		if (err || initialized)
 			break;
 	}
@@ -377,13 +377,13 @@ static int thread__clone_maps(struct thread *thread, struct thread *parent, bool
 	if (thread->pid_ == parent->pid_)
 		return thread__prepare_access(thread);
 
-	if (thread->mg == parent->mg) {
+	if (thread->maps == parent->maps) {
 		pr_debug("broken map groups on thread %d/%d parent %d/%d\n",
 			 thread->pid_, thread->tid, parent->pid_, parent->tid);
 		return 0;
 	}
 	/* But this one is new process, copy maps. */
-	return do_maps_clone ? maps__clone(thread, parent->mg) : 0;
+	return do_maps_clone ? maps__clone(thread, parent->maps) : 0;
 }
 
 int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone)
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 4735d92..20b96b5 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -25,7 +25,7 @@ struct thread {
 		struct rb_node	 rb_node;
 		struct list_head node;
 	};
-	struct maps		*mg;
+	struct maps		*maps;
 	pid_t			pid_; /* Not all tools update this */
 	pid_t			tid;
 	pid_t			ppid;
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index d2a8df0..33f6552 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -200,7 +200,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	struct unwind_info *ui, ui_buf = {
 		.sample		= data,
 		.thread		= thread,
-		.machine	= thread->mg->machine,
+		.machine	= thread->maps->machine,
 		.cb		= cb,
 		.arg		= arg,
 		.max_stack	= max_stack,
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 31f77f8..30f921f 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -660,7 +660,7 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	 */
 	if (max_stack - 1 > 0) {
 		WARN_ONCE(!ui->thread, "WARNING: ui->thread is NULL");
-		addr_space = ui->thread->mg->addr_space;
+		addr_space = ui->thread->maps->addr_space;
 
 		if (addr_space == NULL)
 			return -1;
@@ -709,7 +709,7 @@ static int _unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	struct unwind_info ui = {
 		.sample       = data,
 		.thread       = thread,
-		.machine      = thread->mg->machine,
+		.machine      = thread->maps->machine,
 	};
 
 	if (!data->user_regs.regs)
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 3769ae9..4003ae8 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -82,7 +82,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 			 struct thread *thread,
 			 struct perf_sample *data, int max_stack)
 {
-	if (thread->mg->unwind_libunwind_ops)
-		return thread->mg->unwind_libunwind_ops->get_entries(cb, arg, thread, data, max_stack);
+	if (thread->maps->unwind_libunwind_ops)
+		return thread->maps->unwind_libunwind_ops->get_entries(cb, arg, thread, data, max_stack);
 	return 0;
 }
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 765b29a..3cc91ad 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -144,7 +144,7 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
 	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
 	struct map *map;
 
-	maps__for_each_entry(thread->mg, map) {
+	maps__for_each_entry(thread->maps, map) {
 		struct dso *dso = map->dso;
 		if (!dso || dso->long_name[0] != '/')
 			continue;
