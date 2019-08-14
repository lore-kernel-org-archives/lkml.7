Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F402C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D3A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfHNHYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:24:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39410 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfHNHYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:24:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 749981A0348;
        Wed, 14 Aug 2019 09:24:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C2BAA1A00E8;
        Wed, 14 Aug 2019 09:24:22 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9341F402EC;
        Wed, 14 Aug 2019 15:24:09 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Alison Wang <alison.wang@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>,
        Rajat Srivastava <rajat.srivastava@nxp.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 2/4] soc: fsl: guts: Add definition for LS1028A
Date:   Wed, 14 Aug 2019 15:26:47 +0800
Message-Id: <20190814072649.8237-2-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814072649.8237-1-yinbo.zhu@nxp.com>
References: <20190814072649.8237-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding compatible string "ls1028a-dcfg" to initialize guts driver
for ls1028 and SoC die attribute definition for LS1028A

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/soc/fsl/guts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 1ef8068c8dd3..34810f9bb2ee 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -102,6 +102,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	  .svr          = 0x87360000,
 	  .mask         = 0xff3f0000,
 	},
+	/* Die: LS1028A, SoC: LS1028A */
+	{ .die          = "LS1028A",
+	  .svr          = 0x870b0000,
+	  .mask         = 0xff3f0000,
+	},
 	{ },
 };
 
@@ -224,6 +229,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls1012a-dcfg", },
 	{ .compatible = "fsl,ls1046a-dcfg", },
 	{ .compatible = "fsl,lx2160a-dcfg", },
+	{ .compatible = "fsl,ls1028a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
-- 
2.17.1

