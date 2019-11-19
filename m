Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E643BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B940220721
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142589;
	bh=wI0Y7z5AHDqJ+AST5CMYwQhdap/yK+byxdopLPwAtqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rq+4N6K/Lg4lwB7KYBxdc/ckc/Zjhd75sf4sIBFzzI9nq01s5vPcPfso0VpgzHJ3/
	 2V9SHSZnbz4DfwOoKfG7JxHIFklm9GJ50IAvHPZbaDUAKbG3SP2m1bIsm9o5z5bBah
	 JqIhM7a0T92a3z9CuY4Mi72cRAJYEyz9v/wMMg84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbfKSFts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:49:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbfKSFtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:49:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA3B20721;
        Tue, 19 Nov 2019 05:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142585;
        bh=wI0Y7z5AHDqJ+AST5CMYwQhdap/yK+byxdopLPwAtqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9W2o8nQ/sX4UFlmE91+MuAgES4lhsAWQj4V4S6xHDc8SYGgDSm84UaC99utxQGbk
         NsvZk9N/Ey3LPOnNnx09bxFHa0Qa3WERIQvnL+fA1fUIJy0PRJqrjEjI8QbwuVlFJw
         OZon1UPGJ4qqI6gyqCZbsMn1ECxGXS120J8P2aio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 081/239] ARM: dts: omap3-gta04: keep vpll2 always on
Date:   Tue, 19 Nov 2019 06:18:01 +0100
Message-Id: <20191119051315.368896635@linuxfoundation.org>
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

From: H. Nikolaus Schaller <hns@goldelico.com>

[ Upstream commit 1ae00833e30c9b4af5cbfda65d75b1de12f74013 ]

This is needed to make the display and venc work properly.
Compare to omap3-beagle.dts.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 7992489b953e8..e83d0619b3b7c 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -537,6 +537,12 @@
 	regulator-max-microvolt = <3150000>;
 };
 
+/* Needed to power the DPI pins */
+
+&vpll2 {
+	regulator-always-on;
+};
+
 &dss {
 	pinctrl-names = "default";
 	pinctrl-0 = < &dss_dpi_pins >;
-- 
2.20.1



