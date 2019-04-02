Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7337BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4268B21738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221225;
	bh=dq0RPrxfimD2TyMdn6Bh/ySgOU18v6hxOW/kfBlPYCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mblUXSD21BfsTnUZK+cgm1nuhLvsewPr6RFRwR+BnwIk8AxgWS52LxACYj5JXkg9y
	 xr9LUlCitfFId4f0j+zV+laX3EHqiVLUzOmHrjrj4zh0ATMevxahC7TV/yVgD1FLnN
	 CUvACFmfbYlpkpmT9S2s0IyxKy3bmVALF3ScxeYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfDBQHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731198AbfDBQHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:01 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FCF92133D;
        Tue,  2 Apr 2019 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221220;
        bh=dq0RPrxfimD2TyMdn6Bh/ySgOU18v6hxOW/kfBlPYCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2ZyGaXj6zO9WUZJVIRUvT9XxdFn3Wgha+V/QMTAQtl801GsodS5pjJK3P1k9OF/E
         mM36LyTAHZdS3nzL/QgsP+xGYDGl3mhXgELwbWIoqiG8R2dKX1PKD5XdqIVzZk6+FC
         9MciAtUFvataSocw62BWcK7M/IACM0VLMNxFesqk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/44] tools lib traceevent: Removed unneeded !! and return parenthesis
Date:   Tue,  2 Apr 2019 13:05:23 -0300
Message-Id: <20190402160549.13544-19-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As return is not a function we do not need parenthesis around the return
value. Also, a function returning bool does not need to add !!.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20190401164343.817886725@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index 2ac8b44854ce..002b3f73862b 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -88,7 +88,7 @@ void tep_clear_flag(struct tep_handle *tep, enum tep_flag flag)
 bool tep_test_flag(struct tep_handle *tep, enum tep_flag flag)
 {
 	if (tep)
-		return (tep->flags & flag);
+		return tep->flags & flag;
 	return false;
 }
 
@@ -340,7 +340,7 @@ void tep_set_latency_format(struct tep_handle *pevent, int lat)
 bool tep_is_old_format(struct tep_handle *tep)
 {
 	if (tep)
-		return !!(tep->old_format);
+		return tep->old_format;
 	return false;
 }
 
-- 
2.20.1

