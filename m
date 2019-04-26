Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9849DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6341B20656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556301275;
	bh=7lIC8BYim6XfP85M38TffnDvdK4XgPQY2uBrMalHHeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Z6zPt9p5vXMGMo81BPWLgR8c33pkBMK4xMsWFvcBfBrEYVsWk3qxnQLEvXy3QgOHD
	 mQ+1pY9A5e8Q0wsdAK4vbbx07FjpJjzbMOSoAvHBXD+EqLe7U4v6BngRJIGElVlV55
	 Lji6CKlQA9HHmtG7Db6DE1kMCUu8dizGzZmMPiag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfDZRye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:54:34 -0400
Received: from casper.infradead.org ([85.118.1.10]:60978 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZRyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=shhIa/3jiVOZrsonJvy28/LnOX3peqRsvQa9PY74sNg=; b=so4uCneVPnohNbtCZgNFPr+HGm
        KU9Hj+2f1HwN26rHoWlvmTScxMcyA7VNLQE3lJd1/iYGeLnnmLVWMMJ/Azp2W0VbjY/f2scLg23lA
        13Tu+szeSTJTP+1caINdjN6DpTu3L8M1Cfa9fdM090655apnQ/Wf6IxdAECLTM49NSnqcYy0vypLQ
        DnUGLMCY0mhe2FSkIWrEjENiIGRQcqluVCh+OM2V7XCgJz+Thep15zggNKtuQVXdEcDB54y/yBNlV
        jFZn2oOA4BKJOgWA60ySRM7uNAHagZ4QXWEl+p6KBFzVO7CME65fFBh4NMKb0mZOhB7qLOO6FkbF1
        Od4AcUPA==;
Received: from [179.95.39.209] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK53N-0004Rn-Dy; Fri, 26 Apr 2019 17:54:29 +0000
Date:   Fri, 26 Apr 2019 14:54:24 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] Docs: An initial automarkup extension for sphinx
Message-ID: <20190426145424.268da5df@coco.lan>
In-Reply-To: <20190426105209.1e414eae@lwn.net>
References: <20190425200125.12302-1-corbet@lwn.net>
        <20190425200125.12302-2-corbet@lwn.net>
        <87tvelrv8d.fsf@intel.com>
        <20190426105209.1e414eae@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 10:52:09 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri, 26 Apr 2019 12:06:42 +0300
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
> 
> > It's more involved, but I think the better place to do this (as well as
> > the kernel-doc transformations) would be in the doctree-read event,
> > after the rst parsing is done. You can traverse the doctree and find the
> > places which weren't special for Sphinx, and replace the plain text
> > nodes in-place. I've toyed with this in the past, but alas I didn't have
> > (and still don't) have the time to finish the job.  
> 
> I had thought about this; indeed, there's a comment in the posted patch to
> that effect.  The tradeoff comes down to this, I think:
> 
>  - The fragility and inelegance of embedding a bit of redundant RST
>    parsing into this extension v. that of adding a late parsing stage as a
>    transform, trying to enumerate every node type that you might want to
>    change, and digging into the C domain code to emulate its reference
>    generation.
> 
>  - The time required to implement a solution; I'm having a bit of a hard
>    time keeping up with docs at the moment as it is.
> 
>  - Regexes.  This solution has more of them, but we're not going to get
>    away from them regardless.
> 
> I am not at all opposed to a more proper solution that might, in the
> long term, produce more deterministic results.  I can even try to work in
> that direction.  But this is something that can be done now that, IMO,
> doesn't in any way close off a better implementation in the future.  If we
> agree that we should automatically generate references for occurrences of
> "function()", we can change how that is actually done later.
> 
> I'll look into this further, but my inclination is to go forward with what
> I have now.  It's simple and easy to understand, and doesn't seem to screw
> up anywhere in the current body of kernel docs as far as I can tell.
> 
> > If you decide to go with regex anyway, I'd at least consider pulling the
> > transformations/highlights from kernel-doc the script to the Sphinx
> > extension, and use the exact same transformations for stuff in source
> > code comments and rst files.  
> 
> Pulling all RST manipulation out of kerneldoc has a great deal of appeal;
> assuming this goes forward that should indeed be high on the todo list.

While I didn't review the python code yet, and while I agree with
Jani and Markus that it would be better only parse functions on texts
after the Sphinx parser, I agree with Jon on that: if the current code works
well enough with the current documentation, I would proceed and apply it. 

Later, the script can be improved.

Thanks,
Mauro
