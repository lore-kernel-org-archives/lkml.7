Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1886C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D557214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354506;
	bh=Lyf/DK6TaNWV1nE4CudSgEBwr8TZnPiV8v9hGYLVzXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H1LNgDCKjbEsmerf940VEKAlHfyg+sfOmLNlrnA1inBhfS38Ppbf36q5aFE/q0F9M
	 2dvcCeOVyTmkfuyFQj6kDBBybpe1yEx4cBwT91Sd2GYOfG2VRKXcz6+uJU8KcVv5Lu
	 RIKewokHGK3E7g6sGpaF+uyW3C4Jd8E7JLidzyJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfKJCzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbfKJCu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:50:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67BE522A85;
        Sun, 10 Nov 2019 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354226;
        bh=Lyf/DK6TaNWV1nE4CudSgEBwr8TZnPiV8v9hGYLVzXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1toz7ORF3C7ztc3M8T41ZcO40piQ/YVVvCk+KfaUDycUXF1jch6bREyLJeFC8iUUa
         nMKf5BXpyqeB4jeGfCFaGWjnE9+xBnNcXalx3RbeW464gR2D/hPkNicHpiagDiES+6
         5iEhEoFFtqjVz5cWTz6oEuGKlUIgUz1TrkcCvJzo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 63/66] ARM: dts: lpc32xx: Fix SPI controller node names
Date:   Sat,  9 Nov 2019 21:48:42 -0500
Message-Id: <20191110024846.32598-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 11236ef582b8d66290bb3b3710e03ca1d85d8ad8 ]

SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
name enables dtc SPI bus checks.

Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 0d20aadc78bb1..5fa3111731cb0 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -179,7 +179,7 @@
 			 * ssp0 and spi1 are shared pins;
 			 * enable one in your board dts, as needed.
 			 */
-			ssp0: ssp@20084000 {
+			ssp0: spi@20084000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x20084000 0x1000>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
@@ -199,7 +199,7 @@
 			 * ssp1 and spi2 are shared pins;
 			 * enable one in your board dts, as needed.
 			 */
-			ssp1: ssp@2008c000 {
+			ssp1: spi@2008c000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x2008c000 0x1000>;
 				interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.20.1

