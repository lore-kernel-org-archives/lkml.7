Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF03CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD4120656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240976;
	bh=G/onHIpcO3h97TEJ7qui0iEg3XF5Ui989sFBSybWCAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wMkyI2U2BrbSH1hFuAraFzEV0TlJVq80RSh6JCqDNByfW72b/JOD40Oy3JqlxkO/W
	 AoZ6TVvulnfoXRyTpPw+EjZ5qgPvpPoKt9sDavNQLEOQeNU8XUaUgUhOJQsQb3N8mZ
	 XG4w974KSG3tIid+DUeLPV/eeJd2g6jdEmClbv9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390774AbfKHTWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:22:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfKHSz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:55:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DEC21D7F;
        Fri,  8 Nov 2019 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239327;
        bh=G/onHIpcO3h97TEJ7qui0iEg3XF5Ui989sFBSybWCAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YiPsnEcHHrAHKks06cvh6lzsEANRNTQQ9xJDZNxySTw+AloJPLN7NL4Cn3oUBHZPM
         QB/NNm+7re09RLf2e2cN11RAP8ByO4LbPOB1x33qRv4Bsv+NIqj8hqesfd7+cxf5DU
         s6yVYvvLt4HOIPoBmbKZIPDJ3KiEiA3ehQFUanqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, Ard Biesheuvel" 
        <ardb@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "David A. Long" <dave.long@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 40/75] ARM: add more CPU part numbers for Cortex and Brahma B15 CPUs
Date:   Fri,  8 Nov 2019 19:49:57 +0100
Message-Id: <20191108174748.298689915@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit f5683e76f35b4ec5891031b6a29036efe0a1ff84 upstream.

Add CPU part numbers for Cortex A53, A57, A72, A73, A75 and the
Broadcom Brahma B15 CPU.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/cputype.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -74,8 +74,16 @@
 #define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
 #define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
 #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
+#define ARM_CPU_PART_CORTEX_A53		0x4100d030
+#define ARM_CPU_PART_CORTEX_A57		0x4100d070
+#define ARM_CPU_PART_CORTEX_A72		0x4100d080
+#define ARM_CPU_PART_CORTEX_A73		0x4100d090
+#define ARM_CPU_PART_CORTEX_A75		0x4100d0a0
 #define ARM_CPU_PART_MASK		0xff00fff0
 
+/* Broadcom cores */
+#define ARM_CPU_PART_BRAHMA_B15		0x420000f0
+
 #define ARM_CPU_XSCALE_ARCH_MASK	0xe000
 #define ARM_CPU_XSCALE_ARCH_V1		0x2000
 #define ARM_CPU_XSCALE_ARCH_V2		0x4000


