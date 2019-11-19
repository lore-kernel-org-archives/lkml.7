Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5965C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858EA222DC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141406;
	bh=a8iXu8RnT4u8d3wUf+Xu8tDfl5Vhe4ENrPCED6Q5Btk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jspzXrWlf8mtW6bPc6/tG/142zw0hAhOPLWUXpGiFymwXqUekuyDbArmT+8WTJsWs
	 hua1suGKdF6tFEGpUWJJC6oF992LIwqCKOc4Qyo/sr7i+MME4B+j6O6qiLST1CaJ2B
	 mGecztw3GyFZ8TEYpkU8qyfb76ORlW6wXESbPK90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfKSFaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbfKSFaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:30:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 687EF222A2;
        Tue, 19 Nov 2019 05:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141400;
        bh=a8iXu8RnT4u8d3wUf+Xu8tDfl5Vhe4ENrPCED6Q5Btk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUxgXxrxJ13Lw2UAOLyFz7Mj8uFpoaJwG5Yuj/MkxM1YnGrKzy69v17/+Y/7WM3jm
         1E7wQ0xDpDo9VsuorTFv21Myn9GOrXFwN05ZrmG4wUHKcj5b1qbojQZOya+bdJDHoK
         fuLTjHXcYQB2M60VJO1+XbBLhxhDeH0B8ghh9AKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 149/422] arm64: dts: rockchip: Fix VCC5V0_HOST_EN on rk3399-sapphire
Date:   Tue, 19 Nov 2019 06:15:46 +0100
Message-Id: <20191119051408.309324432@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vicente Bergas <vicencb@gmail.com>

[ Upstream commit bcdb578a5f5b4aea79441606ab7f0a2e076b4474 ]

The pin is GPIO4-D1 not GPIO1-D1, see schematic, page 15 for reference.

Signed-off-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index 36b60791c156d..8b33ef3306820 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -116,7 +116,7 @@
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio1 RK_PD1 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&vcc5v0_host_en>;
 		regulator-name = "vcc5v0_host";
-- 
2.20.1



