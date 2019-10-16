Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A8C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD8F20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404311AbfJPJmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:42:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46407 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391934AbfJPJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:42:09 -0400
X-UUID: 0d7a14638f4345b194b08ad5aa811688-20191016
X-UUID: 0d7a14638f4345b194b08ad5aa811688-20191016
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1407545773; Wed, 16 Oct 2019 17:42:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Oct 2019 17:42:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Oct 2019 17:42:00 +0800
From:   Wen Su <Wen.Su@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <wsd_upstream@mediatek.com>, <wen.su@mediatek.com>
Subject: [PATCH 4/4] arm64: dts: mt6359: add PMIC MT6359 related nodes
Date:   Wed, 16 Oct 2019 17:39:46 +0800
Message-ID: <1571218786-15073-5-git-send-email-Wen.Su@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571218786-15073-1-git-send-email-Wen.Su@mediatek.com>
References: <1571218786-15073-1-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "wen.su" <wen.su@mediatek.com>

add PMIC MT6359 related nodes which is for MT6779 platform

Signed-off-by: wen.su <wen.su@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 312 +++++++++++++++++++++++++++++++
 1 file changed, 312 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6359.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
new file mode 100644
index 0000000..6d2ca1b
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+&pwrap {
+	pmic: pmic {
+		mt6359regulator: mt6359regulator {
+			compatible = "mediatek,mt6359-regulator";
+			mt6359_vs1_buck_reg: buck_vs1 {
+				regulator-name = "vs1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+			};
+			mt6359_vgpu11_buck_reg: buck_vgpu11 {
+				regulator-name = "vgpu11";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-ramp-delay = <5000>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+				regulator-allowed-modes = <0 1 2>;
+			};
+			mt6359_vmodem_buck_reg: buck_vmodem {
+				regulator-name = "vmodem";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-ramp-delay = <10760>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+			};
+			mt6359_vpu_buck_reg: buck_vpu {
+				regulator-name = "vpu";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-ramp-delay = <5000>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-allowed-modes = <0 1 2>;
+			};
+			mt6359_vcore_buck_reg: buck_vcore {
+				regulator-name = "vcore";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-ramp-delay = <5000>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+				regulator-allowed-modes = <0 1 2>;
+			};
+			mt6359_vs2_buck_reg: buck_vs2 {
+				regulator-name = "vs2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1600000>;
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+			};
+			mt6359_vpa_buck_reg: buck_vpa {
+				regulator-name = "vpa";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3650000>;
+				regulator-enable-ramp-delay = <300>;
+			};
+			mt6359_vproc2_buck_reg: buck_vproc2 {
+				regulator-name = "vproc2";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-ramp-delay = <7500>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+				regulator-allowed-modes = <0 1 2>;
+			};
+			mt6359_vproc1_buck_reg: buck_vproc1 {
+				regulator-name = "vproc1";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-ramp-delay = <7500>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+				regulator-allowed-modes = <0 1 2>;
+			};
+			mt6359_vcore_sshub_buck_reg: buck_vcore_sshub {
+				regulator-name = "vcore_sshub";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1193750>;
+			};
+			mt6359_vaud18_ldo_reg: ldo_vaud18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vaud18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_vsim1_ldo_reg: ldo_vsim1 {
+				regulator-name = "vsim1";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <480>;
+			};
+			mt6359_vibr_ldo_reg: ldo_vibr {
+				regulator-name = "vibr";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_vrf12_ldo_reg: ldo_vrf12 {
+				regulator-name = "vrf12";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+			mt6359_vusb_ldo_reg: ldo_vusb {
+				compatible = "regulator-fixed";
+				regulator-name = "vusb";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6359_vsram_proc2_ldo_reg: ldo_vsram_proc2 {
+				regulator-name = "vsram_proc2";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-ramp-delay = <7500>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6359_vio18_ldo_reg: ldo_vio18 {
+				regulator-name = "vio18";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1900000>;
+				regulator-enable-ramp-delay = <960>;
+				regulator-always-on;
+			};
+			mt6359_vcamio_ldo_reg: ldo_vcamio {
+				regulator-name = "vcamio";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1900000>;
+				regulator-enable-ramp-delay = <1920>;
+			};
+			mt6359_vcn18_ldo_reg: ldo_vcn18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vcn18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_vfe28_ldo_reg: ldo_vfe28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vfe28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <120>;
+				regulator-always-on;
+			};
+			mt6359_vcn13_ldo_reg: ldo_vcn13 {
+				regulator-name = "vcn13";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_vcn33_1_bt_ldo_reg: ldo_vcn33_1_bt {
+				regulator-name = "vcn33_1_bt";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_vcn33_1_wifi_ldo_reg: ldo_vcn33_1_wifi {
+				regulator-name = "vcn33_1_wifi";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_vaux18_ldo_reg: ldo_vaux18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vaux18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6359_vsram_others_ldo_reg: ldo_vsram_others {
+				regulator-name = "vsram_others";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-ramp-delay = <5000>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6359_vefuse_ldo_reg: ldo_vefuse {
+				regulator-name = "vefuse";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_vxo22_ldo_reg: ldo_vxo22 {
+				regulator-name = "vxo22";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-enable-ramp-delay = <120>;
+				regulator-always-on;
+			};
+			mt6359_vrfck_ldo_reg: ldo_vrfck {
+				regulator-name = "vrfck";
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1700000>;
+				regulator-enable-ramp-delay = <480>;
+			};
+			mt6359_vbif28_ldo_reg: ldo_vbif28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vbif28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6359_vio28_ldo_reg: ldo_vio28 {
+				regulator-name = "vio28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6359_vemc_ldo_reg: ldo_vemc {
+				regulator-name = "vemc";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_vcn33_2_bt_ldo_reg: ldo_vcn33_2_bt {
+				regulator-name = "vcn33_2_bt";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_vcn33_2_wifi_ldo_reg: ldo_vcn33_2_wifi {
+				regulator-name = "vcn33_2_wifi";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_va12_ldo_reg: ldo_va12 {
+				regulator-name = "va12";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6359_va09_ldo_reg: ldo_va09 {
+				regulator-name = "va09";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6359_vrf18_ldo_reg: ldo_vrf18 {
+				regulator-name = "vrf18";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1810000>;
+				regulator-enable-ramp-delay = <120>;
+				regulator-always-on;
+			};
+			mt6359_vsram_md_ldo_reg: ldo_vsram_md {
+				regulator-name = "vsram_md";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-ramp-delay = <10760>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6359_vufs_ldo_reg: ldo_vufs {
+				regulator-name = "vufs";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1900000>;
+				regulator-enable-ramp-delay = <1920>;
+				regulator-always-on;
+			};
+			mt6359_vm18_ldo_reg: ldo_vm18 {
+				regulator-name = "vm18";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1900000>;
+				regulator-enable-ramp-delay = <1920>;
+				regulator-always-on;
+			};
+			mt6359_vbbck_ldo_reg: ldo_vbbck {
+				regulator-name = "vbbck";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6359_vsram_proc1_ldo_reg: ldo_vsram_proc1 {
+				regulator-name = "vsram_proc1";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-ramp-delay = <7500>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6359_vsim2_ldo_reg: ldo_vsim2 {
+				regulator-name = "vsim2";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <480>;
+			};
+			mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub {
+				regulator-name = "vsram_others_sshub";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1193750>;
+			};
+		};
+	};
+};
-- 
1.9.1

