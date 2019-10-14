Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9957ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA1820854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfJNKy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:54:59 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:58199 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731010AbfJNKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:54:58 -0400
Received: from localhost.localdomain (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Mon, 14 Oct 2019
 18:55:04 +0800
From:   Qianggui Song <qianggui.song@amlogic.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Qianggui Song <qianggui.song@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Rob Herring <robh+dt@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/4] pinctrl: meson-a1: add pinctrl driver
Date:   Mon, 14 Oct 2019 18:54:48 +0800
Message-ID: <1571050492-6598-1-git-send-email-qianggui.song@amlogic.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.19]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds Pin controller driver support for Meson-A1 Soc
which shares the same register layout of pinmux with previous
Meson-G12A, however there is difference for gpio and pin config
registers in A1.

Changes since v2 at [1]:
 - make dt parser callback as a separate patch

Changes since v1 at [0]:
 - collect Reviewed-by
 - modify commit log
 - add an extra dt parser function for a1

[0] https://lore.kernel.org/linux-amlogic/1568700442-18540-1-git-send-email-qianggui.song@amlogic.com/
[1] https://lore.kernel.org/linux-amlogic/1570532999-23302-1-git-send-email-qianggui.song@amlogic.com/

Qianggui Song (4):
  pinctrl: add compatible for Amlogic Meson A1 pin controller
  pinctrl: meson: add a new dt parse callback for Meson-A series SoCs
  pinctrl: meson: add pinctrl driver support for Meson-A1 Soc
  arm64: dts: meson: a1: add pinctrl controller support

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   1 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |  18 +
 drivers/pinctrl/meson/Kconfig                      |   6 +
 drivers/pinctrl/meson/Makefile                     |   1 +
 drivers/pinctrl/meson/pinctrl-meson-a1.c           | 942 +++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.c              |  16 +-
 drivers/pinctrl/meson/pinctrl-meson.h              |   7 +
 include/dt-bindings/gpio/meson-a1-gpio.h           |  73 ++
 8 files changed, 1063 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-a1.c
 create mode 100644 include/dt-bindings/gpio/meson-a1-gpio.h

-- 
1.9.1

