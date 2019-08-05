Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C2DC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934AF20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565003093;
	bh=bscuYmOfxi0UNSI3OBrgXBZ94RilE5rf5BZTijB3RDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NGY9+0sMo2pBRicdYQnZ+D46zdINCFWchY7LGOyXlcaHiG7OiX/HGsJrdTwbDfCRg
	 WQu3KSoST7qVsJZJZ+ei5QbwoVVrMNZiIE6A9lDvrB0qPPJk1xQAeEof6Dtxh32oKA
	 nCe/tWP+kB3s+lpgU+R1P/pKgreXSjTQh4ppJtX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfHELEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfHELEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:04:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9DA20880;
        Mon,  5 Aug 2019 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565003091;
        bh=bscuYmOfxi0UNSI3OBrgXBZ94RilE5rf5BZTijB3RDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B905o5THVWE+kNQuuV/+c88aM7Bo/iKDg0Tgo26bUwd5tjGHgMHJ0Bky83CQlB1R3
         G/61gpWHX5kDGIXpncRTEagBNDO0yJ/ik5e6zjRXPNdxPdIQcInhpE0ECpIadMc3wa
         g8e+w+rs7Ko4uRgKYC3OybJyjJq7iHbntnR3EbY4=
Date:   Mon, 5 Aug 2019 13:04:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, YueHaibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add erase interface for AT25 driver.
Message-ID: <20190805110448.GA6598@kroah.com>
References: <20190805102127.19624-1-joe.burmeister@devtank.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805102127.19624-1-joe.burmeister@devtank.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:21:26AM +0100, Joe Burmeister wrote:
> Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
> ---

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
