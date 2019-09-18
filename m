Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2566BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB3A20882
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gJkNowr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfIRUrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:47:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387492AbfIRUrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yKO+JcrX4WlARPc+kWE02y475ov/blGOIN+ePLKY9jk=; b=gJkNowr2SzR7BFTbrahPJ2la/F
        U1rGQ5TAnIe0V2wQvVHVJSudzxcXRhJugshBq0XINqmfULmUNnKwRQ4zxmtL+yEXmYzwGvSk+M8rN
        hW91rXpleIbzAzZLgJCzWEwG6awzsOP6IA6vnkh6l1C9h9samuELA1m8N+atSr6m6BI4fWLQyMk0h
        nYo1DwH6odStxfocEsZPWqm6gH22F1qi41VPwzpA0Pw7MPJfhlOfZxoDO6PUpyqNMhVlhj3BCBLcS
        O0Lk/GPzewNCEagBg0+HVE1LD7QA9+1HH3D9IGrL9DcaDfUKZOmRD1E1uZ36BpAN3hc0VEV0lgcqf
        sYvKSWlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAgr5-0005yZ-1J; Wed, 18 Sep 2019 20:47:15 +0000
Date:   Wed, 18 Sep 2019 13:47:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.4-rc1
Message-ID: <20190918204715.GA15538@infradead.org>
References: <20190918114754.GA1899504@kroah.com>
 <20190918182412.GA9924@infradead.org>
 <20190918185010.GA1933470@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190918185010.GA1933470@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 08:50:10PM +0200, Greg KH wrote:
> > exfat is just a random old code drop from Samsung hastily picked up,
> > and also duplicating the fat16/32 functionality, and without
> > consultation of the developes of that who are trying to work through
> > their process of contributing the uptodate and official version of it.
> 
> Those developers are still yet to be found, we only got a "drop" of the
> samsung code _after_ this code was merged, from non-samsung people.  No
> samsung developers have said they would actually help with any of this
> work, and when asked what differed from the in-tree stuff, I got a list,
> but no specifics.  I'll be working through that list over the next month
> to resolve those issues.

Park offered to help with a new version, and the Samsung guys are going
through their internal review process to work upstream it.  Remember
it is their codebase in each of the variants here.  While it is fine
if we take some code that has been abandoned by the original developers
and still merge it with helping hands I think it is very rude to not
at least wait for them to get their act of working with their corporate
overlords together first.  It isn't like we've been waiting forever
for an exfat driver - the patent grant has been extremely recent, and
this whole thing just seems like a publicity stunt to be honest.  Give
them a couple weeks to sort their stuff out and then we can decide
how to proceed.  I for one would defintively prefer to have code
maintained by the original maintainers if possible.  And not have
them hindered by the staging process to work on their own code.

> To get back to the meta-problem here, we need a common "vfs/filesystem"
> tree somewhere with reviewers.  I'm glad to set up the tree and handle
> patches, but I am not a vfs expert by any means (I only understand the
> virtual half, not the backing half), so I can't be the only one to do
> reviews.  Do you know of anyone that we can drag in as reviewers to help
> make it easier for new filesystems to get reviews as well as existing
> ones to have their patches collected and forwarded on to Linus at the
> proper times?

Following how staging works and its arcane rules I don't want it to be
anywhere near fs code.  And seriously, it is not like we need one
magic tree to deal with all file systems.  The whole point of git is
that people can setup a tree to collaborate wherever they want if you
just find people to work on it.  And we've had tons of successful
drivers and filesystems that worked that way.  And at least the ones
I've followed seem a lot more productive than the staging show that
is baѕed around coding style cleanup micropatches.
