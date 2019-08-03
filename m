Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B52C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5887F21726
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564813481;
	bh=fpNScs+MHTf7w01QKi3dsBPtHieQZxhSWLqi9kwhYkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rKXDs+8hbD5ej6VOcsxLiMVbnJ3iLybQD/fqNF6TpWfgJFg0paKOsS4KI8hTMel9q
	 1DvJbbvbSuJyA6kkrxAHmsUJAF9kJ8RLO4nglLeEt9A7/SYF+FkLicCM+SEtrz03/Z
	 VeCh6bg+SYgxy73h/eE+nfenTiVJMGD+pzfRQ920=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfHCGYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 02:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbfHCGYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:24:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C4E2087C;
        Sat,  3 Aug 2019 06:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564813477;
        bh=fpNScs+MHTf7w01QKi3dsBPtHieQZxhSWLqi9kwhYkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbrugMEiFk0q6RUBzHE2KRiLg/W1FI7A/GJVyZkXxWNR6Njw4Q0n6i4Tq2ohlrWIf
         ujUGCJYikOZGyTdGtyGpNhJ9vADWPA86BM+ouzKyvcesZnxyvsW3VVk+KFIWGyMQFD
         WIbGQuK/eWGbb+ryLb75czFA+MyRyrab5myWduZM=
Date:   Sat, 3 Aug 2019 08:24:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] rtl8188eu: hal: phy.c
Message-ID: <20190803062434.GA9160@kroah.com>
References: <20190802210018.29251-1-joseespiriki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802210018.29251-1-joseespiriki@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 09:00:18PM +0000, Jose Carlos Cazarin Filho wrote:
> Fix a lot of checkpath errors of the type:
> 	-CHECK: spaces preferred around that
> 	-CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
> ---
>  My second commit to the kernel, I know you ppl don't like these kind of commits
>  fixing style-only erros pointed by the checkpath, but I'm doing this just to learn
>  Thanks!
>  drivers/staging/rtl8188eu/hal/phy.c | 54 ++++++++++++++---------------
>  1 file changed, 27 insertions(+), 27 deletions(-)

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
