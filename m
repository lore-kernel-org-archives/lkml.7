Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F5CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D806820821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfDPE2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:28:22 -0400
Received: from www.osadl.org ([62.245.132.105]:49482 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfDPE2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:28:22 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3G4S2TI017591;
        Tue, 16 Apr 2019 06:28:03 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] MAINTAINERS: add soc/ux500
Date:   Tue, 16 Apr 2019 06:22:42 +0200
Message-Id: <1555388562-9454-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_maintainer.pl only returns linux-kernel@vger.kernel.org for the
drivers/soc/ux500/ files - fix it by adding drivers/soc/ux500/ entry

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Patch is aginst 5.1-rc4 (localversion-next is 20190415)

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 002d564..7961bb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1881,6 +1881,7 @@ S:	Maintained
 F:	arch/arm/mach-nomadik/
 F:	arch/arm/mach-u300/
 F:	arch/arm/mach-ux500/
+F:	drivers/soc/ux500/
 F:	arch/arm/boot/dts/ste-*
 F:	drivers/clk/clk-nomadik.c
 F:	drivers/clk/clk-u300.c
-- 
2.1.4

