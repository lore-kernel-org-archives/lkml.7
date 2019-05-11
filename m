Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA6EC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 06:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB4E2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 06:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557554665;
	bh=kYzDwn15QrIEi6kXFnvZYfsdIVkmI+/O0EqDSXyCmSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KYMZHEiKU7lbpR6dBt00TvLQFph/8Um5O1l+XnjQS54sHubPuxcpMzqrPn4DewOOs
	 FqzOl7mCNFvrFzSb58/ytBFOZZ0+A2+wFZxYOh8DnxXvTn43ddNHEpOkAijWmyJl7S
	 hcipSF/v41WOoMW/pSxIurBXYj8WrUiX2xhz02aQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfEKGEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 02:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfEKGEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 02:04:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8E5C2173B;
        Sat, 11 May 2019 06:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557554663;
        bh=kYzDwn15QrIEi6kXFnvZYfsdIVkmI+/O0EqDSXyCmSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r358BJeyRxcCtBNBrUDqEsD1Lu0ZUdSgloe9OMEQRhu3Lhiv2mi+3a9Jgy97rzwvY
         eZX0GfPpnKiRbBR8wt6+4lfD29VBrdjGym2nauPRvsq7QNOAwKoMMPDs59y/g1awM3
         SF/Ss6jw49/OvWZITHDbvjXIeq2Ux5Khk/z5qes4=
Date:   Sat, 11 May 2019 08:04:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vandana BN <bnvandana@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] Staging: kpc2000: kpc_dma: resolve checkpath errors and
 warnings
Message-ID: <20190511060420.GA18755@kroah.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510193833.1051-1-bnvandana@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 01:08:33AM +0530, Vandana BN wrote:
> This patch resolves coding style errors and warnings reported by chechpatch
> 
> ERROR: "(foo*)" should be "(foo *)"
> ERROR: trailing whitespace
> ERROR: space required before the open brace '{'
> ERROR: "foo * bar" should be "foo *bar"
> ERROR: space prohibited after that '!' (ctx:BxW)
> ERROR: space prohibited after that open parenthesis '('
> ERROR: switch and case should be at the same indent
> ERROR: trailing statements should be on next line
> ERROR: Macros with complex values should be enclosed in parentheses
> ERROR: "foo __init  bar" should be "foo __init bar"
> ERROR: "foo __exit  bar" should be "foo __exit bar"
> WARNING: Missing a blank line after declarations
> WARNING: Prefer using '"%s...", __func__' to using function's name, in a string
> WARNING: braces {} are not necessary for any arm of this statement
> WARNING: unnecessary cast may hide bugs
> WARNING: braces {} are not necessary for single statement
> WARNING: struct file_operations should normally be const
> WARNING: labels should not be indented
> Signed-off-by: Vandana BN <bnvandana@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc_dma/dma.c         | 137 +++++------
>  drivers/staging/kpc2000/kpc_dma/fileops.c     | 220 +++++++++---------
>  .../staging/kpc2000/kpc_dma/kpc_dma_driver.c  | 121 +++++-----
>  .../staging/kpc2000/kpc_dma/kpc_dma_driver.h  |  32 +--
>  4 files changed, 265 insertions(+), 245 deletions(-)
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
