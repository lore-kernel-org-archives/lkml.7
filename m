Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9048BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC972133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M/CBaSBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfDBNiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:38:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48530 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbfDBNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:38:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32Dbx7A091852;
        Tue, 2 Apr 2019 08:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554212279;
        bh=0RueluNUmnctCVcpjCePWJlghhTJkq8vCQtlL6gR87o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=M/CBaSBxwmyPDrmwyp3bzpyQvVPMy905bFSeTYTBVEQtwmV5NafGaJnaz9jH/3g1k
         IE7LXJXPejs6OcgWz34IDstU1TYjktEIVUWVKKLWFY/GT05d2MqEwT32xvi5CyS0qh
         WKEqCH/JTDQecH8/tldGZY9OULTZg1mYaXGYD584=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32Dbw9i018384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 08:37:58 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 08:37:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 08:37:58 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32DbsTx051551;
        Tue, 2 Apr 2019 08:37:57 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <nsekhar@ti.com>, <s-anna@ti.com>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 1/4] ARM: dts: dra7: Keep usb_otg_ss3 and usb_otg_ss4 disabled
Date:   Tue, 2 Apr 2019 16:37:49 +0300
Message-ID: <20190402133752.6912-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402133752.6912-1-rogerq@ti.com>
References: <20190402133752.6912-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 2 modules are not present on all families (e.g. AM57).
Keep them disabled.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 414f1cd68733..40e7281c12f7 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -4120,6 +4120,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x100000 0x20000>;
+			status = "disabled";
 
 			omap_dwc3_3: omap_dwc3_3@0 {
 				compatible = "ti,dwc3";
@@ -4169,6 +4170,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x140000 0x20000>;
+			status = "disabled";
 		};
 
 		target-module@170000 {			/* 0x48970000, ap 21 0a.0 */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

