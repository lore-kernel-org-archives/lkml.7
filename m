Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA9BC282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7864220881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfEWFda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:33:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38551 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfEWFda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:33:30 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hTgM0-0004zF-Js; Thu, 23 May 2019 07:33:24 +0200
Date:   Thu, 23 May 2019 07:33:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joe Perches <joe@perches.com>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
In-Reply-To: <4857dce766f161a643eb3340dfee6a2dec7eb2e5.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1905230732520.1770@nanos.tec.linutronix.de>
References: <20190521133257.GA21471@kroah.com>         <CAK7LNASZWLwYC2E3vBkXhp7wt9zBWkFrR+NTnxTyLn1zO66a0w@mail.gmail.com>         <eae2d0e80824cc84965c571a0ea097e14d3f498c.camel@perches.com>         <CAK7LNAQ=M0ejV3C8bgjuMxdRR9v=2-GRdXeUjFR6URrrtYPCnA@mail.gmail.com>
 <4857dce766f161a643eb3340dfee6a2dec7eb2e5.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Joe Perches wrote:

> On Thu, 2019-05-23 at 11:49 +0900, Masahiro Yamada wrote:
> > On Wed, May 22, 2019 at 3:37 PM Joe Perches <joe@perches.com> wrote:
> []
> > > I could also wire up a patch to checkpatch and docs to
> > > remove the /* */ requirement for .h files and prefer
> > > the generic // form for both .c and .h files as the
> > > current minimum tooling versions now all allow //
> > > comments
> > > .
> > 
> > We have control for minimal tool versions for building the kernel,
> > so I think // will be OK for in-kernel headers.
> > 
> > 
> > On the other hand, I am not quite sure about UAPI headers.
> > We cannot define minimum tool versions
> > for building user-space.
> > Perhaps, using // in UAPI headers causes a problem
> > if an ancient compiler is used?
> 
> Good point. Thanks.

Indeed. Did not think about the UAPI part at all.

Thanks,

	tglx
