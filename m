Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D62DC31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9532183F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbfFSOzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:55:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:58304 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfFSOzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:55:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EA3012BA;
        Wed, 19 Jun 2019 14:54:59 +0000 (UTC)
Date:   Wed, 19 Jun 2019 08:54:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Message-ID: <20190619085458.08872dbb@lwn.net>
In-Reply-To: <20190619111528.3e2665e3@coco.lan>
References: <20190619072218.4437f891@coco.lan>
        <cover.1560890771.git.mchehab+samsung@kernel.org>
        <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
        <CAKMK7uGM1aZz9yg1kYM8w2gw_cS6Eaynmar-uVurXjK5t6WouQ@mail.gmail.com>
        <11422.1560951550@warthog.procyon.org.uk>
        <20190619111528.3e2665e3@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Trimming the CC list from hell made sense, but it might have been better
to leave me on it...]

On Wed, 19 Jun 2019 11:15:28 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Em Wed, 19 Jun 2019 14:39:10 +0100
> David Howells <dhowells@redhat.com> escreveu:
> 
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> >   
> > > > > -Documentation/nommu-mmap.rst
> > > > > +Documentation/driver-api/nommu-mmap.rst      
> > 
> > Why is this moving to Documentation/driver-api?    
> 
> Good point. I tried to do my best with those document renames, but
> I'm pretty sure some of them ended by going to the wrong place - or
> at least there are arguments in favor of moving it to different
> places :-)

I think that a lot of this might also be an argument for slowing down just
a little bit.  I really don't think that blasting through and reformatting
all of our text documents is the most urgent problem right now and, in
cases like this, it might create others.

Organization of the documentation tree is important; it has never really
gotten any attention so far, and we're trying to make it better.  But
moving documents will, by its nature, annoy people.  We can generally get
past that, but I'd really like to avoid moving things twice.  In general,
I would rather see a single document converted, read critically and
updated, and carefully integrated with the rest than a hundred of them
swept into different piles...

See what I'm getting at?

Thanks,

jon
