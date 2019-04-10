Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB04EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DB82133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfDJKji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:39:38 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59777 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfDJKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:39:38 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1DB051BF209;
        Wed, 10 Apr 2019 10:39:34 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/3] gpio: lpc32xx: enable interrupts for port 3
Date:   Wed, 10 Apr 2019 12:39:23 +0200
Message-Id: <20190410103926.8781-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables interrupt support for GPIOs on port 3. Those are the
GPIOs that are connected directl to an interrupt controller (sic1 or
sic2). This was tested on a custom LPC3250 design.

The binding includes support for interrupts on port 0 and port 1 but
this requires the registration of a proper irqchip and I don't have any
way to test it.

Patch 1 and 2 should probably go through the gpio tree while patch 3
should go through arm-soc. They are quite independant and this shoud
cause no issue.

Alexandre Belloni (3):
  dt-bindings: gpio: lpc32xx: document interrupt bindings
  gpio: lpc32xx: enable interrupt lookup for port 3
  ARM: dts: lpc32xx: add GPIO interrupts

 .../devicetree/bindings/gpio/gpio_lpc32xx.txt |  4 +++
 arch/arm/boot/dts/lpc32xx.dtsi                | 25 +++++++++++++++++++
 drivers/gpio/gpio-lpc32xx.c                   | 14 ++++-------
 3 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.20.1

