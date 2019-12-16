Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15444C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4282082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522122;
	bh=OwVgrZZe3+NEKgSc3Kxz+SFE+8Xi58o59qJvArZOm0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LntRxFRcQr5H+3uF/aVW9xrIjj0yLWCXOy1XtlqdWIapIeCrkyrD1rUUGd/HU4pUo
	 Q6CEmvb3hZNhsX8rQqan0wNLI39UMxWmutGvOTFV6L2EIi2lj51GDM0s5+FolYlFqe
	 3ykdVPh1Mxf69QKfyCA1FuleXuNTPnWvrfjaUpGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLPRyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbfLPRxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:53:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF0C20733;
        Mon, 16 Dec 2019 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518835;
        bh=OwVgrZZe3+NEKgSc3Kxz+SFE+8Xi58o59qJvArZOm0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Og/COYC443uYKL7YHOV93NLFCVgzC3Yy1EXqDUKe8+agAsyxnby51vO9x/oP47Wez
         7ILzu7CrinZLeePhinU0+sVnlFoarVfh6oI4iHKMTPAaP49J8hWOZeyjfcuzk8pqcT
         HZ299QtvbMLxERow4OUdndj1mcfhA4RPg+wSzu7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 086/267] arm64: dts: meson-gxbb-odroidc2: fix GPIO lines names
Date:   Mon, 16 Dec 2019 18:46:52 +0100
Message-Id: <20191216174857.725366756@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
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
index c3c65b06ba76b..4ea23df81f212 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -189,7 +189,7 @@
 	pinctrl-names = "default";
 };
 
-&pinctrl_aobus {
+&gpio_ao {
 	gpio-line-names = "UART TX", "UART RX", "VCCK En", "TF 3V3/1V8 En",
 			  "USB HUB nRESET", "USB OTG Power En",
 			  "J7 Header Pin2", "IR In", "J7 Header Pin4",
@@ -197,7 +197,7 @@
 			  "HDMI CEC", "SYS LED";
 };
 
-&pinctrl_periphs {
+&gpio {
 	gpio-line-names = /* Bank GPIOZ */
 			  "Eth MDIO", "Eth MDC", "Eth RGMII RX Clk",
 			  "Eth RX DV", "Eth RX D0", "Eth RX D1", "Eth RX D2",
-- 
2.20.1



