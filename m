Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03380C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C003521D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570034660;
	bh=LazMa1pK/qrmw9zIOVMVd3yQMbbcPVe3fHLRtGvw4yo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NxjDES6GeFoJnOb+SVSTSesxJZYqJSP4/CfeB+bIebYIL5KX6Qf+0brDcXcIlUTiU
	 CId+/bq+faC9OTQsqdKrsdQ+ecqqq85Kk831aw90gXFCbGzOn7HRk4pPxt3N4W4EDS
	 3eFVOs02wql5OEUoUMsPhCVe/Vd/tbTqOSVnV6H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfJBQoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfJBQoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:44:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52CC821D81;
        Wed,  2 Oct 2019 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570034658;
        bh=LazMa1pK/qrmw9zIOVMVd3yQMbbcPVe3fHLRtGvw4yo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YBo3ntsWCjSQWgA/9XorDg11ldbCMjS1jo/ahsGpHl1nij+RyVeBbclDlBQZvZz1E
         iiDEfLn2/l1/z89eJyh0mjbRKS+TkkTzc7JmGgn5xF6jLZPHf6bpW4hbsnBmfmjFJv
         DWoPmIZlZ1QnWoss0qs27LW1FDMlOR4nlRTPN9VQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 05/10] ARM: dts: dove: Rename "sa-sram" node to "sram"
Date:   Wed,  2 Oct 2019 18:43:11 +0200
Message-Id: <20191002164316.14905-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002164316.14905-1-krzk@kernel.org>
References: <20191002164316.14905-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node name should reflect generic class of a device so rename
the "sa-sram" node to "sram".  This will be also in sync with upcoming DT
schema.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/dove.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 2e8a3977219f..3081b04e8c08 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -784,7 +784,7 @@
 				status = "disabled";
 			};
 
-			crypto_sram: sa-sram@ffffe000 {
+			crypto_sram: sram@ffffe000 {
 				compatible = "mmio-sram";
 				reg = <0xffffe000 0x800>;
 				clocks = <&gate_clk 15>;
-- 
2.17.1

