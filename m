Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2C8C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845F12171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555061316;
	bh=xWrBx6+oTY/WaLpNPIz9WwDRzDnmK+NRBn7xB5bcwCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lpdXaen+BtMAtywCRHPE0Cm1o1FVikNWsXwq4ZoXrsWqN4ObSaqDLNsDvsC13LNb3
	 FdXjP+skYxRep4mkHO3ZmSiXrsRM54Vuyvkbw0pOBI9OpCdpZcdCw6cW9DdE43wGty
	 yrfUEF0ICc4yaHtH5myCu4Y2IA1lHEvYcYRYHYus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfDLJ2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:28:35 -0400
Received: from casper.infradead.org ([85.118.1.10]:42328 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WdL/F/RraVaWl4C+zv5obLRbC5DtbEUQ8VLCWL3vU0I=; b=Cxmjv6Bo9ZbULcdLj9ZXPVA7rn
        GDJBhJsaA95unpN+Xtht+KVQ77YLKicnSvbJzrFg8eD9gViUB4PjPRNj19Cs3ze1pc1f9lrddTIKy
        c/QjDGiZgwzZYVG9c73/GKohd+kW83gNuK+NGsbpBPGqALHA04Pd2JrSGMwneLa75A7cbdmOEOqTl
        +RLC5kLSvq627UDxodIS3tj2dJ3MpuQb9QGreDZL1owplKXpe5jMU6x000Q9oepngOe0qJxLPqT8C
        Ki8BZ9tr1ZrhCmdvZcrvg9bfXPF+LhG9m5rfFXK020EevSDKomsQHOar75sOZtnl0qRuE15Fe7G7p
        mZjDtejQ==;
Received: from 201.86.162.146.dynamic.adsl.gvt.net.br ([201.86.162.146] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEsU2-0005DL-Nx; Fri, 12 Apr 2019 09:28:31 +0000
Date:   Fri, 12 Apr 2019 06:28:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Add all documentation files to an html/pdf
 produced book
Message-ID: <20190412062826.7681c803@coco.lan>
In-Reply-To: <20190411124904.12e61bc7@lwn.net>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
        <20190408161820.6a12657f@lwn.net>
        <20190410064939.2a9dca9a@coco.lan>
        <20190411124904.12e61bc7@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 11 Apr 2019 12:49:04 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 10 Apr 2019 06:49:39 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> [I'm just responding to one little piece of this for the moment...]
> 
> > In any case, IMHO, the best would be to add a new
> > crap^h^h^h^hstaging group were we could place all legacy random stuff.
> > Then, gradually fix those, splitting stuff and promoting them to the
> > main books, in a similar way to what we do with staging.  
> 
> Now that's an interesting idea; I hadn't thought about that.  Doing so,
> though, implies a willingness to stage unloved docs *out*,

That sounds like a plus! 

> and my experience is that there is little appetite for that. 

Heh, I guess most of us are biased to avoid dropping stuff. Yet, it
happens with time. I wouldn't mind dropping something too outdated
if, after some time, nobody fixes the issues there.

> It also kind of
> implies moving docs twice - at least for the ones that get updates - and
> that may not be entirely appreciated.

True, but avoiding moving twice is not trivial. I mean, files
need to be renamed anyway. Only if we get it right the first
time (converting the file and placing at the right place), we'll
avoid a double move.

I considered an alternative of just including a *.txt file
at a ReST TOC, but Sphinx doesn't allow including a file that
it is not specified at source_suffix. Worse than that, if a
suffix is added there, it will parse (and crash) if the file
has things like:
        some indented title
        ===================

or even:
	- item
	- ....

With a sort of pattern that we have on several text files.

There's an alternative: we could have an "index_staging.rst" file
with the documents that require serious work. So, instead of
actually moving stuff, we'll just place their location there
(but files still need to be renamed). When the document is fixed,
all we need is to move from the staging index to the main one.

> > > I feel like it would, if anything, reduce the incentive to
> > > deal with these leftover documents properly.      
> > 
> > IMHO, it is just the opposite. Let's face it: ReST build was added around
> > May, 2016, for Kernel 4.7. People had quite some time and kernel versions
> > to do conversions. If nothing is done, I doubt we would have any boom on
> > patches addressing the issues.  
> 
> So I don't have any hard numbers, but my feeling is that this work is
> continuing apace and perhaps even picking up.  Certainly I'm having a
> harder time keeping up with it, even when you're busy with other things :)
> These things take time; I'm not really ready to give up on it yet.

Ok. I'm working on a series of patches converting stuff from some random
subsystems. I should be sending the series soon.


Thanks,
Mauro
