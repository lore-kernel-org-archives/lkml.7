Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E27C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5D922445
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfKTHhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:37:39 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:45152 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726647AbfKTHhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:37:39 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xAK7apQb024885;
        Wed, 20 Nov 2019 09:36:51 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 58EE060329; Wed, 20 Nov 2019 09:36:51 +0200 (IST)
From:   Tali Perry <tali.perry1@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, benjaminfair@google.com,
        avifishman70@gmail.com, joel@jms.id.au, tmaimon77@gmail.com,
        wsa@the-dreams.de, syniurge@gmail.com
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tali Perry <tali.perry1@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 0/2] i2c: npcm: add NPCM i2c controller driver
Date:   Wed, 20 Nov 2019 09:36:20 +0200
Message-Id: <20191120073622.37938-1-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds i2c controller support 
for the Nuvoton NPCM Baseboard Management Controller (BMC).

NPCM7xx includes 16 I2C controllers. This driver operates the controller.
This module also includes a slave mode.

---
v6 -> v5:
	- Update documentation

v5 -> v4:
	- support recovery
	- master-slave switch support needed for IPMB

v4 -> v3:
	- typo on cover letter.

v3 -> v2:
	- fix dt binding: compatible name: omit "bus"

v2 -> v1:
	- run check patch in strict mode.
	- use linux crc.
	- define regs in constant offset without base.
	- remove debug prints.
	- no declarations for local functions.
	
v1: initial version

Signed-off-by: Tali Perry <tali.perry1@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Tali Perry (2):
  Added device tree binding documentation for Nuvoton BMC NPCM I2C
    controller.
  Add Nuvoton NPCM BMC I2C controller driver.

 .../devicetree/bindings/i2c/i2c-npcm7xx.txt   |   29 +
 drivers/i2c/busses/Kconfig                    |   11 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/i2c-npcm7xx.c              | 2486 +++++++++++++++++
 4 files changed, 2527 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
 create mode 100644 drivers/i2c/busses/i2c-npcm7xx.c

-- 
2.22.0

