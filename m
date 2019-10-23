Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300BBCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014452173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z79bC/ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404481AbfJWM6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:58:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59032 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390108AbfJWM6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:13 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwAZI050420;
        Wed, 23 Oct 2019 07:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835490;
        bh=/BAz1mEF/VCGIcrjKk2y140h8J5pxVqyMtVl2hW0A9w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Z79bC/abivNW7XWycZ//efZfVagehOiulLbJttzOshwT/mVVouBjMgwn6VWyTbT9D
         jpnNgW73QUEg67rhrIoDUxVeL8StXzMmDAgLb1OdPpdURMBFPyVXV9dtBiUYNf9426
         Ny8RqJ4jYrLe1G/yecIGEOsVemHJ5lxkFy4Qmoqo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NCwAg7042283
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 07:58:10 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:58:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:58:00 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5o5061147;
        Wed, 23 Oct 2019 07:58:08 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 01/14] dt-bindings: phy: Sierra: Add bindings for Sierra in TI's J721E
Date:   Wed, 23 Oct 2019 18:27:22 +0530
Message-ID: <20191023125735.4713-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023125735.4713-1-kishon@ti.com>
References: <20191023125735.4713-1-kishon@ti.com>
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
index 6e1b47bfce43..bf90ef7e005e 100644
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
+- clock-names:		Must be "phy_clk". Must contain "cmn_refclk" and
+			"cmn_refclk1" for configuring the frequency of the
+			clock to the lanes.
 - cdns,autoconf:	A boolean property whose presence indicates that the
 			PHY registers will be configured by hardware. If not
 			present, all sub-node optional properties must be
-- 
2.17.1

