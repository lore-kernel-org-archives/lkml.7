Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7681C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F75C20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfEWC6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:58:20 -0400
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:49209 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727305AbfEWC6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:58:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 04C33100E86C0;
        Thu, 23 May 2019 02:58:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: care15_2aae51fa10659
X-Filterd-Recvd-Size: 1955
Received: from XPS-9350 (unknown [172.56.44.57])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 May 2019 02:58:12 +0000 (UTC)
Message-ID: <4857dce766f161a643eb3340dfee6a2dec7eb2e5.camel@perches.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Date:   Wed, 22 May 2019 19:57:41 -0700
In-Reply-To: <CAK7LNAQ=M0ejV3C8bgjuMxdRR9v=2-GRdXeUjFR6URrrtYPCnA@mail.gmail.com>
References: <20190521133257.GA21471@kroah.com>
         <CAK7LNASZWLwYC2E3vBkXhp7wt9zBWkFrR+NTnxTyLn1zO66a0w@mail.gmail.com>
         <eae2d0e80824cc84965c571a0ea097e14d3f498c.camel@perches.com>
         <CAK7LNAQ=M0ejV3C8bgjuMxdRR9v=2-GRdXeUjFR6URrrtYPCnA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-23 at 11:49 +0900, Masahiro Yamada wrote:
> On Wed, May 22, 2019 at 3:37 PM Joe Perches <joe@perches.com> wrote:
[]
> > I could also wire up a patch to checkpatch and docs to
> > remove the /* */ requirement for .h files and prefer
> > the generic // form for both .c and .h files as the
> > current minimum tooling versions now all allow //
> > comments
> > .
> 
> We have control for minimal tool versions for building the kernel,
> so I think // will be OK for in-kernel headers.
> 
> 
> On the other hand, I am not quite sure about UAPI headers.
> We cannot define minimum tool versions
> for building user-space.
> Perhaps, using // in UAPI headers causes a problem
> if an ancient compiler is used?

Good point. Thanks.


