Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A85CC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D28D208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="bOtgZ3HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfFZHg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:36:28 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:59703 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbfFZHg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:36:27 -0400
Received: from mx-exchlnx-3.rrze.uni-erlangen.de (mx-exchlnx-3.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::39])
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZbF2Wbfz1yyK;
        Wed, 26 Jun 2019 09:36:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561534585; bh=rdfJF7OXdVWYWY0DWvBIoqdh3Lvhfgd9It92wyyn5EM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=bOtgZ3HUYyUs9S8aGAvG1ezLeyICnjzVZFRfEBmYPgmbyuAfeNsvZuqeZEskrmSRs
         uHu94ONqZmj2nDMmJc3lkt5Hz/DjBWff5tFM/5sdiWUAW9bPMPClC1cQYA13oRWvC7
         uG0cd1zpskc7e2J5cbk8KC78p+ilNHd7CISFRu3NtXus5dG7o2T+irhlW+eWnVNieQ
         rKBA66Kj9pDeIFTQ4dLCWyKyRDNj9j0DO51BjQiGbPeefZNCKh0MDVwVeoEPapWvm/
         Tu+A1bXSm7dsIKStr8h/gnpz0WTrhUyRfOv/uOqx4DPMaHC6p5ZECf6i27twUGr8yg
         c7y+faSvbJ1Zg==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-3.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZbC11Jwz1yy8;
        Wed, 26 Jun 2019 09:36:23 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun 2019
 09:36:03 +0200
Received: from TroubleWorld.fritz.box (95.90.221.207) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Wed, 26 Jun 2019 09:36:02 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        <linux-kernel@i4.cs.fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] staging: kpc2000: add spaces
Date:   Wed, 26 Jun 2019 09:35:23 +0200
Message-ID: <20190626073531.8946-6-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626073531.8946-1-fabian.krueger@fau.de>
References: <20190625115251.GA28859@kadam>
 <20190626073531.8946-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.90.221.207]
X-ClientProxiedBy: MBX3.exch.uni-erlangen.de (10.15.8.45) To
 MBX3.exch.uni-erlangen.de (10.15.8.45)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added spaces on the left side of parenthesis and on both sides of binary
operators. Also realigned else and else if so it matches the
parenthesis line.
This refactoring makes the code more readable.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index b4dba0e42c72..d5b4bd7b2ea7 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -226,10 +226,9 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
 		}
-	}
-	else if(rx) {
+	} else if (rx) {
 		for (i = 0 ; i < c ; i++) {
-			char test=0;
+			char test = 0;
 
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, 0x00);
 			res = kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS,
@@ -267,9 +266,8 @@ kp_spi_setup(struct spi_device *spidev)
 	cs = spidev->controller_state;
 	if (!cs) {
 		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
-		if(!cs) {
+		if (!cs)
 			return -ENOMEM;
-		}
 		cs->base = kpspi->base;
 		cs->conf_cache = -1;
 		spidev->controller_state = cs;
@@ -429,7 +427,7 @@ kp_spi_probe(struct platform_device *pldev)
 	int i;
 
 	drvdata = pldev->dev.platform_data;
-	if (!drvdata){
+	if (!drvdata) {
 		dev_err(&pldev->dev, "kp_spi_probe: platform_data is NULL!\n");
 		return -ENODEV;
 	}
@@ -479,7 +477,7 @@ kp_spi_probe(struct platform_device *pldev)
 		spi_new_device(master, &(table[i])); \
 	}
 
-	switch ((drvdata->card_id & 0xFFFF0000) >> 16){
+	switch ((drvdata->card_id & 0xFFFF0000) >> 16) {
 	case PCI_DEVICE_ID_DAKTRONICS_KADOKA_P2KR0:
 		NEW_SPI_DEVICE_FROM_BOARD_INFO_TABLE(p2kr0_board_info);
 		break;
-- 
2.17.1

