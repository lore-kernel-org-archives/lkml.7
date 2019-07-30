Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48410C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0997E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aqyUhqs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbfG3SOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:14:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfG3SOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:14:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIEIVF3325833
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:14:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIEIVF3325833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510459;
        bh=BwGFZ0E5ir3djK+EjNFs/WKw1INNTsfq1xeQJtJqyBg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aqyUhqs/rWVNcRbqpPzQ+f/Td2rvUD15luDFcBWMriRo0vd5U3l1hDgQ49VQCXlgi
         xleV6Q/v/hn9Dxt6U7rU/YiqzM6bQnr9Qs0XzJ4d6hvGL3mQXuxwV8f9AYlah2hJTK
         E99yY2UrAI69VoMx9H6/lax4nPXW7400DoxVRp8wdF5Xf5QBWa/3tVzvEdHeY1Ms5n
         0n9QXjwINe3h5rGKmfcn31GnASokmaV7j+/+gcW96Gf3rsfbIob+NXRiHTp0reVYku
         YGhAbrnKPKGN54ICc2NgiHMPS1/VPetO1gvryf7r34ew93g7K0pvHO7dyHS6sFIh5r
         PN6H0oB07zf0A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIEHf93325830;
        Tue, 30 Jul 2019 11:14:17 -0700
Date:   Tue, 30 Jul 2019 11:14:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5eb2dd2ade8354dcbe4cef54cd1719622af8f2dc@git.kernel.org>
Cc:     ak@linux.intel.com, alexey.budankov@linux.intel.com,
        peterz@infradead.org, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, mpetlan@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de
Reply-To: jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, namhyung@kernel.org, ak@linux.intel.com,
          mpetlan@redhat.com, peterz@infradead.org,
          alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190721112506.12306-11-jolsa@kernel.org>
References: <20190721112506.12306-11-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Rename perf_evsel__delete() to
 evsel__delete()
Git-Commit-ID: 5eb2dd2ade8354dcbe4cef54cd1719622af8f2dc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5eb2dd2ade8354dcbe4cef54cd1719622af8f2dc
Gitweb:     https://git.kernel.org/tip/5eb2dd2ade8354dcbe4cef54cd1719622af8f2dc
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:23:57 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

perf evsel: Rename perf_evsel__delete() to evsel__delete()

Remame perf_evsel__delete() to evsel__delete(), so we don't have a name
clash when we add perf_evsel__delete() in libperf.

Also renaming perf_evsel__delete_priv() to evsel__delete_priv().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c                |  4 ++--
 tools/perf/builtin-trace.c                 | 12 ++++++------
 tools/perf/tests/evsel-tp-sched.c          |  4 ++--
 tools/perf/tests/openat-syscall-all-cpus.c |  2 +-
 tools/perf/tests/openat-syscall.c          |  2 +-
 tools/perf/util/evlist.c                   |  4 ++--
 tools/perf/util/evsel.c                    |  4 ++--
 tools/perf/util/evsel.h                    |  2 +-
 tools/perf/util/parse-events.c             |  4 ++--
 9 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d2131fc863be..917c8fb4baa5 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -623,7 +623,7 @@ static void strip_fini(struct perf_inject *inject)
 		    ok_to_remove(evlist, evsel)) {
 			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
 			perf_evlist__remove(evlist, evsel);
-			perf_evsel__delete(evsel);
+			evsel__delete(evsel);
 		}
 	}
 }
@@ -725,7 +725,7 @@ static int __cmd_inject(struct perf_inject *inject)
 				pr_debug("Deleting %s\n",
 					 perf_evsel__name(evsel));
 				perf_evlist__remove(session->evlist, evsel);
