Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE27FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5724207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDBXKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:10:19 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:35922 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBXKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:10:18 -0400
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id BSPyhVn8kldkPBSPzhKte9; Tue, 02 Apr 2019 17:02:11 -0600
X-Authority-Analysis: v=2.3 cv=Ko4zJleN c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=oexKYjalfGEA:10 a=Q-fNiiVtAAAA:8
 a=Y8eT2_GWdJ9rPwgqqmoA:9 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id 3E64E3010142F1; Tue,  2 Apr 2019 16:02:10 -0700 (PDT)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] memory: brcmstb: dpfe: remove unused code and fix formatting
Date:   Tue,  2 Apr 2019 16:00:58 -0700
Message-Id: <20190402230103.25491-2-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402230103.25491-1-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBrLP7lsMVhbA5+f36tGdq25LQV8b6zVoAxfkg4q9+s3Cz5l+6RLYhu3aAjNolr6Cerk1c9ah2O8zECYYuSt3/rAsNgxUsFNOY8O1jG3BFe1z8vugHHF
 CxpCnjFJtp2K5IUUZVNY55lgQ2NxOrcNFM90yRMZ6WLc5DM/sSFWy3P7l4Ud+sqOKIZE4C0FjN0WgkCzitoUF77cKrx1hb4TMMhocCK1L4HpF4nX/6Io4Vk7
 YhSBMfaTrI9hHW/TAcPbo7gsFfuug18HBDC6P5QbCkF5KIF0x4KKZFfxFvxUrJnmHyNllNylW3if5sBpuw+Z8JDKfFYrvQEg6RJzYqfGPKh6eJWY9k04e3mk
 bxtG2+bgd9p7/AB4gqCaq7gwcFXk71u3LiQbK6/+4bnKa/awCvPBBhfC7WomdAm2DnSjTx9HToMqJnDMln0fkZUfQ0xK8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Remove an unused struct and fix source code formatting in a few areas.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index fae3ac3d65c6..f143e40e528b 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -131,14 +131,6 @@ enum dpfe_commands {
 	DPFE_CMD_MAX /* Last entry */
 };
 
-struct dpfe_msg {
-	u32 header;
-	u32 command;
-	u32 arg_count;
-	u32 arg0;
-	u32 chksum; /* This is the sum of all other entries. */
-};
-
 /*
  * Format of the binary firmware file:
  *
@@ -585,7 +577,7 @@ static ssize_t show_refresh(struct device *dev,
 		return ret;
 
 	mr4 = (readl_relaxed(info + DRAM_INFO_MR4) >> DRAM_INFO_MR4_SHIFT) &
-	      DRAM_INFO_MR4_MASK;
+	       DRAM_INFO_MR4_MASK;
 
 	refresh = (mr4 >> DRAM_MR4_REFRESH) & DRAM_MR4_REFRESH_MASK;
 	sr_abort = (mr4 >> DRAM_MR4_SR_ABORT) & DRAM_MR4_SR_ABORT_MASK;
@@ -612,7 +604,6 @@ static ssize_t store_refresh(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	priv = dev_get_drvdata(dev);
-
 	ret = __send_command(priv, DPFE_CMD_GET_REFRESH, response);
 	if (ret)
 		return ret;
@@ -627,7 +618,7 @@ static ssize_t store_refresh(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t show_vendor(struct device *dev, struct device_attribute *devattr,
-			 char *buf)
+			   char *buf)
 {
 	u32 response[MSG_FIELD_MAX];
 	struct private_data *priv;
-- 
2.17.1

