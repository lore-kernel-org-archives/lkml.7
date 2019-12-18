Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3789C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE95227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="X0CHUqkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfLRJRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:17:48 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19188 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLRJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:17:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9eeae0000>; Wed, 18 Dec 2019 01:17:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 01:17:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 18 Dec 2019 01:17:44 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:17:43 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Dec 2019 09:17:43 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df9eeb30004>; Wed, 18 Dec 2019 01:17:42 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V2 13/18] arm64: tegra: update OTG port entries for jetson-tx1
Date:   Wed, 18 Dec 2019 14:46:26 +0530
Message-ID: <1576660591-10383-14-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576660654; bh=r6dLijaGQSTeyELW+i73uRPzAvO9Y8ClHFN1zye9h8A=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=X0CHUqkw+De1Z3qZp2feEgqYD5qZnfQPtsHs6W+lcIADDE5CbxAn/Xjcs73ZlM3cT
         9BCwvRLmkVm1B8bshrlVQNts4FE0YumxOtsvJkHsBxzhZCHKIDaAyWxZVwYSsoj7mk
         b4oua6Pbqx2zIsNAlO4M/7G7s9mAisG9/eVJjxn3XN0D2ZKtDyIJRfKPbTWHSWxQc2
         VDFYGpnnZGaZz1aST0nDrDZncmnkFQUGCQJ99wuTUh53gG4UzKYgQ47D2uylg/quhp
         oD1uGcML4Xx0stSnwiAb9capVsDuV9I1sy5yJaSEjp7fRTnEjw/aI0MmpbePBEJ4qE
         ms8+4eBvZ8YRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate OTG vbus regulator. Add usb-role-switch entry to USB 2-0 port
and corresponding connector details.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - No changes in this version
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index b009507..18c0610 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1336,7 +1336,6 @@
 		       <&{/padctl@7009f000/pads/pcie/lanes/pcie-5}>;
 		phy-names = "usb2-0", "usb2-1", "usb2-2", "usb2-3", "usb3-0",
 			    "usb3-1";
-
 		dvddio-pex-supply = <&vdd_pex_1v05>;
 		hvddio-pex-supply = <&vdd_1v8>;
 		avdd-usb-supply = <&vdd_3v3_sys>;
@@ -1440,7 +1439,19 @@
 		ports {
 			usb2-0 {
 				status = "okay";
+				vbus-supply = <&vdd_usb_vbus_otg>;
 				mode = "otg";
+
+				usb-role-switch;
+				connector {
+					compatible = "usb-b-connector",
+						     "gpio-usb-b-connector";
+					label = "micro-USB";
+					type = "micro";
+					vbus-gpio = <&gpio TEGRA_GPIO(Z, 0)
+						     GPIO_ACTIVE_LOW>;
+					id-gpio = <&pmic 0 0>;
+				};
 			};
 
 			usb2-1 {
@@ -1606,6 +1617,17 @@
 			vin-supply = <&vdd_5v0_sys>;
 		};
 
+		vdd_usb_vbus_otg: regulator@11 {
+			compatible = "regulator-fixed";
+			reg = <9>;
+			regulator-name = "USB_VBUS_EN0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio TEGRA_GPIO(CC, 4) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			vin-supply = <&vdd_5v0_sys>;
+		};
+
 		vdd_hdmi: regulator@10 {
 			compatible = "regulator-fixed";
 			reg = <10>;
-- 
2.7.4

