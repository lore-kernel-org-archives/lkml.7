Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314B7C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF45B208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142497;
	bh=HdPHDp3BlBc7LAHKrrfU2bGbLW19OD8QFTgc6uk6uuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cg1iyHwqZFPci5G9sib8EibbvR2Gy4CtjWmCJ51oZ7cLJCfbPxx1zRLnAQivhXfK9
	 Wg76EZSSRoXoUSLybYr2J4UL5xn36zvA/imGQUlcyKxnR2gn3G3D5VhwQiERgTQP0f
	 Zh4ZafXWW7864tSYYv3Y1meKoKsvDMw+wekBj7rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfKSFsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731321AbfKSFsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:48:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2762071B;
        Tue, 19 Nov 2019 05:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142493;
        bh=HdPHDp3BlBc7LAHKrrfU2bGbLW19OD8QFTgc6uk6uuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=riFTTKZ6IO+EVfwa6h5lSAClLtek8a5VgbZ+0QIC3kEE13LZtY5BCYC0SfeXlvfsq
         8TWPZgHanvdOLalSA1HBrlUeoKg2uW3gcZU+ybADzXwqp+KAZA5iWWPr6BRHhwy8iZ
         tFcUetGmYr74manTJuDWGUTR7+wGGtZKcbXqhT2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 083/239] arm64: dts: rockchip: Fix VCC5V0_HOST_EN on rk3399-sapphire
Date:   Tue, 19 Nov 2019 06:18:03 +0100
Message-Id: <20191119051316.339430105@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
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
index ce592a4c0c4cd..82576011b959b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -136,7 +136,7 @@
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



