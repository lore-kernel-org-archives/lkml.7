Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C48FC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4582A20872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="moaSXXmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfFEIoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:44:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59046 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfFEIoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:44:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x558iaLL013111;
        Wed, 5 Jun 2019 03:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559724276;
        bh=QKydF6Lu876iSU7k9u/2w0MqEwWA6SgTM0O/bbSGalU=;
        h=From:To:CC:Subject:Date;
        b=moaSXXmEcs6rH/hQuc+U3NW2TtyVq4IHbf3dhyRj/fxxMMa/787KHDwX7uhsgP4Us
         IJnzDW2EjeZGY9z6iqmhEDFYeCr81LHJ7UwTGIk1YdY3XCbzTy0eOWT8/Mb2fLrZsX
         1AEHxxlnoVxQ9pJsYuxMqDKfPrPFbnposzWZ8jdM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x558iaQn101311
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 03:44:36 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 03:44:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 03:44:35 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x558iWYF019139;
        Wed, 5 Jun 2019 03:44:33 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
CC:     <linux-omap@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] dt-bindings: i2c: omap: Add new compatible for J721E SoCs
Date:   Wed, 5 Jun 2019 14:15:04 +0530
Message-ID: <20190605084504.2777-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

J721E SoCs have same I2C IP as OMAP SoCs. Add new compatible to
handle J721E SoCs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---

Initial support for J721E Platform is proposed here:
https://lore.kernel.org/patchwork/cover/1077382/

 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-omap.txt b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
index 4b90ba9f31b7..a44573d7c118 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
@@ -7,6 +7,7 @@ Required properties :
 	"ti,omap3-i2c" for OMAP3 SoCs
 	"ti,omap4-i2c" for OMAP4+ SoCs
 	"ti,am654-i2c", "ti,omap4-i2c" for AM654 SoCs
+	"ti,j721e-i2c", "ti,omap4-i2c" for J721E SoCs
 - ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
 - #address-cells = <1>;
 - #size-cells = <0>;
-- 
2.21.0

