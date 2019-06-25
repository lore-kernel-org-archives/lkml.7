Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824D0C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5774D215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="Z5Ei0aMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbfFYLgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:36:51 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:46131 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728703AbfFYLgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:36:49 -0400
Received: from mx-exchlnx-3.rrze.uni-erlangen.de (mx-exchlnx-3.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::39])
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3nS2cKzz209F;
        Tue, 25 Jun 2019 13:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561462108; bh=ITXhcPzWjgJuGHxZgbdlGIeNhh56N+8yXgOW99Y2pMY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=Z5Ei0aMX+wI3tcuCRpA7e/sUVYITJh2FupuFXFbKnr8vr53otE5ErEuyU/yukva91
         EZUf6bYrxSudsfAd2dWpEoJrd+rF0bi6S6HWANVlrYUEbEjbQO++jz+MRKyRMAsYGA
         V1jtwWaBAkOT0gz+FwD4yS05XFNULzpLZtHEOrkevjnbcuJU4kke/aY3NCeuUcDOUb
         WXZbX2WVD77RFvwNI6sDlrpBdugiyTCY5Kv6QR/eb/jDS6SsoRtxFG0eScjy0H2016
         mKJARtpPgLQ7Zc5RbX+c3To1wOo9Sd/FQKnqlu2vupj7XTx+AEE8PtW7nBFB6CbXb8
         mp9QCBwhB3Fpg==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-3.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3nQ1DS5z208r;
        Tue, 25 Jun 2019 13:28:26 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Jun 2019
 13:27:40 +0200
Received: from TroubleWorld.pool.uni-erlangen.de (10.21.22.37) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Tue, 25 Jun 2019 13:27:39 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] staging: kpc2000: add spaces
Date:   Tue, 25 Jun 2019 13:27:15 +0200
Message-ID: <20190625112725.10154-5-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625112725.10154-1-fabian.krueger@fau.de>
References: <20190625112725.10154-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.22.37]
X-ClientProxiedBy: MBX3.exch.uni-erlangen.de (10.15.8.45) To
 MBX3.exch.uni-erlangen.de (10.15.8.45)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added spaces on the left side of parenthesis and on both sides of binary
operators.
This refactoring makes the code more readable.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 253a9c150d33..8f56886f4673 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -192,9 +192,8 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 	u64 val;
 
 	addr += idx;
-	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0)){
+	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0))
 		return cs->conf_cache;
-	}
 	val = readq(addr);
 	return val;
 }
@@ -255,10 +254,9 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
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
 
@@ -298,9 +296,8 @@ kp_spi_setup(struct spi_device *spidev)
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
@@ -467,7 +464,7 @@ kp_spi_probe(struct platform_device *pldev)
 	int i;
 
 	drvdata = pldev->dev.platform_data;
-	if (!drvdata){
+	if (!drvdata) {
 		dev_err(&pldev->dev, "kp_spi_probe: platform_data is NULL!\n");
 		return -ENODEV;
 	}
@@ -518,7 +515,7 @@ kp_spi_probe(struct platform_device *pldev)
 		spi_new_device(master, &(table[i])); \
 	}
 
-	switch ((drvdata->card_id & 0xFFFF0000) >> 16){
+	switch ((drvdata->card_id & 0xFFFF0000) >> 16) {
 	case PCI_DEVICE_ID_DAKTRONICS_KADOKA_P2KR0:
 		NEW_SPI_DEVICE_FROM_BOARD_INFO_TABLE(p2kr0_board_info);
 		break;
-- 
2.17.1

