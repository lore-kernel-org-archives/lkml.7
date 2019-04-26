Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AADC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17702084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556311930;
	bh=1v7yEPCN+zFgPbqNM1ws+zbayNNh030c2kNE5Irsl+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gtbY1k5rRCAQ5zTFpcMuMCh0Vw4RXbk1QKhSO3CRETdxnK0Yp4y2XoVuzc2AzOoEf
	 dsXpvCLqv1Q6KCd44AsNzyZjgSZ7RI2Eiww4EYMV8qNAXzEO39Qcfb1pFIzqZlyVHF
	 9OGAHdh9MFm6ELT1hoJr0snEUSrXPi4Kj9tjk3Mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfDZUwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:52:08 -0400
Received: from casper.infradead.org ([85.118.1.10]:41828 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZUwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LkGNyvhAncaB0wFb06dGXLfekZH8dWavH787YZU01SU=; b=TAz6B8awHU41/enEZKRmjDOGkv
        YeXxLjtzzqHDj8rVMBrMKsNwEwB0z0BiuXJwu/9SMwuyhjT6sLs9+C1WcQWjBfHBydisbmvfSZEvM
        NIZHT/mGZbCD0rrX+E0LmsnP2ljTg2QS3gbs4XuJwwJn15q1dqqzE0wV+GoG8t/MzNAes2YZBmmIK
        X3BLdIsQDanwBONhfiowPw7uFaGuTMqmcOXmbSccvtm1/rLDWXnjPxFPKak22rphE2hoIWk3vIr4Z
        +1PL51IpEu6KTAsKaeRtqHJ1V0MA+i7qd67YcVJP6nt+9ZGY3RgOFxJgHIfiVDp1DQ8kIO1p+XGe5
        85xOjJQg==;
Received: from [179.95.39.209] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK7pC-0000Tc-Jv; Fri, 26 Apr 2019 20:52:03 +0000
Date:   Fri, 26 Apr 2019 17:51:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] Docs: An initial automarkup extension for sphinx
Message-ID: <20190426175158.0111c437@coco.lan>
In-Reply-To: <20190426133719.5d30d4a4@lwn.net>
References: <20190425200125.12302-1-corbet@lwn.net>
        <20190425200125.12302-2-corbet@lwn.net>
        <20190426153255.7e424a45@coco.lan>
        <20190426133719.5d30d4a4@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 13:37:19 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri, 26 Apr 2019 15:32:55 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > > +# Try to identify "function()" that's not already marked up some
> > > +# other way.  Sphinx doesn't like a lot of stuff right after a
> > > +# :c:func: block (i.e. ":c:func:`mmap()`s" flakes out), so the last
> > > +# bit tries to restrict matches to things that won't create trouble.
> > > +#
> > > +RE_function = re.compile(r'(^|\s+)([\w\d_]+\(\))([.,/\s]|$)')    
> > 
> > IMHO, this looks good enough to avoid trouble, maybe except if one
> > wants to write a document explaining this functionality at the
> > doc-guide/kernel-doc.rst.  
> 
> Adding something to the docs is definitely on my list.
> 
> > Anyway, the way it is written, we could still explain it by adding
> > a "\ " after the func, e. g.:
> > 
> > 	When you write a function like: func()\ , the automarkup
> > 	extension will automatically convert it into:
> > 	``:c:func:`func()```.
> > 
> > So, this looks OK on my eyes.  
> 
> Not sure I like that; the whole point is to avoid extra markup here.  Plus
> I like that it catches all function references whether the author thought
> to mark them or not.

Yes, but I'm pretty sure that there will be cases where one may want
to explicitly force the parser to not recognize it. One of such examples
is the document explaining this feature.

> 
> > > +#
> > > +# Lines consisting of a single underline character.
> > > +#
> > > +RE_underline = re.compile(r'^([-=~])\1+$')    
> > 
> > Hmm... why are you calling this "underline"? Sounds a bad name to me,
> > as it took me a while to understand what you meant.  
> 
> Seemed OK to me, but I can change it :)

