Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C79C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F133E20663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfDKStI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:49:08 -0400
Received: from ms.lwn.net ([45.79.88.28]:38868 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfDKStG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:49:06 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 923002F3;
        Thu, 11 Apr 2019 18:49:05 +0000 (UTC)
Date:   Thu, 11 Apr 2019 12:49:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Add all documentation files to an html/pdf
 produced book
Message-ID: <20190411124904.12e61bc7@lwn.net>
In-Reply-To: <20190410064939.2a9dca9a@coco.lan>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
        <20190408161820.6a12657f@lwn.net>
        <20190410064939.2a9dca9a@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 06:49:39 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

[I'm just responding to one little piece of this for the moment...]

> In any case, IMHO, the best would be to add a new
> crap^h^h^h^hstaging group were we could place all legacy random stuff.
> Then, gradually fix those, splitting stuff and promoting them to the
> main books, in a similar way to what we do with staging.

Now that's an interesting idea; I hadn't thought about that.  Doing so,
though, implies a willingness to stage unloved docs *out*, and my
experience is that there is little appetite for that.  It also kind of
implies moving docs twice - at least for the ones that get updates - and
that may not be entirely appreciated.

> > I feel like it would, if anything, reduce the incentive to
> > deal with these leftover documents properly.    
> 
> IMHO, it is just the opposite. Let's face it: ReST build was added around
> May, 2016, for Kernel 4.7. People had quite some time and kernel versions
> to do conversions. If nothing is done, I doubt we would have any boom on
> patches addressing the issues.

So I don't have any hard numbers, but my feeling is that this work is
continuing apace and perhaps even picking up.  Certainly I'm having a
harder time keeping up with it, even when you're busy with other things :)
These things take time; I'm not really ready to give up on it yet.

Thanks,

jon
