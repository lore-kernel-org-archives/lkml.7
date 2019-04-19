Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DFEC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784EE21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfDSTbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:31:02 -0400
Received: from [114.143.65.226] ([114.143.65.226]:35692 "EHLO buildserver-90"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726429AbfDSTbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:31:00 -0400
Received: by buildserver-90 (Postfix, from userid 1006)
        id C023A3A8E0F; Fri, 19 Apr 2019 17:41:34 +0530 (IST)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at
Cc:     palmer@sifive.com, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, sagar.kadam@sifive.com
Subject: [PATCH v1] add support for is25wp256d spi-nor device.
Date:   Fri, 19 Apr 2019 17:40:38 +0530
Message-Id: <1555675839-30754-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is tested on HiFive Unleashed board and is based on mainline 5.1-rc5 kernel.
Its intended to add support for 32MB snor flash mounted on the board.
The memory supports 64Kbyte sectors size as added into id table.
Flash parameter table for ISSI device is set to use macronix_quad_enable
procedure to set the QE (quad-enable) bit of Status register.


Sagar Shrikant Kadam (1):
  mtd: spi-nor: add support for is25wp256d

 drivers/mtd/spi-nor/spi-nor.c | 8 ++++++++
 include/linux/mtd/spi-nor.h   | 1 +
 2 files changed, 9 insertions(+)

-- 
1.9.1