I'm pretty sure that, on my last /79 patch series, I used some
patterns that would be placing function names at the title,
and that were not using '-', '=' or '~'. If the parser
would pick it or not is a separate matter[1] :-)

[1] It would probably reject on titles, as very often what
we write on titles are things like:

foo(int i, int j)
.................

As it has the variables inside, the parser won't likely get it.

Yet, I vaguely remember I saw or wrote some title that had
a pattern like:

Usage of foo()
^^^^^^^^^^^^^^

(but I can't really remember what was the used markup)

I would prefer if you change. I usually use myself:

	'=' '-' '^' and '.'

(usually on the above order - as it makes some sense to my
brain  to use the above indentation levels)

In general, function descriptions are sub-sub-title or
sub-sub-sub-title, so, on the places I wrote, it would likely
be either '^' or '.'.

But I've seen other symbols being used too to mark titles
(like '*' and '#').

> > From the code I'm inferring that this is meant to track 3 of the
> > possible symbols used as a (sub).*title markup. On several places 
> > we use other symbols:'^', '~', '.', '*' (and others) as sub-sub(sub..)
> > title markups.  
> 
> I picked the ones that were suggested in our docs; it was enough to catch
> all of the problems in the current kernel docs.
> 
> Anyway, The real documentation gives the actual set, so I'll maybe make it:
> 
> 	=-'`":~^_*+#<>

I'm pretty sure a single dot works as well, as I used this already.

> I'd prefer that to something more wildcardish.

Yeah, makes sense, provided that it will reflect what Sphinx actually
uses internally.

> > You should probably need another regex for the title itself:
> > 
> > 	RE_possible_title = re.compile(r'^(\S.*\S)\s*$')
> > 
> > in order to get the size of the matched line. Doing a doing len(previous)
> > will get you false positives.  
> 
> This I don't quite get.  It's easy enough to trim off the spaces with
> strip() if that turns out to be a problem (which it hasn't so far).  I can
> add that.


What I'm saying is that the title markup should always start at the first
position. So, this is a valid title:

Foo valid title
===============

But this causes Sphinx to crash badly:

 Foo invalid title
 =================

Knowing that, we can use a regex for the previous line assuming that it
will always start with a non-spaced character[2], and checking only the 
length of non-blank characters.

[2] Strictly speaking, I guess Sphinx would accept something like:

   Foo weirdly marked title - probably non-compliant with ReST spec
===================================================================

But I don't think we have any occurrence of something like that - and
I don't think we should concern about that, as it would be a very bad 
documentation style anyway.

So, what I'm saying is that we could use such knowledge in our benefit,
considering a valid title to be something like: ^(\S.*\S)\s*$ - e. g.
the title itself starts on a non-space char and ends on another 
non-space char.

> 
> > on a separate matter (but related to automarkup matter - and to what
> > I would name underline), as a future feature, perhaps we could also add
> > a parser for:
> > 
> > 	_something that requires underlines_
> > 
> > Underlined text is probably the only feature that we use on several docs
> > with Sphinx doesn't support (there are some extensions for that - I guess,
> > but it sounds simple enough to have a parser here).
> > 
> > This can be tricky to get it right, as just underlines_ is a
> > cross reference markup - so, I would only add this after we improve the
> > script to come after Sphinx own markup processing.  
> 
> That does indeed sound tricky.  It would also probably have to come
> *before* Sphinx does its thing or it's unlikely to survive.
> 
> > > +        #
> > > +        # Is this an underline line?  If so, and it is the same length
> > > +        # as the previous line, we may have mangled a heading line in
> > > +        # error, so undo it.
> > > +        #
> > > +        elif RE_underline.match(line):
> > > +            if len(line) == len(previous):    
> > 
> > No, that doesn't seem enough. I would, instead, use the regex I
> > proposed before, in order to check if the previous line starts with
> > a non-space, and getting the length only up to the last non-space
> > (yeah, unfortunately, we have some text files that have extra blank
> > spaces at line's tail).  
> 
> So I'll make it "if len(line) == len(previous.strip())
> 
> Thanks,
> 
> jon



Thanks,
Mauro
