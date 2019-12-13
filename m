Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C3C5070A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF16A24769
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="wVGNG34W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfLMNtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:49:41 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:35178 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfLMNtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:49:41 -0500
Received: from trochilidae.toradex.int (31-10-206-124.static.upc.ch [31.10.206.124])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 395885C05EA;
        Fri, 13 Dec 2019 14:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1576244979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=KGQxjK58jAQG6FE+vNh52hsu3NbDX3qzbuGmMeNbvdc=;
        b=wVGNG34WmvlBILnUGAbsYGUMOh2z1Trmyeqk11UEfG9AHKoO7OAoUj7tmDfJnKVxHZZSIk
        zUBjbeFSMPqAZQqsPRDUOYfMy4Xq2iUywvcTaJDJIUdlDqYr/TZgDhMMOShA+EVIJkR96O
        9TIx5ryMTe/ezWupM7PWTjOEBENhazo=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     stefan@agner.ch, philippe.schenker@toradex.com,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>
Subject: [PATCH] ARM: dts: imx6qdl-apalis: mux HDMI CEC pin
Date:   Fri, 13 Dec 2019 14:49:37 +0100
Message-Id: <20191213134937.257840-1-stefan@agner.ch>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Mux the HDMI CEC pin to make HDMI CEC working. With this change HDMI CEC
seems to work fine on a Apalis iMX6 on Ixora using cec-ctl.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 4b6b8b60ea19..f6dd48a4f89e 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -246,7 +246,7 @@
 
 &hdmi {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hdmi_ddc>;
+	pinctrl-0 = <&pinctrl_hdmi_ddc &pinctrl_hdmi_cec>;
 	status = "disabled";
 };
 
-- 
2.24.0

