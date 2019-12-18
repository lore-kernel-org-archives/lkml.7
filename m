Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C774C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43A420717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fOafnprn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfLRJRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:17:53 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19199 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLRJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:17:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9eeb20000>; Wed, 18 Dec 2019 01:17:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 01:17:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 18 Dec 2019 01:17:48 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:17:47 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Dec 2019 09:17:47 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df9eeb70002>; Wed, 18 Dec 2019 01:17:46 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V2 14/18] arm64: tegra: update OTG port entries for jetson-tx2
Date:   Wed, 18 Dec 2019 14:46:27 +0530
Message-ID: <1576660591-10383-15-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576660658; bh=8M0HvtiODuyljolTa4NngxhMZ2mo6JFCNxzYSu8DYiE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=fOafnprnmyFzCAOpgROJoiCZdosGZbJvGB+cbrfKMvDP7eAXEsBolWg88xJn7fe5A
         nVsThw8L1H08Iqe0KlGXO2wEuE1keQYyeGi6uAgvYDeLdAsS1TeNZDEHk2FfQXSmD1
         7XA/2JuQqoQd67omHP6ZjdcGYLDP8Dhh1pTlX1NlSF9xukKpjJSvN2s3cK5Ab+afzG
         1Qx9yGnyHSBBr/ThSeZCUeIw0lb/LQApQzBQtc/prpxLz/Ev+QbFJm+bf7/9FfR/5z
         GWNQDIvaPYWpHDtXglkLVZzQ1Zny2dn0/hpM28e2Fhv14HGJxj/a2+B4o1MjguEmFu
         MP8QKQIvKF60w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb-role-switch entry to OTG usb port and add corresponding connector
details.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - No changes in this version
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index f1de4ff..a1dcdb9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -174,8 +174,20 @@
 			usb2-0 {
 				status = "okay";
 				mode = "otg";
-
 				vbus-supply = <&vdd_usb0>;
+
+				usb-role-switch;
+				connector {
+					compatible = "usb-b-connector",
+						     "gpio-usb-b-connector";
+					label = "micro-USB";
+					type = "micro";
+					vbus-gpio = <&gpio
+						     TEGRA186_MAIN_GPIO(X, 7)
+						     GPIO_ACTIVE_LOW>;
+					id-gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
+				};
+
 			};
 
 			usb2-1 {
-- 
2.7.4

