Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1511C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A215206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354317;
	bh=sqb++TXGGyVWzTbjaKuwOI/0PkCaHEm9xxhq7qwYYes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=by3wlqF0QsZcAEheBrU09FpLpVYEb6deUcDq/7vNb3QV8kJLtR6FGf5qZJI8ZOYdR
	 Zu+v5XUNTXY95V/YdhL1JXhf6RSJh8QoNXwaHBiSDKVQq51+dnjTRDFBLesAagmWOU
	 H3kk7Y3jcwJCLykftmHI8ubs+2rTFGlEOgWjJPHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfKJCv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbfKJCvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:51:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E77CF22573;
        Sun, 10 Nov 2019 02:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354303;
        bh=sqb++TXGGyVWzTbjaKuwOI/0PkCaHEm9xxhq7qwYYes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISG9ciZ2QsuXHeuTy/d5qh5T7OWkVIFlq9jn1xS7ueLK8wr05u+pmS6xB9bjQKoi/
         oCIPgOrA3/K6XuO5qX/EolkjSFWHBv3VAMqVleZBiG/Ij5CmPqTRuXNEXhAhuQewFx
         oGRm05ISNpF9cF/zxr/0cPa2NhyzBow3ykA5akjk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 39/40] arm64: dts: amd: Fix SPI bus warnings
Date:   Sat,  9 Nov 2019 21:50:31 -0500
Message-Id: <20191110025032.827-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110025032.827-1-sashal@kernel.org>
References: <20191110025032.827-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit e9f0878c4b2004ac19581274c1ae4c61ae3ca70e ]

dtc has new checks for SPI buses. Fix the warnings in node names.

arch/arm64/boot/dts/amd/amd-overdrive.dtb: Warning (spi_bus_bridge): /smb/ssp@e1030000: node name for SPI buses should be 'spi'
arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dtb: Warning (spi_bus_bridge): /smb/ssp@e1030000: node name for SPI buses should be 'spi'
arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dtb: Warning (spi_bus_bridge): /smb/ssp@e1030000: node name for SPI buses should be 'spi'

Cc: Brijesh Singh <brijeshkumar.singh@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 2874d92881fda..a3030c868be5f 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -84,7 +84,7 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		spi0: ssp@e1020000 {
+		spi0: spi@e1020000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
 			#gpio-cells = <2>;
@@ -95,7 +95,7 @@
 			clock-names = "apb_pclk";
 		};
 
-		spi1: ssp@e1030000 {
+		spi1: spi@e1030000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
 			#gpio-cells = <2>;
-- 
2.20.1

