Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4563FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1842073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfDOJHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:07:25 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:39838 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDOJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:07:25 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x3F93pKp042176;
        Mon, 15 Apr 2019 17:03:51 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmal.com, paul.burton@mips.com, stefan@agner.ch,
        christophe.kerello@st.com, liang.yang@amlogic.com,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        marcel.ziswiler@toradex.com, linux-mtd@lists.infradead.org,
        richard@nod.at, miquel.raynal@bootlin.com
Cc:     juliensu@mxic.com.tw, zhengxunli@mxic.com.tw,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v3 0/4] Add Macronix MX25F0A MFD driver for raw nand and spi
Date:   Mon, 15 Apr 2019 17:23:50 +0800
Message-Id: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com x3F93pKp042176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v3 patch is to rename the title of SPI controller driver.
"Patch Macronix SPI controller driver according to MX25F0A MFD driver"

v2s patches is to support Macronix MX25F0A MFD driver 
for raw nand and spi controller which is separated 
form previous patchset:

https://patchwork.kernel.org/patch/10874679/

thanks for your review.

best regards,
Mason

Mason Yang (4):
  mfd: Add Macronix MX25F0A MFD controller driver
  mtd: rawnand: Add Macronix MX25F0A NAND controller
  spi: Patch Macronix SPI controller driver according to MX25F0A MFD
    driver
  dt-bindings: mfd: Document Macronix MX25F0A controller bindings

 .../devicetree/bindings/mfd/mxic-mx25f0a.txt       |  51 ++++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/mxic-mx25f0a.c                         |  84 ++++++
 drivers/mtd/nand/raw/Kconfig                       |   6 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/mxic_nand.c                   | 294 +++++++++++++++++++++
 drivers/spi/spi-mxic.c                             | 275 ++++---------------
 include/linux/mfd/mxic-mx25f0a.h                   | 175 ++++++++++++
 9 files changed, 670 insertions(+), 226 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
 create mode 100644 drivers/mfd/mxic-mx25f0a.c
 create mode 100644 drivers/mtd/nand/raw/mxic_nand.c
 create mode 100644 include/linux/mfd/mxic-mx25f0a.h

-- 
1.9.1

