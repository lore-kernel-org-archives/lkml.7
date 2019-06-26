Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA63C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C741A208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="kwsM0IsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfFZHfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:35:25 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:34935 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfFZHfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:35:24 -0400
Received: from mx-exchlnx-2.rrze.uni-erlangen.de (mx-exchlnx-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::38])
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZZ24CnLzPktj;
        Wed, 26 Jun 2019 09:35:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561534522; bh=xIigqwizTQ7WI5NnlTxiQ699ac4rVmRnMHcHntj5Bkk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=kwsM0IsN8zaqsdjkyUM2Y7Rmx7u77L5J9v4E+lSbhD5a1fnXQ1ADJr1nvfqO/DDNk
         v7pRbQRrWV7VqhKafKa3X60lZ/URBKmqA+X/NrAEA4W/4czVPbRHoAuAE5InDItNjF
         fXqtdf6ze3r6i1yDdNMFi9NYJgCEPWWwJU9OV0Co5bCEIob/FDsvmIssf97brtSUp0
         HpEXqXfLX9U41mPFQL86fWcumUnlxiw+FndQkfX+DVE+j0W/AI3IlrH+PVLz4Y6ucm
         joY0Co9d7ZTf4teO9A6lZCDFYmtNGB9nQoizhGM8RDPwsB4P1Q7wymikYcJi3l3YAS
         QzL7NkNbZ9+RA==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZZ02zktzPkrs;
        Wed, 26 Jun 2019 09:35:20 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun 2019
 09:35:09 +0200
Received: from TroubleWorld.fritz.box (95.90.221.207) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Wed, 26 Jun 2019 09:35:09 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        <linux-kernel@i4.cs.fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] staging: kpc2000: blank lines after declaration
Date:   Wed, 26 Jun 2019 09:35:20 +0200
Message-ID: <20190626073531.8946-3-fabian.krueger@fau.de>
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

After the declarations in a function, there should be a blank line, so
that the declaration part is visibly separated from the rest.
This refactoring makes the code more readable.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index b0b5c9b4d35a..c8fdb7e868f8 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -176,6 +176,7 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 kp_spi_write_reg(struct kp_spi_controller_state *cs, int idx, u64 val)
 {
 	u64 __iomem *addr = cs->base;
+
 	addr += idx;
 	writeq(val, addr);
 	if (idx == KP_SPI_REG_CONFIG)
@@ -187,6 +188,7 @@ kp_spi_wait_for_reg_bit(struct kp_spi_controller_state *cs, int idx,
 			unsigned long bit)
 {
 	unsigned long timeout;
+
 	timeout = jiffies + msecs_to_jiffies(1000);
 	while (!(kp_spi_read_reg(cs, idx) & bit)) {
 		if (time_after(jiffies, timeout)) {
@@ -416,6 +418,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 kp_spi_cleanup(struct spi_device *spidev)
 {
 	struct kp_spi_controller_state *cs = spidev->controller_state;
+
 	if (cs) {
 		kfree(cs);
 	}
@@ -507,6 +510,7 @@ kp_spi_probe(struct platform_device *pldev)
 kp_spi_remove(struct platform_device *pldev)
 {
 	struct spi_master *master = platform_get_drvdata(pldev);
+
 	spi_unregister_master(master);
 	return 0;
 }
-- 
2.17.1

