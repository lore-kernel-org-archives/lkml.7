Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6206BC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6CE216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfEIWT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 18:19:57 -0400
Received: from namei.org ([65.99.196.166]:38378 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfEIWT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:19:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x49MJtYU014529;
        Thu, 9 May 2019 22:19:55 GMT
Date:   Fri, 10 May 2019 08:19:55 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] security subsytem: TPM changes for v5.2
In-Reply-To: <CAHk-=whqzNFfeNOouBjH2GKMVgMi22fsNOaCgbUOnCPmKmEXeQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1905100819390.13541@namei.org>
References: <alpine.LRH.2.21.1905100320110.25349@namei.org> <CAHk-=whqzNFfeNOouBjH2GKMVgMi22fsNOaCgbUOnCPmKmEXeQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019, Linus Torvalds wrote:

> On Thu, May 9, 2019 at 10:23 AM James Morris <jmorris@namei.org> wrote:
> >
> > Bugfixes and new selftests for v5.1 features (partial reads in /dev/tpm0).
> 
> What the heck is going on?
> 
> I got all of these long ago in the "TPM fixes" branch for 5.1. One
> month ago, merge commit a556810d8e06.
> 
> These are just rebased (!) copies of stuff I already have, and they should
> 
>  (a) never have been rebased in the first place
> 
>  (b) certainly not be re-sent to me as a new branch
> 
> Please throw this branch away and make sure it really is dead and
> buried and never shows up again.

Yikes, ok.

> And take a moment to look at what happened and why this broken branch
> was duplicated and sent twice!

Could it be something I pulled in? I haven't used 'rebase' in many years.


-- 
James Morris
<jmorris@namei.org>

