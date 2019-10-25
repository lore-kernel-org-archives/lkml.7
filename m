Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FCBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F251621D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfJYTpK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:45:10 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48495 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfJYTpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:45:10 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E2707C0008;
        Fri, 25 Oct 2019 19:45:03 +0000 (UTC)
Date:   Fri, 25 Oct 2019 21:45:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <linux-mtd@lists.infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: mtd/ubi/ubifs: Remove inactive maintainers
Message-ID: <20191025214502.49f674a7@xps13>
In-Reply-To: <20191017142229.3853-1-miquel.raynal@bootlin.com>
References: <20191017142229.3853-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Gentle ping?

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 17 Oct 2019
16:22:29 +0200:

> Despite their substantial personal investment in the MTD/UBI/UBIFS a
> few years back, David, Brian, Artem and Adrian are not actively
> maintaining the subsystem anymore. We warmly salute them for all the
> work they have achieved and will of course still welcome their
> participation and reviews.
> 
> That said, Marek retired himself a few weeks ago quoting Harald [1]:
> 
>         It matters who has which title and when. Should somebody not
>         be an active maintainer, make sure he's not listed as such.
> 
> For this same reason, let’s trim the maintainers list with the
> actually active ones over the past two years.
> 
> [1] http://laforge.gnumonks.org/blog/20180307-mchardy-gpl/
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  MAINTAINERS | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0632422ce9d4..0e5e0736ee55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10528,8 +10528,6 @@ F:	include/linux/vmalloc.h
>  F:	mm/
>  
>  MEMORY TECHNOLOGY DEVICES (MTD)
> -M:	David Woodhouse <dwmw2@infradead.org>
> -M:	Brian Norris <computersforpeace@gmail.com>
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Richard Weinberger <richard@nod.at>
>  M:	Vignesh Raghavendra <vigneshr@ti.com>
> @@ -16579,8 +16577,6 @@ F:	drivers/media/pci/tw686x/
>  
>  UBI FILE SYSTEM (UBIFS)
>  M:	Richard Weinberger <richard@nod.at>
> -M:	Artem Bityutskiy <dedekind1@gmail.com>
> -M:	Adrian Hunter <adrian.hunter@intel.com>
>  L:	linux-mtd@lists.infradead.org
>  T:	git git://git.infradead.org/ubifs-2.6.git
>  W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
> @@ -16697,7 +16693,6 @@ S:	Maintained
>  F:	drivers/scsi/ufs/ufs-mediatek*
>  
>  UNSORTED BLOCK IMAGES (UBI)
> -M:	Artem Bityutskiy <dedekind1@gmail.com>
>  M:	Richard Weinberger <richard@nod.at>
>  W:	http://www.linux-mtd.infradead.org/
>  L:	linux-mtd@lists.infradead.org

Thanks,
Miquèl
