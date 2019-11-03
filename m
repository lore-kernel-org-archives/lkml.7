Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797A0CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485D02080F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572784544;
	bh=BK+D11+cHY70edHKin0so2otIas8a6H8FGw7tK2gm0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L9qnaHx5BD1X9+HmKFB1Nuh4b0ZKaEfOvHS+kHzRrqNP2Jo4u6h4QkSfkvbQIpps2
	 AkqBmvBJuVkgDeZ46JXiYq5FRlh5Ip69rnoHloJPnyt0viTnF2Sh5fp8OQESd5E+hu
	 qic8MT7Xzdwa8WPiN8ASmAyTDTuOYkFNJahdmB4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfKCMfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 07:35:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfKCMfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 07:35:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD1D2080F;
        Sun,  3 Nov 2019 12:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572784540;
        bh=BK+D11+cHY70edHKin0so2otIas8a6H8FGw7tK2gm0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1yyuyK5TLDhI39cGDdu78riruurLy+CQ/IxmIXX2JVPEI3xSJZBLG4f8bu/lFF89
         KHBPHm4NjHnkVqDvJ0Nswc2NfEvrBTe/cZZPHNWg+V9HX0J2N/28IEVVQ363/qUkvo
         R7sLDqJ0FA4In7icqVPgIlmHFlm3c7nRzrTkNqGc=
Date:   Sun, 3 Nov 2019 13:35:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rama <ramakumar.kanasundara@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        nishadkamdar@gmail.com
Subject: Re: [PATCH] FBTFT: fb_sh: Changed udelay() to usleep_range() based
 on the Document, Documentation/timers/timers-howto.rst Excerpt from the
 document: -SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms): * Use
 usleep_range
Message-ID: <20191103123538.GA604630@kroah.com>
References: <20191103005906.17112-1-ramakumar.kanasundara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103005906.17112-1-ramakumar.kanasundara@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 07:59:06PM -0500, rama wrote:
> ---
>  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
