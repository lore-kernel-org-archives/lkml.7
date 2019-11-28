Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE120C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9292120880
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B7oUa/oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfK1Wmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:42:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfK1Wmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 17:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YWU+2cL1a8V7zdnD6YoB1Y5aa4SlJGwwOBC43F4kcpk=; b=B7oUa/oy07Rxb6l4GSyDKkke8
        nYDX7KYQgQquj8NbVkCT6qjBpdOaYkoUsO6+s4RThCUtsyP8Wjd0do7Nnh8n6SClZSYV3E97S8nmy
        fmnfIhgWmfyTel5C2A52/qmjEeamSFVk8D+/So4kupvHq/S4SK0lpb7qGLdKH4Sbaz4Vp6i81grxh
        jY/zTTq7x5kL5CWQMiUNTAiF61HaD9PNpMNm7tvAwZLFak25HhpafNjBcujjEsEkVqXBmDsViwSob
        YxEZwxESxaWN06jZ+MAgrlr5f0wIu4jcl1PTEppfcsIXnSGIyhbNqws2uU9mClhyEVk7h5pDB+M9i
        KdmjlaAmg==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaSUY-0000hU-2r; Thu, 28 Nov 2019 22:42:30 +0000
To:     LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] irqchip: cleanup Kconfig help text
Message-ID: <ca14f757-f191-62a0-b896-6b3ba0f9d168@infradead.org>
Date:   Thu, 28 Nov 2019 14:42:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fixes to Kconfig help text:

- spell out "hardware"
- fix verb usage

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
---
 drivers/irqchip/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-54.orig/drivers/irqchip/Kconfig
+++ lnx-54/drivers/irqchip/Kconfig
@@ -434,7 +434,7 @@ config CSKY_MPINTC
 	help
 	  Say yes here to enable C-SKY SMP interrupt controller driver used
 	  for C-SKY SMP system.
-	  In fact it's not mmio map in hw and it use ld/st to visit the
+	  In fact it's not mmio map in hardware and it uses ld/st to visit the
 	  controller's register inside CPU.
 
 config CSKY_APB_INTC
@@ -442,7 +442,7 @@ config CSKY_APB_INTC
 	depends on CSKY
 	help
 	  Say yes here to enable C-SKY APB interrupt controller driver used
-	  by C-SKY single core SOC system. It use mmio map apb-bus to visit
+	  by C-SKY single core SOC system. It uses mmio map apb-bus to visit
 	  the controller's register.
 
 config IMX_IRQSTEER

