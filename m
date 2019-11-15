Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC100C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF7620733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKOVdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:33:17 -0500
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:33454 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbfKOVdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:33:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B5F14180220B5;
        Fri, 15 Nov 2019 21:33:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blade42_5685b2467e420
X-Filterd-Recvd-Size: 2369
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Nov 2019 21:33:14 +0000 (UTC)
Message-ID: <cddb7f4f3e247aacd54132d418009bba03308ed0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: whitelist Originally-by: signature
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 15 Nov 2019 13:32:54 -0800
In-Reply-To: <20191115092943.7c79f81e@lwn.net>
References: <20191115150202.15208-1-erosca@de.adit-jv.com>
         <05ba4e29fb78885cf9abf7bfc87e0a7bcda099fe.camel@perches.com>
         <20191115154627.GA2187@lxhi-065.adit-jv.com>
         <20191115092943.7c79f81e@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 09:29 -0700, Jonathan Corbet wrote:
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

I am also not a proponent of adding this as a new tag/signature.


