Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E769FC433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 07:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB70F2085B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 07:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564902946;
	bh=itXVLBJuAKSPhnQG2e20j5LSdNo0vaAMsRMxNkS5blY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OWSVRcYqHKizn7B/WMH+ysy+MEGPFivrNMby3SkzxDqYuPMBWjsz1UzYjgfQ9xPHE
	 +mRU4OLhGYo5lZE9AwqBdDRxiFaHHr1fgVvH9PuH4MAS3rwrmy1mPPVpZmSR/hcVcK
	 qJzRw1qoOlrvXTnXL8SA0ipgnINEd5bm58+QYF9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfHDHLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 03:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfHDHLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 03:11:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464402070D;
        Sun,  4 Aug 2019 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564902710;
        bh=itXVLBJuAKSPhnQG2e20j5LSdNo0vaAMsRMxNkS5blY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pC6FENya6YIb5lE8XF6rKwv2IhsFG1AGs0p2YKCgr3z5diP78r7jCMcdFnKVGkh90
         xvk29qsOo7wuQUK8OavdkPaky80zu8sKTQwHivvVHwBKxPaWYmyjvJqJYmHxOinHrE
         AlkZt0BUDQm2VfbYR7LtR1CqzYuxE8p78K6XyZKM=
Date:   Sun, 4 Aug 2019 09:11:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     z3phyr <cristianoprasath@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix lines greater than 80 characters
Message-ID: <20190804071148.GB28424@kroah.com>
References: <20190804030456.10567-1-cristianoprasath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804030456.10567-1-cristianoprasath@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 08:34:53AM +0530, z3phyr wrote:
> Fix checkpatch error for "line over 80 characters"
> 
> Signed-off-by: z3phyr <cristianoprasath@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.h | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

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

- You did not use your "real name" for the patch, which is not allowed.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
