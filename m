Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B81C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376A3218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553158159;
	bh=lOzywWALribrXhpc6VCkS+xzIjb4WGjuVTb9YCTs1MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rGV1lvROofYoycL2qBPJ8fMYsUFwxTIGK4NmLy7229+lvMnV79hN1MFUUNI5ArbkT
	 A8BMdwZs3M0Oad1ph394qENhIbxX1UlYJAETjw5ieUpHi7GoMVrLYo3Q7vbRkLac7b
	 1pHUqIXp1qUGnoAh7Fion+Tn4ak4j7OTLOpQXDqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfCUItS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:49:18 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:41504 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfCUItF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:49:05 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 5EB18600ED; Thu, 21 Mar 2019 16:48:59 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v3 8/9] ARM: dtsi: axp81x: add USB power supply node
Date:   Thu, 21 Mar 2019 16:48:49 +0800
Message-Id: <20190321084850.20769-9-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321084850.20769-1-wens@kernel.org>
References: <20190321084850.20769-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

The AXP813/818 has a VBUS power input. Add a device node for it, now
that we support it.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
[wens@csie.org: Add commit message]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/axp81x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index bd83962d3627..1dfeeceabf4c 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -171,4 +171,8 @@
 			status = "disabled";
 		};
 	};
+
+	usb_power_supply: usb-power-supply {
+		compatible = "x-powers,axp813-usb-power-supply";
+	};
 };
-- 
2.20.1

