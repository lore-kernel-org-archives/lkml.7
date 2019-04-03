Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAA7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3CE20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCJPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:15:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfDCJPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:15:38 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [10.3.19.201])
        by Forcepoint Email with ESMTP id 4DE6C384C15DCBDE2291;
        Wed,  3 Apr 2019 17:15:36 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 17:15:28 +0800
From:   linmiaohe <linmiaohe@huawei.com>
Subject: [PATCH net] trival: net: skbuff: fix comment in skbuff.h
To:     David Miller <davem@davemloft.net>, <willemb@google.com>,
        <fw@strlen.de>, <edumazet@google.com>, <pabeni@redhat.com>,
        <pctammela@gmail.com>, <deepa.kernel@gmail.com>,
        <sbrivio@redhat.com>, <mirq-linux@rere.qmqm.pl>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
Message-ID: <625895cf-f9aa-cb8b-effc-556f6ae70464@huawei.com>
Date:   Wed, 3 Apr 2019 17:15:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

It should be IPv6|UDP instead of IPv4|UDP for NETIF_F_IPV6_CSUM

Signed-off-by: linmiaohe <linmiaohe@huawei.com>
---
 include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 69b5538adcea..9683e00a5a79 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -71,7 +71,7 @@
  *     NETIF_F_IPV6_CSUM - Driver (device) is only able to checksum plain
  *                       TCP or UDP packets over IPv6. These are specifically
  *                       unencapsulated packets of the form IPv6|TCP or
- *                       IPv4|UDP where the Next Header field in the IPv6
+ *                       IPv6|UDP where the Next Header field in the IPv6
  *                       header is either TCP or UDP. IPv6 extension headers
  *                       are not supported with this feature. This feature
  *                       cannot be set in features for a device with
-- 
2.19.1



.


