Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E4C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384DC2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfGHMyb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:54:31 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53471 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfGHMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:54:30 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 78D0A1C0012;
        Mon,  8 Jul 2019 12:54:27 +0000 (UTC)
Date:   Mon, 8 Jul 2019 14:54:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mtd: remove c++ comments from uapi header
Message-ID: <20190708145426.62b4aabd@xps13>
In-Reply-To: <20190708124946.3679242-1-arnd@arndb.de>
References: <20190708124946.3679242-1-arnd@arndb.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Mon,  8 Jul 2019 14:49:39 +0200:

> Checking the uapi headers now produces a warning with clang:
> 
> ./usr/include/mtd/mtd-abi.h:116:28: error: // comments are not allowed in this language [-Werror,-Wcomment]
> 
> Change these into standard C comments here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/uapi/mtd/mtd-abi.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
> index aff5b5e59845..47ffe3208c27 100644
> --- a/include/uapi/mtd/mtd-abi.h
> +++ b/include/uapi/mtd/mtd-abi.h
> @@ -113,11 +113,11 @@ struct mtd_write_req {
>  #define MTD_CAP_NVRAM		(MTD_WRITEABLE | MTD_BIT_WRITEABLE | MTD_NO_ERASE)
>  
>  /* Obsolete ECC byte placement modes (used with obsolete MEMGETOOBSEL) */
> -#define MTD_NANDECC_OFF		0	// Switch off ECC (Not recommended)
> -#define MTD_NANDECC_PLACE	1	// Use the given placement in the structure (YAFFS1 legacy mode)
> -#define MTD_NANDECC_AUTOPLACE	2	// Use the default placement scheme
> -#define MTD_NANDECC_PLACEONLY	3	// Use the given placement in the structure (Do not store ecc result on read)
> -#define MTD_NANDECC_AUTOPL_USR 	4	// Use the given autoplacement scheme rather than using the default
> +#define MTD_NANDECC_OFF		0	/* Switch off ECC (Not recommended) */
> +#define MTD_NANDECC_PLACE	1	/* Use the given placement in the structure (YAFFS1 legacy mode) */
> +#define MTD_NANDECC_AUTOPLACE	2	/* Use the default placement scheme */
> +#define MTD_NANDECC_PLACEONLY	3	/* Use the given placement in the structure (Do not store ecc result on read) */
> +#define MTD_NANDECC_AUTOPL_USR 	4	/* Use the given autoplacement scheme rather than using the default */
>  
>  /* OTP mode selection */
>  #define MTD_OTP_OFF		0

A similar patch has been sent a few weeks ago and has been applied
yesterday night so it should have appeared this morning in linux-next :)


Thanks anyway!
Miquèl
