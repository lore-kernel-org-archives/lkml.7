Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0443FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD74420685
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfCYTId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:08:33 -0400
Received: from namei.org ([65.99.196.166]:58388 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfCYTId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:08:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2PJ8Abt014348;
        Mon, 25 Mar 2019 19:08:10 GMT
Date:   Tue, 26 Mar 2019 06:08:10 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: Linux 5.1-rc2
In-Reply-To: <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org>
Message-ID: <alpine.LRH.2.21.1903260607500.13529@namei.org>
References: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com> <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019, Randy Dunlap wrote:

> On 3/24/19 2:26 PM, Linus Torvalds wrote:
> > Well, we're a week away from the merge window close, and here's rc2.
> > Things look fairly normal, but honestly, rc2 is usually too early to
> > tell.  People haven't necessarily had time to notice problems yet.
> > Which is just another way of saying "please test harder".
> > 
> > Nothing particularly stands out. Yes, we had some fixes for the new
> > io_ring code for issues that were discussed when merging it. Other
> > than that, worth noting is that the bulk of the patches are for
> > tooling, not the core kernel. In fact, about two thirds of the patch
> > is just for the tools/ subdirectory, most of it due to some late perf
> > tool updates. The people involved promise they're done.
> 
> Hmph.  I'm still looking for the patch that restores the various
> CONFIG_DEFAULT_<security> kconfig options to be merged.
> 
> https://lore.kernel.org/linux-security-module/2bf23acd-22c4-a260-7648-845887a409d5@i-love.sakura.ne.jp/
> 
> since commit 70b62c25665f636c9f6c700b26af7df296b0887e dropped them somehow.

AFAICT we don't have a finalized version of the patch yet.

Kees?


-- 
James Morris
<jmorris@namei.org>

