Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E779AC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6467218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfLRHXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:23:19 -0500
Received: from inva021.nxp.com ([92.121.34.21]:36076 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLRHXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:23:19 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A4270200344;
        Wed, 18 Dec 2019 08:23:17 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6BA032001E4;
        Wed, 18 Dec 2019 08:23:10 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5AABD402DA;
        Wed, 18 Dec 2019 15:23:01 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, shengjiu.wang@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fugang.duan@nxp.com,
        aisheng.dong@nxp.com, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 0/3] drivers/irqchip: Add NXP INTMUX interrupt
Date:   Wed, 18 Dec 2019 15:20:12 +0800
Message-Id: <1576653615-27954-1-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds driver for NXP INTMUX interrupt controller.

Joakim Zhang (2):
  dt-bindings/irq: add binding for NXP INTMUX interrupt multiplexer
  drivers/irqchip: enable INTMUX interrupt controller driver

Shengjiu Wang (1):
  drivers/irqchip: add NXP INTMUX interrupt multiplexer support

 .../interrupt-controller/fsl,intmux.txt       |  34 +++
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-imx-intmux.c              | 220 ++++++++++++++++++
 4 files changed, 261 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
 create mode 100644 drivers/irqchip/irq-imx-intmux.c

-- 
2.17.1

