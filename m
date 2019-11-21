Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F11C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ED1206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKUNjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:39:03 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:55747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:39:03 -0500
Received: from orion.localdomain ([95.115.120.75]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mi2eP-1huJ2m16AL-00e4qC; Thu, 21 Nov 2019 14:38:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com
Subject: [PATCH] include: linux: ftrace.h: use BIT() macro
Date:   Thu, 21 Nov 2019 14:38:15 +0100
Message-Id: <20191121133815.15040-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:YWHX0B4zLw+p3zuqSV0NxLxGMZb+yVVumbHyPnTn/6hA6A/FLRX
 eehc12fB/IB5/dYFi41Zg2cCCByANCXBJZTY7U7uTRmW8XkDJFLZpnhuO/3nAQz4A6vOIh2
 M0HpE54E+w3BjdNfO9bA1Pt2fNwvUx5JlPfL7LO/XCT/freC/jacfmtAk7mLUSGZk0q76kJ
 V7vXUX1VqbwqeqtPvVtog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Xqp1jn7lO4=:9VwcofcNtvlKNqv5J9JT2a
 zZ+VrmzfJyS91NXRBktEXyNP3x9Vzwkf1HezBx3Pt6hz910IOmbYxxDjCMknF7JNk/yF033tK
 LTFV5qDlGKXR3C9Zcl4axod8TN2g+gNU7W3dvJE9Jqo2T6HFebfDBl1rRtWL0fFas9zyY+KJN
 fXFhDWVJcckvskAeg5r5hXdEF1nEN1zrjntxk/hKpccEnzmLY6WPCEt1Cbrcf2xDx+ZoVH1Hf
 vbZLNrnRfNDR+AL9U1THjk/7akUQuAgU94ixtGJMKfx/19gJNDPwexNceLVz1C8kbbw5XwlfW
 eDeN4pKJQIXeddtKvumlFZSNK95ViJBwJCpQniPJTxSnlFrAoe9gFqndAETIJA1rFlqp5yrWj
 ztqDREW31OJFym7fg5Zo3yOVYkhRmK5TpEL8dQb/OxEs2jxxn+9jfYwjBJE9eqvAbD/RoXm51
 mOKD2f6j5bhDETL0I/icTmchRV1PMVRsqLALR8O8WgP80G0svWdcC41okhrgKD8ZhDXB5Tb4Q
 GG5BfyTX4qCaX8fquHewTW+K6SyIw0dobLz8yfJzWQMKi9WkAE33rT6yNHlLzAnaVSB8I/pJF
 idsvneW9YptEYxF1PXOla3HkRcz2NyWEwi7xTZnUld71oSJirhxKp8gYT9c3Y9bQWrtjAZckt
 x5TDCxCicxopmRtpEuryjjpnO/AeCyvqbeoNLLNI5BE2YbMIdY2m2vaNVqqv/3oIq2un2JLGe
 JW3ChlCK5MkkQHP1QW6qqreFurUQmqoUAGy5d4KLtPvy+94Ser46Is8pG3LTnreZLbFNEqoWQ
 +Inoq9lwr1pmUn/xbncm1pHJ/FtGnU++7AP0TjdH2txmgpdFRdQw3NNm3GzchWEGULf5NCcD9
 nwBhEeC72ykxoA2JJvqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's cleaner to use the BIT() macro instead of raw shift operation.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/linux/ftrace.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8a8cb3c401b2..0a84b4ca3e7c 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -144,22 +144,22 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
  * TRACE_ARRAY - The ops->private points to a trace_array descriptor.
  */
 enum {
-	FTRACE_OPS_FL_ENABLED			= 1 << 0,
-	FTRACE_OPS_FL_DYNAMIC			= 1 << 1,
-	FTRACE_OPS_FL_SAVE_REGS			= 1 << 2,
-	FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED	= 1 << 3,
-	FTRACE_OPS_FL_RECURSION_SAFE		= 1 << 4,
-	FTRACE_OPS_FL_STUB			= 1 << 5,
-	FTRACE_OPS_FL_INITIALIZED		= 1 << 6,
-	FTRACE_OPS_FL_DELETED			= 1 << 7,
-	FTRACE_OPS_FL_ADDING			= 1 << 8,
-	FTRACE_OPS_FL_REMOVING			= 1 << 9,
-	FTRACE_OPS_FL_MODIFYING			= 1 << 10,
-	FTRACE_OPS_FL_ALLOC_TRAMP		= 1 << 11,
-	FTRACE_OPS_FL_IPMODIFY			= 1 << 12,
-	FTRACE_OPS_FL_PID			= 1 << 13,
-	FTRACE_OPS_FL_RCU			= 1 << 14,
-	FTRACE_OPS_FL_TRACE_ARRAY		= 1 << 15,
+	FTRACE_OPS_FL_ENABLED			= BIT(0),
+	FTRACE_OPS_FL_DYNAMIC			= BIT(1),
+	FTRACE_OPS_FL_SAVE_REGS			= BIT(2),
+	FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED	= BIT(3),
+	FTRACE_OPS_FL_RECURSION_SAFE		= BIT(4),
+	FTRACE_OPS_FL_STUB			= BIT(5),
+	FTRACE_OPS_FL_INITIALIZED		= BIT(6),
+	FTRACE_OPS_FL_DELETED			= BIT(7),
+	FTRACE_OPS_FL_ADDING			= BIT(8),
+	FTRACE_OPS_FL_REMOVING			= BIT(9),
+	FTRACE_OPS_FL_MODIFYING			= BIT(10),
+	FTRACE_OPS_FL_ALLOC_TRAMP		= BIT(11),
+	FTRACE_OPS_FL_IPMODIFY			= BIT(12),
+	FTRACE_OPS_FL_PID			= BIT(13),
+	FTRACE_OPS_FL_RCU			= BIT(14),
+	FTRACE_OPS_FL_TRACE_ARRAY		= BIT(15),
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
2.11.0

