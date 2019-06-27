Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD48AC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA4620663
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfF0OtY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:49:24 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51465 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfF0OtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:49:23 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9296D240019;
        Thu, 27 Jun 2019 14:49:15 +0000 (UTC)
Date:   Thu, 27 Jun 2019 16:49:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Lucas Stach <dev@lynxeye.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chuanhong Guo <gch981213@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Introduce generic ONFI support
Message-ID: <20190627164914.1cae84ff@xps13>
In-Reply-To: <MN2PR08MB59514E77250C3F0DA76D4801B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB59514E77250C3F0DA76D4801B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shivamurthy,

"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote on
Mon, 3 Jun 2019 12:43:20 +0000:

> Current support to ONFI parameter page is only for raw NAND, this patch
> series turn ONFI support into generic. So that, other NAND devices like
> SPI NAND can use this.
> 
> There are five parts in this series.
> 1. Prepare for turning ONFI into generic
> 2. Turn ONFI into generic, which can be used by SPI NANDs later
> 3. Turn SPI NAND core to use parameter page
> 4. Redesign Micron SPI NAND driver implementation
> 5. Support for new Micron SPI NAND devices
> 

I am very sorry for the delay, I will have a deep look at your series
very soon.

> Changes in V3
> -------------
> 
> * Rebased to nand/next
> * Split the patches as per suggestion
> * Addressed the comments
> * Some fixes which I missed in last version

As a simple note, please mind that "addressed the comments" is way too
generic. "Some fixes" as well. I have plenty of series to follow, you
need to do very careful when you write this changelog, it is important
for me.

Also, for the next series you submit, please use a threaded logic where
all patches are answers to the cover letter (this way it appears as a
thread and it is considered as one series by patchwork.

Thanks,
Miquèl
