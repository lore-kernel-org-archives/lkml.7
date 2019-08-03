Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D253C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 11:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39833206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 11:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564831477;
	bh=RNquwM047cDJ3xjYxGuVe7gjdVQs2ryGrrv4iEqUqIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vn70fHwF1ZqE3TmxgNCLY/UfnKi2UbAy35vQHDnaAqxdINYTDkQBXLEHhNtoRCzj9
	 g7caPSopwYWZupdetZkt2Szi8y8xeQYwhGQ5Zz+QRWsl0fn4NxFY55gsEpuiVeqc5m
	 HiZderWI8PKD4NcWJJcPETJw9h275w50bptJRk+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbfHCLYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 07:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389688AbfHCLYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 07:24:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ACF6206A2;
        Sat,  3 Aug 2019 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564831474;
        bh=RNquwM047cDJ3xjYxGuVe7gjdVQs2ryGrrv4iEqUqIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oH49PuNsqu/UXtMy1nOVlC8wXZ3KV6eOsVAY/nA7749RWn2ViX6s8kFbrjEVqoE8e
         vrnTwgfx+//1kfsaXgeLXehgA1fkJ29CVf3Z1kDrh+PAkLKeiRw7kydccpWBLoBOML
         RFja6KgzMQ0BfSk8v5JOliZeQWtDyK/N1jhvomww=
Date:   Sat, 3 Aug 2019 13:24:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jose Carlos Cazarin Filho <joseespiriki@gmail.com>,
        devel@driverdev.osuosl.org, netdev@vger.kernel.org,
        isdn@linux-pingi.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: hysdn: Fix error spaces around '*'
Message-ID: <20190803112432.GA22063@kroah.com>
References: <20190802195602.28414-1-joseespiriki@gmail.com>
 <20190803063246.GA10186@kroah.com>
 <6ff800ceda4b1c1f1d9e519aac13db42dc703294.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff800ceda4b1c1f1d9e519aac13db42dc703294.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 04:15:05AM -0700, Joe Perches wrote:
> On Sat, 2019-08-03 at 08:32 +0200, Greg KH wrote:
> > On Fri, Aug 02, 2019 at 07:56:02PM +0000, Jose Carlos Cazarin Filho wrote:
> > > Fix checkpath error:
> > > CHECK: spaces preferred around that '*' (ctx:WxV)
> > > +extern hysdn_card *card_root;        /* pointer to first card */
> []
> > > diff --git a/drivers/staging/isdn/hysdn/hysdn_defs.h b/drivers/staging/isdn/hysdn/hysdn_defs.h
> []
> > > @@ -220,7 +220,7 @@ typedef struct hycapictrl_info hycapictrl_info;
> > >  /*****************/
> > >  /* exported vars */
> > >  /*****************/
> > > -extern hysdn_card *card_root;	/* pointer to first card */
> > > +extern hysdn_card * card_root;	/* pointer to first card */
> > 
> > The original code here is correct, checkpatch must be reporting this
> > incorrectly.
> 
> Here checkpatch thinks that hydsn_card is an identifier rather
> than a typedef.
> 
> It's defined as:
> 	typedef struct HYSDN_CARD {
> 	...
> 	} hysdn_card;
> 
> And that confuses checkpatch.
> 
> kernel source code style would not use a typedef for a struct.
> 
> A change would be to remove the typedef and declare this as:
> 	struct hysdn_card {
> 		...
> 	};
> 
> And then do a global:
> 	sed 's/\bhysdn_card\b/struct hysdn_card/g'
> 
> But that's not necessary as the driver is likely to be removed.

Ah, that makes sense why checkpatch did this, thanks for the
information.

And yes, it's not worth being changed, as this is going to be deleted.
But, I bet we get this sent a lot until it is as it's "easy pickings" :)

thanks,

greg k-h
