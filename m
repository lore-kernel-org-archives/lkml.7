Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B59FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7745321848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214456;
	bh=DPTSHDoRdJEoqWbw2URfzbzEk9FVmflOw3BWvsUFfjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z+NCC7182E+7hQZbkLQQ7ohZ3TDBpiVAXmFk3f8eajiZWmCnadQ3zgp7ocA57OI89
	 UDlle0YvSMcVfS6XTEMkLD7QFgc4qlUfc1XdMeWb3/rNFNVXRh7UsRbd3/75GjERIp
	 6c2C2KP1N+UROUS2k8Ei9jMU42VxiEut6HLBIim4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbfKHLnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390438AbfKHLnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D874222C6;
        Fri,  8 Nov 2019 11:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213404;
        bh=DPTSHDoRdJEoqWbw2URfzbzEk9FVmflOw3BWvsUFfjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWNU9cWQYD74PCEChod5zTjGeiZMApaaMs8ZbDNwo6f3v+nlLRT3wIgrNpTaD5TD2
         WqmjA3t5qMyXYXTlrpCSomWZY+L/JL8fPiyawIGVjvUg0bvEo0kbdB1FKzTHguiWZ+
         dJb4kjMTlqaarjxReKZEvD713GUP5tKKZ791g2sA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jay Foster <jayfoster@ieee.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 009/103] ARM: dts: at91/trivial: Fix USART1 definition for at91sam9g45
Date:   Fri,  8 Nov 2019 06:41:34 -0500
Message-Id: <20191108114310.14363-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 64fa3f9a39d33..db0921e7a6138 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -566,7 +566,7 @@
 					};
 				};
 
-				uart1 {
+				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
 							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB4 periph A with pullup */
-- 
2.20.1

