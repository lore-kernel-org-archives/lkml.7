Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D283CC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB8721924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214927;
	bh=Ne3xpqHDEVTaOIwtvgtj6SoGrIn4XBahTRxtBYOMvZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jffY+/u6BkfJPGUr14QxxNbsIxlTwoRrgjMJTjGNqhvK6ptvNPCiuIusTJl1u8naM
	 vm/m5JjtCdsWnT9I3bj/Y61OExUOwBO2KpKvkT3WnVh/9J1l9yVmuvDAB3y18sOPld
	 vxPgWSa2JgVGwpf/O+aGDpOSFSTvbhiEsH1YcCGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbfKHLk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388528AbfKHLkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:40:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6FC20869;
        Fri,  8 Nov 2019 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213212;
        bh=Ne3xpqHDEVTaOIwtvgtj6SoGrIn4XBahTRxtBYOMvZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8j4RTqw9jELV558r0fjuJwDIA3GRzvSYI0MD34OFyB4PyUmxeZgtUk4izG79iZHE
         DBChrRjSHqkkn1FVhvwL2SAcgNL6s81WWzwGx1hxWHZp7fOshzIzSW8CW5wmWrII7U
         iruLA+kpsBu4N7Xg+BNme/cX9OMKa97MkQ+IVAc0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 093/205] ARM: dts: exynos: Disable pull control for S5M8767 PMIC
Date:   Fri,  8 Nov 2019 06:36:00 -0500
Message-Id: <20191108113752.12502-93-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit ef2ecab9af5feae97c47b7f61cdd96f7f49b2c23 ]

S5M8767 PMIC interrupt line on Exynos5250-based Arndale board has
external pull-up resistors, so disable any pull control for it in
in controller node. This fixes support for S5M8767 interrupts and
enables operation of wakeup from S5M8767 RTC alarm.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 9c8ab4b7fb2cf..4ab1f1c66c27f 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -170,6 +170,8 @@
 		reg = <0x66>;
 		interrupt-parent = <&gpx3>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&s5m8767_irq>;
 
 		vinb1-supply = <&main_dc_reg>;
 		vinb2-supply = <&main_dc_reg>;
@@ -530,6 +532,13 @@
 	cap-sd-highspeed;
 };
 
+&pinctrl_0 {
+	s5m8767_irq: s5m8767-irq {
+		samsung,pins = "gpx3-2";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.20.1

