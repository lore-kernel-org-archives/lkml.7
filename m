Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D06C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94529205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfE2NIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:08:05 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50026 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbfE2NIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:08:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TSxw1ro_1559135277;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0TSxw1ro_1559135277)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 May 2019 21:07:57 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        laoar.shao@gmail.com, songliubraving@fb.com
Subject: [PATCH net-next 3/3] tcp: remove redundant new line from tcp_event_sk_skb
Date:   Wed, 29 May 2019 21:06:57 +0800
Message-Id: <20190529130656.23979-4-tonylu@linux.alibaba.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529130656.23979-1-tonylu@linux.alibaba.com>
References: <20190529130656.23979-1-tonylu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes '\n' from trace event class tcp_event_sk_skb to avoid
redundant new blank line and make output compact.

Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
---
 include/trace/events/tcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 2bc9960a31aa..cf97f6339acb 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -86,7 +86,7 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
 			      sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
 	),
 
-	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s\n",
+	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
 		  __entry->sport, __entry->dport, __entry->saddr, __entry->daddr,
 		  __entry->saddr_v6, __entry->daddr_v6,
 		  show_tcp_state_name(__entry->state))
-- 
2.21.0

