Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9D2CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A7E2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbfJVICy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:02:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59802 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbfJVICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:02:53 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iMp7w-0007W6-L4; Tue, 22 Oct 2019 08:02:48 +0000
Date:   Tue, 22 Oct 2019 10:02:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux@rasmusvillemoes.dk,
        cyphar@cyphar.com, keescook@chromium.org
Subject: Re: linux-next: Tree for Oct 18 (objtool)
Message-ID: <20191022080247.6zc36jaqfr4s6o7i@wittgenstein>
References: <20191018180300.090dbcb9@canb.auug.org.au>
 <40de4e26-450e-b932-3d73-e833c8aeaa2e@infradead.org>
 <20191021123549.GC1817@hirez.programming.kicks-ass.net>
 <20191021131149.GA19358@hirez.programming.kicks-ass.net>
 <20191021131947.yih3wqjbfroaj4dz@wittgenstein>
 <20191021134759.GG1800@hirez.programming.kicks-ass.net>
 <20191021193652.lfccehm37dkkofp7@wittgenstein>
 <20191022074034.GK1817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191022074034.GK1817@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:40:34AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 21, 2019 at 09:36:53PM +0200, Christian Brauner wrote:
> > Ok, so I take it you route that patch somehwere through tip?
> > I'm happy with the ubsan fix:
> 
> Yeah, I'll go make a real patch with Changelog of it and stick it in
> tip.

Excellent! Thanks!
Christian
