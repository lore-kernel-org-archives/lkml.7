Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F976C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055772072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfKOQ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:29:48 -0500
Received: from ms.lwn.net ([45.79.88.28]:43402 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbfKOQ3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:29:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3E9582D8;
        Fri, 15 Nov 2019 16:29:45 +0000 (UTC)
Date:   Fri, 15 Nov 2019 09:29:43 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] checkpatch: whitelist Originally-by: signature
Message-ID: <20191115092943.7c79f81e@lwn.net>
In-Reply-To: <20191115154627.GA2187@lxhi-065.adit-jv.com>
References: <20191115150202.15208-1-erosca@de.adit-jv.com>
        <05ba4e29fb78885cf9abf7bfc87e0a7bcda099fe.camel@perches.com>
        <20191115154627.GA2187@lxhi-065.adit-jv.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 16:46:27 +0100
Eugeniu Rosca <erosca@de.adit-jv.com> wrote:

> On Fri, Nov 15, 2019 at 07:09:17AM -0800, Joe Perches wrote:
> > On Fri, 2019-11-15 at 16:02 +0100, Eugeniu Rosca wrote:  
> > > Oftentimes [1], the contributor would like to honor or give credits [2]
> > > to somebody's original ideas in the submission/reviewing process. While
> > > "Co-developed-by:" and "Suggested-by:" (currently whitelisted) could be
> > > employed for this purpose, they are not ideal.  
> > 
> > You need to get the use of this accepted into Documentation/process
> > before adding it to checkpatch  
> 
> If the change [*] makes sense to you, I can submit an update to
> Documentation/process/submitting-patches.rst

So there appear to be 89 patches with Originally-by in the entire Git
history, which isn't a a lot; there are 3x as many Co-developed-by tags,
which still isn't a huge number.  I do wonder if it's worth recognizing
yet another tag with a subtly different shade of meaning here?  My own
opinion doesn't matter a lot, but I'd like to have a sense that there is
wider acceptance of this tag before adding it to the docs.

Thanks,

jon
