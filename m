Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B0C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2483A218AE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567876069;
	bh=W6F7Mkf6oMUfeq/tnd7a5zhL8K7SHq1XA/JZa7RAXhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cDfo4FVt/e1wMspINZeQGsQTt5iZ9Egtw4HSTcYwX1cLzboRyZ3AMWvdyKTygzqRB
	 F4Y17s0+v4YXtKjySc5Eve32xmE8aCOKTEGITLZ060sOipb/OyA0sqGV7ibtGFBsO4
	 YoDOn/povjSA8auonJCU7/ilMyIlN1R5VqNKSrPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395105AbfIGRHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389011AbfIGRHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:07:48 -0400
Received: from localhost (unknown [80.251.162.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CF321835;
        Sat,  7 Sep 2019 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567876067;
        bh=W6F7Mkf6oMUfeq/tnd7a5zhL8K7SHq1XA/JZa7RAXhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYaWtn/du38ppga6SBpybBH2UzNkMh9ANBwr9nC+7wT2mekgO83TwU3imN0qZLmyg
         Sh5uMOYbjfO4WqptFtvnYKeQ6lr1kSg80o3wPN6mMYsumqHxlqv/cUtBMz33QagT/N
         ZDv6a5a/nedqM2VdwLvdRG8+UCH1i/4SoegeXpKs=
Date:   Sat, 7 Sep 2019 18:07:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     volery <sandro@volery.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
Message-ID: <20190907170744.GA17100@kroah.com>
References: <20190907090948.GA5824@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907090948.GA5824@volery>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 11:09:48AM +0200, volery wrote:
> There were a lot of styling problems using space then tab or spaces
> instead of tabs in that file. Especially the entire function at line
> 2677.
> Also added a space before the : on line 2221.
> 
> Signed-off-by: Sandro Volery <sandro@volery.com>
> ---
>  drivers/tty/tty_io.c | 60 ++++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)

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

- Your patch breaks the build.

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
