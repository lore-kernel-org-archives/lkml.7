Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5A5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B612071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419532;
	bh=Lyf/DK6TaNWV1nE4CudSgEBwr8TZnPiV8v9hGYLVzXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TAxd7C87PARfCKg6DtAdzR5gartGFPm0aw/bUE6tLAjFzcBnDOKTURL5/Nbmx404M
	 nUGcB1q/8vngb3F+31ALb/tIiGRogTfSX1wjfuopZNKZ1nf3Bz2QLo8/6QVAJ55d5d
	 83QX3mLcBMnvttwf/jIb42NI+ZDd9xrkBWz+3tdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfKVKpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729466AbfKVKp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:45:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A102073F;
        Fri, 22 Nov 2019 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419526;
        bh=Lyf/DK6TaNWV1nE4CudSgEBwr8TZnPiV8v9hGYLVzXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spi14y07UxnNmNqUHiKYCgeGkO8IelAYk29qU9VkEI3PT6SkLJdKJp+J31C2OK8Nd
         Wng3DWw4zEiU+YkF7mgvPxoZja0d68zJu/WAe524oNhMj27UEUkt0x9w4GAT3IZ5ba
         OmJkWxgyTMBzdnMH2rTMJr/bRIH7Zwp9NSMTXm/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 142/222] ARM: dts: lpc32xx: Fix SPI controller node names
Date:   Fri, 22 Nov 2019 11:28:02 +0100
Message-Id: <20191122100913.102331773@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



