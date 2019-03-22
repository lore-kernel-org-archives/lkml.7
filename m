Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA81C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A951213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfCVNHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:07:54 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:58497 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730585AbfCVLfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:41 -0400
Received: from ip092042140082.rev.nessus.at ([92.42.140.82]:55276 helo=purcell.lan)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1h7ISN-0006u1-SH; Fri, 22 Mar 2019 12:35:27 +0100
From:   Christoph Muellner <christoph.muellner@theobroma-systems.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        shawn.lin@rock-chips.com
Cc:     Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 4/4] arm64: dts: rockchip: Decrease emmc-phy's drive impedance on rk3399-puma
Date:   Fri, 22 Mar 2019 12:34:53 +0100
Message-Id: <20190322113456.16324-4-christoph.muellner@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190322113456.16324-1-christoph.muellner@theobroma-systems.com>
References: <20190322113456.16324-1-christoph.muellner@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3399-Q7 (Puma) requires 33 Ohm drive strength to ensure signal
integrity at HS-400 (200MHz clock, DDR signalling).

A repeated EMC testing run validates that this increase does not
negatively impact EMC compliance (emissions have ample distance to
the regulatory limits).

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Tested-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Tested-by: Klaus Goger <klaus.goger@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 0130b9f98c9d..4f75bb6b2f14 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -146,6 +146,7 @@
 
 &emmc_phy {
 	status = "okay";
+	drive-impedance-ohm = <33>;
 };
 
 &gmac {
-- 
2.11.0

