Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A613C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F6E2147C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221218;
	bh=MDT8Ft2kdxHC3/lJGbIRoG5ao6SMeMEX0aii4dXbXi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AXaDBfz6ahNsPfk5bFJM34XenM3WQBt+d+aMmMjdc/SYQfs8lzYEeuY9AqHSUpDMm
	 EPDZZ9vlE/Ujh3rmN7Wk9eMhoRRbcwJaKcMB6eCRUiv28Rp9FLnOjDqxntRzZtDu3R
	 pPahls+1d/sQXxK0eV99Glp7neSoA9auWPz1WQsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfDBQG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbfDBQGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:54 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9925D2147A;
        Tue,  2 Apr 2019 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221213;
        bh=MDT8Ft2kdxHC3/lJGbIRoG5ao6SMeMEX0aii4dXbXi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfKxeikRIeA97Q7EYj0TOu88DQZX0njDUKsw1cnG1ybwhTGg1B3VhJmK1Qbk7f9ye
         ae9Ro1p1WK3Bn8g5e0k08Bgf7txE577kddli6S5CoveFCvyCEH7EaQTq1yllCaLYCr
         /VV2huhVDYrxAmyXPSgTL409cnqAfNBXBhEdUjzo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/44] tools lib traceevent: Coding style fixes
Date:   Tue,  2 Apr 2019 13:05:21 -0300
Message-Id: <20190402160549.13544-17-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

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
 tools/lib/traceevent/event-parse-api.c | 30 +++++++++++++-------------
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
-- 
2.20.1

