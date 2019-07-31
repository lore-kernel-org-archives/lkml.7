Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B27EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BB0208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="p1ALaFPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfGaAUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 20:20:48 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7295 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfGaAUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:20:44 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d40dee30002>; Tue, 30 Jul 2019 17:20:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jul 2019 17:20:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jul 2019 17:20:43 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 00:20:33 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 00:20:33 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.107]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d40ded00006>; Tue, 30 Jul 2019 17:20:32 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v7 19/20] arm64: dts: tegra210-p2180: Jetson TX1 SC7 timings
Date:   Tue, 30 Jul 2019 17:20:23 -0700
Message-ID: <1564532424-10449-20-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564532424-10449-1-git-send-email-skomatineni@nvidia.com>
References: <1564532424-10449-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564532451; bh=3ikE8x0cNN1fPtdTTddMKObVTKhfyEJPwIrj8ksa4Wg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=p1ALaFPAAQMGl6+AEivmi04/AsSwXmolLSxfsGnYkCLbf6rzVicjD/pwYlCZwpgr5
         qRlVR5osIhY3nSDwV6iQyS/xDU+IGRnDvtNa9WRxLkIzEqsr6XGtJn2rQsEIdfpmxZ
         Dmd+luCoD0H8GLk2QIh8sn6Ocdbi3vos0SiMt0z94GG89/+PcQEA/6Io0Dm0cwm/Jt
         z8+8lcacLFoNuVJmEUXbBm2BDbSYEAteukH8b7AjeJzNnrciAwvkRt1lxpmP7BCFwG
         bEYqT9dyrccTHbbnfWFW3tmPMmJvRK1f3zP/3QLvg0FjpPKH4LuQ+HVXSiLmJQ3G1y
         pTN4ZS2iKFuhw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has Jetson TX1 platform specific SC7 timing configuration
in device tree.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 27723829d033..cb58f79deb48 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -279,6 +279,13 @@
 
 	pmc@7000e400 {
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <0>;
+		nvidia,cpu-pwr-good-time = <0>;
+		nvidia,cpu-pwr-off-time = <0>;
+		nvidia,core-pwr-good-time = <4587 3876>;
+		nvidia,core-pwr-off-time = <39065>;
+		nvidia,core-power-req-active-high;
+		nvidia,sys-clock-req-active-high;
 	};
 
 	/* eMMC */
-- 
2.7.4

