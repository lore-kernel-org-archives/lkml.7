Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7D6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1660E217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfH0I0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbfH0I0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wo9-0007yR-NE; Tue, 27 Aug 2019 10:26:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6FA8A1C0DDF;
        Tue, 27 Aug 2019 10:26:25 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:25 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tool: Rename perf_tool::bpf_event to bpf
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-03spzxtqafbabbbmnm7y4xfx@git.kernel.org>
References: <tip-03spzxtqafbabbbmnm7y4xfx@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156689438532.24568.10727561043033831959.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3f604b5f61dbff80725392c99827d6617f7bb180
Gitweb:        https://git.kernel.org/tip/3f604b5f61dbff80725392c99827d6617f7bb180
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 26 Aug 2019 19:28:13 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:39:11 -03:00

perf tool: Rename perf_tool::bpf_event to bpf

No need for that _event suffix, do just like all the other meta event
handlers and suppress that suffix.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/n/tip-03spzxtqafbabbbmnm7y4xfx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c |  4 ++--
 tools/perf/util/bpf-event.c | 11 +++++------
 tools/perf/util/bpf-event.h | 10 +++++-----
 tools/perf/util/event.c     | 14 +++++++-------
 tools/perf/util/event.h     | 10 +++++-----
 tools/perf/util/machine.c   |  2 +-
 tools/perf/util/session.c   |  6 +++---
 tools/perf/util/tool.h      |  2 +-
 8 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6f389b3..51e7e6d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2492,8 +2492,8 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.finished_round = process_finished_round_event;
 	}
 	if (script->show_bpf_events) {
-		script->tool.ksymbol   = process_bpf_events;
-		script->tool.bpf_event = process_bpf_events;
+		script->tool.ksymbol = process_bpf_events;
+		script->tool.bpf     = process_bpf_events;
 	}
 
 	if (perf_script__setup_per_event_dump(script)) {
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 28fa2b1..2d6d500 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -64,12 +64,11 @@ static int machine__process_bpf_event_load(struct machine *machine,
 	return 0;
 }
 
-int machine__process_bpf_event(struct machine *machine __maybe_unused,
-			       union perf_event *event,
-			       struct perf_sample *sample __maybe_unused)
+int machine__process_bpf(struct machine *machine, union perf_event *event,
+			 struct perf_sample *sample)
 {
 	if (dump_trace)
-		perf_event__fprintf_bpf_event(event, stdout);
+		perf_event__fprintf_bpf(event, stdout);
 
 	switch (event->bpf.type) {
 	case PERF_BPF_EVENT_PROG_LOAD:
@@ -83,7 +82,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 		 */
 		break;
 	default:
-		pr_debug("unexpected bpf_event type of %d\n", event->bpf.type);
+		pr_debug("unexpected bpf event type of %d\n", event->bpf.type);
 		break;
 	}
 	return 0;
@@ -410,7 +409,7 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 		 */
 		break;
 	default:
-		pr_debug("unexpected bpf_event type of %d\n", event->bpf.type);
+		pr_debug("unexpected bpf event type of %d\n", event->bpf.type);
 		break;
 	}
 
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 26ab923..417b788 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -30,8 +30,8 @@ struct btf_node {
 };
 
 #ifdef HAVE_LIBBPF_SUPPORT
-int machine__process_bpf_event(struct machine *machine, union perf_event *event,
-			       struct perf_sample *sample);
+int machine__process_bpf(struct machine *machine, union perf_event *event,
+			 struct perf_sample *sample);
 
 int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
@@ -43,9 +43,9 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 				    struct perf_env *env,
 				    FILE *fp);
 #else
-static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
-					     union perf_event *event __maybe_unused,
-					     struct perf_sample *sample __maybe_unused)
+static inline int machine__process_bpf(struct machine *machine __maybe_unused,
+				       union perf_event *event __maybe_unused,
+				       struct perf_sample *sample __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 17304df..33616ea 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1343,12 +1343,12 @@ int perf_event__process_ksymbol(struct perf_tool *tool __maybe_unused,
 	return machine__process_ksymbol(machine, event, sample);
 }
 
-int perf_event__process_bpf_event(struct perf_tool *tool __maybe_unused,
-				  union perf_event *event,
-				  struct perf_sample *sample __maybe_unused,
-				  struct machine *machine)
+int perf_event__process_bpf(struct perf_tool *tool __maybe_unused,
+			    union perf_event *event,
+			    struct perf_sample *sample,
+			    struct machine *machine)
 {
-	return machine__process_bpf_event(machine, event, sample);
+	return machine__process_bpf(machine, event, sample);
 }
 
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
@@ -1491,7 +1491,7 @@ size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 		       event->ksymbol.flags, event->ksymbol.name);
 }
 
-size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
+size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " type %u, flags %u, id %u\n",
 		       event->bpf.type, event->bpf.flags, event->bpf.id);
@@ -1536,7 +1536,7 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 		ret += perf_event__fprintf_ksymbol(event, fp);
 		break;
 	case PERF_RECORD_BPF_EVENT:
-		ret += perf_event__fprintf_bpf_event(event, fp);
+		ret += perf_event__fprintf_bpf(event, fp);
 		break;
 	default:
 		ret += fprintf(fp, "\n");
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 7251e2e..429a3fe 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -683,10 +683,10 @@ int perf_event__process_ksymbol(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
 				struct machine *machine);
-int perf_event__process_bpf_event(struct perf_tool *tool,
-				  union perf_event *event,
-				  struct perf_sample *sample,
-				  struct machine *machine);
+int perf_event__process_bpf(struct perf_tool *tool,
+			    union perf_event *event,
+			    struct perf_sample *sample,
+			    struct machine *machine);
 int perf_tool__process_synth_event(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct machine *machine,
@@ -751,7 +751,7 @@ size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
-size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 86b7fd2..93483f1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1922,7 +1922,7 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 	case PERF_RECORD_KSYMBOL:
 		ret = machine__process_ksymbol(machine, event, sample); break;
 	case PERF_RECORD_BPF_EVENT:
-		ret = machine__process_bpf_event(machine, event, sample); break;
+		ret = machine__process_bpf(machine, event, sample); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4bfec9d..5786e9c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -473,8 +473,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->context_switch = perf_event__process_switch;
 	if (tool->ksymbol == NULL)
 		tool->ksymbol = perf_event__process_ksymbol;
-	if (tool->bpf_event == NULL)
-		tool->bpf_event = perf_event__process_bpf_event;
+	if (tool->bpf == NULL)
+		tool->bpf = perf_event__process_bpf;
 	if (tool->read == NULL)
 		tool->read = process_event_sample_stub;
 	if (tool->throttle == NULL)
@@ -1452,7 +1452,7 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_KSYMBOL:
 		return tool->ksymbol(tool, event, sample, machine);
 	case PERF_RECORD_BPF_EVENT:
-		return tool->bpf_event(tool, event, sample, machine);
+		return tool->bpf(tool, event, sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 7f95dd1..2abbf66 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -56,7 +56,7 @@ struct perf_tool {
 			throttle,
 			unthrottle,
 			ksymbol,
-			bpf_event;
+			bpf;
 
 	event_attr_op	attr;
 	event_attr_op	event_update;
