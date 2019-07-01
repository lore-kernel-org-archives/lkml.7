Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04836C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA893214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561963706;
	bh=vkthgdF/kKuKoMxa+wMdGLMvroNlFfYu/zU+JAvGcgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ApifMs3CYkcCM0tSZaEaqVydHt4D8abqxqrGBtGoksg95qGKKvbBdaTk5rxj8EI71
	 t1jN4FoM1PGK/CPEJ13qt+aDbiaOffPQrBm5mc/wkBtYxv97yZsza+ejyoEpFugKis
	 aOizB06Cj7cOG9dH0N75kAGCmJG5hOwPx0xBcHRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfGAGsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfGAGsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:48:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB172145D;
        Mon,  1 Jul 2019 06:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561963704;
        bh=vkthgdF/kKuKoMxa+wMdGLMvroNlFfYu/zU+JAvGcgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ek9e05ew3xF9NZT3gU+NHTIxZPkX+5j6bP34zKrOiXzaRwfeZ9HVQQyS0otbAseVf
         4ghaUrus3rRNBUJiBmKv5LkBqBvjnWVE1PpHu/Zb1Nt078Dq/PUjttBWYogqgMCj/T
         qadi79BTdRFkHCSGqX/yCYrNHoavjG4EjDRweqic=
Date:   Mon, 1 Jul 2019 08:48:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriel Beauchamp <beauchampgabriel@gmail.com>
Cc:     christian.gromm@microchip.com, colin.king@canonical.com,
        gustavo@embeddedor.com, joe@perches.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: most: fix coding style issues
Message-ID: <20190701064821.GA12135@kroah.com>
References: <dbe411be6aa32a32aafc5a5b77f08e8507b45da3.camel@perches.com>
 <20190630152726.21092-1-beauchampgabriel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630152726.21092-1-beauchampgabriel@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2019 at 08:27:26AM -0700, Gabriel Beauchamp wrote:
> This is a patch for the core.[ch] files that fixes up warnings
> found with the checkpatch.pl tool.
> 
> Signed-off-by: Gabriel Beauchamp <beauchampgabriel@gmail.com>

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
