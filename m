Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE83DC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F82921855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569942578;
	bh=QYabAK3E31ZbQnReWC+jv5P+nvakbR00xJrsdY7bI3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ge4gvL/mpm3ZU9+cDBm4bkposGjdJLv5BlnZmgaTbuKFLhGg2nf7RXmwUcTHpx4FW
	 LEmaRgixWxvn99+s2cuu8ECRvSQYwTCORawt4HdGO3XZgR0aNklnbVLB0laa8EVJ5O
	 3zxkhkUzbtUXkBy5UTUc6y/1W7CtwoIpfyKkn8qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbfJAPJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:09:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732232AbfJAPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5jDO6BJ2XZ3lCXlD4qqkd9/bqgxLyoxwyp9GKWDHrvI=; b=eFg+C2Li9Lbix6bmqH7hvtyDk
        QT5kBQpSlNZKQ7vjjA3KXp658Y6Ku8ja5dqtr2zaGbLoTpBkLNauhpYw40IHKCLKXgKpNmEN5wf5d
        7LdqWKwhF+ZJM06vaFsOqKh7LRxnvvXrgpnPGWd8Ep46LoGVLqeLo0EzlCFogGnxXTudD+4l1Wwke
        NYZOOZvEzSVY54fd6j5YWUhWCj7Q+aCcEUCj471uqNg7JGdnJbkKcQ0hefbaemak9W9LRglgEaS8c
        k8HPNJY7+iQmWnVsEE7h07diTzgpC5GAgEiI1kjSx5zNadyhm45xHxTasEHSOb2lIP3Tm8XFoSHt2
        hOYouQTpA==;
Received: from 177.157.127.95.dynamic.adsl.gvt.net.br ([177.157.127.95] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFJmR-0000AQ-La; Tue, 01 Oct 2019 15:09:35 +0000
Date:   Tue, 1 Oct 2019 12:09:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: Programmatically render MAINTAINERS into ReST
Message-ID: <20191001120930.5d388839@coco.lan>
In-Reply-To: <20191001083147.3a1b513f@lwn.net>
References: <20190924230208.12414-1-keescook@chromium.org>
        <20191001083147.3a1b513f@lwn.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 1 Oct 2019 08:31:47 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue, 24 Sep 2019 16:02:06 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > Commit log from Patch 2 repeated here for cover letter:
> > 
> > In order to have the MAINTAINERS file visible in the rendered ReST
> > output, this makes some small changes to the existing MAINTAINERS file
> > to allow for better machine processing, and adds a new Sphinx directive
> > "maintainers-include" to perform the rendering.  
> 
> I finally got around to trying this out.  After the usual warnings, the
> build comes to a screeching halt with this:
> 
>   Sphinx parallel build error:
>   UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 8: ordinal not in range(128)
> 
> For extra fun, the build process simply hangs, requiring a ^C to blow it
> away.  You've managed to get new behavior out of Sphinx that I've not seen
> before, congratulations :)
> 
> This almost certainly has to do with the fact that I'm (intentionally)
> running the Python2 Sphinx build here.  Something's not doing unicode that
> should be.
> 
> I would suggest that we might just want to repair this before merging this
> feature.  Either that, or we bite the bullet and deprecate the use of
> Python 2 entirely - something that's probably not too far into our future
> regardless.  Anybody have thoughts on that matter?

I'm almost sure we got this already. If I'm not mistaken, the solution
is to add the encoding line after shebang. Looking at 
Documentation/sphinx/maintainers_include.py (patch 2/2), the script
starts with:

	#!/usr/bin/env python
	# SPDX-License-Identifier: GPL-2.0
	# -*- coding: utf-8; mode: python -*-
	# pylint: disable=R0903, C0330, R0914, R0912, E0401

But, as I pointed before, the SPDX header at the wrong place is causing the 
crash, as the encoding line should be the second line, not the third one,
e. g.:

	#!/usr/bin/env python
	# -*- coding: utf-8; mode: python -*-
	# SPDX-License-Identifier: GPL-2.0
	# pylint: disable=R0903, C0330, R0914, R0912, E0401

I also suspect that this would happen even with python3, depending on
how LC_ALL, LANG, ... are set on the distro you use.

Thanks,
Mauro
