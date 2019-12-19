Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD67C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532902465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781077;
	bh=V2jUsRlq3Dv+MZnM3Ro+bAzdwMYFMhTFt8fR+Zou3Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NVbLk89/XpSgPIGOBzzekOL02IaaRWcwsZKjPCGWjAXoM+NVM2DiiMGTmwOwb635K
	 RYU0s4QEsQpvtAhSq2U3mNiQPwstaXOyorQagkNuqHS178hgKbJnGhZEDFSox19LfM
	 QrqAYdH2eiG9UPgwJwysYrxxgTwGAA17NtwKv6ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfLSSog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbfLSSod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:44:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A078224672;
        Thu, 19 Dec 2019 18:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781073;
        bh=V2jUsRlq3Dv+MZnM3Ro+bAzdwMYFMhTFt8fR+Zou3Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJI3eskGr1yI6sogbqMGPcgDpbhtSURXNFtkeTaZp8fSmOPRrhjrL6dUvbNKn3sRa
         6KqNLvxu58XEpD3hCP3xw1qwFQ/R/D8fP4l+cXDO7ucxaWs3UK2zrPbnRne9xnf7H4
         Jik6chEhmt1yUECeOQsHfSI311bstsc+7rM8/hVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 070/199] ARM: dts: sunxi: Fix PMU compatible strings
Date:   Thu, 19 Dec 2019 19:32:32 +0100
Message-Id: <20191219183218.866619677@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 5719ac19fc32d892434939c1756c2f9a8322e6ef ]

"arm,cortex-a15-pmu" is not a valid fallback compatible string for an
Cortex-A7 PMU, so drop it.

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index ce1960453a0bb..3bfa79717dfab 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -174,7 +174,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
+		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 94cf5a1c71723..db5d30598ad66 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -172,7 +172,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
+		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 	};
-- 
2.20.1



