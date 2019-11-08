Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B819EC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852F020869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214435;
	bh=pJS58U8mwZIYJHL/49hU2S6Sd3AeaEcSOOkKJJyeS8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q0kVZ+FntVpT6M4gZfv1mAmxLZBIWilq4+llxO2vS5SfzyX3YMzil9nhyaO44xFwT
	 pbHqcDzKEDoMJWNlryLlmZgLlxbug470tuBolAUMRlN7XspS16+hxr1GWRvzbYLXGO
	 5HuTVKQ1YwH8atquUjC8rpAoK2dGTQCU6l6YeX3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391729AbfKHMAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390600AbfKHLnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B3862245A;
        Fri,  8 Nov 2019 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213433;
        bh=pJS58U8mwZIYJHL/49hU2S6Sd3AeaEcSOOkKJJyeS8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zoS8PnDIyQkDQSChD4uqKBRuLCizD7v8DZX7+Vq9otK8YfycL7risRhtRBiKTQUL4
         i1GoFFGeQHCgHkbBm+H01nzpTSBJaubYfofDCPavsiPwBOgoWECm2X3GhuarOH4CkB
         V6OAIo4GL/dY7ACuiafsgAyiiO3NGaZ0GYTWnpSY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 031/103] ARM: dts: pxa: fix power i2c base address
Date:   Fri,  8 Nov 2019 06:41:56 -0500
Message-Id: <20191108114310.14363-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel@ziswiler.com>

[ Upstream commit 8a1ecc01a473b75ab97be9b36f623e4551a6e9ae ]

There is one too many zeroes in the Power I2C base address. Fix this.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/pxa27x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 2ab6986433c82..3228ad5fb725f 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -71,7 +71,7 @@
 			clocks = <&clks CLK_PWM1>;
 		};
 
-		pwri2c: i2c@40f000180 {
+		pwri2c: i2c@40f00180 {
 			compatible = "mrvl,pxa-i2c";
 			reg = <0x40f00180 0x24>;
 			interrupts = <6>;
-- 
2.20.1

