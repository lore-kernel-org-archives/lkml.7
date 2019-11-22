Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58691C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D28E2071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419175;
	bh=N18+N6OlaSTcc9dJRJHr9msZMDgvNfCMsLX146+55ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z649d0a6FwiSATUT80iIfw5+5/2aiOEZcgmju7e3TK83vInNE8NzX5oX2mP0OYfdS
	 GpI8LYIgmf2yJKy6Zs4g/kCnFTEFwUO1D39G1jzpHFSh/wUNxR4ZZRP2sSogBuU6ME
	 vYCgxp4gK1iEZsCx4krKtJp30Ty0t03LTA6QIFG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfKVKje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfKVKj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:39:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759D820715;
        Fri, 22 Nov 2019 10:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419168;
        bh=N18+N6OlaSTcc9dJRJHr9msZMDgvNfCMsLX146+55ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qH3AS8Nn0n8eBJVdo9z58ht4VY4rqfQnZOFwKtiKhv7D0zVDRrVGxm1LkISup9xOv
         Paip5lenKbOn/QGrUblPyO8NbCLZHaYH0lAlU4XS8pPxOxDq3KDQ9puvjzo8VmkSQP
         4Ao6TCrAShVU4hpyQMF5FWIOAFxiJ2ZJx8Wo+b8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jay Foster <jayfoster@ieee.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 020/222] ARM: dts: at91/trivial: Fix USART1 definition for at91sam9g45
Date:   Fri, 22 Nov 2019 11:26:00 +0100
Message-Id: <20191122100836.674677209@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Foster <jayfoster@ieee.org>

[ Upstream commit 10af10db8c76fa5b9bf1f52a895c1cb2c0ac24da ]

Fix a typo. No functional change made by this patch.

Signed-off-by: Jay Foster <jayfoster@ieee.org>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index b3501ae2a3bd1..4fba898b8f4f9 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -546,7 +546,7 @@
 					};
 				};
 
-				uart1 {
+				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
 							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB4 periph A with pullup */
-- 
2.20.1



