Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1816CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9160A206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfJZJJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:09:51 -0400
Received: from mout.perfora.net ([74.208.4.194]:53887 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfJZJJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:09:50 -0400
Received: from marcel-nb-toradex-int.cardiotech.int ([81.221.67.182]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MQdh4-1ib1S01G0U-00Nkh2; Sat, 26 Oct 2019 11:04:18 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 1/5] arm: dts: vf-colibri: fix typo in top-level module compatible
Date:   Sat, 26 Oct 2019 11:03:59 +0200
Message-Id: <20191026090403.3057-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uCkCQ5TKbiZEPOXRjuUU6qXHkYQrJJn9ygRw5CFh8WqiHqiMNIH
 6XJvGd+TbDVJksX+AEQotEHsuk7/gDK7WZjqhVGmXRByJJjpu+ZUZB5+yxbkuyOoioiKtxD
 2GKSezcg0OEusEbDk+okfru1hIlQtefsZVgtIxEzrKT14s/bJRgNnVRPWx4jXaZ09R0ZAO8
 G5mRaDsp4xgCjj4e1g2dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TepQZIodI7M=:Px5RUF6fF0wHbFsrTFQJ25
 GQ4GQEt+p0pCIXrX+GOlLwbi5hqYcyh1qe5brIuxpQos9MHZAoyQ6bZb54SdQY40Jf87ygDb+
 jVPfkUef37vB7pjLHraBi+mvzl2/g7/ayM5QKlrCiF6tlW+DuVVfgas8+LMYl4aLwZ1KxWPAS
 kpSE0fkTZj7CWCkB5Fegr6Gdi1/lOnayEFbeCcfDnDMXwN/HoGGTF3Kc0rrTQlSFemKyxYMQm
 onYNhlig7UEp7TUV22LERnKQZ0e36B7zJN682s6aLlskcEONcw6uOgHhEyg7ph/5iLOC9kT2Y
 br8APppcdMIFam+IAFvJq/jf9JqjKtZodKl4PgqI3l/SaoEqSoQ8/jxlQzvhOrh5YYIfSJDj9
 9JovqizTvae+Q331gaciDT6Ko65gNd0hh6PBBQ6w6Y1pjyUTK76h3MBEInk48XPq6KhOJiCzu
 Tj+G0PlrEdOZy1HM1nsO/8FPUqvrh+8fQDLMz2W+bjTqxifOgIuqNDyrvKWXd3dhcbKv8foiT
 j4uFVwedAj9GSVJWKL0D3ZXl1u7ompOOO+7rif8Lr9LzUczKzFqGCzcAHuiQI6AX131qrlokL
 p3ErQqH63qhoWhTXp3EhpuIYVg8tAJhA4s9Lr+jPvL6Rz4dyaPituQOJlqNWrWTgEUb3brKDJ
 ya2Za/oepYM2nbX/8cIE+gSCB47pyXKMa4U1HPUG/lrCaQX4YL/ZYCHYgJ8J3OUdW5pEI6H0R
 GqY1WYwd6fGucXE4frdfR5laHdz6RSIgzFBLEX1fa3ScJwijVU+OTUzGtC80FH87LNTMiD/j6
 +QiF7Pv0JhIch2j0ZIJul8V23MG37eWzgum1d//q4bC966RzkLYe2KK8XN9J0iXS+kHHxTTgy
 O/qpW+r2cHBMBherExgBNHVsnXJeQ295WiI9foX4w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix typo in top-level module compatible.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: New patch.

 arch/arm/boot/dts/vf500-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
index 237b0246fa84..92255f8893ce 100644
--- a/arch/arm/boot/dts/vf500-colibri.dtsi
+++ b/arch/arm/boot/dts/vf500-colibri.dtsi
@@ -44,7 +44,7 @@
 
 / {
 	model = "Toradex Colibri VF50 COM";
-	compatible = "toradex,vf610-colibri_vf50", "fsl,vf500";
+	compatible = "toradex,vf500-colibri_vf50", "fsl,vf500";
 
 	memory@80000000 {
 		device_type = "memory";
-- 
2.21.0

