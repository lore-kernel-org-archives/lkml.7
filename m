Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0496DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31D2217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfDAQpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfDAQnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:43:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E73B217D4;
        Mon,  1 Apr 2019 16:43:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hB02B-0004ss-Ky; Mon, 01 Apr 2019 12:43:43 -0400
Message-Id: <20190401164343.537086316@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 01 Apr 2019 12:43:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 06/15] tools/lib/traceevent: Coding style fixes
References: <20190401164305.359125441@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

Fixed few coding style problems in event-parse-api.c

Link: http://lore.kernel.org/linux-trace-devel/20190325145017.30246-3-tstoyanov@vmware.com

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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


