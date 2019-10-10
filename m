Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B71AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55ED21920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697727;
	bh=i+t7/YEn0t07Cx9UetTXLHhnlWgrYeJ6jGCRIViiryM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qoJ0EIkPbnRWBbvf+ZQDtpmel+SCKKSAguiJAgmp7CIACEU8gtgktG+jD/Utw7hde
	 +NVGxWeFrU4yyTk8cWu6kW0SJ2Gbwv0OCJNH8Gcbj9oxV1P9ZXm7hZtGz9rGom8i0R
	 uZ4pZ/7W8WpHDom6t/auqQH6IDV2oiBFts3zimGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbfJJIz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388344AbfJJIzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:55:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF0DF2190F;
        Thu, 10 Oct 2019 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697724;
        bh=i+t7/YEn0t07Cx9UetTXLHhnlWgrYeJ6jGCRIViiryM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1gOm/EnQOOR0P0eHMOb0V71mSg9JTuHfxwOhWbyvT//9zuqEwt0b4wiAlB1zuQy0b
         NrIPGuHtnebfky9hHyTh6vfO/fwsvLoDn/D0Ka/biY6EDyKW8eX67fphUqwxVXXGeX
         QaKT34lGpq61SiQsYIlDDqobPwmQBVgOXbjyupmU=
Date:   Thu, 10 Oct 2019 10:41:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chandra Annamaneni <chandra627@gmail.com>
Cc:     devel@driverdev.osuosl.org, gneukum1@gmail.com,
        fabian.krueger@fau.de, linux-kernel@vger.kernel.org,
        simon@nikanor.nu, dan.carpenter@oracle.com
Subject: Re: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (line length)
Message-ID: <20191010084140.GA365456@kroah.com>
References: <1570676937-3975-1-git-send-email-chandra627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570676937-3975-1-git-send-email-chandra627@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 08:08:57PM -0700, Chandra Annamaneni wrote:
> Resoved: "WARNING: line over 80 characters" from checkpatch.pl
> 
> Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc2000_spi.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
> index 3be33c4..ef78b6d 100644
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
> +	{ .name = "SLOT_0",  .size = 7798784,  .offset = 0,},
> +	{ .name = "SLOT_1",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "SLOT_2",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "SLOT_3",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "CS0_EXTRA", .size = MTDPART_SIZ_FULL, .offset = MTDPART_OFS_NXTBLK},
>  };
>  
>  static struct mtd_partition p2kr0_spi1_parts[] = {
> -	{ .name = "SLOT_4",	.size = 7798784,		.offset = 0,                },
> -	{ .name = "SLOT_5",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "SLOT_6",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "SLOT_7",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "CS1_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "SLOT_4",  .size = 7798784,  .offset = 0,},
> +	{ .name = "SLOT_5",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "SLOT_6",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "SLOT_7",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "CS1_EXTRA",  .size = MTDPART_SIZ_FULL, .offset = MTDPART_OFS_NXTBLK},
>  };
>  
>  static struct flash_platform_data p2kr0_spi0_pdata = {
> -- 
> 2.7.4
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for a description of how
  to do this so that Greg has a chance to apply these correctly.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
