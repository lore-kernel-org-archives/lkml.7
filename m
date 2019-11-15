Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30453C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113002073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKORVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:21:53 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36333 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfKORVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:21:51 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 70FF43C04C0;
        Fri, 15 Nov 2019 18:21:49 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iCW7gDl92XkX; Fri, 15 Nov 2019 18:21:44 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 18CCC3C009C;
        Fri, 15 Nov 2019 18:21:44 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 15 Nov
 2019 18:21:43 +0100
Date:   Fri, 15 Nov 2019 18:21:41 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] checkpatch: whitelist Originally-by: signature
Message-ID: <20191115172141.GA3085@lxhi-065.adit-jv.com>
References: <20191115150202.15208-1-erosca@de.adit-jv.com>
 <05ba4e29fb78885cf9abf7bfc87e0a7bcda099fe.camel@perches.com>
 <20191115154627.GA2187@lxhi-065.adit-jv.com>
 <20191115092943.7c79f81e@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191115092943.7c79f81e@lwn.net>
X-Originating-IP: [10.72.93.66]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Fri, Nov 15, 2019 at 09:29:43AM -0700, Jonathan Corbet wrote:
> On Fri, 15 Nov 2019 16:46:27 +0100
> Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> 
> > On Fri, Nov 15, 2019 at 07:09:17AM -0800, Joe Perches wrote:
> > > On Fri, 2019-11-15 at 16:02 +0100, Eugeniu Rosca wrote:  
> > > > Oftentimes [1], the contributor would like to honor or give credits [2]
> > > > to somebody's original ideas in the submission/reviewing process. While
> > > > "Co-developed-by:" and "Suggested-by:" (currently whitelisted) could be
> > > > employed for this purpose, they are not ideal.  
> > > 
> > > You need to get the use of this accepted into Documentation/process
> > > before adding it to checkpatch  
> > 
> > If the change [*] makes sense to you, I can submit an update to
> > Documentation/process/submitting-patches.rst
> 
> So there appear to be 89 patches with Originally-by in the entire Git
> history, which isn't a a lot; there are 3x as many Co-developed-by tags,
> which still isn't a huge number.  I do wonder if it's worth recognizing
> yet another tag with a subtly different shade of meaning here?  My own
> opinion doesn't matter a lot, but I'd like to have a sense that there is
> wider acceptance of this tag before adding it to the docs.

I will give a real-life example. Say, I have some patches in my
local tree and they've been developed by somebody who is no longer
interested/paid to upstream those.

I first submit those patches with the original authorship, plus my SoB.
Then, the reviewers post their findings. I put my time into fixing those
and re-testing the patch or the entire series. The final patch/series
may look totally different compared to the original one.

Which way would you suggest to give credits to the original author?
I personally think that "Co-developed-by:" conveys the idea/feeling of
"teaming up" with somebody, which doesn't happen in my example.

-- 
Best Regards,
Eugeniu
