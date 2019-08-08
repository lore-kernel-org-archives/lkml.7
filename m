Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67E6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37BF2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404301AbfHHV4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:56:36 -0400
Received: from verein.lst.de ([213.95.11.211]:49942 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfHHV4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:56:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7D1DE68B02; Thu,  8 Aug 2019 23:56:32 +0200 (CEST)
Date:   Thu, 8 Aug 2019 23:56:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-ID: <20190808215632.GA12773@lst.de>
References: <20190808154240.9384-1-hch@lst.de> <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:50:37AM -0700, Linus Torvalds wrote:
> > Note that both Thomas and Steven have series touching this area pending,
> > and there are a couple consumer in flux too - the hmm tree already
> > conflicts with this series, and I have potential dma changes on top of
> > the consumers in Thomas and Steven's series, so we'll probably need a
> > git tree similar to the hmm one to synchronize these updates.
> 
> I'd be willing to just merge this now, if that helps. The conversion
> is mechanical, and my only slight worry would be that at least for my
> original patch I didn't build-test the (few) non-x86
> architecture-specific cases. But I did end up looking at them fairly
> closely  (basically using some grep/sed scripts to see that the
> conversions I did matched the same patterns). And your changes look
> like obvious improvements too where any mistake would have been caught
> by the compiler.

I did cross compile the s390 and powerpc bits, but I do not have an
openrisc compiler.

> So I'm not all that worried from a functionality standpoint, and if
> this will help the next merge window, I'll happily pull now.

That would help with this series vs the others, but not with the other
series vs each other.
