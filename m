Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE1FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1723420C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565091309;
	bh=5U/2/Mm5gWlfSv6sjHFTN7DhiPuamWniTpQ726fPCdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NlxLCkJ1z+RltbTicEjHCXCYRWBqNtRg1m3XuPj/elMvJMnJQOtg23A4LvFhr7xYv
	 +hSsZgM6tFDFfS8IQqwUWYPoD/RVkTQqlAV6PDlc8qu2EaqG/77KtLjKQ2OEKpoC4c
	 m9KXqgrIzsbG7/+NntTtEfGkL9zXdjb/k9pf1NaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbfHFLfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfHFLfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:35:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3E82089E;
        Tue,  6 Aug 2019 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565091304;
        bh=5U/2/Mm5gWlfSv6sjHFTN7DhiPuamWniTpQ726fPCdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n12m+88N5aBRrXyP74KrQsS7Syb2gKkgrjZqUqVqxQfAEW912HN6lPYhKBjR8m2A+
         TRbN3O5mCmrYCZu++Y+jE8rCUjL4L70K61UuRtfUz+KAscb6UNxE6beyKv/EglVV6t
         +D/KQtUk6t8/8cOkIGkGuuDV1NJF/m0twpNUA928=
Date:   Tue, 6 Aug 2019 13:35:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] USB: Move wusbcore and UWB to staging as it is obsolete
Message-ID: <20190806113501.GA18443@kroah.com>
References: <20190806101509.GA11280@kroah.com>
 <b73f09c944625a40b2589e9bac7f8bd22a711ed3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b73f09c944625a40b2589e9bac7f8bd22a711ed3.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:29:40AM -0700, Joe Perches wrote:
> On Tue, 2019-08-06 at 12:15 +0200, Greg Kroah-Hartman wrote:
> > The UWB and wusbcore code is long obsolete, so let us just move the code
> > out of the real part of the kernel and into the drivers/staging/
> > location with plans to remove it entirely in a few releases.
> []
> >  MAINTAINERS                                   | 15 +++-------
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -3800,14 +3800,9 @@ F:	scripts/sign-file.c
> >  F:	scripts/extract-cert.c
> >  
> >  CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
> > -L:	linux-usb@vger.kernel.org
> > +L:	devel@driverdev.osuosl.org
> >  S:	Orphan
> 
> Better to mark this as obsolete so checkpatch emits
> a message saying "no unnecessary modifications"
> 
> 

Ah, good point, will do that as an add-on patch after this.

thanks,

greg k-h
