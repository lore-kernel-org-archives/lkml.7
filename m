Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC4C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627EA2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PBJuGVD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgAIIub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:50:31 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47144 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAIIua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:50:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0098oMEB107738;
        Thu, 9 Jan 2020 02:50:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578559822;
        bh=BmZz4GM008QcVUfmXOfqaIwBn3aJlcL0leg79D9LVbc=;
        h=From:To:CC:Subject:Date;
        b=PBJuGVD4APjXiqg5yVm2jm2kE686Ss/0yy8YL8/wnbe6WqursScxnydg6qEV+ISlL
         l7413nX2pi+v+PQu0TGngxBYQpgjWVqmTsSswrVCFY1PNOn6G7AFigVV37h/tNOGDz
         eSkyKr94s8rP/kSA+j08kQ4n3a2xU5k84fBgh4Fc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0098oMhY073027
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Jan 2020 02:50:22 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Jan
 2020 02:50:22 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Jan 2020 02:50:22 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0098oJc7055573;
        Thu, 9 Jan 2020 02:50:20 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH] arm: dts: ti: k3-am654-main: Update otap-del-sel values
Date:   Thu, 9 Jan 2020 14:21:52 +0530
Message-ID: <20200109085152.10573-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the latest AM65x Data Manual[1], a different output tap
delay value is optimum for a given speed mode. Update these values.

[1] http://www.ti.com/lit/gpn/am6526

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---

This patch depends on my two kernel series posted here:
https://patchwork.kernel.org/project/linux-mmc/list/?series=225425
https://patchwork.kernel.org/project/linux-mmc/list/?series=225459

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index efb24579922c..c8d812fdfa0a 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -253,7 +253,17 @@
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
-		ti,otap-del-sel = <0x2>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0x0>;
+		ti,otap-del-sel-sdr25 = <0x0>;
+		ti,otap-del-sel-sdr50 = <0x8>;
+		ti,otap-del-sel-sdr104 = <0x5>;
+		ti,otap-del-sel-ddr50 = <0x5>;
+		ti,otap-del-sel-ddr52 = <0x5>;
+		ti,otap-del-sel-hs200 = <0x5>;
+		ti,otap-del-sel-hs400 = <0x0>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
 	};
-- 
2.19.2

