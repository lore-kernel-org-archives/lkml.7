Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C389C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5801821925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKKOTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:19:53 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56292 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbfKKOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:19:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ThoSgfC_1573481985;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0ThoSgfC_1573481985)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Nov 2019 22:19:45 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     sanagi.koki@jp.fujitsu.co, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: add missing semicolon in net_dev_template
Date:   Mon, 11 Nov 2019 22:17:53 +0800
Message-Id: <20191111141752.31655-1-tonylu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing semicolon in the end of net_dev_template.

Fixes: cf66ba58b5cb ("netdev: Add tracepoints to netdev layer")
Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
---
 include/trace/events/net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index 2399073c3afc..3b28843652d2 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -138,7 +138,7 @@ DECLARE_EVENT_CLASS(net_dev_template,
 
 	TP_printk("dev=%s skbaddr=%p len=%u",
 		__get_str(name), __entry->skbaddr, __entry->len)
-)
+);
 
 DEFINE_EVENT(net_dev_template, net_dev_queue,
 
-- 
2.24.0

