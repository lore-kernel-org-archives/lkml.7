Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C59C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C32A2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560800761;
	bh=MgWBRgom0TeDPVoVtgeO9Szc+BhqL4mX3zOVqWhlHFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bK0c9Hgew4BFAtMN115vIBPaCP3SDES2YzZtVt4YHLytz6uoKbqHmcaDsNt8EAKDn
	 D0aEn/RdLN/8P9MRrLX8cBkcLnNiKYyOyfPb5ZIc1huqMjsZbYa3nf1xGOEpLEQVZU
	 HveffutbbiSQDaKBsvSslatNDi7scSbr2Kf1QeJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfFQTpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:45:55 -0400
Received: from casper.infradead.org ([85.118.1.10]:38336 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfFQTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=76GJ8bjLwn5gnvDNJShrlkM+RiGU+MWO5N2V/mZ8lAU=; b=WHdgtVLiHPk1hrxxk/4SizG0Ul
        Er0j8EW950YQ6SmTEWx3dJKzF2u42NntXt4U+AGdSvSGTLUFJQIIQRoPFpFPNop1E0h1UtEovY2a/
        l/VdfdI7YwMYIgsKejbjdk0vkMEy36EftDKfP0SytURnaB+0l3g3E4qKqfkSDV5bUQeLyC26oCi4G
        9rIeLKPXQTkCdMKY1NYrb5rcNWdE5PjXrcVBX0YsLU34r8B811HGJ8PwVjAIztBRxaoW71rkX06EW
        6/AZMmkm51icEoF8iGR/MAdpWMffEJ+nf+oRiThAZcjlwv8hBWfYpD1Xyn8zmnrmCdQ/ygive18eX
        rwOJHoUw==;
Received: from 179.186.105.91.dynamic.adsl.gvt.net.br ([179.186.105.91] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcxZh-0003p2-Ed; Mon, 17 Jun 2019 19:45:54 +0000
Date:   Mon, 17 Jun 2019 16:45:47 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [PATCH RFC] scripts: add a script to handle
 Documentation/features
Message-ID: <20190617164547.65ce54bd@coco.lan>
In-Reply-To: <20190617181116.GA17114@kroah.com>
References: <20190617142117.76478570@coco.lan>
        <98ce589a7c50e2693ab6be158e03afde19aed81e.1560794401.git.mchehab+samsung@kernel.org>
        <20190617181116.GA17114@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 17 Jun 2019 20:11:16 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, Jun 17, 2019 at 03:05:07PM -0300, Mauro Carvalho Chehab wrote:
> > The Documentation/features contains a set of parseable files.
> > It is not worth converting them to ReST format, as they're
> > useful the way it is. It is, however, interesting to parse
> > them and produce output on different formats:
> > 
> > 1) Output the contents of a feature in ReST format;
> > 
> > 2) Output what features a given architecture supports;
> > 
> > 3) Output a matrix with features x architectures.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> > 
> > As commented at KS mailing list, converting the Documentation/features
> > file to ReST may not be the best way to handle it. 
> > 
> > This script allows validating the features files and to  generate ReST files 
> > on three different formats.
> > 
> > The goal is to support it via a sphinx extension, in order to be able to add
> > the features inside the Kernel documentation.
> > 
> >  scripts/get_feat.pl | 470 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 470 insertions(+)
> >  create mode 100755 scripts/get_feat.pl
> > 
> > diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
> > new file mode 100755
> > index 000000000000..c5a267b12f49
> > --- /dev/null
> > +++ b/scripts/get_feat.pl
> > @@ -0,0 +1,470 @@
> > +#!/usr/bin/perl
> > +  
> 
> No SPDX line :(

Added.

I also added a Sphinx extension to handle it as well. You'll notice that it
is almost a copy of kernel_abi.py. 

With regards to patch 2/2, it will generate both a feature x arch matrix 
at the admin-guide and a x86-specific features list.

IMO, it makes sense to have a per-arch feature file just like the one
I added to x86. As the patches converting documentation for other archs
are still being merged via docs tree, before adding the features list to
the other arch documents, it seems better to wait to do it after the
next merge window.

Those patches are applied after the ABI patches on this dir:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v4.1

The output with both scripts are at:

	https://www.infradead.org/~mchehab/rst_features/index.html

The relevant parts are: ABI:

	https://www.infradead.org/~mchehab/rst_features/admin-guide/abi.html

Feature list x architecture (at admin-guide:

	https://www.infradead.org/~mchehab/rst_features/admin-guide/features.html

X86 features:

	https://www.infradead.org/~mchehab/rst_features/x86/features.html

While I didn't write a patch, with the new get_feat.pl script, we can probably
get rid of the previous shell script at:

	Documentation/features/list-arch.sh

As calling:

	./scripts/get_feat.pl current

Will output the same content (with a different format, though).

Thanks,
Mauro
