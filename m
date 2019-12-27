Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A8C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C95206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469266;
	bh=HbygnXdb9+pNdvN77EkwyXpwBKKeuf9al5hOlxjXzp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f47SgjDmvwIRXof4JHsfQZ6x8CJq1D+FyguVYhGOtg3tu7psmMntaY4w5VnO0ZZxA
	 5rT7yccosXTc1PoS8G84v4E+3lc46nq0kGqcdOex4ScQKjXdHF377zyVTiPz0rXTpN
	 HZqIeekfAOB7FkOEgew1iS9Da022csAwkKfUjhy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfL0RyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:54:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbfL0Rmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB8721744;
        Fri, 27 Dec 2019 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468556;
        bh=HbygnXdb9+pNdvN77EkwyXpwBKKeuf9al5hOlxjXzp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbDGCuyYvvUim1J9xzF+IMceAMXxQ8F+5IM89wbutNCx3kJIoHOeMGQl5SdXg7Fuz
         ODWPkbZropg584sA7ECQ1hZ4douOI39vEXHBgMMj15gyqaREUBiqWxbw9RRLWuy5GO
         W95bLPBID99dE/EHGpRECJmAgAg5ziS4f1t23/ns=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Walle <michael@walle.cc>, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 082/187] arm64: dts: ls1028a: fix reboot node
Date:   Fri, 27 Dec 2019 12:39:10 -0500
Message-Id: <20191227174055.4923-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

[ Upstream commit 3f0fb37b22b460e3dec62bee284932881574acb9 ]

The reboot register isn't located inside the DCFG controller, but in its
own RST controller. Fix it.

Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index c7dae9ec17da..bb960fe2bb64 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -102,7 +102,7 @@
 
 	reboot {
 		compatible ="syscon-reboot";
-		regmap = <&dcfg>;
+		regmap = <&rst>;
 		offset = <0xb0>;
 		mask = <0x02>;
 	};
@@ -161,6 +161,12 @@
 			big-endian;
 		};
 
+		rst: syscon@1e60000 {
+			compatible = "syscon";
+			reg = <0x0 0x1e60000 0x0 0x10000>;
+			little-endian;
+		};
+
 		scfg: syscon@1fc0000 {
 			compatible = "fsl,ls1028a-scfg", "syscon";
 			reg = <0x0 0x1fc0000 0x0 0x10000>;
-- 
2.20.1

