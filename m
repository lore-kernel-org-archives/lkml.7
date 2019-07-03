Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA6BC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32A6218B6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfGCTE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:04:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50542 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfGCTEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:04:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 30BF920043C;
        Wed,  3 Jul 2019 21:04:20 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 21BC7200434;
        Wed,  3 Jul 2019 21:04:20 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 96388205F0;
        Wed,  3 Jul 2019 21:04:19 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/3] firmware: imx: scu-pd: Add mu_b side PD range
Date:   Wed,  3 Jul 2019 22:04:03 +0300
Message-Id: <20190703190404.21136-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703190404.21136-1-daniel.baluta@nxp.com>
References: <20190703190404.21136-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSIO subsystem contains 14 MU instances.

5 MUs to communicate between AP <-> SCU
  - side-A PD range managed by AP
  - side-B PD range managed by SCU

9 MUs to communicate between AP <-> M4
  - side-A PD range managed by AP
  - side-B PD range managed by AP

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 950d30238186..30adc3104347 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -93,6 +93,7 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "kpp", IMX_SC_R_KPP, 1, false, 0 },
 	{ "fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
 	{ "mu_a", IMX_SC_R_MU_0A, 14, true, 0 },
+	{ "mu_b", IMX_SC_R_MU_5B, 9, true, 0 },
 
 	/* CONN SS */
 	{ "usb", IMX_SC_R_USB_0, 2, true, 0 },
-- 
2.17.1

