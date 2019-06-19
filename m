Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3203C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9280D208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u/yx0b7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfFSV17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:27:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36118 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSV16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5XMySBjGKrkBnB1JxKQv1JEfL3b4e7/NmHEdLk+D6Sk=; b=u/yx0b7tXx7HhQUFDk+ANQZqr
        xVXDrn7ydER6MENQoQxAilSRKf3BR3OxSnlePO5dLiNXegTJgyyGqalFkygOTdVbfGug3u1hxQ4Nx
        hof629fVPl9+6mArrH4/4LlogJbeD2/7Cmqd8AYz1QkHDtbwCMpTCHgroPA0mT/cPn5SHBssZvx9d
        sCDD8Ml3Yxdc/RoMIRvvd/urdngsGlftXKy7zETm+cWgJ9ZkywhaW9haIT1JHPXbiqoPOOojfd0UQ
        NTUugcLE5QDyt7u1jCTIjm5xbzTO4jxWg4x+Vp7FM4fZBa1s9q8FdF6zyshUQPvAjn0qaN5hQYa+x
        FFurFJ/+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdi7X-0008L6-TE; Wed, 19 Jun 2019 21:27:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3929220098E60; Wed, 19 Jun 2019 23:27:53 +0200 (CEST)
Date:   Wed, 19 Jun 2019 23:27:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Message-ID: <20190619212753.GQ3419@hirez.programming.kicks-ass.net>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
 <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
 <20190619114356.GP3419@hirez.programming.kicks-ass.net>
 <20190619101922.04340605@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619101922.04340605@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:19:22AM -0300, Mauro Carvalho Chehab wrote:
> (c/c list cleaned)
> 
> Em Wed, 19 Jun 2019 13:43:56 +0200
> Peter Zijlstra <peterz@infradead.org> escreveu:
> 
> > On Tue, Jun 18, 2019 at 05:53:17PM -0300, Mauro Carvalho Chehab wrote:
> > 
> > >  .../{ => driver-api}/atomic_bitops.rst        |  2 -  
> > 
> > That's a .txt file, big fat NAK for making it an rst.
> 
> Rst is a text file. This one is parsed properly by Sphinx without
> any changes.

In my tree it is a .txt file, I've not seen patches changing it. And I
disagree, rst is just as much 'a text file' as .c is.

> > >  .../{ => driver-api}/futex-requeue-pi.rst     |  2 -  
> > 
> > >  .../{ => driver-api}/gcc-plugins.rst          |  2 -  
> > 
> > >  Documentation/{ => driver-api}/kprobes.rst    |  2 -
> > >  .../{ => driver-api}/percpu-rw-semaphore.rst  |  2 -  
> > 
> > More NAK for rst conversion
> 
> Again, those don't need any conversion. Those files already parse 
> as-is by Sphinx, with no need for any change.

And yet, they're a .txt file in my tree. And I've not seen a rename,
just this move.

> The only change here is that, on patch 1/22, the files that
> aren't listed on an index file got a :orphan: added in order
> to make this explicit. This patch removes it.

I've no idea what :orphan: is. Text file don't have markup.

> > >  Documentation/{ => driver-api}/pi-futex.rst   |  2 -
> > >  .../{ => driver-api}/preempt-locking.rst      |  2 -  
> > 
> > >  Documentation/{ => driver-api}/rbtree.rst     |  2 -  
> > 
> > >  .../{ => driver-api}/robust-futex-ABI.rst     |  2 -
> > >  .../{ => driver-api}/robust-futexes.rst       |  2 -  
> > 
> > >  .../{ => driver-api}/speculation.rst          |  8 +--
> > >  .../{ => driver-api}/static-keys.rst          |  2 -  
> > 
> > >  .../{ => driver-api}/this_cpu_ops.rst         |  2 -  
> > 
> > >  Documentation/locking/rt-mutex.rst            |  2 +-  
> > 
> > NAK. None of the above have anything to do with driver-api.
> 
> Ok. Where do you think they should sit instead? core-api?

Pretty much all of then are core-api I tihnk, with exception of the one
that are ABI, which have nothing to do with API. And i've no idea where
GCC plugins go, but it's definitely nothing to do with drivers.

Many of the futex ones are about the sys_futex user API, which
apparently we have Documentation/userspace-api/ for.

Why are you doing this if you've no clue what they're on about?

Just randomly moving files about isn't helpful.

