Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB621C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8774A21848
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353942;
	bh=jIFlpl/wQMGI9GNYRcwXiD1YCvrHp52FADOVP/p53Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QW6n3xmzGO70MbgQl7veyxYz8Yg1ao9yvsSDm3Mn1M1VtTg8qh8fjqT+PqIU+Zjtv
	 myz3EY1BDCP8NhBOzldIvHFLUhifCu1TGewZg40DNrh8JPBo+RblhDe1Hibiv9BtQt
	 tita6p0uoYOXZhZzB3LCQRUDewSR7FfnxRqRXcFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKJCpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:45:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbfKJCpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:45:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD3021848;
        Sun, 10 Nov 2019 02:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353916;
        bh=jIFlpl/wQMGI9GNYRcwXiD1YCvrHp52FADOVP/p53Gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Sdd0Q9RBFFJ+ZB/2YF0wEo2t3U7YWTRaq7LFgkOhgzvH8LO0qsExsZcmkDJza/jj
         ZqCqt97qvHlExFcQxdaPm0qmuR4l/9GYMgBkCSGEdNZbGBzBIuDXBFTegaTICDejoj
         bUZCcuxnjlBGn/X7EIv9RIxHkqNCa0ZH1qkdoLRA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 179/191] ARM: dts: lpc32xx: Fix SPI controller node names
Date:   Sat,  9 Nov 2019 21:40:01 -0500
Message-Id: <20191110024013.29782-179-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
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
index 4981741377f3a..ed0d6fb20122a 100644
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

