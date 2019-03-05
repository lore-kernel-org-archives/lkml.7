Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49321C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1112133F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfCENws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:52:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbfCENwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:52:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B11A52087C;
        Tue,  5 Mar 2019 13:52:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h1AUv-0002zI-TB; Tue, 05 Mar 2019 08:52:45 -0500
Message-Id: <20190305135245.741516353@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 05 Mar 2019 08:52:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-next][PATCH 1/6] tracing: Fix spelling mistake: "analagous" -> "analogous"
References: <20190305135223.360347148@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the mini-howto help text. Fix it.

Link: http://lkml.kernel.org/r/20190217223222.16479-1-colin.king@canonical.com

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2cf3c747a357..3835f7ed3293 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4916,7 +4916,7 @@ static const char readme_msg[] =
 	"\t    unchanged.\n\n"
 	"\t    The enable_hist and disable_hist triggers can be used to\n"
 	"\t    have one event conditionally start and stop another event's\n"
-	"\t    already-attached hist trigger.  The syntax is analagous to\n"
+	"\t    already-attached hist trigger.  The syntax is analogous to\n"
 	"\t    the enable_event and disable_event triggers.\n\n"
 	"\t    Hist trigger handlers and actions are executed whenever a\n"
 	"\t    a histogram entry is added or updated.  They take the form:\n\n"
-- 
2.20.1


