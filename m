Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0423220B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565003400;
	bh=4v1BXGNEAXSPDV+b8ZWGqw5cQa5k3Mn7PfVlahFOd2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ecwta4Mad12gp0cgszDxR7saGz9t5Qt7PpdPBFtMN9IoVkrnP1pvoijSFuPerkFMO
	 2Ibv8lFdLbL3pPZHGqvCyWH9nrLmCl8/VF5wiezpRTXrMOcGvkTZduJuvAdDDLkqdx
	 3SLYkVWttA4Dsgx8NARtIAfG9+Uw9t9EBDzE5eS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfHELJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfHELJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:09:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC2C620856;
        Mon,  5 Aug 2019 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565003397;
        bh=4v1BXGNEAXSPDV+b8ZWGqw5cQa5k3Mn7PfVlahFOd2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TdYkGai1Y5PgHsSHjnVyphk1RcMxm6kW80iHGktTwcdCJxxSDUYDHbICxQYYOWJog
         dES8G+ZO2mZxjgDDvRHuuVgjuOG+00HAIeJjQbgM76HQoQRnXYIWrAEainf8MIJHvk
         wYV4WH1T6/BvESMiR1/KgTfd6BBwMheLuXRCj9cI=
Date:   Mon, 5 Aug 2019 13:09:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     merwintf <merwintf@gmail.com>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH] Staging : rtl8188eu : rtw_security.c       - Fixed
 warning: coding style issues   - Fixed warning: if statement containing
 return with an else    - Fixed check: coding style issues
Message-ID: <20190805110954.GC6598@kroah.com>
References: <20190805075256.GA7330@IoT-COE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805075256.GA7330@IoT-COE>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 01:22:56PM +0530, merwintf wrote:
> Signed-off-by: merwintf <merwintf@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_security.c | 525 +++++++++++-------
>  1 file changed, 334 insertions(+), 191 deletions(-)
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
