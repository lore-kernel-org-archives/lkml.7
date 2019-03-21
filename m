Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3551C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB21218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfCUPrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:47:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:47:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LFkIM8189311
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 08:46:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LFkHVI189308;
        Thu, 21 Mar 2019 08:46:17 -0700
Date:   Thu, 21 Mar 2019 08:46:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-f27b744baaa646a7c0a01443cc0d8b4787cac2f7@git.kernel.org>
Cc:     hpa@zytor.com, marc.zyngier@arm.com, yuehaibing@huawei.com,
        andrew@lunn.ch, mingo@kernel.org, sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
        jason@lakedaemon.net
Reply-To: yuehaibing@huawei.com, marc.zyngier@arm.com,
          gregory.clement@bootlin.com, andrew@lunn.ch,
          jason@lakedaemon.net, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          linux-arm-kernel@lists.infradead.org, mingo@kernel.org,
          sebastian.hesselbarth@gmail.com
In-Reply-To: <20190321151448.15600-1-yuehaibing@huawei.com>
References: <20190321151448.15600-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/irq-mvebu-sei: Make mvebu_sei_ap806_caps
 static
Git-Commit-ID: f27b744baaa646a7c0a01443cc0d8b4787cac2f7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f27b744baaa646a7c0a01443cc0d8b4787cac2f7
Gitweb:     https://git.kernel.org/tip/f27b744baaa646a7c0a01443cc0d8b4787cac2f7
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Thu, 21 Mar 2019 23:14:48 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 16:43:00 +0100

irqchip/irq-mvebu-sei: Make mvebu_sei_ap806_caps static

Fix sparse warning:

drivers/irqchip/irq-mvebu-sei.c:481:23: warning:
 symbol 'mvebu_sei_ap806_caps' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <jason@lakedaemon.net>
Cc: <andrew@lunn.ch>
Cc: <gregory.clement@bootlin.com>
Cc: <sebastian.hesselbarth@gmail.com>
Cc: <marc.zyngier@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Link: https://lkml.kernel.org/r/20190321151448.15600-1-yuehaibing@huawei.com

---
 drivers/irqchip/irq-mvebu-sei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index add4c9c934c8..18832ccc8ff8 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -478,7 +478,7 @@ dispose_irq:
 	return ret;
 }
 
-struct mvebu_sei_caps mvebu_sei_ap806_caps = {
+static struct mvebu_sei_caps mvebu_sei_ap806_caps = {
 	.ap_range = {
 		.first = 0,
 		.size = 21,
