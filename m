Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF04C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10B120835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555604296;
	bh=Rlbl3BnfpKeCN6orz47nZ573e9nCGAHXEhUEGsPSrqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WesH425PDIwKhrdp67NQkVhkiIj8R+N70DBJ1h4Y0tlDm86hmlvyRQHKrMTsQv8MW
	 7xr28m5Z7f01U3CP5PWURNyyNyPQLrAC2CcoU2xJiaFo73WW7dBze20kr89/D2/zey
	 e6612vXIK6nS8ZWlA1F2wTzdV4J7ZgvdrORJAq9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389698AbfDRQSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:18:14 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34386 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbfDRQSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:18:07 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 59FDE60292; Fri, 19 Apr 2019 00:18:05 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: allwinner: axp803: add USB power supply node
Date:   Fri, 19 Apr 2019 00:18:03 +0800
Message-Id: <20190418161804.17723-3-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418161804.17723-1-wens@kernel.org>
References: <20190418161804.17723-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The AXP803 has a VBUS power input. Add a device node for it,
now that we support it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index c3a618e1279a..f0349ef4bfdd 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -185,4 +185,10 @@
 			status = "disabled";
 		};
 	};
+
+	usb_power_supply: usb-power-supply {
+		compatible = "x-powers,axp803-usb-power-supply",
+			     "x-powers,axp813-usb-power-supply";
+		status = "disabled";
+	};
 };
-- 
2.20.1

