Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9DEC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AE92133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LnjGajHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfHPUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:53:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41543 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfHPUxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:53:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKrdDM2959514
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:53:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKrdDM2959514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565988820;
        bh=aisWntI5ezEgLDFd+8AFRtNV2wPmEzrgp2daHOKWrGE=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=LnjGajHiUKKcPTbefbVPTcJ3RDWISiKX9qwzmwzwAhNFs55u+qXoMvSL3vOP71/XN
         0aW5JMpNnzaqi01mS8pYUNgbtOUhHkRE9VqizvD0gPxfWEFiyBnM9//AgAVbIq63Qo
         rd65YCxae7BjUNFwq2oUSaeeRSTTZ5brKuAu03AUyOZtrAHFlyr0DWDd4ms3Z2cKBj
         Nj1KlIyYg0Kod7BF8CM8wVCPAmljXprMnjlUtndB79//mxrDpvh8bXuV6MFKIJzjYe
         wWct/YEaiufOZLI3Cu0dLVYWQXwiEUSwmxnhKId5rtMZy1HyPctOgs37tPEULBb2Bw
         c0lOm//XI5l2A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKrduM2959511;
        Fri, 16 Aug 2019 13:53:39 -0700
Date:   Fri, 16 Aug 2019 13:53:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-q0og1xoqqi0w38ve5u0a43k2@git.kernel.org>
Cc:     tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        fweimer@redhat.com, jolsa@kernel.org, wcohen@redhat.com,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, fweimer@redhat.com, hpa@zytor.com,
          wcohen@redhat.com, jolsa@kernel.org, mingo@kernel.org,
          adrian.hunter@intel.com, acme@redhat.com, tglx@linutronix.de,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evswitch: Add the names of on/off events
Git-Commit-ID: 0b495b121585a1b6ca120fe13f950e2f86ca8197
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

Commit-ID:  0b495b121585a1b6ca120fe13f950e2f86ca8197
Gitweb:     https://git.kernel.org/tip/0b495b121585a1b6ca120fe13f950e2f86ca8197
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Aug 2019 11:11:14 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Aug 2019 12:24:42 -0300

perf evswitch: Add the names of on/off events

So that we can have macros for the OPT_ entries and also for finding
those in an evlist, this way other tools will use this very easily.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-q0og1xoqqi0w38ve5u0a43k2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 18 ++++++++----------
 tools/perf/util/evswitch.h  |  1 +
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e7b950e977a9..177e4e91b199 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3400,8 +3400,6 @@ int cmd_script(int argc, const char **argv)
 	struct utsname uts;
 	char *script_path = NULL;
 	const char **__argv;
-	const char *event_switch_on  = NULL,
-		   *event_switch_off = NULL;
 	int i, j, err = 0;
 	struct perf_script script = {
 		.tool = {
@@ -3545,9 +3543,9 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/kallsyms"),
 	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
 		   "file", "file saving guest os /proc/modules"),
-	OPT_STRING(0, "switch-on", &event_switch_on,
+	OPT_STRING(0, "switch-on", &script.evswitch.on_name,
 		   "event", "Consider events after the ocurrence of this event"),
-	OPT_STRING(0, "switch-off", &event_switch_off,
+	OPT_STRING(0, "switch-off", &script.evswitch.off_name,
 		   "event", "Stop considering events after the ocurrence of this event"),
 	OPT_BOOLEAN(0, "show-on-off-events", &script.evswitch.show_on_off_events,
 		    "Show the on/off switch events, used with --switch-on"),
@@ -3875,20 +3873,20 @@ int cmd_script(int argc, const char **argv)
 						  script.range_num);
 	}
 
-	if (event_switch_on) {
-		script.evswitch.on = perf_evlist__find_evsel_by_str(session->evlist, event_switch_on);
+	if (script.evswitch.on_name) {
+		script.evswitch.on = perf_evlist__find_evsel_by_str(session->evlist, script.evswitch.on_name);
 		if (script.evswitch.on == NULL) {
-			fprintf(stderr, "switch-on event not found (%s)\n", event_switch_on);
+			fprintf(stderr, "switch-on event not found (%s)\n", script.evswitch.on_name);
 			err = -ENOENT;
 			goto out_delete;
 		}
 		script.evswitch.discarding = true;
 	}
 
-	if (event_switch_off) {
-		script.evswitch.off = perf_evlist__find_evsel_by_str(session->evlist, event_switch_off);
+	if (script.evswitch.off_name) {
+		script.evswitch.off = perf_evlist__find_evsel_by_str(session->evlist, script.evswitch.off_name);
 		if (script.evswitch.off == NULL) {
-			fprintf(stderr, "switch-off event not found (%s)\n", event_switch_off);
+			fprintf(stderr, "switch-off event not found (%s)\n", script.evswitch.off_name);
 			err = -ENOENT;
 			goto out_delete;
 		}
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index bae3a22ad719..891164504080 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -9,6 +9,7 @@ struct evsel;
 
 struct evswitch {
 	struct evsel *on, *off;
+	const char   *on_name, *off_name;
 	bool	     discarding;
 	bool	     show_on_off_events;
 };
