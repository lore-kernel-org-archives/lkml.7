Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89390C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A342133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfJDT7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:59:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57104 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfJDT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:59:51 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iGTjx-0005cl-Le; Fri, 04 Oct 2019 19:59:49 +0000
Date:   Fri, 4 Oct 2019 21:59:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] usercopy structs for v5.4-rc2
Message-ID: <20191004195947.lkq5lkyj5zvlyxaw@wittgenstein>
References: <20191004104116.20418-1-christian.brauner@ubuntu.com>
 <CAHk-=whxf5HVdaXqL6RgHCLzb2LNn3U2n_x4GWQZroCC+evRoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whxf5HVdaXqL6RgHCLzb2LNn3U2n_x4GWQZroCC+evRoA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:53:41AM -0700, Linus Torvalds wrote:
> On Fri, Oct 4, 2019 at 3:42 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> >            The only separate fix we we had to apply
> > was for a warning by clang when building the tests for using the result of
> > an assignment as a condition without parantheses.

<snip>

> 
> I've pulled this, since it's not in core kernel code anyway, but I
> wish I had never had to see that ugly construct.

I admit that I'm _less_ anal about other people's code in _tests_ as for
example in this case.
For core kernel code I obviously would not have taken this into the
tree.
Honestly, my main concern currently is to get people to add tests at all
- at least if they want to go through my tree - and if they adhere to
that request I'm more lenient.

Christian
