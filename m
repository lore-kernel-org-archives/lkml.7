Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B594C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739862075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfKGWRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:17:02 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:50065 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKGWRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:17:02 -0500
X-Originating-IP: 92.184.100.203
Received: from localhost (unknown [92.184.100.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D0629240005;
        Thu,  7 Nov 2019 22:16:59 +0000 (UTC)
Date:   Thu, 7 Nov 2019 23:16:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: Drivers for 5.5
Message-ID: <20191107221644.GA201884@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

A single new driver and a bit of churn this cycle.

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.5-drivers

for you to fetch changes up to c3277f8ee8cdadf011b8390dfdb4c44ecfaa1a7a:

  soc: at91: Add Atmel SFR SN (Serial Number) support (2019-11-07 22:33:10 +0100)

----------------------------------------------------------------
AT91 drivers for 5.5

 - a new driver exposing the serial number registers through nvmem
 - a few documentation and definition changes

----------------------------------------------------------------
Kamel Bouhara (1):
      soc: at91: Add Atmel SFR SN (Serial Number) support

Nicolas Ferre (1):
      ARM: at91: Documentation: update the sama5d3 and armv7m datasheets

Tudor Ambarus (2):
      memory: atmel-ebi: move NUM_CS definition inside EBI driver
      memory: atmel-ebi: switch to SPDX license identifiers

 Documentation/arm/microchip.rst         |  4 +-
 drivers/memory/atmel-ebi.c              | 11 ++--
 drivers/soc/atmel/Kconfig               | 11 ++++
 drivers/soc/atmel/Makefile              |  1 +
 drivers/soc/atmel/sfr.c                 | 99 +++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon/atmel-matrix.h |  1 -
 6 files changed, 118 insertions(+), 9 deletions(-)
 create mode 100644 drivers/soc/atmel/sfr.c

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
