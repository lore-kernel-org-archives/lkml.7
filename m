Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04048C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A8820882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554373456;
	bh=WRAuoJvBBtkGtlOGNi2tpZIndJUqz6cDkYMgk6CJdCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aPWLk8zQNCgym9cvDr6mDZ3eqrpTeOivrp7Y2T2uTP95+T6Dpo4HNH1qop9pdFzCj
	 J4ylS9TFfvdsbmxrGNuzZvTIJKyjrOcNT/YL0+UzVRhb52A8W59WRv3yyhkl+qj6Iy
	 EYAA2CmugWuNte+QRGWSrPU4uCyQB0FhetFaG8uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfDDKYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfDDKYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:24:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA9C20643;
        Thu,  4 Apr 2019 10:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554373454;
        bh=WRAuoJvBBtkGtlOGNi2tpZIndJUqz6cDkYMgk6CJdCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbLg7NzaiQm1ZD1IObJ9aTISgYlrhlGYa6Hdaa4Yv0X1F34RgkAycC6NWaZ9irWSi
         +NFNQKvSIxq8GSoUfo1MID3D0m+QhZhYPKxlTd2IjerPBIWOiaoh9kCF7CBzNte2CM
         aBGgUGLryE4vybbj80FwXZkNJ5xqSK+l8E3LEnqQ=
Date:   Thu, 4 Apr 2019 12:24:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] tty: fix up a few remaining files without SPDX
 identifiers
Message-ID: <20190404102405.GA15592@kroah.com>
References: <20190402140708.519-1-gregkh@linuxfoundation.org>
 <20190402140708.519-2-gregkh@linuxfoundation.org>
 <988b3a14-f5f6-44cb-3bda-eb7489bd2431@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988b3a14-f5f6-44cb-3bda-eb7489bd2431@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 02:16:06PM +0530, Mukesh Ojha wrote:
> 
> On 4/2/2019 7:37 PM, Greg Kroah-Hartman wrote:
> > There were a few straggling files under drivers/tty/ that did not have
> > any SPDX identifier either because they entered the tree recently, or
> > they somehow missed the mass-tagging of commit b24413180f56 ("License
> > cleanup: add SPDX GPL-2.0 license identifier to files with no license")
> > 
> > This commit follows the same rule as b24413180f56 ("License cleanup: add
> > SPDX GPL-2.0 license identifier to files with no license") where files
> > without any specified license in them fall under GPL-2.0 as the correct
> > license for the individual file.  Add that identifier to these remaining
> > files so that we don't have to guess at the license of them in the
> > future.
> > 
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/tty/serial/8250/8250_men_mcb.c | 1 +
> >   drivers/tty/serial/sn_console.c        | 1 +
> >   drivers/tty/vcc.c                      | 1 +
> >   drivers/tty/vt/.gitignore              | 1 +
> >   drivers/tty/vt/cp437.uni               | 1 +
> >   drivers/tty/vt/defkeymap.c_shipped     | 1 +
> >   drivers/tty/vt/defkeymap.map           | 1 +
> >   7 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
> > index 127017cc41d9..02c5aff58a74 100644
> > --- a/drivers/tty/serial/8250/8250_men_mcb.c
> > +++ b/drivers/tty/serial/8250/8250_men_mcb.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >   #include <linux/device.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> > diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
> > index fe9170731c16..283493358a62 100644
> > --- a/drivers/tty/serial/sn_console.c
> > +++ b/drivers/tty/serial/sn_console.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >   /*
> >    * C-Brick Serial Port (and console) driver for SGI Altix machines.
> >    *
> > diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> > index 58b454c34560..d2a1e1228c82 100644
> > --- a/drivers/tty/vcc.c
> > +++ b/drivers/tty/vcc.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >   /* vcc.c: sun4v virtual channel concentrator
> >    *
> >    * Copyright (C) 2017 Oracle. All rights reserved.
> > diff --git a/drivers/tty/vt/.gitignore b/drivers/tty/vt/.gitignore
> > index 83683a2d8e6a..9b38b85f9d9a 100644
> > --- a/drivers/tty/vt/.gitignore
> > +++ b/drivers/tty/vt/.gitignore
> 
> .gitignore ?

Yes, all files need them :)

> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Thanks for the review.

greg k-h
