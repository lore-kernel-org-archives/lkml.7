Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A0DC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E75B21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934045;
	bh=KY1pTVSVOlB8zydh/WnqEu8LohWlLxvY35Ylhs8yDY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H9GfmgHVa1AfuumYgZQqKAYn9YRqiFHT8LNn+d+9ugWlLPAiXyUA/pCZ+lYwdtOIe
	 bjZc21FOXpfu+DA3e4zRuFq54B3hiG/ZUpANrs7YlOUXbcLvl3OuRoCnHHR+oeAIOZ
	 gIG8CqUkP1R4yU2Oc/V5oshFSDW2zXMxOCzvBwmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfGLMUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfGLMUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:20:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD181208E4;
        Fri, 12 Jul 2019 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934039;
        bh=KY1pTVSVOlB8zydh/WnqEu8LohWlLxvY35Ylhs8yDY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xuf6JsflccgjY9FeXizuWI4QZqJHpb4DFhe9KxUi2AQPlYQUgLo+JxAELHT/Xdupl
         0ZJtaAQaqtg2CIL6bohAZu7MTRim9tk/J+C5eY9PmB2js5RhvKON5G3nC6bqTMc/76
         p/0WVPBNFpQpchdWdlrlTZz+64/xqOcjKlXs6E5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Teresa Remmet <t.remmet@phytec.de>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 26/91] ARM: dts: am335x phytec boards: Fix cd-gpios active level
Date:   Fri, 12 Jul 2019 14:18:29 +0200
Message-Id: <20190712121622.803758252@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8a0098c05a272c9a68f6885e09755755b612459c ]

Active level of the mmc1 cd gpio needs to be low instead of high.
Fix PCM-953 and phyBOARD-WEGA.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-pcm-953.dtsi | 2 +-
 arch/arm/boot/dts/am335x-wega.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-pcm-953.dtsi b/arch/arm/boot/dts/am335x-pcm-953.dtsi
index 1ec8e0d80191..572fbd254690 100644
--- a/arch/arm/boot/dts/am335x-pcm-953.dtsi
+++ b/arch/arm/boot/dts/am335x-pcm-953.dtsi
@@ -197,7 +197,7 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 8ce541739b24..83e4fe595e37 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -157,7 +157,7 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.20.1



