Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AA9C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7DA21741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UDzniReo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfK1Kro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:47:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35258 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfK1Krn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:47:43 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASAldD0120070;
        Thu, 28 Nov 2019 04:47:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574938059;
        bh=nUDBKv4JrNDGM93TzKWCaAhzdc1M2/r35cweUvBTKlk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UDzniReoTIUaPQiKm/5GXqtJ8jPhkDJnS4yA9bZ3SAA2GWjn3y/Emc2qDZl9mwipl
         qSkLogr7OWqzaLRr4h1TFqU3UHi+3y0Dw3oJzGNWk3pzut6V5joGY3KZRDBkV9bBCj
         cV1JC9s1aKYcgqvoae4AxDJn/4s+qNgv4TK8MF9E=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAldjx118006;
        Thu, 28 Nov 2019 04:47:39 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 04:47:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 04:47:38 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAlX3w098163;
        Thu, 28 Nov 2019 04:47:36 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 01/14] dt-bindings: phy: Sierra: Add bindings for Sierra in TI's J721E
Date:   Thu, 28 Nov 2019 16:16:35 +0530
Message-ID: <20191128104648.21894-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128104648.21894-1-kishon@ti.com>
References: <20191128104648.21894-1-kishon@ti.com>
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

