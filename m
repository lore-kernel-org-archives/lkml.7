Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFDFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCBF20678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfK0N7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:59:49 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56495 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0N7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:59:40 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iZxqv-0005PB-JT; Wed, 27 Nov 2019 14:59:33 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iZxqv-0008Da-2w; Wed, 27 Nov 2019 14:59:33 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        support.opensource@diasemi.com, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        stwiss.opensource@diasemi.com, Adam.Thomson.Opensource@diasemi.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 0/5] DA9062 PMIC features
Date:   Wed, 27 Nov 2019 14:59:27 +0100
Message-Id: <20191127135932.7223-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series address all comments made on [1]. Patch "regulator: da9062:
fix suspend_enable/disable preparation" was applied mainline so I
droppped it. Patch "gpio: add support to get local gpio number" is new
and based on Linus suggestion. The v2 has no compile dependency like
[1] but you need to apply [2] else the features can't be used.

[1] https://lkml.org/lkml/2019/9/17/411
[2] https://patchwork.ozlabs.org/cover/1201549/

Marco Felsch (5):
  gpio: add support to get local gpio number
  dt-bindings: mfd: da9062: add regulator voltage selection
    documentation
  regulator: da9062: add voltage selection gpio support
  dt-bindings: mfd: da9062: add regulator gpio enable/disable
    documentation
  regulator: da9062: add gpio based regulator dis-/enable support

 .../devicetree/bindings/mfd/da9062.txt        |  17 ++
 drivers/gpio/gpiolib.c                        |   6 +
 drivers/regulator/da9062-regulator.c          | 244 ++++++++++++++++++
 include/linux/gpio/consumer.h                 |  10 +
 4 files changed, 277 insertions(+)

-- 
2.20.1

