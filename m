Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39642C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1184121019
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfCENxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbfCENwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:52:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF89A21019;
        Tue,  5 Mar 2019 13:52:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h1AUw-0002zm-27; Tue, 05 Mar 2019 08:52:46 -0500
Message-Id: <20190305135245.954711317@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 05 Mar 2019 08:52:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        KAUSTUBH RAJENDRA WELANKAR 
        <f20160095@hyderabad.bits-pilani.ac.in>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [for-next][PATCH 2/6] doc: trace: Fix documentation for uprobe_profile
References: <20190305135223.360347148@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

uprobe_profile has filename and number of probe hits information for
each uprobe event. The documentation erroneously talks about probe
mis-hits. Update the documentation to the correct information.

Link: http://lkml.kernel.org/r/1550557168-12345-1-git-send-email-srikar@linux.vnet.ibm.com

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: KAUSTUBH RAJENDRA WELANKAR <f20160095@hyderabad.bits-pilani.ac.in>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/uprobetracer.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index 4c3bfde2ba47..4346e23e3ae7 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -73,10 +73,9 @@ For $comm, the default type is "string"; any other type is invalid.
 
 Event Profiling
 ---------------
-You can check the total number of probe hits and probe miss-hits via
-/sys/kernel/debug/tracing/uprobe_profile.
-The first column is event name, the second is the number of probe hits,
-the third is the number of probe miss-hits.
+You can check the total number of probe hits per event via
+/sys/kernel/debug/tracing/uprobe_profile. The first column is the filename,
+the second is the event name, the third is the number of probe hits.
 
 Usage examples
 --------------
-- 
2.20.1


