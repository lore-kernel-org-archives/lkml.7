Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E277CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F53D20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450774;
	bh=8XL0N7+8Yry6975/n+5Oi9lcE2269yYZhshaCS8uCWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R5pobG7fWbttNbyziuOka3goHhcK8OFRKHTgf0XOgO+kjwwaakNKpR4XVxZHqbhrA
	 2Qq8eDA8wQftAw/yuhC8tJ4b+8tDVFZUa9jI3Df4LabiLAIJHRwZMGA1RwZNMPOg3S
	 I8NwmEc9EU7z8hoiw6XPUGF9Jr7MEwR7r6R+6y7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfJ3Pww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbfJ3Pwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:52:46 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0323C20874;
        Wed, 30 Oct 2019 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450766;
        bh=8XL0N7+8Yry6975/n+5Oi9lcE2269yYZhshaCS8uCWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYuIAct1POwBmWqZUL2owfwEuFBMQr0psCvC0HiZsS3c33NdPGK5CxonY9tSYq2Xy
         slUwqAhlB7N8/c6f54EQ55apG0TL/oS+UkMdcNxFdmSjmwnF6zbvgIekt5jw6R9nK+
         /wqyf9wMUx6v1b0lrjXluhRuSD6ZouUAsrxx8mHg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anson Huang <Anson.Huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 46/81] ARM: dts: imx7s: Correct GPT's ipg clock source
Date:   Wed, 30 Oct 2019 11:48:52 -0400
Message-Id: <20191030154928.9432-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 252b9e21bcf46b0d16f733f2e42b21fdc60addee ]

i.MX7S/D's GPT ipg clock should be from GPT clock root and
controlled by CCM's GPT CCGR, using correct clock source for
GPT ipg clock instead of IMX7D_CLK_DUMMY.

Fixes: 3ef79ca6bd1d ("ARM: dts: imx7d: use imx7s.dtsi as base device tree")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index c1a4fff5ceda9..6323a9462afa9 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -448,7 +448,7 @@
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x302d0000 0x10000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_CLK_DUMMY>,
+				clocks = <&clks IMX7D_GPT1_ROOT_CLK>,
 					 <&clks IMX7D_GPT1_ROOT_CLK>;
 				clock-names = "ipg", "per";
 			};
@@ -457,7 +457,7 @@
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x302e0000 0x10000>;
 				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_CLK_DUMMY>,
+				clocks = <&clks IMX7D_GPT2_ROOT_CLK>,
 					 <&clks IMX7D_GPT2_ROOT_CLK>;
 				clock-names = "ipg", "per";
 				status = "disabled";
@@ -467,7 +467,7 @@
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x302f0000 0x10000>;
 				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_CLK_DUMMY>,
+				clocks = <&clks IMX7D_GPT3_ROOT_CLK>,
 					 <&clks IMX7D_GPT3_ROOT_CLK>;
 				clock-names = "ipg", "per";
 				status = "disabled";
@@ -477,7 +477,7 @@
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x30300000 0x10000>;
 				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_CLK_DUMMY>,
+				clocks = <&clks IMX7D_GPT4_ROOT_CLK>,
 					 <&clks IMX7D_GPT4_ROOT_CLK>;
 				clock-names = "ipg", "per";
 				status = "disabled";
-- 
2.20.1

