Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD6FC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 05:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108642083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 05:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFEFsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 01:48:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56500 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfFEFsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 01:48:14 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E88CE1A07A5;
        Wed,  5 Jun 2019 07:48:12 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C3871A00E7;
        Wed,  5 Jun 2019 07:48:08 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B2967402DD;
        Wed,  5 Jun 2019 13:48:01 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiafei.pan@nxp.com
Subject: [PATCH v6 3/5] usb: linux/fsl_device: Add platform member has_fsl_erratum_a006918
Date:   Wed,  5 Jun 2019 13:49:50 +0800
Message-Id: <20190605054952.34687-3-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605054952.34687-1-yinbo.zhu@nxp.com>
References: <20190605054952.34687-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add member has_fsl_erratum_a006918 in platform data

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 include/linux/fsl_devices.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index cb2b46f57af3..5d231ce8709b 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -98,6 +98,7 @@ struct fsl_usb2_platform_data {
 	unsigned	has_fsl_erratum_14:1;
 	unsigned	has_fsl_erratum_a005275:1;
 	unsigned	has_fsl_erratum_a005697:1;
+	unsigned        has_fsl_erratum_a006918:1;
 	unsigned	check_phy_clk_valid:1;
 
 	/* register save area for suspend/resume */
-- 
2.17.1

