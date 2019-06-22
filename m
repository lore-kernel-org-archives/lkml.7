Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D27C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357AB206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561225578;
	bh=2fYPgtkDKK/kg8Wi0hW6VOGHSXxbomeiZ8BHHs+zuLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Zv0SKlESNPXc5YeG8orALa+WA502OxSuiiNpQf4v1ThJHao8B3PVQ9NsJKHOWEcue
	 zvopSro+uLx8BciW42kcp4k6CryYrsSzqtb7URa6URf+z7nnqxrWIfGGn6EvQ0sSMc
	 FuPg6AVyayC7vR3fdvlMISyhoqbt8YvgRszscTrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfFVRqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:46:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVRqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=60xhp6+spwceUSgQlTZCaiG+QVWO6xAU7FfyK/vAN3I=; b=oZjCdq+aOYjrAf52L1dFiPYI3
        2gk3jiuUylbGyGZVzOMi0QOW3M3gLO/yX4lFyAvdtD+X65QZqEcBw0PesQ3HYXQrousfJ1GxR/TsW
        tGCawfIFudlTfNa9MTafpRdpB/NqCEM1auqW1KD8237APvpTwG3xXFizOpGtQZqVgIXfdpvqWgvSG
        /A0Nh1OUMjZiXqOO4cepbYSgS0nDo2TS8haLDFh/bCw59RFA0XAQOW/Jbnb/OdW9Ewgpa1sScXjxQ
        5yYuGuvy+fze++xJzCZkXxUvxU4pfPMRDiurPQc+fHj4IrFioHHT8zq0RbQBu4bBviaRzN+95tvSM
        L3BRhR29w==;
Received: from [179.95.45.115] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hek5d-000394-Jd; Sat, 22 Jun 2019 17:46:13 +0000
Date:   Sat, 22 Jun 2019 14:46:10 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Docs: An initial automarkup extension for sphinx
Message-ID: <20190622144610.26b7d99c@coco.lan>
In-Reply-To: <20190622084346.28c7c748@lwn.net>
References: <20190621235159.6992-1-corbet@lwn.net>
        <20190621235159.6992-2-corbet@lwn.net>
        <20190621220046.3de30d9d@coco.lan>
        <20190622084346.28c7c748@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 22 Jun 2019 08:43:46 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri, 21 Jun 2019 22:00:46 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > > +#
> > > +# The DVB docs create references for these basic system calls, leading
> > > +# to lots of confusing links.  So just don't link them.
> > > +#
> > > +Skipfuncs = [ 'open', 'close', 'write' ]    
> > 
> > and yeah, of course, if there's something weird, it has to be at
> > the media docs :-)
> > 
> > Btw, if I'm not mistaken, we do the same for ioctl.  
> 
> So that's actually interesting.  In, for example,
> Documentation/media/uapi/v4l/func-ioctl.rst, you see something that looks
> like this:
> 
> > .. c:function:: int ioctl( int fd, int request, void *argp )
> >     :name: v4l2-ioctl  
> 
> Some digging around didn't turn up any documentation for :name:, but it
> seems to prevent ioctl() from going into the list of functions that can be
> cross-referenced. 

It took me a while to discover this way to be able to re-define the
name of a symbol at the C domain, but I'm pretty sure I read this
somewhere at the Sphinx docs (or perhaps on some bug track or Stack
Overflow).

I don't remember exactly where I get it, but I guess it is related to
this:

	http://docutils.sourceforge.net/docs/howto/rst-roles.html

> I wonder if the same should be done for the others?

Sure.

> I think that would be better than putting a special-case hack into the
> toolchain.

Agreed. As you're doing this, if you prefer, feel free to send the
patches to media docs. Otherwise, I'll seek for some time next week.

> 
> > I'm wandering if this could also handle the Documentation/* auto-replace.  
> 
> I think it's the obvious place for it, yes.  Let's make sure I haven't
> badly broken anything with the existing change first, though :)

Yeah, sure. Just wanted to place the code at the same thread. There are
some tricks that need to be done in order to handle the relative paths.
It took me a lot more time to get it right than adding the replacing Regex :-)

(That reminds I should post a patch to one place where we have a
Documentation/Documentation typo)

Thanks,
Mauro
