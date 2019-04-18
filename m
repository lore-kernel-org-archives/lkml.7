Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2656DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21FF217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbfDRQXF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:23:05 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:36359 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDRQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:23:05 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 823B51C0007;
        Thu, 18 Apr 2019 16:23:00 +0000 (UTC)
Date:   Thu, 18 Apr 2019 18:22:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     liang.yang@amlogic.com, linux-amlogic@lists.infradead.org,
        linux-mtd@lists.infradead.org, richard@nod.at,
        linux-arm-kernel@lists.infradead.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org, jianxin.pan@amlogic.com
Subject: Re: [PATCH 0/4] meson-nand: small code improvements
Message-ID: <20190418182259.479bbeb3@xps13>
In-Reply-To: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote on Fri,
12 Apr 2019 00:00:52 +0200:

> This series comes with four small improvements for the meson-nand
> driver:
> * the first patches are replacing open-coded logic with existing
>   utilities / helpers
> * the third patch drops some unnecessary casting after changing
>   the type of the info buffer parameter from "u8 *" to "void *"
> * the fourth patch adjusts the usage of init_completion with what the
>   documentation suggests
> 
> I have tested these patches as best as I could on my Meson8m2 board
> using experimental patches on top of this series which add support for
> this older SoC to the meson-nand driver.
> 
> Liang, can you please test this series on GXL and/or AXG so I don't
> break the NFC driver on these newer SoCs? All of my GXL/GXM boards
> have eMMC instead of raw NAND, so I cannot test it on these newer SoCs
> myself.
> 
> This series is meant to be applied to the nand/next tree.
> 
> 
> Martin Blumenstingl (4):
>   mtd: rawnand: meson: use struct_size macro
>   mtd: rawnand: meson: use of_property_count_elems_of_size helper
>   mtd: rawnand: meson: use a void pointer for meson_nfc_dma_buffer_setup
>   mtd: rawnand: meson: only initialize the RB completion once
> 
>  drivers/mtd/nand/raw/meson_nand.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 

Series applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git 
branch nand/next.

Thanks,
Miquèl
