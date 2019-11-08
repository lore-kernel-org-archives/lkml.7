Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E208FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04015222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213771;
	bh=Utzkaksfpu3Lct4rFLnmEDm/He7L40Lde6OkD4hNLUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BUFgbAwTaiRPv28fd+tC5iSx8xekdJG2QG4XU3SPdVC+f2xqZGX/YnPOYRHq5kGdO
	 vRQYnUUInf5TOlwokcCILbo7QBZaWQNjyLHf1lpEU7o5uc/3Sq6plDJeohc12mo6YF
	 uJUdJj0j+i3XXLqnudD1WpGgwKplFPr2uLyAqTHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389470AbfKHLt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391729AbfKHLsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:48:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4639C222D1;
        Fri,  8 Nov 2019 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213699;
        bh=Utzkaksfpu3Lct4rFLnmEDm/He7L40Lde6OkD4hNLUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y2WuO5tkvrHLcGzWE5jXrhKenGLtB9by1iCZdIEZbahelKKdtShbYz1JeIRICJB0F
         uQWXp/MG124gLYkuPYRWqR6vK3IRwOcefj5TKjGwEpcMbv1+Hq6qeIYeUOEEG+6vc5
         4myO5fJki78dLPI/7zjgPYBVESvSKWzgqpv3pSbY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 39/44] ARM: dts: socfpga: Fix I2C bus unit-address error
Date:   Fri,  8 Nov 2019 06:47:15 -0500
Message-Id: <20191108114721.15944-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114721.15944-1-sashal@kernel.org>
References: <20191108114721.15944-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinguyen@kernel.org>

[ Upstream commit cbbc488ed85061a765cf370c3e41f383c1e0add6 ]

dtc has new checks for I2C buses. Fix the warnings in unit-addresses.

arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dtb: Warning (i2c_bus_reg): /soc/i2c@ffc04000/adxl345@0: I2C bus unit address format error, expected "53"

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
index 555e9caf21e16..7b8e1c4215b51 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
@@ -88,7 +88,7 @@
 	status = "okay";
 	speed-mode = <0>;
 
-	adxl345: adxl345@0 {
+	adxl345: adxl345@53 {
 		compatible = "adi,adxl345";
 		reg = <0x53>;
 
-- 
2.20.1

