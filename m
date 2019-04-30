Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437B4C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116F220835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfD3GbI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:31:08 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54469 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfD3GbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:31:07 -0400
X-Originating-IP: 81.185.165.117
Received: from xps13 (117.165.185.81.rev.sfr.net [81.185.165.117])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 46E011C0003;
        Tue, 30 Apr 2019 06:31:01 +0000 (UTC)
Date:   Tue, 30 Apr 2019 08:30:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 1/4] mtd: rawnand: Turn the ONFI support to generic
Message-ID: <20190430083059.629e0bf1@xps13>
In-Reply-To: <MN2PR08MB5951BDBAC83D3D04B3B122A5B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951BDBAC83D3D04B3B122A5B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
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

Sorry for the long delay I was a bit overloaded.

"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote on
Tue, 26 Mar 2019 10:51:47 +0000:

> Fix headers to make way for adding helper functions.
> 
> Add onfi helper structure.
> 
> Add helper functions in raw NAND core, which later will be used during
> ONFI detection.
> 

As you are touching the core, I need to identify clearly each change
you make; typically in this commit you do several different changes.
Please split this patch in small meaningful peaces.

> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/raw/internals.h |   6 +-
>  drivers/mtd/nand/raw/nand_base.c | 236 ++++++++++++++++++++++++++++---
>  drivers/mtd/nand/raw/nand_onfi.c | 215 +++++-----------------------
>  include/linux/mtd/nand.h         |  30 ++++
>  include/linux/mtd/rawnand.h      |   5 +
>  5 files changed, 289 insertions(+), 203 deletions(-)
> 

Thanks,
Miquèl
