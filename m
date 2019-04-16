Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE50C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0080020868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555438498;
	bh=72K1zzrifdI3jmktErt+s4b5l+1ZxXN2UJEYxwmPnOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IWd3EYEVeUKRV0cW+A/Rq+8wj4Ya/zaOczkCfDSn9BrQQlgkERjemMwJyb43vehI7
	 qJCgSPn6ENt6SMdRiN6u48TbSj9uAJy/e8FsR4KrNCUw5EYOqxASQ9+1OH4Fd09jwY
	 JAYm/JIdOPyegGW7SKL3+kqGAYX0OwGTm5YsJfFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfDPSO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:14:57 -0400
Received: from casper.infradead.org ([85.118.1.10]:38374 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPSO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tik6zFx2WnnwNinVI/xSp1hxAz+RbSHGC6Dp9mqkBDY=; b=i3HR6AOI6uX6S2n8mX1UXQDo5P
        V+MF3ubVO6BAj1aAqLh63PjqjjIuLGtfhmr/rf3AlODMWvpdw9Cipa6su04nESNY2sImIpWD9o0b8
        UBEYwL5xMkyyRxWiCKBLbLaCVFnhGmbbwca1dsUwYp6mxw0pH2u4dwtTTy8l/ObbDxiJjvRTsgCOj
        8RY1P3/1yWcGHvejM18ov6VtkjQrsdX39BV+P5GxM65VkAQbAwN+i9QERvDrKO1TiUqhpU8RlM3Oj
        05B7DFA2LWtK/dBOn4HF86Apw8d/2+16obw/9ulTyXgHzV1N0DkClQxZk8LtWEUDG5u6CPFjV8KrO
        fqmvt2EQ==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSbb-0007AG-Ep; Tue, 16 Apr 2019 18:14:52 +0000
Date:   Tue, 16 Apr 2019 15:14:46 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com
Subject: Re: [PATCH 10/57] docs: device-mapper: convert it to ReST format
Message-ID: <20190416151446.1a2b8ffa@coco.lan>
In-Reply-To: <20190416154858.GB22497@redhat.com>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <9dd3c4eca01489bd67ea6de88dfedef8b0e81901.1555382110.git.mchehab+samsung@kernel.org>
        <20190416132851.GA22497@redhat.com>
        <20190416080024.7fb65682@lwn.net>
        <20190416154858.GB22497@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 16 Apr 2019 11:48:59 -0400
Mike Snitzer <snitzer@redhat.com> escreveu:

> On Tue, Apr 16 2019 at 10:00am -0400,
> Jonathan Corbet <corbet@lwn.net> wrote:
> 
> > On Tue, 16 Apr 2019 09:28:52 -0400
> > Mike Snitzer <snitzer@redhat.com> wrote:
> >   
> > > Can you help me understand why this is the direction text based
> > > Documenation is taking in the Linux kernel?  All I see is markup, and
> > > escaping of characters, that is a chore to administer over time.  
> > 
> > This is a discussion that was mostly resolved some years ago...
> > 
> > Classic Documentation/ is a jumbled collection of unorganized text files,
> > some of which contain highly useful information and others of which
> > haven't had much to offer since about 1996.  We are working to turn it
> > into an organized collection where, hopefully, some thought has actually
> > been given to the people who will be reading it.
> > 
> > The ReST conversion, in particular, allows us to link documents into a
> > larger structure, create indexes and cross references, and produce output
> > in formats like HTML and PDF.  It lets us present the documentation like
> > this:
> > 
> > 	https://www.kernel.org/doc/html/latest/
> > 
> > Among other things, making the documentation more accessible in this way
> > makes it easier and more rewarding for developers to improve it, and I
> > believe we are seeing the results of that.  Linus called out the
> > documentation work in the 5.1-rc1 announcement, for example.
> > 
> > Nobody has complained about the maintenance burden of RST docs - so far as
> > I have heard, anyway.  Things do break occasionally, but problems in the
> > docs build almost always result from code changes that mess up the
> > kerneldoc comments rather than RST changes, and it's been that way for as
> > long as I've been paying attention.  
> 
> Thanks for the context.  I clearly just haven't followed the evolution.
> Certainly looks like a solid improvement.
> 
> Think the last piece I'm missing is: how does one edit a .rst document
> without having to know to sprinkle syntactic sugar around?  Does emacs
> have a ReST mode?  If not what client interface are people using to
> properly change these documents?

I guess the main point is that, after writing a .rst file, run
"make htmldocs" and see how it fits :-)

As Jon mentioned, a large number of documents (even some written lots of
years ago) already fits into ReST, and keeping it simpler makes easier
for plain text file readers.

We do have some documents (like the media book), were we use a lot
of the markup stuff, as those documents came from DocBook and it is full of
cross-references, complex tables, images, examples, etc, but for most
subsystems, you're safe with the usual stuff.

> 
> (apologies if this is all spelled out nicely in Documentation/
> somewhere, but please help this man learn to fish).

A few tips if you want to write documents that are easy to
read as text files and produce nice output after parsed:

1) it is written to document Python. So, it is indentation 
   sensitive. Usually most of the fixes are just to properly
   indent things;

2) By default, it identifies line breaks with two \n. The
   exceptions are literal blocks like:

   ::
	foo
	bar

  and things like:

	foo
	   bar

  (in this case, it will bold **foo**) 

  Another trick that I use to avoid the need of adding an extra \n is to 
  convert itemized lists into a table, with:

	===
	foo
	bar
	===

3) Things like "struct *foo" usually produces error, as a single
   * is interpreted as italic. The parser will look for another *. As
   it won't find, it will produce an error. So, this need to be escaped
   somehow.

   While you can escape such special characters like * and _ with an
   inverted bar, like "struct \*foo", that looks ugly for casual
   text file readers.

   Instead, I do either::

	struct *foo

   or, if I want it in the middle of a text, I use `struct *foo`. 
   IMO, placing it on a literal block (::) looks visually better for
   both text and html modes.

Thanks,
Mauro
