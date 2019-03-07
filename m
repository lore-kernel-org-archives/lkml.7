Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4C7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E393420835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCGImc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:42:32 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:42299 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbfCGImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:42:31 -0500
Received: from ip092042140082.rev.nessus.at ([92.42.140.82]:54490 helo=purcell.lan)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1h1obV-000810-CG; Thu, 07 Mar 2019 09:42:13 +0100
From:   Christoph Muellner <christoph.muellner@theobroma-systems.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        shawn.lin@rock-chips.com
Cc:     Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Brian Norris <briannorris@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Lin Huang <hl@rock-chips.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 3/4] arm64: dts: rockchip: Define drive-impedance-ohm for RK3399's emmc-phy.
Date:   Thu,  7 Mar 2019 09:41:55 +0100
Message-Id: <20190307084159.25236-3-christoph.muellner@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190307084159.25236-1-christoph.muellner@theobroma-systems.com>
References: <20190307084159.25236-1-christoph.muellner@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch introduced the property 'drive-impedance-ohm'
for the RK3399's emmc phy node. This patch sets this value
explicitly to the default value of 50 Ohm.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 6cc1c9fa4ea6..b875364a7709 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1450,6 +1450,7 @@
 			clock-names = "refclk";
 			#phy-cells = <1>;
 			resets = <&cru SRST_PCIEPHY>;
+			drive-impedance-ohm = <50>;
 			reset-names = "phy";
 			status = "disabled";
 		};
-- 
2.11.0

