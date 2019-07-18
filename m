Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFADBC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A0C2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfGRCPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:15:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47248 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727787AbfGRCPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:15:08 -0400
X-IronPort-AV: E=Sophos;i="5.64,276,1559491200"; 
   d="scan'208";a="71677718"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Jul 2019 10:15:05 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id CAEE14B40405;
        Thu, 18 Jul 2019 10:15:00 +0800 (CST)
Received: from localhost.localdomain (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 18 Jul 2019 10:15:07 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Su Yanjun <suyj.fnst@cn.fujitsu.com>
Subject: [PATCH] udp: Fix typo in udpv4/p.c
Date:   Thu, 18 Jul 2019 10:13:37 +0800
Message-ID: <1563416017-6193-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: CAEE14B40405.ABB3E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
 net/ipv4/udp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c21862b..d88821c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2170,7 +2170,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 
 /* Initialize UDP checksum. If exited with zero value (success),
  * CHECKSUM_UNNECESSARY means, that no more checks are required.
- * Otherwise, csum completion requires chacksumming packet body,
+ * Otherwise, csum completion requires checksumming packet body,
  * including udp header and folding it to skb->csum.
  */
 static inline int udp4_csum_init(struct sk_buff *skb, struct udphdr *uh,
-- 
2.7.4



