Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2946C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FA323407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfH3RT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:19:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36093 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfH3RT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:19:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so8416991qtc.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 10:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eREbuz0j2yx01SeF7umXo65Zd8gunKI6vNp3hTkMlVc=;
        b=MJZKcpJYpb1ogC/0tY9Sxq390Y2Em4aBYTWlMT7jlRk1Kgozl6H+ltqDYsQC8EsMuk
         5o+85F0A08rsSETs/376eoYjBc/b4Q739AEzFVxm1S1ME25dPttphaG+Ks9pwC8CcXq7
         oWJJo/3TqDIrK/o1LydMbkx/RDcqd05XLD2reXkAEgx/MaGO6R2PFN7eSQvtrqgIJrWt
         DH5fn4qiT64tSeKijkx0ilFBitsOkoN61SQXQaGdCQuXnUeLFIJxop1YROYAsBSIGbaQ
         cghPky0xc+tFi2BUwPD/pBYL3ciOhjyKe/mCdlEO9NEed+NKGJZ+vFJVjLc+jO1/b2TR
         Uyog==
X-Gm-Message-State: APjAAAWM4zk4LsTegD47An12EuL5w4T6GsmjDNz5/DZ+kRKjUaDUFihj
        Es8HUTcsBdzd96rx8metisvqEXjZldQyjQBhkog=
X-Google-Smtp-Source: APXvYqwVevCuvuH2sy338AJ2V2IsQ6SavmSFH2Vz3yo29gW/Ty69n6T+cSn11lboWM0ZqxXySp5bXRiU47TYVhw1fhY=
X-Received: by 2002:aed:3363:: with SMTP id u90mr16473668qtd.7.1567185597224;
 Fri, 30 Aug 2019 10:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2OZPybUQ=2xXcF4Qft-Gpe3a1mvgPncJZugETnaOxsvw@mail.gmail.com>
 <CAHk-=wgq71zNZtcb7vAsgb0EEozJsBDrLC0L+91tmMCBG=8FiQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgq71zNZtcb7vAsgb0EEozJsBDrLC0L+91tmMCBG=8FiQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Aug 2019 19:19:40 +0200
Message-ID: <CAK8P3a1WQn67D2L1pBwF-L=HeodjgJNhAKfMM4BC99bXiO9t5g@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for Linux-5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 6:34 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Aug 30, 2019 at 9:26 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git armsoc-fixes
> >
> > for you to fetch changes up to 7a6c9dbb36a415c5901313fc89871fd19f533656:
>
> Nope. That's a stale tag for me, pointing to commit 7bd9d465140a. Your
> old pull request from end of July, it looks like.
>
> Forgot to push out? Or forgot to use "-f" to overwrite the old tag?

Wrong tree: I pushed it to soc.git, but passed the old tree to 'git
request-pull'

Correct URL is

git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

I guess we should just delete the old tree now to avoid confusion like this.

        Arnd
