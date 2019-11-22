Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83383C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E5204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574404249;
	bh=//48Y0e+TnSjcWbypK13uBxiX7dydB+93cLmWpdG+a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a3BphdnnP2wi4lOohMbI+G0maDWHngURUw9g/5i0TgUOst7X910fS0RSi3B1UGPfw
	 6Fx+9XEusfXsmo/FxjZ+uDmmfUelZprsW1vq4Rgj3T+52uibwWKMkKEh9reGD3VpI3
	 a7PhZPy98WnO9tb4gq7UN7ZPpyuFTIIPcHqb3oIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfKVGas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfKVFt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:49:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11FB12071F;
        Fri, 22 Nov 2019 05:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401768;
        bh=//48Y0e+TnSjcWbypK13uBxiX7dydB+93cLmWpdG+a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+O4cnIUMktUkwbl7VL3x0Jhp6A2C4sVuZZkRBh4OcHdvS1R7uJMVyLzpvdv1PoTs
         77TceYoqwJhz6zNyNbxjshO5vktczrAhXiHyOTbZZupL/AbUbtVvNl2U83wIIe3cN8
         42ae8WZ2KLIQUyfRjnxrts2yVeVzvVh6dy6Dwe6Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 019/219] ARM: dts: imx27: Fix memory node duplication
Date:   Fri, 22 Nov 2019 00:45:51 -0500
Message-Id: <20191122054911.1750-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 38715dcd49b4430ac5b6bc1293278d91a4d32bd5 ]

Boards based on imx27 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx27.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx27-apf27.dts                 | 1 +
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi      | 1 +
 arch/arm/boot/dts/imx27-pdk.dts                   | 1 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi | 1 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi   | 1 +
 arch/arm/boot/dts/imx27.dtsi                      | 2 --
 6 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index 3eddd805a793a..f635d5c5029c4 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -20,6 +20,7 @@
 	compatible = "armadeus,imx27-apf27", "fsl,imx27";
 
 	memory@a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x04000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index 9c455dcbe6ebf..c85f9d01768a1 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -17,6 +17,7 @@
 	compatible = "eukrea,cpuimx27", "fsl,imx27";
 
 	memory@a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index f9a882d991329..35123b7cb6b3e 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -10,6 +10,7 @@
 	compatible = "fsl,imx27-pdk", "fsl,imx27";
 
 	memory@a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
index cbad7c88c58cc..b0b4f7c00246d 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
@@ -18,6 +18,7 @@
 	compatible = "phytec,imx27-pca100", "fsl,imx27";
 
 	memory@a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x08000000>; /* 128MB */
 	};
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index ec466b4bfd410..0935e1400e5d2 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -17,6 +17,7 @@
 	compatible = "phytec,imx27-pcm038", "fsl,imx27";
 
 	memory@a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 753d88df16274..39e75b997bdc8 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -16,10 +16,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
-- 
2.20.1

