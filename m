Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD23C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22842186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfDELpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:45:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46289 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDELpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:45:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35Bip0j2736976
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:44:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BippC2736973;
        Fri, 5 Apr 2019 04:44:51 -0700
Date:   Fri, 5 Apr 2019 04:44:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-d5d2d05bd5b02efa8545a3323a60465de9efb21e@git.kernel.org>
Cc:     namhyung@kernel.org, tstoyanov@vmware.com, mingo@kernel.org,
        hpa@zytor.com, acme@redhat.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, rostedt@goodmis.org
Reply-To: namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com,
          tstoyanov@vmware.com, akpm@linux-foundation.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          rostedt@goodmis.org, acme@redhat.com, jolsa@redhat.com
In-Reply-To: <20190401164343.537086316@goodmis.org>
References: <20190401164343.537086316@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Coding style fixes
Git-Commit-ID: d5d2d05bd5b02efa8545a3323a60465de9efb21e
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

Commit-ID:  d5d2d05bd5b02efa8545a3323a60465de9efb21e
Gitweb:     https://git.kernel.org/tip/d5d2d05bd5b02efa8545a3323a60465de9efb21e
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Mon, 1 Apr 2019 12:43:11 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:18:09 -0300

tools lib traceevent: Coding style fixes

Fixed few coding style problems in event-parse-api.c

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/linux-trace-devel/20190325145017.30246-3-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190401164343.537086316@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-api.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index 3686a221e981..3716a9142aef 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -32,7 +32,7 @@ struct tep_event *tep_get_first_event(struct tep_handle *tep)
  */
 int tep_get_events_count(struct tep_handle *tep)
 {
-	if(tep)
+	if (tep)
 		return tep->nr_events;
 	return 0;
 }
@@ -47,7 +47,7 @@ int tep_get_events_count(struct tep_handle *tep)
  */
 void tep_set_flag(struct tep_handle *tep, int flag)
 {
-	if(tep)
+	if (tep)
 		tep->flags |= flag;
 }
 
@@ -108,7 +108,7 @@ tep_data2host8(struct tep_handle *pevent, unsigned long long data)
  */
 int tep_get_header_page_size(struct tep_handle *pevent)
 {
-	if(pevent)
+	if (pevent)
 		return pevent->header_page_size_size;
 	return 0;
 }
@@ -122,7 +122,7 @@ int tep_get_header_page_size(struct tep_handle *pevent)
  */
 int tep_get_cpus(struct tep_handle *pevent)
 {
-	if(pevent)
+	if (pevent)
 		return pevent->cpus;
 	return 0;
 }
@@ -135,7 +135,7 @@ int tep_get_cpus(struct tep_handle *pevent)
  */
 void tep_set_cpus(struct tep_handle *pevent, int cpus)
 {
-	if(pevent)
+	if (pevent)
 		pevent->cpus = cpus;
 }
 
@@ -148,7 +148,7 @@ void tep_set_cpus(struct tep_handle *pevent, int cpus)
  */
 int tep_get_long_size(struct tep_handle *pevent)
 {
-	if(pevent)
+	if (pevent)
 		return pevent->long_size;
 	return 0;
 }
@@ -162,7 +162,7 @@ int tep_get_long_size(struct tep_handle *pevent)
  */
 void tep_set_long_size(struct tep_handle *pevent, int long_size)
 {
-	if(pevent)
+	if (pevent)
 		pevent->long_size = long_size;
 }
 
@@ -175,7 +175,7 @@ void tep_set_long_size(struct tep_handle *pevent, int long_size)
  */
 int tep_get_page_size(struct tep_handle *pevent)
 {
-	if(pevent)
+	if (pevent)
 		return pevent->page_size;
 	return 0;
 }
@@ -189,7 +189,7 @@ int tep_get_page_size(struct tep_handle *pevent)
  */
 void tep_set_page_size(struct tep_handle *pevent, int _page_size)
 {
-	if(pevent)
+	if (pevent)
 		pevent->page_size = _page_size;
 }
 
@@ -202,7 +202,7 @@ void tep_set_page_size(struct tep_handle *pevent, int _page_size)
  */
 int tep_file_bigendian(struct tep_handle *pevent)
 {
-	if(pevent)
+	if (pevent)
 		return pevent->file_bigendian;
 	return 0;
 }
@@ -216,7 +216,7 @@ int tep_file_bigendian(struct tep_handle *pevent)
  */
 void tep_set_file_bigendian(struct tep_handle *pevent, enum tep_endian endian)
 {
-	if(pevent)
+	if (pevent)
 		pevent->file_bigendian = endian;
 }
 
@@ -229,7 +229,7 @@ void tep_set_file_bigendian(struct tep_handle *pevent, enum tep_endian endian)
  */
 int tep_is_host_bigendian(struct tep_handle *pevent)
 {
-	if(pevent)
+	if (pevent)
 		return pevent->host_bigendian;
 	return 0;
 }
@@ -243,7 +243,7 @@ int tep_is_host_bigendian(struct tep_handle *pevent)
  */
 void tep_set_host_bigendian(struct tep_handle *pevent, enum tep_endian endian)
 {
-	if(pevent)
+	if (pevent)
 		pevent->host_bigendian = endian;
 }
 
@@ -256,7 +256,7 @@ void tep_set_host_bigendian(struct tep_handle *pevent, enum tep_endian endian)
  */
 int tep_is_latency_format(struct tep_handle *pevent)
 {
-	if(pevent)
+	if (pevent)
 		return pevent->latency_format;
 	return 0;
 }
@@ -270,6 +270,6 @@ int tep_is_latency_format(struct tep_handle *pevent)
   */
 void tep_set_latency_format(struct tep_handle *pevent, int lat)
 {
-	if(pevent)
+	if (pevent)
 		pevent->latency_format = lat;
 }
