Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77913CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2339A222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504183AbfJRFFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:05:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407379AbfJRFFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 26C4A2832EEE2F549A8D;
        Fri, 18 Oct 2019 11:19:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:39 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 32/33] tools perf: Renaming pr_warning to pr_warn
Date:   Fri, 18 Oct 2019 11:18:49 +0800
Message-ID: <20191018031850.48498-32-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kernel logging macro, pr_warning is completely removed and
replaced by pr_warn, using pr_warn in tools perf for symmetry
to kernel logging macro, then we could drop pr_warning in the
whole linux code.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 tools/perf/arch/x86/util/intel-pt.c      |   2 +-
 tools/perf/builtin-annotate.c            |   7 +-
 tools/perf/builtin-buildid-cache.c       |  28 +++---
 tools/perf/builtin-diff.c                |  12 +--
 tools/perf/builtin-help.c                |  10 +-
 tools/perf/builtin-inject.c              |   8 +-
 tools/perf/builtin-probe.c               |  14 +--
 tools/perf/builtin-record.c              |  10 +-
 tools/perf/builtin-report.c              |   2 +-
 tools/perf/builtin-script.c              |  14 +--
 tools/perf/builtin-stat.c                |  18 ++--
 tools/perf/builtin-timechart.c           |  12 +--
 tools/perf/builtin-top.c                 |   2 +-
 tools/perf/builtin-trace.c               |   8 +-
 tools/perf/lib/internal.h                |   2 +-
 tools/perf/ui/browsers/scripts.c         |   2 +-
 tools/perf/util/bpf-loader.c             |   6 +-
 tools/perf/util/bpf-prologue.c           |   4 +-
 tools/perf/util/callchain.c              |   2 +-
 tools/perf/util/config.c                 |   8 +-
 tools/perf/util/data-convert-bt.c        |   4 +-
 tools/perf/util/data.c                   |   2 +-
 tools/perf/util/debug.c                  |   4 +-
 tools/perf/util/debug.h                  |   2 +-
 tools/perf/util/event.c                  |   4 +-
 tools/perf/util/evlist.c                 |   4 +-
 tools/perf/util/evsel.c                  |  19 ++--
 tools/perf/util/header.c                 |  20 ++--
 tools/perf/util/jitdump.c                |   4 +-
 tools/perf/util/llvm-utils.c             |  18 ++--
 tools/perf/util/machine.c                |   2 +-
 tools/perf/util/parse-branch-options.c   |   3 +-
 tools/perf/util/perf-hooks.c             |   6 +-
 tools/perf/util/probe-event.c            |  90 +++++++++---------
 tools/perf/util/probe-file.c             |  36 +++----
 tools/perf/util/probe-finder.c           | 115 +++++++++++------------
 tools/perf/util/record.c                 |  18 ++--
 tools/perf/util/session.c                |   2 +-
 tools/perf/util/srcline.c                |   6 +-
 tools/perf/util/synthetic-events.c       |  10 +-
 tools/perf/util/thread-stack.c           |   4 +-
 tools/perf/util/thread_map.c             |   2 +-
 tools/perf/util/trace-event-parse.c      |   2 +-
 tools/perf/util/unwind-libunwind-local.c |   9 +-
 44 files changed, 273 insertions(+), 284 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index d6d26256915f..7ce07da4abb1 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -530,7 +530,7 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
 	 */
 	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1 &&
 	    !(evsel->core.attr.config & 1)) {
-		pr_warning("pt=0 doesn't make sense, forcing pt=1\n");
+		pr_warn("pt=0 doesn't make sense, forcing pt=1\n");
 		evsel->core.attr.config |= 1;
 	}
 
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8db8fc9bddef..9be57f894d09 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -269,8 +269,8 @@ static int process_sample_event(struct perf_tool *tool,
 	int ret = 0;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
-		pr_warning("problem processing %d event, skipping it.\n",
-			   event->header.type);
+		pr_warn("problem processing %d event, skipping it.\n",
+			event->header.type);
 		return -1;
 	}
 
@@ -279,8 +279,7 @@ static int process_sample_event(struct perf_tool *tool,
 
 	if (!al.filtered &&
 	    perf_evsel__add_sample(evsel, sample, &al, ann, machine)) {
-		pr_warning("problem incrementing symbol count, "
-			   "skipping event\n");
+		pr_warn("problem incrementing symbol count, skipping event\n");
 		ret = -1;
 	}
 out_put:
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 39efa51d7fb3..3d81f8a94c55 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -282,11 +282,11 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 		if (errno == ENOENT)
 			return false;
 
-		pr_warning("Problems with %s file, consider removing it from the cache\n",
-			   filename);
+		pr_warn("Problems with %s file, consider removing it from the cache\n",
+			filename);
 	} else if (memcmp(dso->build_id, build_id, sizeof(dso->build_id))) {
-		pr_warning("Problems with %s file, consider removing it from the cache\n",
-			   filename);
+		pr_warn("Problems with %s file, consider removing it from the cache\n",
+			filename);
 	}
 
 	return true;
@@ -447,8 +447,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 							 pos->s);
 						continue;
 					}
-					pr_warning("Couldn't add %s: %s\n",
-						   pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
+					pr_warn("Couldn't add %s: %s\n",
+						pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
 				}
 
 			strlist__delete(list);
@@ -465,8 +465,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 							 pos->s);
 						continue;
 					}
-					pr_warning("Couldn't remove %s: %s\n",
-						   pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
+					pr_warn("Couldn't remove %s: %s\n",
+						pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
 				}
 
 			strlist__delete(list);
@@ -483,8 +483,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 							 pos->s);
 						continue;
 					}
-					pr_warning("Couldn't remove %s: %s\n",
-						   pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
+					pr_warn("Couldn't remove %s: %s\n",
+						pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
 				}
 
 			strlist__delete(list);
@@ -493,7 +493,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 
 	if (purge_all) {
 		if (build_id_cache__purge_all()) {
-			pr_warning("Couldn't remove some caches. Error: %s.\n",
+			pr_warn("Couldn't remove some caches. Error: %s.\n",
 				str_error_r(errno, sbuf, sizeof(sbuf)));
 		}
 	}
@@ -511,8 +511,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 							 pos->s);
 						continue;
 					}
-					pr_warning("Couldn't update %s: %s\n",
-						   pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
+					pr_warn("Couldn't update %s: %s\n",
+						pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
 				}
 
 			strlist__delete(list);
@@ -520,7 +520,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 	}
 
 	if (kcore_filename && build_id_cache__add_kcore(kcore_filename, force))
-		pr_warning("Couldn't add %s\n", kcore_filename);
+		pr_warn("Couldn't add %s\n", kcore_filename);
 
 out:
 	perf_session__delete(session);
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c37a78677955..5a105338c4fa 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -395,8 +395,8 @@ static int diff__process_sample_event(struct perf_tool *tool,
 	}
 
 	if (machine__resolve(machine, &al, sample) < 0) {
-		pr_warning("problem processing %d event, skipping it.\n",
-			   event->header.type);
+		pr_warn("problem processing %d event, skipping it.\n",
+			event->header.type);
 		return -1;
 	}
 
@@ -408,15 +408,15 @@ static int diff__process_sample_event(struct perf_tool *tool,
 	if (compute != COMPUTE_CYCLES) {
 		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample,
 				      true)) {
-			pr_warning("problem incrementing symbol period, "
-				   "skipping event\n");
+			pr_warn("problem incrementing symbol period, "
+				"skipping event\n");
 			goto out_put;
 		}
 	} else {
 		if (!hists__add_entry_ops(hists, &block_hist_ops, &al, NULL,
 					  NULL, NULL, sample, true)) {
-			pr_warning("problem incrementing symbol period, "
-				   "skipping event\n");
+			pr_warn("problem incrementing symbol period, "
+				"skipping event\n");
 			goto out_put;
 		}
 
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 3976aebe3677..36c1aa33d72f 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -117,7 +117,7 @@ static int check_emacsclient_version(void)
 static void exec_failed(const char *cmd)
 {
 	char sbuf[STRERR_BUFSIZE];
-	pr_warning("failed to exec '%s': %s", cmd, str_error_r(errno, sbuf, sizeof(sbuf)));
+	pr_warn("failed to exec '%s': %s", cmd, str_error_r(errno, sbuf, sizeof(sbuf)));
 }
 
 static void exec_woman_emacs(const char *path, const char *page)
@@ -218,8 +218,8 @@ static void do_add_man_viewer_info(const char *name,
 
 static void unsupported_man_viewer(const char *name, const char *var)
 {
-	pr_warning("'%s': path for unsupported man viewer.\n"
-		   "Please consider using 'man.<tool>.%s' instead.", name, var);
+	pr_warn("'%s': path for unsupported man viewer.\n"
+		"Please consider using 'man.<tool>.%s' instead.", name, var);
 }
 
 static int add_man_viewer_path(const char *name,
@@ -267,7 +267,7 @@ static int add_man_viewer_info(const char *var, const char *value)
 		return add_man_viewer_cmd(name, subkey - name, value);
 	}
 
-	pr_warning("'%s': unsupported man viewer sub key.", subkey);
+	pr_warn("'%s': unsupported man viewer sub key.", subkey);
 	return 0;
 }
 
@@ -355,7 +355,7 @@ static void exec_viewer(const char *name, const char *page)
 	else if (info)
 		exec_man_cmd(info, page);
 	else
-		pr_warning("'%s': unknown man viewer.", name);
+		pr_warn("'%s': unknown man viewer.", name);
 }
 
 static int show_man_page(const char *perf_cmd)
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3e2c06..c93f271096ba 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -450,9 +450,9 @@ static int perf_event__inject_buildid(struct perf_tool *tool,
 				 */
 			} else {
 #ifdef HAVE_LIBELF_SUPPORT
-				pr_warning("no symbols found in %s, maybe "
-					   "install a debug package?\n",
-					   al.map->dso->long_name);
+				pr_warn("no symbols found in %s, maybe "
+					"install a debug package?\n",
+					al.map->dso->long_name);
 #endif
 			}
 		}
