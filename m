Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D5EC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E59B206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfLPMZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:25:05 -0500
Received: from gloria.sntech.de ([185.11.138.130]:56914 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfLPMZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:25:05 -0500
Received: from wf0651.dip.tu-dresden.de ([141.76.182.139] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1igpQm-0008GW-Fd; Mon, 16 Dec 2019 13:24:56 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     kishon@ti.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH RESEND 1/2] dt-bindings: phy: drop #clock-cells from rockchip,px30-dsi-dphy
Date:   Mon, 16 Dec 2019 13:24:47 +0100
Message-Id: <20191216122448.27867-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Further review of the dsi components for the px30 revealed that the
phy shouldn't expose the pll as clock but instead handle settings
via phy parameters.

As the phy binding is new and not used anywhere yet, just drop them
so they don't get used.

Fixes: 3817c7961179 ("dt-bindings: phy: add yaml binding for rockchip,px30-dsi-dphy")
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
Hi Kishon,

maybe suitable as a fix for 5.5-rc?

Thanks
Heiko

 .../devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml      | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
index bb0da87bcd84..476c56a1dc8c 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
@@ -13,9 +13,6 @@ properties:
   "#phy-cells":
     const: 0
 
-  "#clock-cells":
-    const: 0
-
   compatible:
     enum:
       - rockchip,px30-dsi-dphy
@@ -49,7 +46,6 @@ properties:
 
 required:
   - "#phy-cells"
-  - "#clock-cells"
   - compatible
   - reg
   - clocks
@@ -66,7 +62,6 @@ examples:
         reg = <0x0 0xff2e0000 0x0 0x10000>;
         clocks = <&pmucru 13>, <&cru 12>;
         clock-names = "ref", "pclk";
-        #clock-cells = <0>;
         resets = <&cru 12>;
         reset-names = "apb";
         #phy-cells = <0>;
-- 
2.23.0

