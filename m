Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC26CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4FA21734
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450870;
	bh=Yryrw8btORmLzFL2hJEnT0zESURDGptQcMl5Pp9dUxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f9viQuy1L3xULVFHwyTvNqP+XDX7qTwDNvPsLOBbBiPSvY1x4Ei/yeY9IknNZU/5D
	 pTQV629hpWbp2DixLtcTdOgPc3Iw3IMwgTXDzwcpU3JT7/DattUsXoOeypBQPrt8WT
	 ndKgHcBbdixjpiWL2Mj9j2X3FDNbi0Y0hJPsdQQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfJ3Py3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbfJ3PyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:54:21 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D91720656;
        Wed, 30 Oct 2019 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450861;
        bh=Yryrw8btORmLzFL2hJEnT0zESURDGptQcMl5Pp9dUxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBGQeVDt9SqZwv3BrJ2A+NtHGMLo9KKESxPt7fgqnp1sEEvOBSSLZ3GXcZ3qTjtW8
         7m//bwQfBLTbzxNylkN8ikWmTpCPWwpcGZKLRiIrTgE5C9RMOHZvMs9Lteb1iiue63
         rTUZ3r3iVJ5+VfQEEFtTOcyYxAQf07yUCqYBRFj0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/38] arm64: dts: Fix gpio to pinmux mapping
Date:   Wed, 30 Oct 2019 11:53:33 -0400
Message-Id: <20191030155406.10109-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155406.10109-1-sashal@kernel.org>
References: <20191030155406.10109-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

[ Upstream commit 965f6603e3335a953f4f876792074cb36bf65f7f ]

There are total of 151 non-secure gpio (0-150) and four
pins of pinmux (91, 92, 93 and 94) are not mapped to any
gpio pin, hence update same in DT.

Fixes: 8aa428cc1e2e ("arm64: dts: Add pinctrl DT nodes for Stingray SOC")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi | 5 +++--
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi         | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
index 8a3a770e8f2ce..56789ccf94545 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
@@ -42,13 +42,14 @@
 
 		pinmux: pinmux@14029c {
 			compatible = "pinctrl-single";
-			reg = <0x0014029c 0x250>;
+			reg = <0x0014029c 0x26c>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0xf>;
 			pinctrl-single,gpio-range = <
-				&range 0 154 MODE_GPIO
+				&range 0  91 MODE_GPIO
+				&range 95 60 MODE_GPIO
 				>;
 			range: gpio-range {
 				#pinctrl-single,gpio-range-cells = <3>;
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index e283480bfc7e5..84101ea1fd2cb 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -463,8 +463,7 @@
 					<&pinmux 108 16 27>,
 					<&pinmux 135 77 6>,
 					<&pinmux 141 67 4>,
-					<&pinmux 145 149 6>,
-					<&pinmux 151 91 4>;
+					<&pinmux 145 149 6>;
 		};
 
 		i2c1: i2c@e0000 {
-- 
2.20.1

