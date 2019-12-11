Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA48C2D0C7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70232073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079501;
	bh=SzMJyPNV6wAQy+vcTNqjI8o8y4jxA+AfKRf1/AMgt8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dD4rE54Z0lnsuxgSokH4UarW4YybU+qtAGauFNZBsXgBwtmbdAeBhx6HvKIYYBaCz
	 AExHKr6f4iHzY6+YLGSPXUPVIjIZqmTKaldvf70TIz12f7NB7n0MtYk0KCW+oF+9dr
	 TXbg8zY7cZ53mAprUoRTR+P+3gckM/ySHWXBlJes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfLKPVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732354AbfLKPVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:21:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89CE922B48;
        Wed, 11 Dec 2019 15:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077708;
        bh=SzMJyPNV6wAQy+vcTNqjI8o8y4jxA+AfKRf1/AMgt8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDLRmmjHX2E4jfcXJMu7hJSyJdNmI2hPxoMH1PAUE0j/EaTYYT8+QdOR4I3JGFMLe
         qtL30LL2VzNRk3Yl5QzI7viRdF2rlew4aCQo0g3mj2XbVWzjLKzKqjaooq9tsdfpUv
         cLjMA2v+0IQPsrHoV+I+bsrLZXu40ZvB1U3seQS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 139/243] arm64: dts: meson-gxl-libretech-cc: fix GPIO lines names
Date:   Wed, 11 Dec 2019 16:05:01 +0100
Message-Id: <20191211150348.543346964@linuxfoundation.org>
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

[ Upstream commit 11fa9774612decea87144d7f950a9c53a4fe3050 ]

The gpio line names were set in the pinctrl node instead of the gpio node,
at the time it was merged, it worked, but was obviously wrong.
This patch moves the properties to the gpio nodes.

Fixes: 47884c5c746e ("ARM64: dts: meson-gxl-libretech-cc: Add GPIO lines names")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 90a56af967a7f..b4dfb9afdef86 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -163,7 +163,7 @@
 	};
 };
 
-&pinctrl_aobus {
+&gpio_ao {
 	gpio-line-names = "UART TX",
 			  "UART RX",
 			  "Blue LED",
@@ -178,7 +178,7 @@
 			  "7J1 Header Pin15";
 };
 
-&pinctrl_periphs {
+&gpio {
 	gpio-line-names = /* Bank GPIOZ */
 			  "", "", "", "", "", "", "",
 			  "", "", "", "", "", "", "",
-- 
2.20.1



