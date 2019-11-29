Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60A8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5C120869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfK2GDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:03:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48050 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfK2GDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMl-0008L3-AE; Fri, 29 Nov 2019 07:02:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5B3B21C2107;
        Fri, 29 Nov 2019 07:02:52 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf addr_location: Rename al->mg to al->maps
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-foo95pyyp3bhocbt7yd8qrvq@git.kernel.org>
References: <tip-foo95pyyp3bhocbt7yd8qrvq@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737225.21853.1963410218703907138.tip-bot2@tip-bot2>
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

Commit-ID:     694520dfeb474619402620b68edf08e60ca36a17
Gitweb:        https://git.kernel.org/tip/694520dfeb474619402620b68edf08e60ca36a17
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 25 Nov 2019 22:11:20 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:46 -03:00

perf addr_location: Rename al->mg to al->maps

One more step on the merge of 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-foo95pyyp3bhocbt7yd8qrvq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c                            |  8 +++---
 tools/perf/util/db-export.c                            | 12 ++++-----
 tools/perf/util/event.c                                |  6 ++---
 tools/perf/util/hist.c                                 |  8 +++---
 tools/perf/util/machine.c                              |  6 ++---
 tools/perf/util/scripting-engines/trace-event-python.c |  2 +-
 tools/perf/util/symbol.h                               |  2 +-
 tools/perf/util/unwind-libdw.c                         |  2 +-
 tools/perf/util/unwind-libunwind-local.c               |  2 +-
 9 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 5cefce3..c7270c0 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1106,7 +1106,7 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
 			bool hide_unresolved)
 {
-	al->mg	= node->ms.mg;
+	al->maps = node->ms.mg;
 	al->map = node->ms.map;
 	al->sym = node->ms.sym;
 	al->srcline = node->srcline;
@@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 			goto out;
 	}
 
