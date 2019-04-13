Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D240C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651B72084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfDMHaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:30:15 -0400
Received: from www.osadl.org ([62.245.132.105]:36554 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfDMHaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:30:14 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3D7Sohb010572;
        Sat, 13 Apr 2019 09:28:50 +0200
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
Subject: [PATCH 0/4] ARM: imx legacy: cleanups
Date:   Sat, 13 Apr 2019 09:23:29 +0200
Message-Id: <1555140213-1081-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the noise - I accidentally sent out a set of old patches
along with this cleanups set. Only the ARM: imx legacy: should
have goon out.

While preparing a proposed fix for a missing check on zmalloc a few
other checkpatch warnings poped up - this little set fixes those
warnings. There is one remaining checkpatch warning but that looks
like a false-positive to me:

ERROR: Use of __initconst requires a separate use of const
#171: FILE: arch/arm/mach-imx/mach-mx27ads.c:171:
+mx27ads_nand_board_info __initconst = {

The false positive seems due to the definition spanning two lines
anyway looks good to me

<snip>
static const struct mxc_nand_platform_data
mx27ads_nand_board_info __initconst = {
        .width = 1,
        .hw_ecc = 1,
};
<snip>

thx!
hofrat
