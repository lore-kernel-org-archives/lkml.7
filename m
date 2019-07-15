Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC7DC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D458A20693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WkSxcw7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbfGOVkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:40:36 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:34574 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732540AbfGOVkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563226822; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8E40KY2beyOGUeXo3Pc5VtaYHQ9RQJpjOfirkoUufqU=;
        b=WkSxcw7H2EeVxgzYpRhP4paD9RCjkFv30PFANldAF2dKcu51enAWCRhpAcopF/ls6d3oZd
        D3jjiczhC8Oq+VyV5OA6C4/XQh/Jqkg+3C2j+0GNwkWxecjrUvDkpuhyQzZszD3j6iS/PF
        101W2aec3Cl9J+L1UH+Ijwm2c+3j6Uk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/5] MIPS: ingenic: Add support for huge pages
Date:   Mon, 15 Jul 2019 17:40:02 -0400
Message-Id: <20190715214003.9714-4-paul@crapouillou.net>
In-Reply-To: <20190715214003.9714-1-paul@crapouillou.net>
References: <20190715214003.9714-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Silsby <dansilsby@gmail.com>

The Ingenic jz47xx SoC series of 32-bit MIPS CPUs support huge pages.

Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 47d50e37faa4..2a5d80c72c4e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -384,6 +384,7 @@ config MACH_INGENIC
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_ZBOOT_UART16550
+	select CPU_SUPPORTS_HUGEPAGES
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
 	select PINCTRL
-- 
2.21.0.593.g511ec345e18

