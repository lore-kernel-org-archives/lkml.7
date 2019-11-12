Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7950C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974A620650
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a7yz14u4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfKLO3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:29:08 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37382 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfKLO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:29:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACET4Nj014149;
        Tue, 12 Nov 2019 08:29:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568944;
        bh=/uLv7JVb364YMJpDL21sew7lV3/imt2e+I/yD5VDeMY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a7yz14u4SlGlNL1uGRGJOlBN6ZmibKKuQZ2D6HiwD9Sec5R1vQwQd6Wt6NTx+AaL6
         zTV+1NctSMA7qFLFgbZ3LuvJIsBdZIdK3mdeNavdrWOe1wkseYIPXi1KenBW9rCq4g
         Q5DxsaC6fabTHVq1mw6VMjqhwobebw7CLccMl3tY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACET3tR018600
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:29:04 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:28:47 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:28:46 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESriJ044422;
        Tue, 12 Nov 2019 08:29:04 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>, Jyri Sarha <jsarha@ti.com>
Subject: [Patch v3 07/20] dt-bindings: media: cal: update binding to add PHY LDO errata support
Date:   Tue, 12 Nov 2019 08:31:39 -0600
Message-ID: <20191112143152.23176-8-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112143152.23176-1-bparrot@ti.com>
References: <20191112143152.23176-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Device Tree bindings for the CAL driver to add support for
the CSI2 PHY LDO errata workaround for pre-es2 devices.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/ti-cal.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/ti-cal.txt b/Documentation/devicetree/bindings/media/ti-cal.txt
index 7e960cf26e23..cb2dc50a24fb 100644
--- a/Documentation/devicetree/bindings/media/ti-cal.txt
+++ b/Documentation/devicetree/bindings/media/ti-cal.txt
@@ -7,7 +7,9 @@ processing capability to connect CSI2 image-sensor modules to the
 DRA72x device.
 
 Required properties:
-- compatible: must be "ti,dra72-cal"
+- compatible:
+ Should be "ti,dra72-cal", for DRA72 controllers
+ Should be "ti,dra72-pre-es2-cal", for DRA72 controllers pre ES2.0
 - reg:	CAL Top level, Receiver Core #0, Receiver Core #1 and Camera RX
 	control address space
 - reg-names: cal_top, cal_rx_core0, cal_rx_core1 and camerrx_control
-- 
2.17.1