-				perf_evsel__delete(evsel);
+				evsel__delete(evsel);
 			}
 			if (inject->strip)
 				strip_fini(inject);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e133204b3bb9..0f7d1859a2d1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -274,10 +274,10 @@ static int perf_evsel__init_tp_ptr_field(struct evsel *evsel,
 	({ struct syscall_tp *sc = evsel->priv;\
 	   perf_evsel__init_tp_ptr_field(evsel, &sc->name, #name); })
 
-static void perf_evsel__delete_priv(struct evsel *evsel)
+static void evsel__delete_priv(struct evsel *evsel)
 {
 	zfree(&evsel->priv);
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 }
 
 static int perf_evsel__init_syscall_tp(struct evsel *evsel)
@@ -368,7 +368,7 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 	return evsel;
 
 out_delete:
-	perf_evsel__delete_priv(evsel);
+	evsel__delete_priv(evsel);
 	return NULL;
 }
 
@@ -2638,7 +2638,7 @@ static bool perf_evlist__add_vfs_getname(struct evlist *evlist)
 
 		list_del_init(&evsel->node);
 		evsel->evlist = NULL;
-		perf_evsel__delete(evsel);
+		evsel__delete(evsel);
 	}
 
 	return found;
@@ -2739,9 +2739,9 @@ out:
 	return ret;
 
 out_delete_sys_exit:
-	perf_evsel__delete_priv(sys_exit);
+	evsel__delete_priv(sys_exit);
 out_delete_sys_enter:
-	perf_evsel__delete_priv(sys_enter);
+	evsel__delete_priv(sys_enter);
 	goto out;
 }
 
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 0170e9d2e329..261e6eaaee99 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -64,7 +64,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 	if (perf_evsel__test_field(evsel, "next_prio", 4, true))
 		ret = -1;
 
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 
 	evsel = perf_evsel__newtp("sched", "sched_wakeup");
 
@@ -85,6 +85,6 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 	if (perf_evsel__test_field(evsel, "target_cpu", 4, true))
 		ret = -1;
 
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 	return ret;
 }
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 4bf73896695a..001a0e8e6998 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -118,7 +118,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 out_close_fd:
 	perf_evsel__close_fd(evsel);
 out_evsel_delete:
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 out_cpu_map_delete:
 	cpu_map__put(cpus);
 out_thread_map_delete:
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index f3efadd05863..20e353fbfdd0 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -59,7 +59,7 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 out_close_fd:
 	perf_evsel__close_fd(evsel);
 out_evsel_delete:
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 out_thread_map_delete:
 	thread_map__put(threads);
 	return err;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9fa3663068b4..986d20c15778 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -121,7 +121,7 @@ static void perf_evlist__purge(struct evlist *evlist)
 	evlist__for_each_entry_safe(evlist, n, pos) {
 		list_del_init(&pos->node);
 		pos->evlist = NULL;
-		perf_evsel__delete(pos);
+		evsel__delete(pos);
 	}
 
 	evlist->nr_entries = 0;
@@ -277,7 +277,7 @@ static int perf_evlist__add_attrs(struct evlist *evlist,
 
 out_delete_partial_list:
 	__evlist__for_each_entry_safe(&head, n, evsel)
-		perf_evsel__delete(evsel);
+		evsel__delete(evsel);
 	return -1;
 }
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 97bee83f0f98..de379b63f1ce 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -316,7 +316,7 @@ new_event:
 out:
 	return evsel;
 error_free:
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 	evsel = NULL;
 	goto out;
 }
@@ -1333,7 +1333,7 @@ void perf_evsel__exit(struct evsel *evsel)
 	perf_evsel__object.fini(evsel);
 }
 
-void perf_evsel__delete(struct evsel *evsel)
+void evsel__delete(struct evsel *evsel)
 {
 	perf_evsel__exit(evsel);
 	free(evsel);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index af230d92fbef..20b4e31b63a9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -240,7 +240,7 @@ struct tep_event *event_format__new(const char *sys, const char *name);
 
 void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
 void perf_evsel__exit(struct evsel *evsel);
-void perf_evsel__delete(struct evsel *evsel);
+void evsel__delete(struct evsel *evsel);
 
 struct callchain_param;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6a4bfc7ab0c1..cc63367f6e45 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -662,7 +662,7 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 			 group, event);
 		list_for_each_entry_safe(evsel, tmp, &new_evsels, node) {
 			list_del_init(&evsel->node);
-			perf_evsel__delete(evsel);
+			evsel__delete(evsel);
 		}
 		return err;
 	}
@@ -2334,7 +2334,7 @@ static bool is_event_supported(u8 type, unsigned config)
 			evsel->attr.exclude_kernel = 1;
 			ret = perf_evsel__open(evsel, NULL, tmap) >= 0;
 		}
-		perf_evsel__delete(evsel);
+		evsel__delete(evsel);
 	}
 
 	thread_map__put(tmap);
