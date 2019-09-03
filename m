Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC761C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC09D206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfICJiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:38:07 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54800 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbfICJiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:38:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A4453200177;
        Tue,  3 Sep 2019 11:38:03 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1989C200156;
        Tue,  3 Sep 2019 11:37:45 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D63974031E;
        Tue,  3 Sep 2019 17:37:31 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        dmitry.torokhov@gmail.com, aisheng.dong@nxp.com,
        ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com,
        daniel.baluta@nxp.com, leonard.crestez@nxp.com, mripard@kernel.org,
        olof@lixom.net, arnd@arndb.de, jagan@amarulasolutions.com,
        bjorn.andersson@linaro.org, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, stefan@agner.ch,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        yuehaibing@huawei.com, tglx@linutronix.de, ronald@innovation.ch,
        m.felsch@pengutronix.de, ping.bai@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 4/5] arm64: dts: imx8qxp-mek: Enable scu key
Date:   Tue,  3 Sep 2019 17:36:39 -0400
Message-Id: <1567546600-21566-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567546600-21566-1-git-send-email-Anson.Huang@nxp.com>
References: <1567546600-21566-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable scu key for i.MX8QXP MEK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- change node name accordingly.
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 1946805..88dd9132 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -234,3 +234,7 @@
 &adma_dsp {
 	status = "okay";
 };
+
+&scu_key {
+	status = "okay";
+};
-- 
2.7.4

