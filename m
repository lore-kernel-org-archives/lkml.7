Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9898C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5937208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfEMRx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:53:57 -0400
Received: from namei.org ([65.99.196.166]:38872 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbfEMRx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:53:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4DHrsbi002989;
        Mon, 13 May 2019 17:53:54 GMT
Date:   Tue, 14 May 2019 03:53:54 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
In-Reply-To: <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1905140352370.14684@namei.org>
References: <alpine.LRH.2.21.1905110801350.9392@namei.org> <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2019, Linus Torvalds wrote:

> On Fri, May 10, 2019 at 6:09 PM James Morris <jmorris@namei.org> wrote:
> >
> > These patches include fixes to enable fuzz testing, and a fix for
> > calculating whether a filesystem is user-modifiable.
> 
> So now these have been very recently rebased (on top of a random
> merge-window "tree of the day" version) instead of having multiple
> merges.
> 
> That makes the history cleaner, but has its own issues.

These are just plain patches from the author, they were not part of any 
publicly accessible tree -- there's nowhere they could be merged from.

> We really need to find a different model for the security layer patches.
> 
>                    Linus
> 

-- 
James Morris
<jmorris@namei.org>

