Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41281C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A02207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UZSfp15x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfFLK3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:29:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56410 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfFLK3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:29:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5CATpC1031934;
        Wed, 12 Jun 2019 05:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560335391;
        bh=IdaQjdXlt1IrKCg6uSGP7IL6H1ZHedEZAA0iGbkCJKA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UZSfp15xhQUA01lGq8g/mVjJrFVH6cLh8pYyGhjagFLuLsWNJUiaE1BLlsXGOwD9k
         ozHS+GUcYlOlv/laVcoPT8CLBXJviriGr5Y4pPrRej9PXJVD92ySsbcMxRWirSNrVN
         df+GYprFd0HxmNvqA19eRD+OJCbasn3E9yTUGeK8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5CATpBj085393
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jun 2019 05:29:51 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 12
 Jun 2019 05:29:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 12 Jun 2019 05:29:51 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5CATTJa128310;
        Wed, 12 Jun 2019 05:29:49 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] dt-bindings: phy: tegra-xusb: List PLL power supplies
Date:   Wed, 12 Jun 2019 15:58:01 +0530
Message-ID: <20190612102803.25398-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612102803.25398-1-kishon@ti.com>
References: <20190612102803.25398-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

These power supplies provide power for various PLLs that are set up and
driven by the XUSB pad controller. These power supplies were previously
improperly added to the PCIe and XUSB controllers, but depending on the
driver probe order, power to the PLLs will not be supplied soon enough
and cause initialization to fail.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
index daedb15f322e..9fb682e47c29 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
@@ -42,6 +42,18 @@ Required properties:
 - reset-names: Must include the following entries:
   - "padctl"
 
+For Tegra124:
+- avdd-pll-utmip-supply: UTMI PLL power supply. Must supply 1.8 V.
+- avdd-pll-erefe-supply: PLLE reference PLL power supply. Must supply 1.05 V.
+- avdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
+- hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 3.3 V.
+
+For Tegra210:
+- avdd-pll-utmip-supply: UTMI PLL power supply. Must supply 1.8 V.
+- avdd-pll-uerefe-supply: PLLE reference PLL power supply. Must supply 1.05 V.
+- dvdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
+- hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 1.8 V.
+
 For Tegra186:
 - avdd-pll-erefeut-supply: UPHY brick and reference clock as well as UTMI PHY
   power supply. Must supply 1.8 V.
-- 
2.17.1

