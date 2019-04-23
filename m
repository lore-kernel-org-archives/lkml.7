Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045C1C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5C6208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hZ+pOpsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfDWU0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:26:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDWU0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ooa7NpjLlY0pPro4+B2vufDC8zNt2FDFGxeBdk5A+TE=; b=hZ+pOpsEUtPrQAMfJlzvEwHLS
        GuH+k6NLAbcCmvCLDWdOKkDl7opZ4DXlln5H1Wfh4gKuYHdGnB2KKOdZpFS0cNyh3amJA+tQme0P5
        TIKKgEibjdkbnRfzBnupdPPXiOv+9Orl9rr+pvQfk7Nc6Yo+H284uCgY4qMLnykImiTNpphfG2mxB
        SB2c7OivdsWfgae1yN5D6whHGF1uwhLc4hG6BT34hgq/Irn0V9qShnC46Byohsl/8h/qIJUcGt8MM
        z5e8riMs0wcShkcteBhqEw0iF+JPwOjqCVkiEHbGjzBqUiYkqHSFmPwSj3ahwK5FqvRz6V0alQhjh
        TFtA4fkzQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ204-0004xw-R9; Tue, 23 Apr 2019 20:26:45 +0000
Date:   Tue, 23 Apr 2019 17:26:41 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Howells <dhowells@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
 files to *.rst
Message-ID: <20190423172641.612012c8@coco.lan>
In-Reply-To: <20190423105415.3a69a0cb@lwn.net>
References: <20190423132100.GB7132@redhat.com>
        <cover.1555938375.git.mchehab+samsung@kernel.org>
        <cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
        <20190423083135.GA11158@hirez.programming.kicks-ass.net>
        <20190423125519.GA7104@redhat.com>
        <20190423130132.GT4038@hirez.programming.kicks-ass.net>
        <20704.1556031146@warthog.procyon.org.uk>
        <20190423105415.3a69a0cb@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 23 Apr 2019 10:54:15 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue, 23 Apr 2019 15:52:26 +0100
> David Howells <dhowells@redhat.com> wrote:
> 
> > There've been some changes that I've particularly objected to, such as
> > removing contents lists from files and replacing them with markup like:
> > 
> > 	.. contents:: :local:
> > 
> > This actually impedes use of the file.  It should not be necessary to build
> > the docs to get that for ordinary use.  
> 
> Usability of the text files versus that of the built docs is occasionally
> something that has to be traded off.  As a general rule, I want the text
> files to remain useful on their own.  There is a lot of value in the
> built docs for a lot of people, but that should not be the only, or even
> the primary, form of access
> 
> Tables of contents are certainly a place where that tradeoff makes itself
> felt.  Doing them by hand ensures that they are always present, but
> requires that people editing the docs also maintain the TOCS - something
> that experience has shown tends not to happen.  That's more of a pain
> than a little bit of markup, and people don't do it.  An automatically
> generated TOC, instead, is always correct and is linkable.
> 
> Few people complain about the biggest impediment to the readability of
> text files, though: the use of kerneldoc comments.  That splits the
> information between the text file and multiple random-seeming locations
> among tends of thousands of source files.  Sometimes the solution here is
> to move all of the documentation into the source, but that tends to
> fragment it and make it harder to find; it's certainly not the right
> place for many kinds of docs.  In general, it's hard to create a coherent
> story that way.
> 
> Suggestions / patches on how to improve things for *all* users of the
> docs are certainly welcome!
> 
> I am, incidentally, toying with the idea of trying to put together a
> documentation microconf at the Linux Plumbers Conference this year.  If
> anybody out there thinks that's a good idea and would like to
> participate, please let me know.

If you add a microconf to LPC, I'm in. 

IMO, we made big advances with documentation, but there's a lot more
to be done. Having a microconf to discuss those things may help us
to bring new ideas about how to keep improving it.

Thanks,
Mauro
