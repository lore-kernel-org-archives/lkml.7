Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782F8C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F20527BE1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559563568;
	bh=EKhNyBAfNxOKEhvdrjWPO+lRER7We/ReqFPk94xj26Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bG6f1FOzXULy9OUzWhLOoeBfpfPj9xqHEAbKg+KXOemECXLdCJ5ufn0T6hgzzQ/tr
	 6mF4QzyPaQ/g47qginuT+TYmP1e2DCAVBbsu+gc6aT7RWcDwSMpk3daRmU6/04t9ph
	 djhh3bJjU6Y8H1MqNPDNkd+TC6LtvwGy7LDALw08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfFCMGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFCMGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:06:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E952500E;
        Mon,  3 Jun 2019 12:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559563566;
        bh=EKhNyBAfNxOKEhvdrjWPO+lRER7We/ReqFPk94xj26Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uN1m9V1POrSWguPHinx3MUCOXQraw0IgJJ3xgHaampPd5OiVVQRaaiUvGFxAwq9uV
         zHQPrZLNHYIUYBN8DC+nnl7zdYweYE4+ud6/t6HWVgJbqLMQQnWTzu/v7k0rTT5Pbj
         ceJo8Sh4vvOTYAmgM1a1cIyzSI0kdWxnDHKxP9VI=
Date:   Mon, 3 Jun 2019 14:06:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tobias =?iso-8859-1?Q?Nie=DFen?= 
        <tobias.niessen@stud.uni-hannover.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Sabrina Gaube <sabrina-gaube@web.de>
Subject: Re: [PATCH] Improve code style in drivers/staging/rts5208
Message-ID: <20190603120603.GA23013@kroah.com>
References: <20190603114350.32242-1-tobias.niessen@stud.uni-hannover.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603114350.32242-1-tobias.niessen@stud.uni-hannover.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 01:43:50PM +0200, Tobias Nieﬂen wrote:
> These changes to sd.c and xd.c slightly improve the code style and
> reduce the overall line length.
> 
> Signed-off-by: Tobias Nieﬂen <tobias.niessen@stud.uni-hannover.de>
> Signed-off-by: Sabrina Gaube <sabrina-gaube@web.de>
> ---
>  drivers/staging/rts5208/sd.c | 23 +++++++++++------------
>  drivers/staging/rts5208/xd.c |  8 ++++----
>  2 files changed, 15 insertions(+), 16 deletions(-)

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
