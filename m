Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F2C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC67021880
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGCGxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 02:53:19 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:63167 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCGxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:53:19 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x636rBC3005738;
        Wed, 3 Jul 2019 14:53:11 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, marek.vasut@gmail.com,
        bbrezillon@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        juliensu@mxic.com.tw, paul.burton@mips.com, liang.yang@amlogic.com,
        lee.jones@linaro.org, masonccyang@mxic.com.tw,
        anders.roxell@linaro.org, christophe.kerello@st.com,
        paul@crapouillou.net, devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] Add Macronix raw NAND controller driver
Date:   Wed,  3 Jul 2019 15:15:42 +0800
Message-Id: <1562138144-2212-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com x636rBC3005738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v5 patch including:
1. compatible rename to "macronix,nand-controller"
2. handle three clock in one
3. other minor patches

v4 patch back to only raw NAND controller driver instead of MFD,
raw NAND and SPI driver. This is based on MFD maintainer, Lee Jones
comments:
MFD is for registering child devices of chips which offer genuine
cross-subsystem functionality.
It is not designed for mode selecting, or as a place to shove shared code 
just because a better location doesn't appear to exist. 

v3 patch is to rename the title of SPI controller driver.
"Patch Macronix SPI controller driver according to MX25F0A MFD driver"

v2s patches is to support Macronix MX25F0A MFD driver 
for raw nand and spi controller which is separated 
form previous patchset:

https://patchwork.kernel.org/patch/10874679/

thanks for your review.

best regards,
Mason


Mason Yang (2):
  mtd: rawnand: Add Macronix raw NAND controller
  dt-bindings: mtd: Document Macronix raw NAND controller bindings

 .../devicetree/bindings/mtd/mxic-nand.txt          |  20 +
 drivers/mtd/nand/raw/Kconfig                       |   6 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/mxic_nand.c                   | 557 +++++++++++++++++++++
 4 files changed, 584 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt
 create mode 100644 drivers/mtd/nand/raw/mxic_nand.c

-- 
1.9.1

