Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C08620835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCDT6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:58:50 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:38719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDT6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:58:50 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MV5G4-1ga3RQ2lyo-00S7VB; Mon, 04 Mar 2019 20:58:46 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Zhu Yi <yi.zhu5@cn.bosch.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: raspberrypi-ts: select CONFIG_INPUT_POLLDEV
Date:   Mon,  4 Mar 2019 20:57:53 +0100
Message-Id: <20190304195845.1096214-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cg93aIPM4bd+ibdb9VisYXpZi4JfThg9wT+PQdqsQsm9+e3822Z
 I2ldUl3FzJdRYkmu+cq5aUksjGMuJfMHJqfwgat6rulGA6TzW3HDHy1Oa23MMAlcu/qAJJe
 jJPtnCQVBxfUGAMubVQfvdCW6bPecgIM5doZJUeAGVciwUGSwmNN9owcui1PIXrLrQi2YGQ
 1J7wps5XStuKzO+oVnJMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uSUgUQkxPbQ=:4tRef4TaTQuQiX2lft9kTe
 HUni0s8h/Rblplh7ge/BIjG92Mo3IbfgaDZvH+j+ucnsxVOUyu3grCB9H3PDGehSz1eP5NfBy
 B6k0M/PPBSmPMhamjZBGdiLVXgdfKDKt6WwqLxN9GT1c8jCIwNx1ZR8KFm4U1H8wa4NLrIYRf
 OuhOTHhh95l1eF0RSlozKk/ohhMv6nN7WiVt8Qs7dtG367e+x7ymVvAxrsCh/5KufKt+Blzt4
 gXX33RXYueSwey+isyHVbFNG2ycmnXp8ZjPWP1pF3fXlnYwltQHQU+atYjw4fz6tVrKpATuJJ
 EP098Zi0xHczp9/BIoOZClaeYTGmkCwpM/3JDfGU4NFSLvfBqiXj5jql3ilFXpX+us+MTXnmm
 8a/GlT/YKErylwyTeyOjl4cuBOYFIaojbBhgk3X6HmNvT2radLkILl2wP4/QR8kC9K+Mgk0Yt
 1TyGFBmaZyT94gCPnLwgEzMzyURhjqF2qhsal2kiX6lT7yYVpGgDslCO33WegJzOiKY56oHr4
 LlIqyTK2J6mfIk+TmPaCiKx656bQ+JY3J8cp6+Lwl+hmx5RI+Tev2azMDv7pYaEehDOgOu04p
 JCs54Jmfiwhtt+9hYAFx8tLqcu66KLOCet7Ly83kw6rT1Zd43mMDMJegRzK1epLoXyLg/S8JD
 JvQy7FSSblC2juf2MCiA1ahkS3GTt7KVzLbhA5z9OFO0WU7BEEP0SG3baXgNGxJhAPIInhv9g
 pl+VeBbo3vC1B/Uq6zFUmrqAFYx37Fc2+LsacbUy7wxGOkOX20l+dXWmyZVhd+tq03tI2zWV2
 j6JcCD8kiE5kMwF6Tp5wTzghVO5+EFcGDc40rLaRig9wzEjaGE2v+w0AfdnazyYOKO107DzVj
 rLaPerim+VL4v7bTkzBxEBVG77oF6950d7tDkWA1B3+8Mpy2QNbNP1+PwUxQiU0xYXEmew9yn
 ol+SGb5LTlA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_INPUT_POLLDEV is disabled, we get a link error:

drivers/input/touchscreen/raspberrypi-ts.o: In function `rpi_ts_probe':
raspberrypi-ts.c:(.text+0xec): undefined reference to `devm_input_allocate_polled_device'
raspberrypi-ts.c:(.text+0xec): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `devm_input_allocate_polled_device'
raspberrypi-ts.c:(.text+0x19c): undefined reference to `input_register_polled_device'
raspberrypi-ts.c:(.text+0x19c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `input_register_polled_device'

Select that symbol like we do from the other similar drivers.

Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 7c597a49c265..7a4884ad198b 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -699,6 +699,7 @@ config TOUCHSCREEN_EDT_FT5X06
 config TOUCHSCREEN_RASPBERRYPI_FW
 	tristate "Raspberry Pi's firmware base touch screen support"
 	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=n && COMPILE_TEST)
+	select INPUT_POLLDEV
 	help
 	  Say Y here if you have the official Raspberry Pi 7 inch screen on
 	  your system.
-- 
2.20.0

