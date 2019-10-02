Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98825C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FFA21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfJBOrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:47:05 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:49231 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBOrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:47:04 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3D8EB200009;
        Wed,  2 Oct 2019 14:47:02 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 0/4] i2c bus recovery for Microchip SoCs.
Date:   Wed,  2 Oct 2019 16:46:54 +0200
Message-Id: <20191002144658.7718-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce the kernel i2c-gpio bus recovery mechanism
for the Microchip SoCs. Updated the corresponding dts to add i2c
gpio pinctrl. The bus recovery is configured for the sama5d3/4 xplained
boards in dts.

Kamel Bouhara (4):
  dt-bindings: i2c: at91: document optional bus recovery properties
  i2c: at91: implement i2c bus recovery
  ARM: at91/dt: sama5d3: add i2c gpio pinctrl
  ARM: at91/dt: sama5d4: add i2c gpio pinctrl

 .../devicetree/bindings/i2c/i2c-at91.txt      | 10 +++
 arch/arm/boot/dts/sama5d3.dtsi                | 33 +++++++++-
 arch/arm/boot/dts/sama5d4.dtsi                | 33 +++++++++-
 drivers/i2c/busses/i2c-at91-master.c          | 63 +++++++++++++++++++
 drivers/i2c/busses/i2c-at91.h                 |  8 +++
 5 files changed, 141 insertions(+), 6 deletions(-)

--
2.23.0

