Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C7AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279C622CEA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfHSR0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:26:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55250 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfHSR0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:26:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 7F62F28B120
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     dafna.hirschfeld@collabora.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ezequiel@collabora.com,
        kernel@collabora.com
Subject: [PATCH v4 0/2] add imx8mq nitrogen support - changes since v3
Date:   Mon, 19 Aug 2019 19:26:04 +0200
Message-Id: <20190819172606.6410-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change log:
patch 1: no changes
patch 2:
- gpio-key,wakeup -> source-wakeup
- newline between property list and child nodes.
- settting pinctrl nodes names to: "pinctrl_xxx: xxxgrp {"

Gary Bisson (2):
  dt-bindings: arm: imx: add imx8mq nitrogen support
  arm64: dts: imx: Add i.mx8mq nitrogen8m basic dts support

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 405 ++++++++++++++++++
 3 files changed, 407 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts

-- 
2.20.1

