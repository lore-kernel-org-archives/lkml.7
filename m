Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31CAC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6624C20672
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141764;
	bh=hF3+0/awYwGTiTMznroF4fqR9vXqdkxIXXDkxWqji8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U73Fx2K1pq3EuR7Nv0Y/rR+evnWJeoA/vY0p3KozN/ZD1+ht8Ig2QMcDozO0Py1uP
	 A7p9zaDDPnwEFmd/4Xns5eSFhdg4kTvYejsYGxqNEnMbL8SSKVu7ckq3Gcs02YhznW
	 lhLpI2DlRL4BFhDU+xkmzazpDBs+BLFIf62qkpug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfKSFgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbfKSFgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:36:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 393CB20672;
        Tue, 19 Nov 2019 05:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141759;
        bh=hF3+0/awYwGTiTMznroF4fqR9vXqdkxIXXDkxWqji8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=En0wh7odoUIxKO5TgjNH+TqDQeg6JAbE2ODAh3XNbIkMAvXfW+On2FGULtE2+Gtrr
         3Y3UyM4dg1qP0xnygfwYftbyToML4Ny818egLeyB5in4imbGGgtlTJC8jB3r6Ru42x
         VOfMZM21WN4P7ad5nT/C4CpGOP26mYMO4PrlUGHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 231/422] arm64: dts: rockchip: Fix I2C bus unit-address error on rk3399-puma-haikou
Date:   Tue, 19 Nov 2019 06:17:08 +0100
Message-Id: <20191119051414.015045393@linuxfoundation.org>
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

From: Rob Herring <robh@kernel.org>

[ Upstream commit 501500e65fa96f899230d66153fefd780f08dd34 ]

dtc has new checks for I2C buses. Fix the warnings in unit-addresses.

arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: Warning (i2c_bus_reg): /i2c@ff3d0000/codec@0a: I2C bus unit address format error, expected "a"

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 8ce4a79d9360f..1e6a71066c163 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -131,7 +131,7 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
-	sgtl5000: codec@0a {
+	sgtl5000: codec@a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&sgtl5000_clk>;
-- 
2.20.1