-	if (al->mg == &al->mg->machine->kmaps) {
-		if (machine__is_host(al->mg->machine)) {
+	if (al->maps == &al->maps->machine->kmaps) {
+		if (machine__is_host(al->maps->machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
 		} else {
@@ -1128,7 +1128,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 			al->level = 'g';
 		}
 	} else {
-		if (machine__is_host(al->mg->machine)) {
+		if (machine__is_host(al->maps->machine)) {
 			al->cpumode = PERF_RECORD_MISC_USER;
 			al->level = '.';
 		} else if (perf_guest) {
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index e726922..db74471 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 	if (al->map) {
 		struct dso *dso = al->map->dso;
 
-		err = db_export__dso(dbe, dso, al->mg->machine);
+		err = db_export__dso(dbe, dso, al->maps->machine);
 		if (err)
 			return err;
 		*dso_db_id = dso->db_id;
@@ -251,7 +251,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		 */
 		al.sym = node->ms.sym;
 		al.map = node->ms.map;
-		al.mg  = thread->maps;
+		al.maps = thread->maps;
 		al.addr = node->ip;
 
 		if (al.map && !al.sym)
@@ -360,13 +360,13 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	if (err)
 		return err;
 
-	err = db_export__machine(dbe, al->mg->machine);
+	err = db_export__machine(dbe, al->maps->machine);
 	if (err)
 		return err;
 
-	main_thread = thread__main_thread(al->mg->machine, thread);
+	main_thread = thread__main_thread(al->maps->machine, thread);
 
-	err = db_export__threads(dbe, thread, main_thread, al->mg->machine, &comm);
+	err = db_export__threads(dbe, thread, main_thread, al->maps->machine, &comm);
 	if (err)
 		goto out_put;
 
@@ -380,7 +380,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		goto out_put;
 
 	if (dbe->cpr) {
-		struct call_path *cp = call_path_from_sample(dbe, al->mg->machine,
+		struct call_path *cp = call_path_from_sample(dbe, al->maps->machine,
 							     thread, sample,
 							     evsel);
 		if (cp) {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2f0b773..fc3da38 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -461,7 +461,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	struct machine *machine = mg->machine;
 	bool load_map = false;
 
-	al->mg = mg;
+	al->maps = mg;
 	al->thread = thread;
 	al->addr = addr;
 	al->cpumode = cpumode;
@@ -474,13 +474,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
-		al->mg = mg = &machine->kmaps;
+		al->maps = mg = &machine->kmaps;
 		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
 		al->level = '.';
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
 		al->level = 'g';
-		al->mg = mg = &machine->kmaps;
+		al->maps = mg = &machine->kmaps;
 		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
 		al->level = 'u';
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0a8d72a..5ebfbe3 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -692,7 +692,7 @@ __hists__add_entry(struct hists *hists,
 			.ino = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0,
 		},
 		.ms = {
-			.mg	= al->mg,
+			.mg	= al->maps,
 			.map	= al->map,
 			.sym	= al->sym,
 		},
@@ -760,7 +760,7 @@ struct hist_entry *hists__add_entry_block(struct hists *hists,
 		.block_info = block_info,
 		.hists = hists,
 		.ms = {
-			.mg  = al->mg,
+			.mg  = al->maps,
 			.map = al->map,
 			.sym = al->sym,
 		},
@@ -895,7 +895,7 @@ iter_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 	if (iter->curr >= iter->total)
 		return 0;
 
-	al->mg  = bi[i].to.ms.mg;
+	al->maps = bi[i].to.ms.mg;
 	al->map = bi[i].to.ms.map;
 	al->sym = bi[i].to.ms.sym;
 	al->addr = bi[i].to.addr;
@@ -1072,7 +1072,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 		.comm = thread__comm(al->thread),
 		.ip = al->addr,
 		.ms = {
-			.mg  = al->mg,
+			.mg  = al->maps,
 			.map = al->map,
 			.sym = al->sym,
 		},
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b351476..de5d6b4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1934,7 +1934,7 @@ static void ip__resolve_ams(struct thread *thread,
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
-	ams->ms.mg  = al.mg;
+	ams->ms.mg  = al.maps;
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
 	ams->phys_addr = 0;
@@ -1952,7 +1952,7 @@ static void ip__resolve_data(struct thread *thread,
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
-	ams->ms.mg  = al.mg;
+	ams->ms.mg  = al.maps;
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
 	ams->phys_addr = phys_addr;
@@ -2069,7 +2069,7 @@ static int add_callchain_ip(struct thread *thread,
 		iter_cycles = iter->cycles;
 	}
 
-	ms.mg  = al.mg;
+	ms.mg  = al.maps;
 	ms.map = al.map;
 	ms.sym = al.sym;
 	srcline = callchain_srcline(&ms, al.addr);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 9581a90..80ca5d0 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1127,7 +1127,7 @@ static void python_export_sample_table(struct db_export *dbe,
 
 	tuple_set_u64(t, 0, es->db_id);
 	tuple_set_u64(t, 1, es->evsel->db_id);
-	tuple_set_u64(t, 2, es->al->mg->machine->db_id);
+	tuple_set_u64(t, 2, es->al->maps->machine->db_id);
 	tuple_set_u64(t, 3, es->al->thread->db_id);
 	tuple_set_u64(t, 4, es->comm_db_id);
 	tuple_set_u64(t, 5, es->dso_db_id);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d3e8fae..29c4ea4 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -108,7 +108,7 @@ struct ref_reloc_sym {
 
 struct addr_location {
 	struct thread *thread;
-	struct maps   *mg;
+	struct maps   *maps;
 	struct map    *map;
 	struct symbol *sym;
 	const char    *srcline;
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 33f6552..bb4f515 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -81,7 +81,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 		return -1;
 
 	e->ip	  = ip;
-	e->ms.mg  = al.mg;
+	e->ms.mg  = al.maps;
 	e->ms.map = al.map;
 	e->ms.sym = al.sym;
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 30f921f..a744dfa 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -578,7 +578,7 @@ static int entry(u64 ip, struct thread *thread,
 	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 	e.ip     = ip;
 	e.ms.map = al.map;
-	e.ms.mg  = al.mg;
+	e.ms.mg  = al.maps;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
