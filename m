Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1F0214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077715;
	bh=uS7gmQDj9sSE+2xzjmZNv7rUzSLA/iIGv1gGDR6Rsys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0G3WsQKy7ahRGTr0pG+dwbnHqv8AFtWlEleIN/83GALOC7DdC4Pbeu5W0wXCg2iqc
	 sriAwxqijFrJDsYX8t+ReU+6wOVFi7mq0zuyw6/TsZYAEy0Nv55Th4GkXgNRcVurln
	 RufI22TtJzmKVs+yVOWhi7JGZfVLPZP+gkExvh+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbfLKPVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731800AbfLKPVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:21:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2A51214AF;
        Wed, 11 Dec 2019 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077713;
        bh=uS7gmQDj9sSE+2xzjmZNv7rUzSLA/iIGv1gGDR6Rsys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kV7EUuDTgFMsq4mEwzGSz5L0CMDoBP6eAekLiwTaukGB++lIKHq3D4yX771ZxUR+7
         UttsOwRDMQ1TjKFYAZaSCFkfAXryreW1ll3iQZBNDWCP/hQflc2j2mJYcvHe9jSNxT
         D2UsGR0xrFQqg/CpexIk+OiZUjOcGTJ/SttkJke8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 141/243] arm64: dts: meson-gxbb-odroidc2: fix GPIO lines names
Date:   Wed, 11 Dec 2019 16:05:03 +0100
Message-Id: <20191211150348.679716778@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit 2165b006b65d609140dafafcb14cce5a4aaacbab ]

The gpio line names were set in the pinctrl node instead of the gpio node,
at the time it was merged, it worked, but was obviously wrong.
This patch moves the properties to the gpio nodes.

Fixes: b03c7d6438bb ("ARM64: dts: meson-gxbb-odroidc2: Add GPIO lines names")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 54954b314a452..00f7be6d83f7c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -187,7 +187,7 @@
 	pinctrl-names = "default";
 };
 
-&pinctrl_aobus {
+&gpio_ao {
 	gpio-line-names = "UART TX", "UART RX", "VCCK En", "TF 3V3/1V8 En",
 			  "USB HUB nRESET", "USB OTG Power En",
 			  "J7 Header Pin2", "IR In", "J7 Header Pin4",
@@ -197,7 +197,7 @@
 			  "";
 };
 
-&pinctrl_periphs {
+&gpio {
 	gpio-line-names = /* Bank GPIOZ */
 			  "Eth MDIO", "Eth MDC", "Eth RGMII RX Clk",
 			  "Eth RX DV", "Eth RX D0", "Eth RX D1", "Eth RX D2",
-- 
2.20.1



