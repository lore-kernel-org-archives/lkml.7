Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ECC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61DB21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfDWXYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:24:54 -0400
Received: from namei.org ([65.99.196.166]:35478 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfDWXYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:24:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3NNOqB6029657;
        Tue, 23 Apr 2019 23:24:52 GMT
Date:   Wed, 24 Apr 2019 09:24:52 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] seccomp: fix up grammar in comment
In-Reply-To: <CAGXu5jJDhQ_3jS9-VSUwruFDpb4GwqUs=iz7uNGMkPbLnNWKUw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1904240924410.29297@namei.org>
References: <20190306201413.14153-1-tycho@tycho.ws> <CAGXu5jJDhQ_3jS9-VSUwruFDpb4GwqUs=iz7uNGMkPbLnNWKUw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019, Kees Cook wrote:

> On Wed, Mar 6, 2019 at 12:14 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > This sentence is kind of a train wreck anyway, but at least dropping the
> > extra pronoun helps somewhat.
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> James, this can go in for v5.2 -- no rush.
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

