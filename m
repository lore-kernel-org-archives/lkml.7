Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C9FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC7720721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574400475;
	bh=WszExPIIwxHba7R4ODtPaqd+zT5cyG2VdXTU71sfmK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ifOKClT+U1UmZUCrQqK33eaO1oCYYY75EzYmz3EubhXTh0QzbJAbtlLXDAKtGwQWV
	 GrBbMoOjDpNfX+R8kyTwLfy8ILpOecuAEyBg3I5o3RKi/oGTJqRWdDdmHr3c1NZ7W+
	 chqBQCCESilqefLO0AB3XmFfLU/Cb2Ybc/RHLE1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKVF1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:27:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfKVF1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:27:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F94B20707;
        Fri, 22 Nov 2019 05:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574400467;
        bh=WszExPIIwxHba7R4ODtPaqd+zT5cyG2VdXTU71sfmK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CccMh5BX1N/asJTkWhf6TapevK7C4HQtxO+2ODlACdDTh0HnL7EowQOijDIPz0s69
         OT9iygJCmz0nZ1mwVPviHa3aGvU5jYkPfyRo1jPUYzfwa5tuMUAR7fephqJZGPNjY/
         HCB0txclohscwezFu46IOa1nyRGHqGYIsXGVYJ7M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ding Tao <miyatsu@qq.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 004/219] arm64: dts: marvell: armada-37xx: Enable emmc on espressobin
Date:   Fri, 22 Nov 2019 00:24:06 -0500
Message-Id: <20191122052741.32499-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122052741.32499-1-sashal@kernel.org>
References: <20191122052741.32499-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ding Tao <miyatsu@qq.com>

[ Upstream commit 43ebc7c1b3ed8198b9acf3019eca16e722f7331c ]

The ESPRESSObin board has a emmc interface available on U11: declare it
and let the bootloader enable it if the emmc is present.

[gregory.clement@bootlin.com: disable the emmc by default]
Signed-off-by: Ding Tao <miyatsu@qq.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/marvell/armada-3720-espressobin.dts   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 3ab25ad402b90..846003bb480cd 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -60,9 +60,31 @@
 	cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
 	marvell,pad-type = "sd";
 	vqmmc-supply = <&vcc_sd_reg1>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio_pins>;
 	status = "okay";
 };
 
+/* U11 */
+&sdhci0 {
+	non-removable;
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,xenon-emmc;
+	marvell,xenon-tun-count = <9>;
+	marvell,pad-type = "fixed-1-8v";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc_pins>;
+/*
+ * This eMMC is not populated on all boards, so disable it by
+ * default and let the bootloader enable it, if it is present
+ */
+	status = "disabled";
+};
+
 &spi0 {
 	status = "okay";
 
-- 
2.20.1