@@ -840,7 +840,7 @@ int cmd_inject(int argc, const char **argv)
 		return PTR_ERR(inject.session);
 
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
-		pr_warning("Decompression initialization failed.\n");
+		pr_warn("Decompression initialization failed.\n");
 
 	if (inject.build_ids) {
 		/*
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 26bc5923e6b5..1f94481fc3bf 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -182,7 +182,7 @@ static int opt_set_target(const struct option *opt, const char *str,
 		if (params.uprobes || strchr(str, '/')) {
 			tmp = nsinfo__realpath(str, params.nsi);
 			if (!tmp) {
-				pr_warning("Failed to get the absolute path of %s: %m\n", str);
+				pr_warn("Failed to get the absolute path of %s: %m\n", str);
 				return ret;
 			}
 		} else {
@@ -211,8 +211,8 @@ static int opt_set_target_ns(const struct option *opt __maybe_unused,
 		ns_pid = (pid_t)strtol(str, NULL, 10);
 		if (errno != 0) {
 			ret = -errno;
-			pr_warning("Failed to parse %s as a pid: %s\n", str,
-				   strerror(errno));
+			pr_warn("Failed to parse %s as a pid: %s\n", str,
+				strerror(errno));
 			return ret;
 		}
 		nsip = nsinfo__new(ns_pid);
@@ -239,8 +239,8 @@ static int opt_show_lines(const struct option *opt,
 		return 0;
 
 	if (params.command == 'L') {
-		pr_warning("Warning: more than one --line options are"
-			   " detected. Only the first one is valid.\n");
+		pr_warn("Warning: more than one --line options are"
+			" detected. Only the first one is valid.\n");
 		return 0;
 	}
 
@@ -408,7 +408,7 @@ static int del_perf_probe_caches(struct strfilter *filter)
 			continue;
 		if (probe_cache__filter_purge(cache, filter) < 0 ||
 		    probe_cache__commit(cache) < 0)
-			pr_warning("Failed to remove entries for %s\n", nd->s);
+			pr_warn("Failed to remove entries for %s\n", nd->s);
 		probe_cache__delete(cache);
 	}
 	return 0;
@@ -462,7 +462,7 @@ static int perf_del_probe_events(struct strfilter *filter)
 	}
 
 	if (ret == -ENOENT && ret2 == -ENOENT)
-		pr_warning("\"%s\" does not hit any event.\n", str);
+		pr_warn("\"%s\" does not hit any event.\n", str);
 	else
 		ret = 0;
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 23332861de6e..501ffeaef63e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -790,7 +790,7 @@ static int record__open(struct record *rec)
 	}
 
 	if (symbol_conf.kptr_restrict && !perf_evlist__exclude_kernel(evlist)) {
-		pr_warning(
+		pr_warn(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
 "check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
 "Samples in kernel functions may not be resolved if a suitable vmlinux\n"
@@ -1323,7 +1323,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
 						machine, opts);
 	if (err < 0)
-		pr_warning("Couldn't synthesize bpf events.\n");
+		pr_warn("Couldn't synthesize bpf events.\n");
 
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
 					    process_synthesized_event, opts->sample_address,
@@ -1429,7 +1429,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	 * evlist.
 	 */
 	if (rec->tool.ordered_events && !perf_evlist__sample_id_all(rec->evlist)) {
-		pr_warning("WARNING: No sample_id_all support, falling back to unordered processing\n");
+		pr_warn("WARNING: No sample_id_all support, falling back to unordered processing\n");
 		rec->tool.ordered_events = false;
 	}
 
@@ -1874,7 +1874,7 @@ static int get_clockid_res(clockid_t clk_id, u64 *res_ns)
 	if (!clock_getres(clk_id, &res))
 		*res_ns = res.tv_nsec + res.tv_sec * NSEC_PER_SEC;
 	else
-		pr_warning("WARNING: Failed to determine specified clock resolution.\n");
+		pr_warn("WARNING: Failed to determine specified clock resolution.\n");
 
 	return 0;
 }
@@ -1990,7 +1990,7 @@ static void switch_output_size_warn(struct record *rec)
 		char buf[100];
 
 		unit_number__scnprintf(buf, sizeof(buf), wakeup_size);
-		pr_warning("WARNING: switch-output data size lower than "
+		pr_warn("WARNING: switch-output data size lower than "
 			   "wakeup kernel buffer size (%s) "
 			   "expect bigger perf.data sizes\n", buf);
 	}
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index aae0e57c60fb..70dccecd338a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1277,7 +1277,7 @@ int cmd_report(int argc, const char **argv)
 		return ret;
 
 	if (zstd_init(&(session->zstd_data), 0) < 0)
