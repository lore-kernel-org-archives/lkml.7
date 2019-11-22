Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F204FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09B42075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420713;
	bh=0KIFf+yZ8C/VuVjVmiu3e3orCWGVm8Ohdi7wNMRPvMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VUbdk0vxirntLIEUnZPpD6ypGrFe0f9JR9WpmEcki4HJoiFI8RbauuV2L5YlIDx/K
	 MCIKla/WOtWhwie5yENX9HubjdQB9rV7j+nmmj2QVy44EGg6LvXA7CPizE2/vVPsX3
	 VvstmqH5UyRpixXrxYRGB26oTFlN8zWt5IoISfCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbfKVLFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731656AbfKVLFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:05:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E8B2075E;
        Fri, 22 Nov 2019 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420708;
        bh=0KIFf+yZ8C/VuVjVmiu3e3orCWGVm8Ohdi7wNMRPvMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+lDfLKjZNu8oZgeUlo6gCn8LUc55+YiI8YimvaWktBXr44C6os4AI/viZ7K9BDPg
         zPMvBqFS66EcZDk+8/w4m5hmhO0GRqDEgxaV8gDPPhxovo+b3+/gX0p/jniIhaIfo0
         hORxcf2fXQAIAeoy4cm+5ecEP2yDZ6ML7U5XcCfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ching Huang <ching2048@areca.com.tw>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 198/220] scsi: arcmsr: clean up clang warning on extraneous parentheses
Date:   Fri, 22 Nov 2019 11:29:23 +0100
Message-Id: <20191122100928.204102618@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit ca2ade24157693b4e533ccec69df00ef719d4aad ]

There are extraneous parantheses that are causing clang to produce a
warning so remove these.

Clean up 3 clang warnings:
equality comparison with extraneous parentheses [-Wparentheses-equality]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Ching Huang <ching2048@areca.com.tw>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 12316ef4c8931..c75d4695f9828 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -4135,9 +4135,9 @@ static void arcmsr_hardware_reset(struct AdapterControlBlock *acb)
 		pci_read_config_byte(acb->pdev, i, &value[i]);
 	}
 	/* hardware reset signal */
-	if ((acb->dev_id == 0x1680)) {
+	if (acb->dev_id == 0x1680) {
 		writel(ARCMSR_ARC1680_BUS_RESET, &pmuA->reserved1[0]);
-	} else if ((acb->dev_id == 0x1880)) {
+	} else if (acb->dev_id == 0x1880) {
 		do {
 			count++;
 			writel(0xF, &pmuC->write_sequence);
@@ -4161,7 +4161,7 @@ static void arcmsr_hardware_reset(struct AdapterControlBlock *acb)
 		} while (((readl(&pmuE->host_diagnostic_3xxx) &
 			ARCMSR_ARC1884_DiagWrite_ENABLE) == 0) && (count < 5));
 		writel(ARCMSR_ARC188X_RESET_ADAPTER, &pmuE->host_diagnostic_3xxx);
-	} else if ((acb->dev_id == 0x1214)) {
+	} else if (acb->dev_id == 0x1214) {
 		writel(0x20, pmuD->reset_request);
 	} else {
 		pci_write_config_byte(acb->pdev, 0x84, 0x20);
-- 
2.20.1



