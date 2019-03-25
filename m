Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC62C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25EA20848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfCYVYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:24:44 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:34485 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730442AbfCYVYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:24:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 22F611803671A;
        Mon, 25 Mar 2019 21:24:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coast25_baf3a27b1a45
X-Filterd-Recvd-Size: 5769
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:24:40 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Olof Johansson <olof@lixom.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Bad file pattern in MAINTAINERS section 'ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT'
Date:   Mon, 25 Mar 2019 14:24:38 -0700
Message-Id: <20190325212438.25657-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	1133	ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
	1134	M:	Linus Walleij <linus.walleij@linaro.org>
	1135	L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
	1136	S:	Maintained
	1137	F:	Documentation/devicetree/bindings/arm/arm-boards
	1138	F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
	1139	F:	Documentation/devicetree/bindings/clock/arm-integrator.txt
	1140	F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
	1141	F:	Documentation/devicetree/bindings/mtd/arm-versatile.txt
	1142	F:	arch/arm/mach-integrator/
	1143	F:	arch/arm/mach-realview/
	1144	F:	arch/arm/mach-versatile/
	1145	F:	arch/arm/plat-versatile/
	1146	F:	arch/arm/boot/dts/arm-realview-*
	1147	F:	arch/arm/boot/dts/integrator*
	1148	F:	arch/arm/boot/dts/versatile*
	1149	F:	drivers/clk/versatile/
	1150	F:	drivers/i2c/busses/i2c-versatile.c
	1151	F:	drivers/irqchip/irq-versatile-fpga.c
-->	1152	F:	drivers/mtd/maps/physmap_of_versatile.c
	1153	F:	drivers/power/reset/arm-versatile-reboot.c
	1154	F:	drivers/soc/versatile/

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'drivers/mtd/maps/physmap_of_versatile.c':

commit 7f08c966f7e578dc84f7c3d1a528068841d72d32
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Fri Sep 28 13:42:50 2018 +0200

    ARM: Assume maintainership of ARM reference designs
    
    With this I assume maintainership of the Integrator, Versatile
    and RealView ARM reference machines.
    
    It's no big secret that I've been maintaining them for years,
    but might as well make it official so I get the mails and
    don't miss anything.
    
    I have also included some drivers that are closely associated
    with the ARM reference designs and yet orphaned in the
    MAINTAINERS file. I can surely maintain them too, or route
    the question to the right people so it doesn't fall on the
    floor of upward to the subsystem maintainers who have too much
    to do already as it is.
    
    Cc: Russell King <linux@armlinux.org.uk>
    Cc: Rob Herring <robh@kernel.org>
    Cc: Will Deacon <will.deacon@arm.com>
    Cc: Stephen Boyd <sboyd@kernel.org>
    Cc: Mark Brown <broonie@kernel.org>
    Cc: Brian Norris <computersforpeace@gmail.com>
    Acked-by: Wolfram Sang <wsa@the-dreams.de>
    Acked-by: Olof Johansson <olof@lixom.net>
    Acked-by: Michael Turquette <mturquette@baylibre.com>
    Acked-by: Marc Zyngier <marc.zyngier@arm.com>
    Acked-by: Mark Brown <broonie@kernel.org>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 MAINTAINERS | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

3: ---------------------------------------------------------------------------

The last commit with a real presence of file pattern 'drivers/mtd/maps/physmap_of_versatile.c':

commit 6ca15cfa0788ebef365ce31d1e01ea30a389a895
Author: Boris Brezillon <boris.brezillon@bootlin.com>
Date:   Fri Oct 19 09:49:05 2018 +0200

    mtd: maps: Rename physmap_of_{versatile, gemini} into physmap-{versatile, gemini}
    
    Now that the physmap_of driver is gone, the gemini and versative
    extensions are part of the physmap driver. Rename the source files and
    the config option to reflect this.
    
    Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
    Reviewed-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
    Acked-by: Linus Walleij <linus.walleij@linaro.org>

 drivers/mtd/maps/Kconfig                                         | 4 ++--
 drivers/mtd/maps/Makefile                                        | 4 ++--
 drivers/mtd/maps/physmap-core.c                                  | 4 ++--
 drivers/mtd/maps/{physmap_of_gemini.c => physmap-gemini.c}       | 2 +-
 drivers/mtd/maps/{physmap_of_gemini.h => physmap-gemini.h}       | 2 +-
 drivers/mtd/maps/{physmap_of_versatile.c => physmap-versatile.c} | 2 +-
 drivers/mtd/maps/{physmap_of_versatile.h => physmap-versatile.h} | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)
