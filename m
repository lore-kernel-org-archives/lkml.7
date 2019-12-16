Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841C7C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EBC205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NKlrK6FA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLPJ4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:56:08 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58728 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfLPJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:07 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9u0Yx105981;
        Mon, 16 Dec 2019 03:56:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490160;
        bh=6fpvrXJ83jkqpt127njJSVIBYoo3/59w/XSU+W0RtjE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NKlrK6FAlZIywRYsmE4sw/16bzggCzHeGDwwldI39Hdp7S90tAciZ/h6bu4/1rxNa
         RAz6bnpPEBZX+XHfhoYUI8V2Cc2UUIx2O0W+bMmZVEwv7e1CWuLDIrtbj4wEkeoEfR
         y2qcPmhmzNzlUyTM4+aq2e3p7s/niGMY1vT8bBis=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBG9u0fu048706
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 03:56:00 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:55:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:55:59 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tsJK084408;
        Mon, 16 Dec 2019 03:55:57 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 01/14] dt-bindings: phy: Sierra: Add bindings for Sierra in TI's J721E
Date:   Mon, 16 Dec 2019 15:26:59 +0530
Message-ID: <20191216095712.13266-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216095712.13266-1-kishon@ti.com>
References: <20191216095712.13266-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for Sierra PHY IP used in TI's J721E
SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/phy-cadence-sierra.txt  | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
index 6e1b47bfce43..03f5939d3d19 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
@@ -2,21 +2,24 @@ Cadence Sierra PHY
 -----------------------
 
 Required properties:
-- compatible:	cdns,sierra-phy-t0
-- clocks:	Must contain an entry in clock-names.
-		See ../clocks/clock-bindings.txt for details.
-- clock-names:	Must be "phy_clk"
+- compatible:	Must be "cdns,sierra-phy-t0" for Sierra in Cadence platform
+		Must be "ti,sierra-phy-t0" for Sierra in TI's J721E SoC.
 - resets:	Must contain an entry for each in reset-names.
 		See ../reset/reset.txt for details.
 - reset-names:	Must include "sierra_reset" and "sierra_apb".
 		"sierra_reset" must control the reset line to the PHY.
 		"sierra_apb" must control the reset line to the APB PHY
-		interface.
+		interface ("sierra_apb" is optional).
 - reg:		register range for the PHY.
 - #address-cells: Must be 1
 - #size-cells:	Must be 0
 
 Optional properties:
+- clocks:		Must contain an entry in clock-names.
+			See ../clocks/clock-bindings.txt for details.
+- clock-names:		Must contain "cmn_refclk_dig_div" and
+			"cmn_refclk1_dig_div" for configuring the frequency of
+			the clock to the lanes. "phy_clk" is deprecated.
 - cdns,autoconf:	A boolean property whose presence indicates that the
 			PHY registers will be configured by hardware. If not
 			present, all sub-node optional properties must be
-- 
2.17.1

