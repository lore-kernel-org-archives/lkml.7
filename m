Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B02CC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDE9218AF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfDMH3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:29:25 -0400
Received: from www.osadl.org ([62.245.132.105]:36521 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfDMH3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:29:25 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3D7Sohd010572;
        Sat, 13 Apr 2019 09:29:02 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/4] ARM: imx legacy: declare unsigned int rather than unsigned
Date:   Sat, 13 Apr 2019 09:23:31 +0200
Message-Id: <1555140213-1081-3-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1555140213-1081-1-git-send-email-hofrat@osadl.org>
References: <1555140213-1081-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

provide the proper type for unsigned int.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem reported by checkpatch

Patch was compile-tested with: imx_v4_v5_defconfig (implies
CONFIG_MACH_MX27ADS=y)

Patch is against 5.1-rc4 (localversion-next is 20190412)

 arch/arm/mach-imx/mach-mx27ads.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 528846f..49ac898 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -202,7 +202,7 @@ static const struct imxi2c_platform_data mx27ads_i2c1_data __initconst = {
 static struct i2c_board_info mx27ads_i2c_devices[] = {
 };
 
-static void vgpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void vgpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	if (value)
 		imx_writew(PBC_BCTRL1_LCDON, PBC_BCTRL1_SET_REG);
@@ -210,7 +210,7 @@ static void vgpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		imx_writew(PBC_BCTRL1_LCDON, PBC_BCTRL1_CLEAR_REG);
 }
 
-static int vgpio_dir_out(struct gpio_chip *chip, unsigned offset, int value)
+static int vgpio_dir_out(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	return 0;
 }
-- 
2.1.4

