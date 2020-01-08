Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2412DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC13320643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="RH6BuAjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgAHVIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:08:00 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:43149 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgAHVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=zGVrt1CaSjQ+KYxMuJ8yaAAfHLp2yzYIyOjxAJaDlEA=;
        b=RH6BuAjwFS2Uy67WI3hhoKteoCYavlm1gFlKO4p5CTas808UyS7DGlSqdR3GCslNOEoO
        Sl4pYw65bOfdp7onKU2dlanpEzajO7L++i1UKTHf90jQ9YuS095AWZHWMgXqw2t09BRyRr
        hkHVPSD1DMPXvvCf1hYwBnSmpeWyIHu1E=
Received: by filterdrecv-p3mdw1-56c97568b5-m6gw4 with SMTP id filterdrecv-p3mdw1-56c97568b5-m6gw4-19-5E1644A7-18
        2020-01-08 21:07:51.361082852 +0000 UTC m=+1974284.586093135
Received: from bionic.localdomain (unknown [98.128.173.80])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id Sl3TaZXdSJ6-rD9zZJXxWw
        Wed, 08 Jan 2020 21:07:51.174 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 10/14] arm64: dts: rockchip: add vpll clock to hdmi node on
 rk3328
Date:   Wed, 08 Jan 2020 21:07:51 +0000 (UTC)
Message-Id: <20200108210740.28769-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hzchG1hbSefw3nPpK?=
 =?us-ascii?Q?SnZ=2FYbnfoXLVjCgB=2FbRoE+99Du8Gk2dg2yX4tND?=
 =?us-ascii?Q?97JSRLFvAhj=2FopZ=2FH6F8AZg3+Bpr6e2lH6zx0=2FH?=
 =?us-ascii?Q?SI2=2Fsf5MQR4EgSG+OLXIyoj0M=2Fti1blpHdjzw7R?=
 =?us-ascii?Q?eFj1CYcjbegE9LcxpyI6w0bt=2F0at6Qtf0Y+qVrO?=
 =?us-ascii?Q?OdM9aNuCk6tGUw++7smtg=3D=3D?=
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Zheng Yang <zhengyang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the hdmiphy clock as the vpll in hdmi node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index fee896338cc1..5d8807aca62e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -720,9 +720,11 @@
 			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_HDMI>,
 			 <&cru SCLK_HDMI_SFC>,
+			 <&hdmiphy>,
 			 <&cru SCLK_RTC32K>;
 		clock-names = "iahb",
 			      "isfr",
+			      "vpll",
 			      "cec";
 		phys = <&hdmiphy>;
 		phy-names = "hdmi";
-- 
2.17.1

