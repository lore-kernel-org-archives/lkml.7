Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B222C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61B821473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221215;
	bh=7KfnGT/coJMyiDOPKoLWkUgT6yKNTzE9WCOzo5dnzv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EYjD5vWfPZxmBzPqxFq+u2mMhG77xp9ONIOlE58neuA73SD5NpwQVlaNfB7I6RlTS
	 YvMr7TNmaNKf9raoQjNVgnsEjAHAPHLLy0EGyArvCL7PXTUhJFWIp5SdkVVmnfKvmu
	 RD51MYQJxYP3ptTTZkpoabEQliJHCAhmX46uqPCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfDBQGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbfDBQGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:50 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D75D20882;
        Tue,  2 Apr 2019 16:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221210;
        bh=7KfnGT/coJMyiDOPKoLWkUgT6yKNTzE9WCOzo5dnzv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwgtIaTdw6jmTv9n1yXebxcdMwSTT8fRHRlFfkzuAPSu5HoTonMPCxn+jEUQkYPsE
         233sXq7r5g8gqQn+Hf50qGt0R42HSWr++DkPhwf550oxGDMptBULeBgPiO7D3mVavO
         gHSV5XDpjGK6YvPcSuGCHSaTmHtXJ4JfmNJ3wC1s=
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
Subject: [PATCH 15/44] tools lib traceevent: Change description of few APIs
Date:   Tue,  2 Apr 2019 13:05:20 -0300
Message-Id: <20190402160549.13544-16-acme@kernel.org>
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

APIs descriptions should describe the purpose of the function, its
parameters and return value. While working  on man pages implementation,
I noticed mismatches in the  descriptions of few APIs.  This patch
changes the description of these APIs, making them consistent with the
man pages:

 - tep_print_num_field()
 - tep_print_func_field()
 - tep_get_header_page_size()
 - tep_get_long_size()
 - tep_set_long_size()
 - tep_get_page_size()
 - tep_set_page_size()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/linux-trace-devel/20190325145017.30246-2-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190401164343.396759247@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-api.c | 20 ++++++++++----------
 tools/lib/traceevent/event-parse.c     |  6 ++++--
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index d463761a58f4..3686a221e981 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -43,8 +43,8 @@ int tep_get_events_count(struct tep_handle *tep)
  * @flag: flag, or combination of flags to be set
  * can be any combination from enum tep_flag
  *
- * This sets a flag or mbination of flags  from enum tep_flag
-  */
+ * This sets a flag or combination of flags from enum tep_flag
+ */
 void tep_set_flag(struct tep_handle *tep, int flag)
 {
 	if(tep)
@@ -140,10 +140,10 @@ void tep_set_cpus(struct tep_handle *pevent, int cpus)
 }
 
 /**
- * tep_get_long_size - get the size of a long integer on the current machine
+ * tep_get_long_size - get the size of a long integer on the traced machine
  * @pevent: a handle to the tep_handle
  *
- * This returns the size of a long integer on the current machine
+ * This returns the size of a long integer on the traced machine
  * If @pevent is NULL, 0 is returned.
  */
 int tep_get_long_size(struct tep_handle *pevent)
@@ -154,11 +154,11 @@ int tep_get_long_size(struct tep_handle *pevent)
 }
 
 /**
- * tep_set_long_size - set the size of a long integer on the current machine
+ * tep_set_long_size - set the size of a long integer on the traced machine
  * @pevent: a handle to the tep_handle
  * @size: size, in bytes, of a long integer
  *
- * This sets the size of a long integer on the current machine
+ * This sets the size of a long integer on the traced machine
  */
 void tep_set_long_size(struct tep_handle *pevent, int long_size)
 {
@@ -167,10 +167,10 @@ void tep_set_long_size(struct tep_handle *pevent, int long_size)
 }
 
 /**
- * tep_get_page_size - get the size of a memory page on the current machine
+ * tep_get_page_size - get the size of a memory page on the traced machine
  * @pevent: a handle to the tep_handle
  *
- * This returns the size of a memory page on the current machine
+ * This returns the size of a memory page on the traced machine
  * If @pevent is NULL, 0 is returned.
  */
 int tep_get_page_size(struct tep_handle *pevent)
@@ -181,11 +181,11 @@ int tep_get_page_size(struct tep_handle *pevent)
 }
 
 /**
- * tep_set_page_size - set the size of a memory page on the current machine
+ * tep_set_page_size - set the size of a memory page on the traced machine
  * @pevent: a handle to the tep_handle
  * @_page_size: size of a memory page, in bytes
  *
- * This sets the size of a memory page on the current machine
+ * This sets the size of a memory page on the traced machine
  */
 void tep_set_page_size(struct tep_handle *pevent, int _page_size)
 {
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index c00aebab3c33..000ab7514be7 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6453,7 +6453,8 @@ int tep_get_any_field_val(struct trace_seq *s, struct tep_event *event,
  * @record: The record with the field name.
  * @err: print default error if failed.
  *
- * Returns: 0 on success, -1 field not found, or 1 if buffer is full.
+ * Returns positive value on success, negative in case of an error,
+ * or 0 if buffer is full.
  */
 int tep_print_num_field(struct trace_seq *s, const char *fmt,
 			struct tep_event *event, const char *name,
@@ -6485,7 +6486,8 @@ int tep_print_num_field(struct trace_seq *s, const char *fmt,
  * @record: The record with the field name.
  * @err: print default error if failed.
  *
- * Returns: 0 on success, -1 field not found, or 1 if buffer is full.
+ * Returns positive value on success, negative in case of an error,
+ * or 0 if buffer is full.
  */
 int tep_print_func_field(struct trace_seq *s, const char *fmt,
 			 struct tep_event *event, const char *name,
-- 
2.20.1

