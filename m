Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD0DC5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C2D21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="NJPB8zmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfKEVls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:41:48 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46371 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbfKEVls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:41:48 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 39B858365A;
        Wed,  6 Nov 2019 10:41:44 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1572990104;
        bh=qCCum7Y7ylZunEZTc0mEN2AR+w9a1L5cSW5bKWxjglM=;
        h=From:To:Cc:Subject:Date;
        b=NJPB8zmU/4e80+N03rFjRr4ub/wYH2eXncfm4tVERnJhchxSdULhYJcVBFNMqqORW
         1gykRjWIdqQJMBfty97g/eOUg+JUyD2BkACUWkgTvjSbla+14Aql/xMD9B02xOOzOZ
         y3NYy7IPzO7mFhwtrptxul8ZVWkJ2VJv6ycOwlHmh3HWHw3FyJLBv3A//SJmHrjyW6
         pJ8SSmWESaY4c5bZFLceeKSGN5yWnOElqm/B/h5Ty/gPIX4MKx54ZNcQCJf9THoHu3
         cJ7xUQbPEMkBnSaOqgnlDadelYJEFOFuFhBZ5n7nFNZlOFLxqzA+J7hYmfVr+a6F9I
         UfQsCMrCrWrWg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dc1ec970000>; Wed, 06 Nov 2019 10:41:44 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id E0D1513EEEB;
        Wed,  6 Nov 2019 10:41:41 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id F409528005F; Wed,  6 Nov 2019 10:41:42 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org
Cc:     trivial@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] spi: bcm2835: fix typo in comment
Date:   Wed,  6 Nov 2019 10:41:34 +1300
Message-Id: <20191105214134.25142-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOS_OUT_LOW should be GPIOD_OUT_LOW.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index b4070c0de3df..fb61a620effc 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1248,7 +1248,7 @@ static int bcm2835_spi_setup(struct spi_device *spi=
)
 	/*
 	 * Retrieve the corresponding GPIO line used for CS.
 	 * The inversion semantics will be handled by the GPIO core
-	 * code, so we pass GPIOS_OUT_LOW for "unasserted" and
+	 * code, so we pass GPIOD_OUT_LOW for "unasserted" and
 	 * the correct flag for inversion semantics. The SPI_CS_HIGH
 	 * on spi->mode cannot be checked for polarity in this case
 	 * as the flag use_gpio_descriptors enforces SPI_CS_HIGH.
--=20
2.24.0

