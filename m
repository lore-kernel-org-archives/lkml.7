Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EAECA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B5721925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407512AbfJRGNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:13:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:39458 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406918AbfJRGNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:13:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 23:13:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,310,1566889200"; 
   d="scan'208";a="190270930"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.55]) ([10.237.72.55])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2019 23:12:58 -0700
Subject: Re: [PATCH] MAINTAINERS: mtd/ubi/ubifs: Remove inactive maintainers
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20191017142229.3853-1-miquel.raynal@bootlin.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a5914504-9eac-afff-0e7e-8c70bb1b5eac@intel.com>
Date:   Fri, 18 Oct 2019 09:11:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017142229.3853-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/19 5:22 PM, Miquel Raynal wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
> 

