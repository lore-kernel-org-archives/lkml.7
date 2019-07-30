Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37328C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1358320882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfG3FoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:44:03 -0400
Received: from mx.socionext.com ([202.248.49.38]:57337 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729426AbfG3Fnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:43:47 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Jul 2019 14:43:46 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 33151180B6E;
        Tue, 30 Jul 2019 14:43:46 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 30 Jul 2019 14:43:46 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 94A731A04FC;
        Tue, 30 Jul 2019 14:43:45 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 4/5] pinctrl: uniphier: Add Pro5 PCIe pin-mux settings
Date:   Tue, 30 Jul 2019 14:43:29 +0900
Message-Id: <1564465410-9165-5-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564465410-9165-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1564465410-9165-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pro5 PCIe interface uses the following pins:
    XPERST, XPEWAKE, XPECLKRQ

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index 1d418e3..0c0af99 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -807,6 +807,8 @@ static const unsigned nand_pins[] = {19, 20, 21, 22, 23, 24, 25, 28, 29, 30,
 static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned nand_cs1_pins[] = {26, 27};
 static const int nand_cs1_muxvals[] = {0, 0};
+static const unsigned pcie_pins[] = {109, 110, 111};
+static const int pcie_muxvals[] = {0, 0, 0};
 static const unsigned sd_pins[] = {250, 251, 252, 253, 254, 255, 256, 257, 258};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned spi0_pins[] = {120, 121, 122, 123};
@@ -902,6 +904,7 @@ static const struct uniphier_pinctrl_group uniphier_pro5_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c5b),
 	UNIPHIER_PINCTRL_GROUP(i2c5c),
 	UNIPHIER_PINCTRL_GROUP(i2c6),
+	UNIPHIER_PINCTRL_GROUP(pcie),
 	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP(spi0),
 	UNIPHIER_PINCTRL_GROUP(spi1),
@@ -936,6 +939,7 @@ static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const i2c5_groups[] = {"i2c5", "i2c5b", "i2c5c"};
 static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
+static const char * const pcie_groups[] = {"pcie"};
 static const char * const sd_groups[] = {"sd"};
 static const char * const spi0_groups[] = {"spi0"};
 static const char * const spi1_groups[] = {"spi1"};
@@ -967,6 +971,7 @@ static const struct uniphier_pinmux_function uniphier_pro5_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c5),
 	UNIPHIER_PINMUX_FUNCTION(i2c6),
 	UNIPHIER_PINMUX_FUNCTION(nand),
+	UNIPHIER_PINMUX_FUNCTION(pcie),
 	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(spi0),
 	UNIPHIER_PINMUX_FUNCTION(spi1),
-- 
2.7.4

