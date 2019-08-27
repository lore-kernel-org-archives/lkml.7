Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0701CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF71F21872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbfH0I0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42862 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbfH0I0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wo8-0007xR-05; Tue, 27 Aug 2019 10:26:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6CC161C0DE5;
        Tue, 27 Aug 2019 10:26:24 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:24 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Rename perf_event::ksymbol_event to
 perf_event::ksymbol
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-0q8b2xnfs17q0g523oej75s0@git.kernel.org>
References: <tip-0q8b2xnfs17q0g523oej75s0@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156689438436.24562.17720825512275523869.tip-bot2@tip-bot2>
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

Commit-ID:     ebdba16e95f728e94dba07fe0f1221b0e8efdb9d
Gitweb:        https://git.kernel.org/tip/ebdba16e95f728e94dba07fe0f1221b0e8efdb9d
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 26 Aug 2019 19:15:18 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:39:11 -03:00

perf tools: Rename perf_event::ksymbol_event to perf_event::ksymbol

Just like all the other meta events, that extra _event suffix is just
redundant, ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/n/tip-0q8b2xnfs17q0g523oej75s0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c |  2 +-
 tools/perf/util/event.c     |  6 +++---
 tools/perf/util/event.h     |  2 +-
 tools/perf/util/machine.c   | 16 ++++++++--------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 3be8c48..69795c3 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -161,7 +161,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 					       union perf_event *event,
 					       struct record_opts *opts)
 {
-	struct perf_record_ksymbol *ksymbol_event = &event->ksymbol_event;
+	struct perf_record_ksymbol *ksymbol_event = &event->ksymbol;
 	struct perf_record_bpf_event *bpf_event = &event->bpf_event;
 	struct bpf_prog_info_linear *info_linear;
 	struct perf_tool *tool = session->tool;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 4447cd2..bdeaad4 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1486,9 +1486,9 @@ static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " addr %" PRI_lx64 " len %u type %u flags 0x%x name %s\n",
-		       event->ksymbol_event.addr, event->ksymbol_event.len,
-		       event->ksymbol_event.ksym_type,
-		       event->ksymbol_event.flags, event->ksymbol_event.name);
+		       event->ksymbol.addr, event->ksymbol.len,
+		       event->ksymbol.ksym_type,
+		       event->ksymbol.flags, event->ksymbol.name);
 }
 
 size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 25f5309..34190e0 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -561,7 +561,7 @@ union perf_event {
 	struct perf_record_throttle	throttle;
 	struct perf_record_sample	sample;
 	struct perf_record_bpf_event	bpf_event;
-	struct perf_record_ksymbol	ksymbol_event;
+	struct perf_record_ksymbol	ksymbol;
 	struct attr_event		attr;
 	struct event_update_event	event_update;
 	struct event_type_event		event_type;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 823aaf7..86b7fd2 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -713,20 +713,20 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct symbol *sym;
 	struct map *map;
 
-	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
+	map = map_groups__find(&machine->kmaps, event->ksymbol.addr);
 	if (!map) {
-		map = dso__new_map(event->ksymbol_event.name);
+		map = dso__new_map(event->ksymbol.name);
 		if (!map)
 			return -ENOMEM;
 
-		map->start = event->ksymbol_event.addr;
-		map->end = map->start + event->ksymbol_event.len;
+		map->start = event->ksymbol.addr;
+		map->end = map->start + event->ksymbol.len;
 		map_groups__insert(&machine->kmaps, map);
 	}
 
 	sym = symbol__new(map->map_ip(map, map->start),
-			  event->ksymbol_event.len,
-			  0, 0, event->ksymbol_event.name);
+			  event->ksymbol.len,
+			  0, 0, event->ksymbol.name);
 	if (!sym)
 		return -ENOMEM;
 	dso__insert_symbol(map->dso, sym);
@@ -739,7 +739,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 {
 	struct map *map;
 
-	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
+	map = map_groups__find(&machine->kmaps, event->ksymbol.addr);
 	if (map)
 		map_groups__remove(&machine->kmaps, map);
 
@@ -753,7 +753,7 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
 	if (dump_trace)
 		perf_event__fprintf_ksymbol(event, stdout);
 
-	if (event->ksymbol_event.flags & PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER)
+	if (event->ksymbol.flags & PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER)
 		return machine__process_ksymbol_unregister(machine, event,
 							   sample);
 	return machine__process_ksymbol_register(machine, event, sample);
