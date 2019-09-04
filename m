Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F76C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E217208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567622173;
	bh=GTxG0x3SjW+AbBc6RPkuBbTYZAv5mi3uQJ0SdGnvY90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZcoXi/xBNXn0zzLg/3n3G3PsdjBjmg+rgcG+pnKf1UCY+ouYs24EG1uWLq6mO4PUE
	 +7XHwvfYhNit+/lSSrCl0+osiorJXNB+QxJu2kN9/7wgmH60D8JMRNt567ozaFej4y
	 HzlnGM3c5GQj4f3xY3EHjEveGULzzoQIST1/4CI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfIDSgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732177AbfIDSgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:36:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9626920820;
        Wed,  4 Sep 2019 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567622171;
        bh=GTxG0x3SjW+AbBc6RPkuBbTYZAv5mi3uQJ0SdGnvY90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SaJPgvwrSJOEr8Tx4SeFQoYiz5jz65bIH/yPBKFwv28VwoZjdgDd/uql/vdL2x9sD
         Pmqjmhu8gw9MhxXe3DZzFBLKCRy5RNp0BEbReOgXRg1+eAhjW0K9wDm9E03raooKd2
         OujkS4LC3/hC4XN2lVBBmscjvbchDFocJaMvvNW0=
Date:   Wed, 4 Sep 2019 20:36:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Joe Perches <joe@perches.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: siano: Use the correct style for SPDX License
 Identifier
Message-ID: <20190904183608.GA495@kroah.com>
References: <20190831151147.GA7082@nishad>
 <20190904153432.7fb54f02@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904153432.7fb54f02@coco.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 03:34:32PM -0300, Mauro Carvalho Chehab wrote:
> Em Sat, 31 Aug 2019 20:41:51 +0530
> Nishad Kamdar <nishadkamdar@gmail.com> escreveu:
> 
> > This patch corrects the SPDX License Identifier style
> > in header file related to Siano Mobile Silicon Digital TV.
> > For C header files Documentation/process/license-rules.rst
> > mandates C-like comments (opposed to C source files where
> > C++ style should be used)
> > 
> > Changes made by using a script provided by Joe Perches here:
> > https://lkml.org/lkml/2019/2/7/46
> > 
> > Suggested-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/media/common/siano/smsir.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/common/siano/smsir.h b/drivers/media/common/siano/smsir.h
> > index b2c54c256e86..ada41d5c4e83 100644
> > --- a/drivers/media/common/siano/smsir.h
> > +++ b/drivers/media/common/siano/smsir.h
> > @@ -1,5 +1,5 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> >  /*
> > - * SPDX-License-Identifier: GPL-2.0+
> >   *
> >   * Siano Mobile Silicon, Inc.
> >   * MDTV receiver kernel modules.
> 
> What's wrong with that? The above is a perfectly fine SPDX header.

It is not the first line of the file :(

