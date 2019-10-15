Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDBBECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E0220663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571168247;
	bh=lcpIP2gdDDciuXOla/dQcSyYcp9/lx8ELrq6YY97BrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dql9erXVg3yoVOHZHOgjNu2pixGgh0bK0Rqz7+GqcoSI7YOxzuDysttYa1jlTVjCp
	 FsbTWGbk4WIE5/PKGTFTt6vXjSDLiN1y4eNsBVVMVcCl0SbSDIhLTGzZdcQFc2uT3g
	 TG2L6ZWd99RIb5/+scr3xHQS00u5mWa8O92SqkK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfJOThZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbfJOThZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:37:25 -0400
Received: from localhost (unknown [38.98.37.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A830320872;
        Tue, 15 Oct 2019 19:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571168244;
        bh=lcpIP2gdDDciuXOla/dQcSyYcp9/lx8ELrq6YY97BrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAAIQqb4CEp/F11NqfFBJEnj6jRgBQD9V7wmM2CEM+TlE6qwRTnFpg8nNUyaVP87D
         f+eoaflEQTcvdejOyGx4eBzOCVZcSvSz5gkc+NPkVTiYuMreSSs9Y8tAY0DCWVUgEr
         bGfr3z/YQzJL2pEL0ieP1pcZPvC2xVwMkcbm3Ky0=
Date:   Tue, 15 Oct 2019 21:36:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michiel Schuurmans <michielschuurmans@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Christina Quast <contact@christina-quast.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        Zach Turner <turnerzdp@gmail.com>
Subject: Re: [PATCH] [PATCH] staging: rtl8192e: Fix checkpatch errors
Message-ID: <20191015193635.GA1153895@kroah.com>
References: <20191015193210.20146-1-michielschuurmans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015193210.20146-1-michielschuurmans@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:32:08PM +0200, Michiel Schuurmans wrote:
> Replace formatting as suggested by checkpatch.
> 
> Signed-off-by: Michiel Schuurmans <michielschuurmans@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

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