-		pr_warning("Decompression initialization failed. Reported data may be incomplete.\n");
+		pr_warn("Decompression initialization failed. Reported data may be incomplete.\n");
 
 	if (report.queue_size) {
 		ordered_events__set_alloc_size(&session->ordered_events,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 67be8d31afab..8ee70baabf5c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2686,8 +2686,8 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 		}
 
 		if (output[type].user_set)
-			pr_warning("Overriding previous field request for %s events.\n",
-				   event_type(type));
+			pr_warn("Overriding previous field request for %s events.\n",
+				event_type(type));
 
 		/* Don't override defaults for +- */
 		if (strchr(tok, '+') || strchr(tok, '-'))
@@ -2711,7 +2711,7 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 			goto parse;
 
 		if (output_set_by_user())
-			pr_warning("Overriding previous field request for all events.\n");
+			pr_warn("Overriding previous field request for all events.\n");
 
 		for (j = 0; j < OUTPUT_TYPE_MAX; ++j) {
 			output[j].fields = 0;
@@ -2758,8 +2758,8 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 			 */
 			for (j = 0; j < OUTPUT_TYPE_MAX; ++j) {
 				if (output[j].invalid_fields & all_output_options[i].field) {
-					pr_warning("\'%s\' not valid for %s events. Ignoring.\n",
-						   all_output_options[i].str, event_type(j));
+					pr_warn("\'%s\' not valid for %s events. Ignoring.\n",
+						all_output_options[i].str, event_type(j));
 				} else {
 					if (change == REMOVE) {
 						output[j].fields &= ~all_output_options[i].field;
@@ -3300,7 +3300,7 @@ int process_thread_map_event(struct perf_session *session,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 
 	if (script->threads) {
-		pr_warning("Extra thread map event, ignoring.\n");
+		pr_warn("Extra thread map event, ignoring.\n");
 		return 0;
 	}
 
@@ -3319,7 +3319,7 @@ int process_cpu_map_event(struct perf_session *session,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 
 	if (script->cpus) {
-		pr_warning("Extra cpu map event, ignoring.\n");
+		pr_warn("Extra cpu map event, ignoring.\n");
 		return 0;
 	}
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 468fc49420ce..66b3ee5cbd39 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -332,7 +332,7 @@ static void read_counters(struct timespec *rs)
 			pr_debug("failed to read counter %s\n", counter->name);
 
 		if (ret == 0 && perf_stat_process_counter(&stat_config, counter))
-			pr_warning("failed to process counter %s\n", counter->name);
+			pr_warn("failed to process counter %s\n", counter->name);
 	}
 }
 
@@ -1486,7 +1486,7 @@ int process_stat_config_event(struct perf_session *session,
 
 	if (perf_cpu_map__empty(st->cpus)) {
 		if (st->aggr_mode != AGGR_UNSET)
-			pr_warning("warning: processing task data, aggregation mode not set\n");
+			pr_warn("warning: processing task data, aggregation mode not set\n");
 		return 0;
 	}
 
@@ -1526,7 +1526,7 @@ int process_thread_map_event(struct perf_session *session,
 	struct perf_stat *st = container_of(tool, struct perf_stat, tool);
 
 	if (st->threads) {
-		pr_warning("Extra thread map event, ignoring.\n");
+		pr_warn("Extra thread map event, ignoring.\n");
 		return 0;
 	}
 
@@ -1546,7 +1546,7 @@ int process_cpu_map_event(struct perf_session *session,
 	struct perf_cpu_map *cpus;
 
 	if (st->cpus) {
-		pr_warning("Extra cpu map event, ignoring.\n");
+		pr_warn("Extra cpu map event, ignoring.\n");
 		return 0;
 	}
 
@@ -1906,9 +1906,9 @@ int cmd_stat(int argc, const char **argv)
 			parse_options_usage(stat_usage, stat_options, "timeout", 0);
 			goto out;
 		} else
-			pr_warning("timeout < 100ms. "
-				   "The overhead percentage could be high in some cases. "
-				   "Please proceed with caution.\n");
+			pr_warn("timeout < 100ms. "
+				"The overhead percentage could be high in some cases. "
+				"Please proceed with caution.\n");
 	}
 	if (timeout && interval) {
 		pr_err("timeout option is not supported with interval-print.\n");
@@ -1984,8 +1984,8 @@ int cmd_stat(int argc, const char **argv)
 							     process_synthesized_event,
 							     &perf_stat.session->machines.host);
 		if (err) {
-			pr_warning("Couldn't synthesize the kernel mmap record, harmless, "
-				   "older tools may produce warnings about this file\n.");
+			pr_warn("Couldn't synthesize the kernel mmap record, harmless, "
+				"older tools may produce warnings about this file\n.");
 		}
 
 		if (!interval) {
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 9e84fae9b096..b22a5054cb8e 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -735,8 +735,8 @@ static int pid_begin_io_sample(struct timechart *tchart, int pid, int type,
 	prev = c->io_samples;
 
 	if (prev && prev->start_time && !prev->end_time) {
-		pr_warning("Skip invalid start event: "
-			   "previous event already started!\n");
+		pr_warn("Skip invalid start event: "
+			"previous event already started!\n");
 
 		/* remove previous event that has been started,
 		 * we are not sure we will ever get an end for it */
@@ -768,7 +768,7 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 	struct io_sample *sample, *prev;
 
 	if (!c) {
-		pr_warning("Invalid pidcomm!\n");
+		pr_warn("Invalid pidcomm!\n");
 		return -1;
 	}
 
@@ -778,13 +778,13 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 		return 0;
 
 	if (sample->end_time) {
-		pr_warning("Skip invalid end event: "
-			   "previous event already ended!\n");
+		pr_warn("Skip invalid end event: "
+			"previous event already ended!\n");
 		return 0;
 	}
 
 	if (sample->type != type) {
-		pr_warning("Skip invalid end event: invalid event type!\n");
+		pr_warn("Skip invalid end event: invalid event type!\n");
 		return 0;
 	}
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1f60124eb19b..9115ed7a791d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -596,7 +596,7 @@ static void perf_top__sort_new_samples(void *arg)
 	perf_top__resort_hists(t);
 
 	if (t->lost || t->drop)
-		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
+		pr_warn("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
 }
 
 static void stop_top(void)
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bb5130d02155..49d8f44142f9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1390,9 +1390,9 @@ static char *trace__machine__resolve_kernel_addr(void *vmachine, unsigned long l
 		return NULL;
 
 	if (symbol_conf.kptr_restrict) {
-		pr_warning("Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
-			   "Check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
-			   "Kernel samples will not be resolved.\n");
+		pr_warn("Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
+			"Check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
+			"Kernel samples will not be resolved.\n");
 		machine->kptr_restrict_warned = true;
 		return NULL;
 	}
@@ -4049,7 +4049,7 @@ static int trace__config(const char *var, const char *value, void *arg)
 	} else if (!strcmp(var, "trace.show_zeros")) {
 		bool new_show_zeros = perf_config_bool(var, value);
 		if (!trace->show_arg_names && !new_show_zeros) {
-			pr_warning("trace.show_zeros has to be set when trace.show_arg_names=no\n");
+			pr_warn("trace.show_zeros has to be set when trace.show_arg_names=no\n");
 			goto out;
 		}
 		trace->show_zeros = new_show_zeros;
diff --git a/tools/perf/lib/internal.h b/tools/perf/lib/internal.h
index dc92f241732e..11292bfab2f0 100644
--- a/tools/perf/lib/internal.h
+++ b/tools/perf/lib/internal.h
@@ -11,7 +11,7 @@ do {                            \
 	libperf_print(level, "libperf: " fmt, ##__VA_ARGS__);     \
 } while (0)
 
-#define pr_warning(fmt, ...)    __pr(LIBPERF_WARN, fmt, ##__VA_ARGS__)
+#define pr_warn(fmt, ...)	__pr(LIBPERF_WARN, fmt, ##__VA_ARGS__)
 #define pr_info(fmt, ...)       __pr(LIBPERF_INFO, fmt, ##__VA_ARGS__)
 #define pr_debug(fmt, ...)      __pr(LIBPERF_DEBUG, fmt, ##__VA_ARGS__)
 
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index fc733a6354d4..af69bf1c7e2b 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -158,7 +158,7 @@ void run_script(char *cmd)
 	pr_debug("Running %s\n", cmd);
 	SLang_reset_tty();
 	if (system(cmd) < 0)
-		pr_warning("Cannot run %s\n", cmd);
+		pr_warn("Cannot run %s\n", cmd);
 	/*
 	 * SLang doesn't seem to reset the whole terminal, so be more
 	 * forceful to get back to the original state.
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 10c187b8b8ea..900789bab05a 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -258,9 +258,9 @@ parse_prog_config_kvpair(const char *config_str, struct perf_probe_event *pev)
 		*sep = '\0';
 		equ = strchr(line, '=');
 		if (!equ) {
-			pr_warning("WARNING: invalid config in BPF object: %s\n",
-				   line);
-			pr_warning("\tShould be 'key=value'.\n");
+			pr_warn("WARNING: invalid config in BPF object: %s\n",
+				line);
+			pr_warn("\tShould be 'key=value'.\n");
 			goto nextline;
 		}
 		*equ = '\0';
diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index b020a8678eb9..cee4e23325ad 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -388,8 +388,8 @@ int bpf__gen_prologue(struct probe_trace_arg *args, int nargs,
 	}
 
 	if (nargs > BPF_PROLOGUE_MAX_ARGS) {
-		pr_warning("bpf: prologue: %d arguments are dropped\n",
-			   nargs - BPF_PROLOGUE_MAX_ARGS);
+		pr_warn("bpf: prologue: %d arguments are dropped\n",
+			nargs - BPF_PROLOGUE_MAX_ARGS);
 		nargs = BPF_PROLOGUE_MAX_ARGS;
 	}
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 9a9b56ed3f0a..2a4a2a7ee5ae 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -569,7 +569,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 
 	node->val_nr = cursor->nr - cursor->pos;
 	if (!node->val_nr)
-		pr_warning("Warning: empty node in callchain tree\n");
+		pr_warn("Warning: empty node in callchain tree\n");
 
 	cursor_node = callchain_cursor_current(cursor);
 
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 0bc9c4d7fdc5..a0ba50291806 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -345,9 +345,9 @@ static int perf_parse_long(const char *value, long *ret)
 static void bad_config(const char *name)
 {
 	if (config_file_name)
-		pr_warning("bad config value for '%s' in %s, ignoring...\n", name, config_file_name);
+		pr_warn("bad config value for '%s' in %s, ignoring...\n", name, config_file_name);
 	else
-		pr_warning("bad config value for '%s', ignoring...\n", name);
+		pr_warn("bad config value for '%s', ignoring...\n", name);
 }
 
 int perf_config_u64(u64 *dest, const char *name, const char *value)
@@ -676,7 +676,7 @@ static int perf_config_set__init(struct perf_config_set *set)
 
 	user_config = strdup(mkpath("%s/.perfconfig", home));
 	if (user_config == NULL) {
-		pr_warning("Not enough memory to process %s/.perfconfig, ignoring it.", home);
+		pr_warn("Not enough memory to process %s/.perfconfig, ignoring it.", home);
 		goto out;
 	}
 
@@ -689,7 +689,7 @@ static int perf_config_set__init(struct perf_config_set *set)
 	ret = 0;
 
 	if (st.st_uid && (st.st_uid != geteuid())) {
-		pr_warning("File %s not owned by current user or root, ignoring it.", user_config);
+		pr_warn("File %s not owned by current user or root, ignoring it.", user_config);
 		goto out_free;
 	}
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index dbc772bfb04e..b320799d3d7f 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -443,8 +443,8 @@ add_bpf_output_values(struct bt_ctf_event_class *event_class,
 	int ret;
 
 	if (nr_elements * sizeof(u32) != raw_size)
-		pr_warning("Incorrect raw_size (%u) in bpf output event, skip %zu bytes\n",
-			   raw_size, nr_elements * sizeof(u32) - raw_size);
+		pr_warn("Incorrect raw_size (%u) in bpf output event, skip %zu bytes\n",
+			raw_size, nr_elements * sizeof(u32) - raw_size);
 
 	len_type = bt_ctf_event_class_get_field_by_name(event_class, "raw_len");
 	len_field = bt_ctf_field_create(len_type);
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 88fba2ba549f..693d36874cb0 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -381,7 +381,7 @@ int perf_data__switch(struct perf_data *data,
 	 * original file.
 	 */
 	if (rename(data->path, *new_filepath))
-		pr_warning("Failed to rename %s to %s\n", data->path, *new_filepath);
+		pr_warn("Failed to rename %s to %s\n", data->path, *new_filepath);
 
 	if (!at_exit) {
 		close(data->file.fd);
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index e55114f0336f..0b3005ef73e6 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -247,12 +247,12 @@ static int pr_ ## __n ## _wrapper(const char *fmt, ...)	\
 	return ret;					\
 }
 
-DEBUG_WRAPPER(warning, 0);
+DEBUG_WRAPPER(warn, 0);
 DEBUG_WRAPPER(debug, 1);
 
 void perf_debug_setup(void)
 {
-	libapi_set_print(pr_warning_wrapper, pr_warning_wrapper, pr_debug_wrapper);
+	libapi_set_print(pr_warn_wrapper, pr_warn_wrapper, pr_debug_wrapper);
 }
 
 /* Obtain a backtrace and print it to stdout. */
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index d25ae1c4cee9..5d8c45e300e1 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -18,7 +18,7 @@ extern int debug_data_convert;
 
 #define pr_err(fmt, ...) \
 	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_warning(fmt, ...) \
+#define pr_warn(fmt, ...) \
 	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_info(fmt, ...) \
 	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fc1e5a991008..168846aea517 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -135,8 +135,8 @@ void perf_event__read_stat_config(struct perf_stat_config *config,
 		CASE(INTERVAL,  interval)
 #undef CASE
 		default:
-			pr_warning("unknown stat config term %" PRI_lu64 "\n",
-				   event->data[i].tag);
+			pr_warn("unknown stat config term %" PRI_lu64 "\n",
+				event->data[i].tag);
 		}
 	}
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d277a98e62df..1885c61ce59e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1681,7 +1681,7 @@ int perf_evlist__add_sb_event(struct evlist **evlist,
 		return -1;
 
 	if (!attr->sample_id_all) {
-		pr_warning("enabling sample_id_all for all side band events\n");
+		pr_warn("enabling sample_id_all for all side band events\n");
 		attr->sample_id_all = 1;
 	}
 
@@ -1737,7 +1737,7 @@ static void *perf_evlist__poll_thread(void *arg)
 				if (evsel && evsel->side_band.cb)
 					evsel->side_band.cb(event, evsel->side_band.data);
 				else
-					pr_warning("cannot locate proper evsel for the side band event\n");
+					pr_warn("cannot locate proper evsel for the side band event\n");
 
 				perf_mmap__consume(map);
 				got_data = true;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index abc7fda4a0fe..ae6fb4cfb269 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -704,9 +704,9 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
 	if (param->record_mode == CALLCHAIN_LBR) {
 		if (!opts->branch_stack) {
 			if (attr->exclude_user) {
-				pr_warning("LBR callstack option is only available "
-					   "to get user callchain information. "
-					   "Falling back to framepointers.\n");
+				pr_warn("LBR callstack option is only available "
+					"to get user callchain information. "
+					"Falling back to framepointers.\n");
 			} else {
 				perf_evsel__set_sample_bit(evsel, BRANCH_STACK);
 				attr->branch_sample_type = PERF_SAMPLE_BRANCH_USER |
@@ -715,8 +715,8 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
 							PERF_SAMPLE_BRANCH_NO_FLAGS;
 			}
 		} else
-			 pr_warning("Cannot use LBR callstack with branch stack. "
-				    "Falling back to framepointers.\n");
+			 pr_warn("Cannot use LBR callstack with branch stack. "
+				 "Falling back to framepointers.\n");
 	}
 
 	if (param->record_mode == CALLCHAIN_DWARF) {
@@ -725,9 +725,9 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
 			perf_evsel__set_sample_bit(evsel, STACK_USER);
 			if (opts->sample_user_regs && DWARF_MINIMAL_REGS != PERF_REGS_MASK) {
 				attr->sample_regs_user |= DWARF_MINIMAL_REGS;
-				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
-					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
-					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
+				pr_warn("WARNING: The use of --call-graph=dwarf may require all the user registers, "
+					"specifying a subset with --user-regs may render DWARF unwinding unreliable, "
+					"so the minimal registers set (IP, SP) is explicitly forced.\n");
 			} else {
 				attr->sample_regs_user |= PERF_REGS_MASK;
 			}
@@ -1511,8 +1511,7 @@ static bool ignore_missing_thread(struct evsel *evsel,
 	if (thread_map__remove(threads, thread))
 		return false;
 
-	pr_warning("WARNING: Ignored open failure for pid %d\n",
-		   ignore_pid);
+	pr_warn("WARNING: Ignored open failure for pid %d\n", ignore_pid);
 	return true;
 }
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 86d9396cb131..59b369313832 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1228,7 +1228,7 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 
 	dir = opendir(path);
 	if (!dir) {
-		pr_warning("failed: cant' open memory sysfs data\n");
+		pr_warn("failed: cant' open memory sysfs data\n");
 		return -1;
 	}
 
@@ -2683,7 +2683,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 	int err = -1;
 
 	if (ff->ph->needs_swap) {
-		pr_warning("interpreting bpf_prog_info from systems with endianity is not yet supported\n");
+		pr_warn("interpreting bpf_prog_info from systems with endianity is not yet supported\n");
 		return 0;
 	}
 
@@ -2703,7 +2703,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 			goto out;
 
 		if (info_len > sizeof(struct bpf_prog_info)) {
-			pr_warning("detected invalid bpf_prog_info\n");
+			pr_warn("detected invalid bpf_prog_info\n");
 			goto out;
 		}
 
@@ -2757,7 +2757,7 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 	int err = -1;
 
 	if (ff->ph->needs_swap) {
-		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
+		pr_warn("interpreting btf from systems with endianity is not yet supported\n");
 		return 0;
 	}
 
@@ -2893,7 +2893,7 @@ static int perf_file_section__fprintf_info(struct perf_file_section *section,
 		return 0;
 	}
 	if (feat >= HEADER_LAST_FEATURE) {
-		pr_warning("unknown feature %d\n", feat);
+		pr_warn("unknown feature %d\n", feat);
 		return 0;
 	}
 	if (!feat_ops[feat].print)
@@ -3563,9 +3563,9 @@ int perf_session__read_header(struct perf_session *session)
 	 * information.  Just warn user and process it as much as it can.
 	 */
 	if (f_header.data.size == 0) {
-		pr_warning("WARNING: The %s file's data size field is 0 which is unexpected.\n"
-			   "Was the 'perf record' command properly terminated?\n",
-			   data->file.path);
+		pr_warn("WARNING: The %s file's data size field is 0 which is unexpected.\n"
+			"Was the 'perf record' command properly terminated?\n",
+			data->file.path);
 	}
 
 	if (f_header.attr_size == 0) {
@@ -3652,11 +3652,11 @@ int perf_event__process_feature(struct perf_session *session,
 	u64 feat = fe->feat_id;
 
 	if (type < 0 || type >= PERF_RECORD_HEADER_MAX) {
-		pr_warning("invalid record type %d in pipe-mode\n", type);
+		pr_warn("invalid record type %d in pipe-mode\n", type);
 		return 0;
 	}
 	if (feat == HEADER_RESERVED || feat >= HEADER_LAST_FEATURE) {
-		pr_warning("invalid record type %d in pipe-mode\n", type);
+		pr_warn("invalid record type %d in pipe-mode\n", type);
 		return -1;
 	}
 
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index e3ccb0ce1938..a119010cc3b5 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -89,7 +89,7 @@ jit_emit_elf(char *filename,
 
 	fd = open(filename, O_CREAT|O_TRUNC|O_WRONLY, 0644);
 	if (fd == -1) {
-		pr_warning("cannot create jit ELF %s: %s\n", filename, strerror(errno));
+		pr_warn("cannot create jit ELF %s: %s\n", filename, strerror(errno));
 		return -1;
 	}
 
@@ -282,7 +282,7 @@ jit_get_next_entry(struct jit_buf_desc *jd)
 		return NULL;
 
 	if (id >= JIT_CODE_MAX) {
-		pr_warning("next_entry: unknown record type %d, skipping\n", id);
+		pr_warn("next_entry: unknown record type %d, skipping\n", id);
 	}
 	if (bs > jd->bufsize) {
 		void *n;
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 8b14e4a7f1dc..494a1343f3b5 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -333,7 +333,7 @@ void llvm__get_kbuild_opts(char **kbuild_dir, char **kbuild_include_opts)
 
 	err = detect_kbuild_dir(kbuild_dir);
 	if (err) {
-		pr_warning(
+		pr_warn(
 "WARNING:\tunable to get correct kernel building directory.\n"
 "Hint:\tSet correct kbuild directory using 'kbuild-dir' option in [llvm]\n"
 "     \tsection of ~/.perfconfig or set it to \"\" to suppress kbuild\n"
@@ -348,7 +348,7 @@ void llvm__get_kbuild_opts(char **kbuild_dir, char **kbuild_include_opts)
 			     (void **)kbuild_include_opts,
 			     NULL);
 	if (err) {
-		pr_warning(
+		pr_warn(
 "WARNING:\tunable to get kernel include directories from '%s'\n"
 "Hint:\tTry set clang include options using 'clang-bpf-cmd-template'\n"
 "     \toption in [llvm] section of ~/.perfconfig and set 'kbuild-dir'\n"
@@ -399,29 +399,29 @@ void llvm__dump_obj(const char *path, void *obj_buf, size_t size)
 	char *p;
 
 	if (!obj_path) {
-		pr_warning("WARNING: Not enough memory, skip object dumping\n");
+		pr_warn("WARNING: Not enough memory, skip object dumping\n");
 		return;
 	}
 
 	p = strrchr(obj_path, '.');
 	if (!p || (strcmp(p, ".c") != 0)) {
-		pr_warning("WARNING: invalid llvm source path: '%s', skip object dumping\n",
-			   obj_path);
+		pr_warn("WARNING: invalid llvm source path: '%s', skip object dumping\n",
+			obj_path);
 		goto out;
 	}
 
 	p[1] = 'o';
 	fp = fopen(obj_path, "wb");
 	if (!fp) {
-		pr_warning("WARNING: failed to open '%s': %s, skip object dumping\n",
-			   obj_path, strerror(errno));
+		pr_warn("WARNING: failed to open '%s': %s, skip object dumping\n",
+			obj_path, strerror(errno));
 		goto out;
 	}
 
 	pr_info("LLVM: dumping %s\n", obj_path);
 	if (fwrite(obj_buf, size, 1, fp) != 1)
-		pr_warning("WARNING: failed to write to file '%s': %s, skip object dumping\n",
-			   obj_path, strerror(errno));
+		pr_warn("WARNING: failed to write to file '%s': %s, skip object dumping\n",
+			obj_path, strerror(errno));
 	fclose(fp);
 out:
 	free(obj_path);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 70a9f8716a4b..e70ad3e1843e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2347,7 +2347,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 		struct iterations iter[nr];
 
 		if (branch->nr > PERF_MAX_BRANCH_DEPTH) {
-			pr_warning("corrupted branch chain. skipping...\n");
+			pr_warn("corrupted branch chain. skipping...\n");
 			goto check_calls;
 		}
 
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index bb4aa88c50a8..ffa59286a6ed 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -68,8 +68,7 @@ int parse_branch_str(const char *str, __u64 *mode)
 		}
 		if (!br->name) {
 			ret = -1;
-			pr_warning("unknown branch filter %s,"
-				    " check man page\n", s);
+			pr_warn("unknown branch filter %s, check man page\n", s);
 			goto error;
 		}
 
diff --git a/tools/perf/util/perf-hooks.c b/tools/perf/util/perf-hooks.c
index 7a0ab3507bd5..ba480d0e0eaa 100644
--- a/tools/perf/util/perf-hooks.c
+++ b/tools/perf/util/perf-hooks.c
@@ -24,8 +24,8 @@ void perf_hooks__invoke(const struct perf_hook_desc *desc)
 		return;
 
 	if (sigsetjmp(jmpbuf, 1)) {
-		pr_warning("Fatal error (SEGFAULT) in perf hook '%s'\n",
-			   desc->hook_name);
+		pr_warn("Fatal error (SEGFAULT) in perf hook '%s'\n",
+			desc->hook_name);
 		*(current_perf_hook->p_hook_func) = NULL;
 	} else {
 		current_perf_hook = desc;
@@ -68,7 +68,7 @@ int perf_hooks__set_hook(const char *hook_name,
 			continue;
 
 		if (*(perf_hooks[i]->p_hook_func))
-			pr_warning("Overwrite existing hook: %s\n", hook_name);
+			pr_warn("Overwrite existing hook: %s\n", hook_name);
 		*(perf_hooks[i]->p_hook_func) = hook_func;
 		perf_hooks[i]->hook_ctx = hook_ctx;
 		return 0;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 91cab5f669d2..cf96953078de 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -91,7 +91,7 @@ int init_probe_symbol_maps(bool user_only)
 	}
 out:
 	if (ret < 0)
-		pr_warning("Failed to init vmlinux path.\n");
+		pr_warn("Failed to init vmlinux path.\n");
 	return ret;
 }
 
@@ -240,9 +240,9 @@ static bool kprobe_warn_out_range(const char *symbol, unsigned long address)
 						false, false);
 
 	if (ret == 0 && etext_addr < address)
-		pr_warning("%s is out of .text, skip it.\n", symbol);
+		pr_warn("%s is out of .text, skip it.\n", symbol);
 	else if (kprobe_blacklist__listed(address))
-		pr_warning("%s is blacklisted function, skip it.\n", symbol);
+		pr_warn("%s is blacklisted function, skip it.\n", symbol);
 	else
 		return false;
 
@@ -475,12 +475,12 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 	nsinfo__mountns_enter(nsi, &nsc);
 	ret = debuginfo__new(path);
 	if (!ret && !silent) {
-		pr_warning("The %s file has no debug information.\n", path);
+		pr_warn("The %s file has no debug information.\n", path);
 		if (!module || !strtailcmp(path, ".ko"))
-			pr_warning("Rebuild with CONFIG_DEBUG_INFO=y, ");
+			pr_warn("Rebuild with CONFIG_DEBUG_INFO=y, ");
 		else
-			pr_warning("Rebuild with -g, ");
-		pr_warning("or install an appropriate debuginfo package.\n");
+			pr_warn("Rebuild with -g, ");
+		pr_warn("or install an appropriate debuginfo package.\n");
 	}
 	nsinfo__mountns_exit(&nsc);
 	return ret;
@@ -658,7 +658,7 @@ post_process_offline_probe_trace_events(struct probe_trace_event *tevs,
 	/* Prepare a map for offline binary */
 	map = dso__new_map(pathname);
 	if (!map || get_text_start_address(pathname, &stext, NULL) < 0) {
-		pr_warning("Failed to get ELF symbols for %s\n", pathname);
+		pr_warn("Failed to get ELF symbols for %s\n", pathname);
 		return -EINVAL;
 	}
 
@@ -716,7 +716,7 @@ post_process_module_probe_trace_events(struct probe_trace_event *tevs,
 
 	map = get_target_map(module, NULL, false);
 	if (!map || debuginfo__get_text_offset(dinfo, &text_offs, true) < 0) {
-		pr_warning("Failed to get ELF symbols for %s\n", module);
+		pr_warn("Failed to get ELF symbols for %s\n", module);
 		return -EINVAL;
 	}
 
@@ -755,7 +755,7 @@ post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
 
 	reloc_sym = kernel_get_ref_reloc_sym();
 	if (!reloc_sym) {
-		pr_warning("Relocated base symbol is not found!\n");
+		pr_warn("Relocated base symbol is not found!\n");
 		return -EINVAL;
 	}
 
@@ -865,14 +865,14 @@ static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
 	debuginfo__delete(dinfo);
 
 	if (ntevs == 0)	{	/* No error but failed to find probe point. */
-		pr_warning("Probe point '%s' not found.\n",
-			   synthesize_perf_probe_point(&pev->point));
+		pr_warn("Probe point '%s' not found.\n",
+			synthesize_perf_probe_point(&pev->point));
 		return -ENOENT;
 	} else if (ntevs < 0) {
 		/* Error path : ntevs < 0 */
 		pr_debug("An error occurred in debuginfo analysis (%d).\n", ntevs);
 		if (ntevs == -EBADF)
-			pr_warning("Warning: No dwarf info found in the vmlinux - "
+			pr_warn("Warning: No dwarf info found in the vmlinux - "
 				"please rebuild kernel with CONFIG_DEBUG_INFO=y.\n");
 		if (!need_dwarf) {
 			pr_debug("Trying to use symbols.\n");
@@ -907,8 +907,8 @@ static int __show_one_line(FILE *fp, int l, bool skip, bool show_num)
 	return 1;
 error:
 	if (ferror(fp)) {
-		pr_warning("File read error: %s\n",
-			   str_error_r(errno, sbuf, sizeof(sbuf)));
+		pr_warn("File read error: %s\n",
+			str_error_r(errno, sbuf, sizeof(sbuf)));
 		return -1;
 	}
 	return 0;
@@ -918,7 +918,7 @@ static int _show_one_line(FILE *fp, int l, bool skip, bool show_num)
 {
 	int rv = __show_one_line(fp, l, skip, show_num);
 	if (rv == 0) {
-		pr_warning("Source file is shorter than expected.\n");
+		pr_warn("Source file is shorter than expected.\n");
 		rv = -1;
 	}
 	return rv;
@@ -957,10 +957,10 @@ static int __show_line_range(struct line_range *lr, const char *module,
 	}
 	debuginfo__delete(dinfo);
 	if (ret == 0 || ret == -ENOENT) {
-		pr_warning("Specified source line is not found.\n");
+		pr_warn("Specified source line is not found.\n");
 		return -ENOENT;
 	} else if (ret < 0) {
-		pr_warning("Debuginfo analysis failed.\n");
+		pr_warn("Debuginfo analysis failed.\n");
 		return ret;
 	}
 
@@ -973,7 +973,7 @@ static int __show_line_range(struct line_range *lr, const char *module,
 		free(tmp);
 
 	if (ret < 0) {
-		pr_warning("Failed to find source file path.\n");
+		pr_warn("Failed to find source file path.\n");
 		return ret;
 	}
 
@@ -987,8 +987,8 @@ static int __show_line_range(struct line_range *lr, const char *module,
 
 	fp = fopen(lr->path, "r");
 	if (fp == NULL) {
-		pr_warning("Failed to open %s: %s\n", lr->path,
-			   str_error_r(errno, sbuf, sizeof(sbuf)));
+		pr_warn("Failed to open %s: %s\n", lr->path,
+			str_error_r(errno, sbuf, sizeof(sbuf)));
 		return -errno;
 	}
 	/* Skip to starting line number */
@@ -1069,7 +1069,7 @@ static int show_available_vars_at(struct debuginfo *dinfo,
 			pr_err("Failed to find the address of %s\n", buf);
 			ret = -ENOENT;
 		} else
-			pr_warning("Debuginfo analysis failed.\n");
+			pr_warn("Debuginfo analysis failed.\n");
 		goto end;
 	}
 
@@ -1150,7 +1150,7 @@ static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
 				struct probe_trace_event **tevs __maybe_unused)
 {
 	if (perf_probe_event_need_dwarf(pev)) {
-		pr_warning("Debuginfo-analysis is not supported.\n");
+		pr_warn("Debuginfo-analysis is not supported.\n");
 		return -ENOSYS;
 	}
 
@@ -1162,7 +1162,7 @@ int show_line_range(struct line_range *lr __maybe_unused,
 		    struct nsinfo *nsi __maybe_unused,
 		    bool user __maybe_unused)
 {
-	pr_warning("Debuginfo-analysis is not supported.\n");
+	pr_warn("Debuginfo-analysis is not supported.\n");
 	return -ENOSYS;
 }
 
@@ -1170,7 +1170,7 @@ int show_available_vars(struct perf_probe_event *pevs __maybe_unused,
 			int npevs __maybe_unused,
 			struct strfilter *filter __maybe_unused)
 {
-	pr_warning("Debuginfo-analysis is not supported.\n");
+	pr_warn("Debuginfo-analysis is not supported.\n");
 	return -ENOSYS;
 }
 #endif
@@ -2621,11 +2621,11 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 		goto out;
 
 	if (!allow_suffix) {
-		pr_warning("Error: event \"%s\" already exists.\n"
-			   " Hint: Remove existing event by 'perf probe -d'\n"
-			   "       or force duplicates by 'perf probe -f'\n"
-			   "       or set 'force=yes' in BPF source.\n",
-			   buf);
+		pr_warn("Error: event \"%s\" already exists.\n"
+			" Hint: Remove existing event by 'perf probe -d'\n"
+			"       or force duplicates by 'perf probe -f'\n"
+			"       or set 'force=yes' in BPF source.\n",
+			buf);
 		ret = -EEXIST;
 		goto out;
 	}
@@ -2641,7 +2641,7 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 			break;
 	}
 	if (i == MAX_EVENT_INDEX) {
-		pr_warning("Too many events are on the same function.\n");
+		pr_warn("Too many events are on the same function.\n");
 		ret = -ERANGE;
 	}
 
@@ -2650,8 +2650,8 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 
 	/* Final validation */
 	if (ret >= 0 && !is_c_func_name(buf)) {
-		pr_warning("Internal error: \"%s\" is an invalid event name.\n",
-			   buf);
+		pr_warn("Internal error: \"%s\" is an invalid event name.\n",
+			buf);
 		ret = -EINVAL;
 	}
 
@@ -2666,9 +2666,9 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
 	struct probe_trace_point *tp = &tev->point;
 
 	if (tp->ref_ctr_offset && !uprobe_ref_ctr_is_supported()) {
-		pr_warning("A semaphore is associated with %s:%s and "
-			   "seems your kernel doesn't support it.\n",
-			   tev->group, tev->event);
+		pr_warn("A semaphore is associated with %s:%s and "
+			"seems your kernel doesn't support it.\n",
+			tev->group, tev->event);
 	}
 
 	/* Old uprobe event doesn't support memory dereference */
@@ -2677,9 +2677,9 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
 
 	for (i = 0; i < tev->nargs; i++)
 		if (strglobmatch(tev->args[i].value, "[$@+-]*")) {
-			pr_warning("Please upgrade your kernel to at least "
-				   "3.14 to have access to feature %s\n",
-				   tev->args[i].value);
+			pr_warn("Please upgrade your kernel to at least "
+				"3.14 to have access to feature %s\n",
+				tev->args[i].value);
 			break;
 		}
 out:
@@ -2810,7 +2810,7 @@ static int __add_probe_trace_events(struct perf_probe_event *pev,
 		if (!cache ||
 		    probe_cache__add_entry(cache, pev, tevs, ntevs) < 0 ||
 		    probe_cache__commit(cache) < 0)
-			pr_warning("Failed to add event to probe cache\n");
+			pr_warn("Failed to add event to probe cache\n");
 		probe_cache__delete(cache);
 	}
 
@@ -2925,7 +2925,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 			(!pp->retprobe || kretprobe_offset_is_supported())) {
 		reloc_sym = kernel_get_ref_reloc_sym();
 		if (!reloc_sym) {
-			pr_warning("Relocated base symbol is not found!\n");
+			pr_warn("Relocated base symbol is not found!\n");
 			ret = -EINVAL;
 			goto out;
 		}
@@ -2946,14 +2946,14 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 		tev = (*tevs) + ret;
 		tp = &tev->point;
 		if (ret == num_matched_functions) {
-			pr_warning("Too many symbols are listed. Skip it.\n");
+			pr_warn("Too many symbols are listed. Skip it.\n");
 			break;
 		}
 		ret++;
 
 		if (pp->offset > sym->end - sym->start) {
-			pr_warning("Offset %ld is bigger than the size of %s\n",
-				   pp->offset, sym->name);
+			pr_warn("Offset %ld is bigger than the size of %s\n",
+				pp->offset, sym->name);
 			ret = -ENOENT;
 			goto err_out;
 		}
@@ -3324,7 +3324,7 @@ static int convert_to_probe_trace_events(struct perf_probe_event *pev,
 		} else
 			ret = convert_exec_to_group(pev->target, &pev->group);
 		if (ret != 0) {
-			pr_warning("Failed to make a group name.\n");
+			pr_warn("Failed to make a group name.\n");
 			return ret;
 		}
 	}
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index b659466ea498..3ebc4f67cbe0 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -43,31 +43,31 @@ static void print_open_warning(int err, bool uprobe)
 		else
 			config = "CONFIG_KPROBE_EVENTS";
 
-		pr_warning("%cprobe_events file does not exist"
-			   " - please rebuild kernel with %s.\n",
-			   uprobe ? 'u' : 'k', config);
+		pr_warn("%cprobe_events file does not exist"
+			" - please rebuild kernel with %s.\n",
+			uprobe ? 'u' : 'k', config);
 	} else if (err == -ENOTSUP)
-		pr_warning("Tracefs or debugfs is not mounted.\n");
+		pr_warn("Tracefs or debugfs is not mounted.\n");
 	else
-		pr_warning("Failed to open %cprobe_events: %s\n",
-			   uprobe ? 'u' : 'k',
-			   str_error_r(-err, sbuf, sizeof(sbuf)));
+		pr_warn("Failed to open %cprobe_events: %s\n",
+			uprobe ? 'u' : 'k',
+			str_error_r(-err, sbuf, sizeof(sbuf)));
 }
 
 static void print_both_open_warning(int kerr, int uerr)
 {
 	/* Both kprobes and uprobes are disabled, warn it. */
 	if (kerr == -ENOTSUP && uerr == -ENOTSUP)
-		pr_warning("Tracefs or debugfs is not mounted.\n");
+		pr_warn("Tracefs or debugfs is not mounted.\n");
 	else if (kerr == -ENOENT && uerr == -ENOENT)
-		pr_warning("Please rebuild kernel with CONFIG_KPROBE_EVENTS "
-			   "or/and CONFIG_UPROBE_EVENTS.\n");
+		pr_warn("Please rebuild kernel with CONFIG_KPROBE_EVENTS "
+			"or/and CONFIG_UPROBE_EVENTS.\n");
 	else {
 		char sbuf[STRERR_BUFSIZE];
-		pr_warning("Failed to open kprobe events: %s.\n",
-			   str_error_r(-kerr, sbuf, sizeof(sbuf)));
-		pr_warning("Failed to open uprobe events: %s.\n",
-			   str_error_r(-uerr, sbuf, sizeof(sbuf)));
+		pr_warn("Failed to open kprobe events: %s.\n",
+			str_error_r(-kerr, sbuf, sizeof(sbuf)));
+		pr_warn("Failed to open uprobe events: %s.\n",
+			str_error_r(-uerr, sbuf, sizeof(sbuf)));
 	}
 }
 
@@ -239,8 +239,8 @@ int probe_file__add_event(int fd, struct probe_trace_event *tev)
 	if (!probe_event_dry_run) {
 		if (write(fd, buf, strlen(buf)) < (int)strlen(buf)) {
 			ret = -errno;
-			pr_warning("Failed to write event: %s\n",
-				   str_error_r(errno, sbuf, sizeof(sbuf)));
+			pr_warn("Failed to write event: %s\n",
+				str_error_r(errno, sbuf, sizeof(sbuf)));
 		}
 	}
 	free(buf);
@@ -277,8 +277,8 @@ static int __del_trace_probe_event(int fd, struct str_node *ent)
 
 	return 0;
 error:
-	pr_warning("Failed to delete event: %s\n",
-		   str_error_r(-ret, buf, sizeof(buf)));
+	pr_warn("Failed to delete event: %s\n",
+		str_error_r(-ret, buf, sizeof(buf)));
 	return ret;
 }
 
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index cd9f95e5044e..eedd5fd006de 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -260,8 +260,8 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	regs = get_dwarf_regstr(regn, machine);
 	if (!regs) {
 		/* This should be a bug in DWARF or this tool */
-		pr_warning("Mapping for the register number %u "
-			   "missing on this architecture.\n", regn);
+		pr_warn("Mapping for the register number %u "
+			"missing on this architecture.\n", regn);
 		return -ENOTSUP;
 	}
 
@@ -313,8 +313,8 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	}
 
 	if (die_get_real_type(vr_die, &type) == NULL) {
-		pr_warning("Failed to get a type information of %s.\n",
-			   dwarf_diename(vr_die));
+		pr_warn("Failed to get a type information of %s.\n",
+			dwarf_diename(vr_die));
 		return -ENOENT;
 	}
 
@@ -326,14 +326,13 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 		ret = dwarf_tag(&type);
 		if (ret != DW_TAG_pointer_type &&
 		    ret != DW_TAG_array_type) {
-			pr_warning("Failed to cast into string: "
-				   "%s(%s) is not a pointer nor array.\n",
-				   dwarf_diename(vr_die), dwarf_diename(&type));
+			pr_warn("Failed to cast into string: "
+				"%s(%s) is not a pointer nor array.\n",
+				dwarf_diename(vr_die), dwarf_diename(&type));
 			return -EINVAL;
 		}
 		if (die_get_real_type(&type, &type) == NULL) {
-			pr_warning("Failed to get a type"
-				   " information.\n");
+			pr_warn("Failed to get a type information.\n");
 			return -ENOENT;
 		}
 		if (ret == DW_TAG_pointer_type) {
@@ -342,16 +341,16 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 			/* Add new reference with offset +0 */
 			*ref_ptr = zalloc(sizeof(struct probe_trace_arg_ref));
 			if (*ref_ptr == NULL) {
-				pr_warning("Out of memory error\n");
+				pr_warn("Out of memory error\n");
 				return -ENOMEM;
 			}
 			(*ref_ptr)->user_access = user_access;
 		}
 		if (!die_compare_name(&type, "char") &&
 		    !die_compare_name(&type, "unsigned char")) {
-			pr_warning("Failed to cast into string: "
-				   "%s is not (unsigned) char *.\n",
-				   dwarf_diename(vr_die));
+			pr_warn("Failed to cast into string: "
+				"%s is not (unsigned) char *.\n",
+				dwarf_diename(vr_die));
 			return -EINVAL;
 		}
 		tvar->type = strdup(cast);
@@ -387,8 +386,8 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	if (ret < 0 || ret >= 16) {
 		if (ret >= 16)
 			ret = -E2BIG;
-		pr_warning("Failed to convert variable type: %s\n",
-			   str_error_r(-ret, sbuf, sizeof(sbuf)));
+		pr_warn("Failed to convert variable type: %s\n",
+			str_error_r(-ret, sbuf, sizeof(sbuf)));
 		return ret;
 	}
 	tvar->type = strdup(buf);
@@ -409,7 +408,7 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 
 	pr_debug("converting %s in %s\n", field->name, varname);
 	if (die_get_real_type(vr_die, &type) == NULL) {
-		pr_warning("Failed to get the type of %s.\n", varname);
+		pr_warn("Failed to get the type of %s.\n", varname);
 		return -ENOENT;
 	}
 	pr_debug2("Var real type: %s (%x)\n", dwarf_diename(&type),
@@ -422,7 +421,7 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 		memcpy(die_mem, &type, sizeof(*die_mem));
 		/* Get the type of this array */
 		if (die_get_real_type(&type, &type) == NULL) {
-			pr_warning("Failed to get the type of %s.\n", varname);
+			pr_warn("Failed to get the type of %s.\n", varname);
 			return -ENOENT;
 		}
 		pr_debug2("Array real type: %s (%x)\n", dwarf_diename(&type),
@@ -448,14 +447,14 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 		}
 		/* Get the type pointed by this pointer */
 		if (die_get_real_type(&type, &type) == NULL) {
-			pr_warning("Failed to get the type of %s.\n", varname);
+			pr_warn("Failed to get the type of %s.\n", varname);
 			return -ENOENT;
 		}
 		/* Verify it is a data structure  */
 		tag = dwarf_tag(&type);
 		if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
-			pr_warning("%s is not a data structure nor a union.\n",
-				   varname);
+			pr_warn("%s is not a data structure nor a union.\n",
+				varname);
 			return -EINVAL;
 		}
 
@@ -469,8 +468,8 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 	} else {
 		/* Verify it is a data structure  */
 		if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
-			pr_warning("%s is not a data structure nor a union.\n",
-				   varname);
+			pr_warn("%s is not a data structure nor a union.\n",
+				varname);
 			return -EINVAL;
 		}
 		if (field->name[0] == '[') {
@@ -485,15 +484,14 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 			return -EINVAL;
 		}
 		if (!ref) {
-			pr_warning("Structure on a register is not "
-				   "supported yet.\n");
+			pr_warn("Structure on a register is not supported yet.\n");
 			return -ENOTSUP;
 		}
 	}
 
 	if (die_find_member(&type, field->name, die_mem) == NULL) {
-		pr_warning("%s(type:%s) has no member %s.\n", varname,
-			   dwarf_diename(&type), field->name);
+		pr_warn("%s(type:%s) has no member %s.\n", varname,
+			dwarf_diename(&type), field->name);
 		return -EINVAL;
 	}
 
@@ -503,8 +501,8 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 	} else {
 		ret = die_get_data_member_location(die_mem, &offs);
 		if (ret < 0) {
-			pr_warning("Failed to get the offset of %s.\n",
-				   field->name);
+			pr_warn("Failed to get the offset of %s.\n",
+				field->name);
 			return ret;
 		}
 	}
@@ -587,8 +585,8 @@ static int find_variable(Dwarf_Die *sc_die, struct probe_finder *pf)
 		/* Search again in global variables */
 		if (!die_find_variable_at(&pf->cu_die, pf->pvar->var,
 						0, &vr_die)) {
-			pr_warning("Failed to find '%s' in this function.\n",
-				   pf->pvar->var);
+			pr_warn("Failed to find '%s' in this function.\n",
+				pf->pvar->var);
 			ret = -ENOENT;
 		}
 	}
@@ -610,18 +608,18 @@ static int convert_to_trace_point(Dwarf_Die *sp_die, Dwfl_Module *mod,
 
 	/* Verify the address is correct */
 	if (dwarf_entrypc(sp_die, &eaddr) != 0) {
-		pr_warning("Failed to get entry address of %s\n",
-			   dwarf_diename(sp_die));
+		pr_warn("Failed to get entry address of %s\n",
+			dwarf_diename(sp_die));
 		return -ENOENT;
 	}
 	if (dwarf_highpc(sp_die, &highaddr) != 0) {
-		pr_warning("Failed to get end address of %s\n",
-			   dwarf_diename(sp_die));
+		pr_warn("Failed to get end address of %s\n",
+			dwarf_diename(sp_die));
 		return -ENOENT;
 	}
 	if (paddr > highaddr) {
-		pr_warning("Offset specified is greater than size of %s\n",
-			   dwarf_diename(sp_die));
+		pr_warn("Offset specified is greater than size of %s\n",
+			dwarf_diename(sp_die));
 		return -EINVAL;
 	}
 
@@ -630,8 +628,8 @@ static int convert_to_trace_point(Dwarf_Die *sp_die, Dwfl_Module *mod,
 		/* Try to get the symbol name from symtab */
 		symbol = dwfl_module_addrsym(mod, paddr, &sym, NULL);
 		if (!symbol) {
-			pr_warning("Failed to find symbol at 0x%lx\n",
-				   (unsigned long)paddr);
+			pr_warn("Failed to find symbol at 0x%lx\n",
+				(unsigned long)paddr);
 			return -ENOENT;
 		}
 		eaddr = sym.st_value;
@@ -645,10 +643,9 @@ static int convert_to_trace_point(Dwarf_Die *sp_die, Dwfl_Module *mod,
 	/* Return probe must be on the head of a subprogram */
 	if (retprobe) {
 		if (eaddr != paddr) {
-			pr_warning("Failed to find \"%s%%return\",\n"
-				   " because %s is an inlined function and"
-				   " has no return point.\n", function,
-				   function);
+			pr_warn("Failed to find \"%s%%return\",\n"
+				" because %s is an inlined function and"
+				" has no return point.\n", function, function);
 			return -EINVAL;
 		}
 		tp->retprobe = true;
@@ -674,12 +671,11 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 	if (!die_is_func_def(sc_die)) {
 		if (!die_find_realfunc(&pf->cu_die, pf->addr, &pf->sp_die)) {
 			if (die_find_tailfunc(&pf->cu_die, pf->addr, &pf->sp_die)) {
-				pr_warning("Ignoring tail call from %s\n",
-						dwarf_diename(&pf->sp_die));
+				pr_warn("Ignoring tail call from %s\n",
+					dwarf_diename(&pf->sp_die));
 				return 0;
 			} else {
-				pr_warning("Failed to find probe point in any "
-					   "functions.\n");
+				pr_warn("Failed to find probe point in any functions.\n");
 				return -ENOENT;
 			}
 		}
@@ -697,8 +693,8 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 		if ((dwarf_cfi_addrframe(pf->cfi_eh, pf->addr, &frame) != 0 &&
 		     (dwarf_cfi_addrframe(pf->cfi_dbg, pf->addr, &frame) != 0)) ||
 		    dwarf_frame_cfa(frame, &pf->fb_ops, &nops) != 0) {
-			pr_warning("Failed to get call frame on 0x%jx\n",
-				   (uintmax_t)pf->addr);
+			pr_warn("Failed to get call frame on 0x%jx\n",
+				(uintmax_t)pf->addr);
 			free(frame);
 			return -ENOENT;
 		}
@@ -786,7 +782,7 @@ static int probe_point_line_walker(const char *fname, int lineno,
 	pf->addr = addr;
 	sc_die = find_best_scope(pf, &die_mem);
 	if (!sc_die) {
-		pr_warning("Failed to find scope of probe point.\n");
+		pr_warn("Failed to find scope of probe point.\n");
 		return -ENOENT;
 	}
 
@@ -815,8 +811,8 @@ static int find_lazy_match_lines(struct intlist *list,
 
 	fp = fopen(fname, "r");
 	if (!fp) {
-		pr_warning("Failed to open %s: %s\n", fname,
-			   str_error_r(errno, sbuf, sizeof(sbuf)));
+		pr_warn("Failed to open %s: %s\n", fname,
+			str_error_r(errno, sbuf, sizeof(sbuf)));
 		return -errno;
 	}
 
@@ -859,7 +855,7 @@ static int probe_point_lazy_walker(const char *fname, int lineno,
 	pf->lno = lineno;
 	sc_die = find_best_scope(pf, &die_mem);
 	if (!sc_die) {
-		pr_warning("Failed to find scope of probe point.\n");
+		pr_warn("Failed to find scope of probe point.\n");
 		return -ENOENT;
 	}
 
@@ -884,7 +880,7 @@ static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 		comp_dir = cu_get_comp_dir(&pf->cu_die);
 		ret = get_real_path(pf->fname, comp_dir, &fpath);
 		if (ret < 0) {
-			pr_warning("Failed to find source file path.\n");
+			pr_warn("Failed to find source file path.\n");
 			return ret;
 		}
 
@@ -943,8 +939,8 @@ static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
 	else {
 		/* Get probe address */
 		if (dwarf_entrypc(in_die, &addr) != 0) {
-			pr_warning("Failed to get entry address of %s.\n",
-				   dwarf_diename(in_die));
+			pr_warn("Failed to get entry address of %s.\n",
+				dwarf_diename(in_die));
 			return -ENOENT;
 		}
 		if (addr == 0) {
@@ -1276,8 +1272,7 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 
 	/* Check number of tevs */
 	if (tf->ntevs == tf->max_tevs) {
-		pr_warning("Too many( > %d) probe point found.\n",
-			   tf->max_tevs);
+		pr_warn("Too many( > %d) probe point found.\n", tf->max_tevs);
 		return -ERANGE;
 	}
 	tev = &tf->tevs[tf->ntevs++];
@@ -1437,7 +1432,7 @@ static int add_available_vars(Dwarf_Die *sc_die, struct probe_finder *pf)
 
 	/* Check number of tevs */
 	if (af->nvls == af->max_vls) {
-		pr_warning("Too many( > %d) probe point found.\n", af->max_vls);
+		pr_warn("Too many( > %d) probe point found.\n", af->max_vls);
 		return -ERANGE;
 	}
 	vl = &af->vls[af->nvls++];
@@ -1563,8 +1558,8 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		addr += baseaddr;
 	/* Find cu die */
 	if (!dwarf_addrdie(dbg->dbg, (Dwarf_Addr)addr, &cudie)) {
-		pr_warning("Failed to find debug information for address %lx\n",
-			   addr);
+		pr_warn("Failed to find debug information for address %lx\n",
+			addr);
 		ret = -EINVAL;
 		goto end;
 	}
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 8579505c29a4..a2d013fe04bd 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -231,11 +231,11 @@ static int record_opts__config_freq(struct record_opts *opts)
 			       max_rate);
 			return -1;
 		} else {
-			pr_warning("warning: Maximum frequency rate (%'u Hz) exceeded, throttling from %'u Hz to %'u Hz.\n"
-				   "         The limit can be raised via /proc/sys/kernel/perf_event_max_sample_rate.\n"
-				   "         The kernel will lower it when perf's interrupts take too long.\n"
-				   "         Use --strict-freq to disable this throttling, refusing to record.\n",
-				   max_rate, opts->freq, max_rate);
+			pr_warn("warning: Maximum frequency rate (%'u Hz) exceeded, throttling from %'u Hz to %'u Hz.\n"
+				"         The limit can be raised via /proc/sys/kernel/perf_event_max_sample_rate.\n"
+				"         The kernel will lower it when perf's interrupts take too long.\n"
+				"         Use --strict-freq to disable this throttling, refusing to record.\n",
+				max_rate, opts->freq, max_rate);
 
 			opts->freq = max_rate;
 		}
@@ -245,10 +245,10 @@ static int record_opts__config_freq(struct record_opts *opts)
 	 * Default frequency is over current maximum.
 	 */
 	if (max_rate < opts->freq) {
-		pr_warning("Lowering default frequency rate to %u.\n"
-			   "Please consider tweaking "
-			   "/proc/sys/kernel/perf_event_max_sample_rate.\n",
-			   max_rate);
+		pr_warn("Lowering default frequency rate to %u.\n"
+			"Please consider tweaking "
+			"/proc/sys/kernel/perf_event_max_sample_rate.\n",
+			max_rate);
 		opts->freq = max_rate;
 	}
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 061bb4d6a3f5..847de4ae9f15 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -244,7 +244,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
 		 * kernel MMAP event, in perf_event__process_mmap().
 		 */
 		if (perf_session__create_kernel_maps(session) < 0)
-			pr_warning("Cannot read kernel map\n");
+			pr_warn("Cannot read kernel map\n");
 	}
 
 	/*
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 6ccf6f6d09df..d770de66ceaf 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -290,7 +290,7 @@ static int addr2line(const char *dso_name, u64 addr,
 
 	if (a2l == NULL) {
 		if (!symbol_conf.disable_add2line_warn)
-			pr_warning("addr2line_init failed for %s\n", dso_name);
+			pr_warn("addr2line_init failed for %s\n", dso_name);
 		return 0;
 	}
 
@@ -406,12 +406,12 @@ static int addr2line(const char *dso_name, u64 addr,
 
 	fp = popen(cmd, "r");
 	if (fp == NULL) {
-		pr_warning("popen failed for %s\n", dso_name);
+		pr_warn("popen failed for %s\n", dso_name);
 		return 0;
 	}
 
 	if (getline(&filename, &len, fp) < 0 || !len) {
-		pr_warning("addr2line has no output for %s\n", dso_name);
+		pr_warn("addr2line has no output for %s\n", dso_name);
 		goto out;
 	}
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 807cbca403a7..5c376ff46ab0 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -91,8 +91,7 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 	n = read(fd, bf, sizeof(bf) - 1);
 	close(fd);
 	if (n <= 0) {
-		pr_warning("Couldn't get COMM, tigd and ppid for pid %d\n",
-			   pid);
+		pr_warn("Couldn't get COMM, tigd and ppid for pid %d\n", pid);
 		return -1;
 	}
 	bf[n] = '\0';
@@ -320,10 +319,9 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			break;
 
 		if ((rdclock() - t) > timeout) {
-			pr_warning("Reading %s time out. "
-				   "You may want to increase "
-				   "the time limit by --proc-map-timeout\n",
-				   filename);
+			pr_warn("Reading %s time out. You may want to increase "
+				"the time limit by --proc-map-timeout\n",
+				filename);
 			truncation = true;
 			goto out;
 		}
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index cd8a948d03ec..2e21f88746d1 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -220,7 +220,7 @@ static int thread_stack__push(struct thread_stack *ts, u64 ret_addr,
 	if (ts->cnt == ts->sz) {
 		err = thread_stack__grow(ts);
 		if (err) {
-			pr_warning("Out of memory: discarding thread stack\n");
+			pr_warn("Out of memory: discarding thread stack\n");
 			ts->cnt = 0;
 		}
 	}
@@ -364,7 +364,7 @@ int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
 	if (!ts) {
 		ts = thread_stack__new(thread, cpu, NULL);
 		if (!ts) {
-			pr_warning("Out of memory: no thread stack\n");
+			pr_warn("Out of memory: no thread stack\n");
 			return -ENOMEM;
 		}
 		ts->trace_nr = trace_nr;
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index c9bfe4696943..e0dea5b46931 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -355,7 +355,7 @@ static void comm_init(struct perf_thread_map *map, int i)
 	 * so just warn if we fail for any reason.
 	 */
 	if (get_comm(&comm, pid))
-		pr_warning("Couldn't resolve comm name for pid %d\n", pid);
+		pr_warn("Couldn't resolve comm name for pid %d\n", pid);
 
 	map->map[i].comm = comm;
 }
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 5d6bfc70b210..9433bbabcbda 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -134,7 +134,7 @@ void parse_ftrace_printk(struct tep_handle *pevent,
 	while (line) {
 		addr_str = strtok_r(line, ":", &fmt);
 		if (!addr_str) {
-			pr_warning("printk format with empty entry");
+			pr_warn("printk format with empty entry");
 			break;
 		}
 		addr = strtoull(addr_str, NULL, 16);
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 1800887b2255..c9314f3d05bf 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -340,11 +340,10 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 			}
 			if (ofs > 0) {
 				if (dso->symsrc_filename != NULL) {
-					pr_warning(
-						"%s: overwrite symsrc(%s,%s)\n",
-							__func__,
-							dso->symsrc_filename,
-							debuglink);
+					pr_warn("%s: overwrite symsrc(%s,%s)\n",
+						__func__,
+						dso->symsrc_filename,
+						debuglink);
 					zfree(&dso->symsrc_filename);
 				}
 				dso->symsrc_filename = debuglink;
-- 
2.20.1

