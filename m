Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59154C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBE42173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562070508;
	bh=FjfBIbH0kOz+SGRfOSJPjKHyfuRjSgiXO29xImynHtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UUCW2+znj6fMOlApofnnCMCN8oV3nNuc1Noqnh8VeY4DCyfs+yTSUcGpbZBp0mWhY
	 oBbysTpmHd+u1f8Fg6ELmGlt/cUlhvLbPmSv7lpckZykbiYLuLzJFSIcjEnUl6BrRg
	 4u8R+v+ru6NZygzWthsCGLsKAnKfNXlWbWZtdsng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfGBM20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfGBM20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:28:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E1820836;
        Tue,  2 Jul 2019 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562070505;
        bh=FjfBIbH0kOz+SGRfOSJPjKHyfuRjSgiXO29xImynHtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yg5rAW8umxtBwHAFKsPutjGbD0dNDqsLY9NnYntkRsCQCYPZM+vdr63gMfN15/Mk/
         SYb4D5UwWIdi0jrAS9Vkyg+3dvMUV8ri3VhD5UcmuNs9yok5HuGkaDxAkpJ4La/e9F
         lXGuR12uiwR3rx1sZkKBfvWeMUXxcoHC5mJp0rV0=
Date:   Tue, 2 Jul 2019 14:28:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriel Beauchamp <beauchampgabriel@gmail.com>
Cc:     christian.gromm@microchip.com, colin.king@canonical.com,
        gustavo@embeddedor.com, joe@perches.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Staging: most: fix coding style issues
Message-ID: <20190702122822.GA12794@kroah.com>
References: <20190630165604.2452-1-beauchampgabriel@gmail.com>
 <20190702122403.4557-1-beauchampgabriel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702122403.4557-1-beauchampgabriel@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 05:24:03AM -0700, Gabriel Beauchamp wrote:
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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
