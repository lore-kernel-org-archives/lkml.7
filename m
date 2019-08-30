Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C83EC3A5A7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB7A21726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfH3Iz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:55:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46274 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbfH3IzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:55:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CDEA4200281;
        Fri, 30 Aug 2019 10:55:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F03E2001B1;
        Fri, 30 Aug 2019 10:55:04 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 63A58402BC;
        Fri, 30 Aug 2019 16:54:50 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        dmitry.torokhov@gmail.com, aisheng.dong@nxp.com,
        ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com,
        daniel.baluta@nxp.com, leonard.crestez@nxp.com, olof@lixom.net,
        mripard@kernel.org, arnd@arndb.de, jagan@amarulasolutions.com,
        bjorn.andersson@linaro.org, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, hsweeten@visionengravers.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org, stefan@agner.ch,
        ronald@innovation.ch, ping.bai@nxp.com, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 4/5] arm64: dts: imx8qxp-mek: Enable scu power key
Date:   Fri, 30 Aug 2019 16:53:48 -0400
Message-Id: <1567198429-27886-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567198429-27886-1-git-send-email-Anson.Huang@nxp.com>
References: <1567198429-27886-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable scu power key for i.MX8QXP MEK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 1946805..f3df5c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -234,3 +234,7 @@
 &adma_dsp {
 	status = "okay";
 };
+
+&scu_pwrkey {
+	status = "okay";
+};
-- 
2.7.4

