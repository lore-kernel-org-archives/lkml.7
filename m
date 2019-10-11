Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F191C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B6121D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570775588;
	bh=TnPE58qDV86k0o5BhRzbVv2fC2mc+NsmiUcLxnerE7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NTs8bK+sJT9r8pNYKmtqckJ/5YdPGnC7Kep7p78hp+Z4sv/4SwZxWzXqoc0RaeaId
	 h/xWe+XLJHshzKC5QlWByjMztrGY6D5dQOSxcbFpvJXz3UASjoaMMl7WCgiJd8CXKf
	 HwolNzNBcDPAW84UhreP4gYa8YM8qToF2GN2d42s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfJKGcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfJKGcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:32:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA8FA21D56;
        Fri, 11 Oct 2019 06:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570775542;
        bh=TnPE58qDV86k0o5BhRzbVv2fC2mc+NsmiUcLxnerE7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRLo7QPRsBYuhpFKZQkmqcgXRt3nFD2Lg0imhUIf+OaJVDoNgY1p6N+APhLY6x0uX
         mtKF2jhkjxlobKahiUxrhK86v/+kh9r2IC5AfF8NTdgz0dOvy4cwnFZFTxpB9s3cQ9
         fpo5xL0IrvqkwSMdn1HMO0sWHq6fnGP8Mz+Meyik=
Date:   Fri, 11 Oct 2019 08:32:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chandra Annamaneni <chandra627@gmail.com>
Cc:     devel@driverdev.osuosl.org, gneukum1@gmail.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        linux-kernel@vger.kernel.org, simon@nikanor.nu,
        dan.carpenter@oracle.com
Subject: Re: [PATCH 1/5] KPC2000: kpc2000_spi.c: Fix style issues (line
 length)
Message-ID: <20191011063219.GA986093@kroah.com>
References: <20191011055155.4985-1-chandra627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011055155.4985-1-chandra627@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:51:51PM -0700, Chandra Annamaneni wrote:
> Resoved: "WARNING: line over 80 characters" from checkpatch.pl

Please put "staging:" in your subject line, makes it easier to sort and
handle.  It should look something like:
	staging: kpc2000_spi: fix line length issues

Looks a lot cleaner, right?

> 
> Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc2000_spi.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
> index 3be33c450cab..81d79b116ce0 100644
> --- a/drivers/staging/kpc2000/kpc2000_spi.c
> +++ b/drivers/staging/kpc2000/kpc2000_spi.c
> @@ -30,19 +30,19 @@
>  #include "kpc.h"
>  
>  static struct mtd_partition p2kr0_spi0_parts[] = {
> -	{ .name = "SLOT_0",	.size = 7798784,		.offset = 0,                },
> -	{ .name = "SLOT_1",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "SLOT_2",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "SLOT_3",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "SLOT_0",  .size = 7798784,  .offset = 0,                },
> +	{ .name = "SLOT_1",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "SLOT_2",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "SLOT_3",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "CS0_EXTRA",  .size = MTDPART_SIZ_FULL,  .offset = MTDPART_OFS_NXTBLK},

Why did you pick 2 spaces here as a random choice of padding?  That's
very odd, please don't.

Either leave this alone (as it lines everything up nicely), or only use
one space.  I would suggest just leaving it alone.

thanks,

greg k-h
