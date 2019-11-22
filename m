Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27C3C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C759B20637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419254;
	bh=CTbRnSZq5ZLNEflGuQxqlQZhXHTVS1zUS0z7z21x1ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gfzdItKXJPxPl0Y2aN0THBlVothKgoq64wq9I6z8XC/wdszQrORaHVpcFsNyYdhtS
	 EsgjY8PJ63cqdUJjkYiBXPkh3eN5RpDURCtqm4EFKp2s4IYLvdRNifnKxqxV12xqz5
	 nY2RzLenIGJDfwa80T0RcVPlra5mROWxXlZ7Wuf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfKVKkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:40:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbfKVKku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:40:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD772071F;
        Fri, 22 Nov 2019 10:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419250;
        bh=CTbRnSZq5ZLNEflGuQxqlQZhXHTVS1zUS0z7z21x1ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktEKBYryckS57dUhatd9Mp+0MJaYJ1YV1jbmBuYx+zg3sut6vR7jdd46Pe0XK5dO0
         zpnHP+GMmSpEWnfKY2+lcc5Dd6mIORwauvD0DlPbOLwlGJcs0l8iPPH2NhZLxaNQnf
         30CqGmaGwsk7QicXXjrrChL9OE+SVGbGSdHWdw3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 048/222] ARM: dts: omap3-gta04: keep vpll2 always on
Date:   Fri, 22 Nov 2019 11:26:28 +0100
Message-Id: <20191122100853.416381190@linuxfoundation.org>
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
index 6b8e013e49bb9..7191506934494 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -536,6 +536,12 @@
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



