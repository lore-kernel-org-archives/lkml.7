Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E12FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D89A20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561394339;
	bh=H5s9B+mWHa8fAAlANY+QSB05sWH1ftBeHONchoanyss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p55meTJawB+co/KBAsHysgn7F2jYJk9zcSI9TQn4sg/Ytabjuc42Ec9GHKMzq9MRj
	 +otzY4fXME2JvdsmHysVakTWAPQ2OFS/t9FLxmS+rcypFq7b5cqeCssl+gX41qqvEo
	 nQ/qlfVzwV4BbWjJdFvYIe3muVTVjrqoRnZDukYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfFXQi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:38:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfFXQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fY1uicw44jx44qL4fNl32lhk7YJ+D/1JLgTlaHjUDKg=; b=X/gGuMjIdfzOOqUQIRE98lBM8
        hQJ/bXQjAv+k3udNbi95nJ1/gufdyY5py1gC7U+WAQHzoM0Ln6sIYtbupQ39CQlULhoQ/UyYEb7IG
        YeXmW2/8XhLDS4FP6sFxS2sB22txPlNU3jpuu/FN1ZppX+4ExMwDh9PBvRxcYBu4c1mt0j0tVV7Vx
        Xivr/9G0/IY9FiZVWLWYjAMsJGXuMR7FvmzTGXKxbIccY9AIdfr7XJHKnro49rCD2VjXwl1/Xav2O
        mBIHOWiOZqawA+qOwgPJH3uOZb0nZ1UxM7oafp8dKlXGhqtDAhIOk/AHiwNrlh+JMta0ZdvO7nKD4
        VYBICpYzQ==;
Received: from 177.205.71.220.dynamic.adsl.gvt.net.br ([177.205.71.220] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfRzc-0001LO-7X; Mon, 24 Jun 2019 16:38:56 +0000
Date:   Mon, 24 Jun 2019 13:38:52 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Docs: An initial automarkup extension for sphinx
Message-ID: <20190624133852.4a31c597@coco.lan>
In-Reply-To: <20190624082950.5e338d37@lwn.net>
References: <20190621235159.6992-1-corbet@lwn.net>
        <20190621235159.6992-2-corbet@lwn.net>
        <20190621220046.3de30d9d@coco.lan>
        <20190622084346.28c7c748@lwn.net>
        <20190622144610.26b7d99c@coco.lan>
        <20190624082950.5e338d37@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 24 Jun 2019 08:29:50 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Sat, 22 Jun 2019 14:46:10 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > > > .. c:function:: int ioctl( int fd, int request, void *argp )
> > > >     :name: v4l2-ioctl      
> > > 
> > > Some digging around didn't turn up any documentation for :name:, but it
> > > seems to prevent ioctl() from going into the list of functions that can be
> > > cross-referenced.     
> > 
> > It took me a while to discover this way to be able to re-define the
> > name of a symbol at the C domain, but I'm pretty sure I read this
> > somewhere at the Sphinx docs (or perhaps on some bug track or Stack
> > Overflow).
> > 
> > I don't remember exactly where I get it, but I guess it is related to
> > this:
> > 
> > 	http://docutils.sourceforge.net/docs/howto/rst-roles.html
> >   
> > > I wonder if the same should be done for the others?    
> > 
> > Sure.  
> 
> It actually occurs to me that it might be better to keep the skip list and
> maybe expand it.  There are vast numbers of places where people write
> open() or whatever(), and there is no point in even trying to
> cross-reference them. 

Yeah, subsystems will likely have their own "man pages" for for sysctls.

Both the dvb and the v4l2 ones are part of what used to be the DocBook
manpages for those syscalls. If I'm not mistaken, we ended by expanded 
the same approach for the media controller, for CEC and for RC.

> I should do some tests, it might even make a
> measurable difference in the build time to skip them :)  And in any case,
> somebody is bound to put one of those common names into the namespace in
> the future, recreating the current problem.

There is one way of keeping it while avoiding troubles: you could
create internal names, for example using the current dir, auto-adding
the ":name:" tag when a declaration conflict rises. Not sure how
easy/hard would be to implement it.

Btw, at get_abi.pl, I had to do a trick like that, as some symbols
have a "local context". The good thing at ABI files is that the context
is clear: it is valid only between "What:" and "Description:" fields.

Also, as it is a single script that parses the entire ABI (it takes
on ~0.1 seconds to parse everything and store internally on my machine),
the logic there detects when an existing symbol is re-used on a different
context. When this happens, it adds a random char at the end of the
internal reference, while keeping the original name[1].

[1] on the the highly unlikely event that the new name still repeats,
it adds a new random char - until the name gets different.

Probably doing it at automarkup won't be that simple, but it could
work.

Thanks,
Mauro
