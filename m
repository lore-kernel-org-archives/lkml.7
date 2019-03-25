Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECC020848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfCYVY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:24:58 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:36852 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729569AbfCYVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:24:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 17663180A8867;
        Mon, 25 Mar 2019 21:24:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: place45_db53fa961c00
X-Filterd-Recvd-Size: 3412
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:24:54 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, Vinod Koul <vkoul@kernel.org>
Subject: Bad file pattern in MAINTAINERS section 'ARM/UNIPHIER ARCHITECTURE'
Date:   Mon, 25 Mar 2019 14:24:53 -0700
Message-Id: <20190325212453.25934-1-joe@perches.com>
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

	2344	ARM/UNIPHIER ARCHITECTURE
	2345	M:	Masahiro Yamada <yamada.masahiro@socionext.com>
	2346	L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
	2347	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
	2348	S:	Maintained
	2349	F:	Documentation/devicetree/bindings/arm/socionext/uniphier.txt
	2350	F:	Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
	2351	F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
	2352	F:	arch/arm/boot/dts/uniphier*
	2353	F:	arch/arm/include/asm/hardware/cache-uniphier.h
	2354	F:	arch/arm/mach-uniphier/
	2355	F:	arch/arm/mm/cache-uniphier.c
	2356	F:	arch/arm64/boot/dts/socionext/uniphier*
	2357	F:	drivers/bus/uniphier-system-bus.c
	2358	F:	drivers/clk/uniphier/
-->	2359	F:	drivers/dmaengine/uniphier-mdmac.c
	2360	F:	drivers/gpio/gpio-uniphier.c
	2361	F:	drivers/i2c/busses/i2c-uniphier*
	2362	F:	drivers/irqchip/irq-uniphier-aidet.c
	2363	F:	drivers/mmc/host/uniphier-sd.c
	2364	F:	drivers/pinctrl/uniphier/
	2365	F:	drivers/reset/reset-uniphier.c
	2366	F:	drivers/tty/serial/8250/8250_uniphier.c
	2367	N:	uniphier

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'drivers/dmaengine/uniphier-mdmac.c':

commit 32e74aabebc8d045a11452d2de0ac9d2625fcd45
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri Oct 12 01:41:03 2018 +0900

    dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver
    
    The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
    Pro4, and sLD8 SoCs.
    
    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Signed-off-by: Vinod Koul <vkoul@kernel.org>

 MAINTAINERS                  |   1 +
 drivers/dma/Kconfig          |  11 +
 drivers/dma/Makefile         |   1 +
 drivers/dma/uniphier-mdmac.c | 506 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 519 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'drivers/dmaengine/uniphier-mdmac.c' was found
