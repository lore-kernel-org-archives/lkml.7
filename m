Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41926C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124502070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FhZiU6rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfE2JUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:20:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52500 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfE2JUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:20:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4T9JsGR024114;
        Wed, 29 May 2019 04:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559121594;
        bh=AfXj0dA2uE7BKjcDG8GO32yzKz/LyY/lufBnllEBR0U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FhZiU6rxSv4DdnO7G88rRlXzAbf/Qxc5XjgIISCLEldIVxBaBcPLa018KSIL4UyyH
         VZakdBy3r9ZrKw7JDaoFryE18gSkNIdHU5bMBdqEJdtooi+PvIb4FLTxY5gb8K7LVk
         PTIoLUQ/11ARk02YXgYUZkzWNkjVcnTEQ8rkY38E=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4T9Js3g050576
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 May 2019 04:19:54 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 29
 May 2019 04:19:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 29 May 2019 04:19:53 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4T9JVxT079377;
        Wed, 29 May 2019 04:19:51 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 6/6] arm64: dts: ti: am654-base-board: Disable SERDES and PCIe
Date:   Wed, 29 May 2019 14:48:12 +0530
Message-ID: <20190529091812.20764-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529091812.20764-1-kishon@ti.com>
References: <20190529091812.20764-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 base board does not have any PCIe slots. Disable all the
SERDES and PCIe instances.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index cf1aa276a1ea..abd7e4e218f2 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -228,3 +228,27 @@
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
 };
+
+&serdes0 {
+	status = "disabled";
+};
+
+&serdes1 {
+	status = "disabled";
+};
+
+&pcie0_rc {
+	status = "disabled";
+};
+
+&pcie0_ep {
+	status = "disabled";
+};
+
+&pcie1_rc {
+	status = "disabled";
+};
+
+&pcie1_ep {
+	status = "disabled";
+};
-- 
2.17.1

