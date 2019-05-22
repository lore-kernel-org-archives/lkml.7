Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD451C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7192F2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Y+M45mOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfEVEdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 00:33:16 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:28211 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfEVEdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 00:33:15 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x4M4WrAX025249;
        Wed, 22 May 2019 13:32:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x4M4WrAX025249
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558499574;
        bh=kC/7prX+C+2GIVJQiuuIi8XLzMVgnvSoZHhNqAH7bsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y+M45mOHntg7+tiS8t2jkB7FG6WmxhT1aIs7ysQEDA7b6MaBj+9LGsRC31jKW0FV6
         HZ+dHSQneVH0pBmfC+TeG0tz4ZFdv4Kn5NL4yQUzq6Ngd4aSZPB3yy/GMPVjaTcxl1
         EFSuBzIJh/C9oPbaXt/eoKhThySkcDycwBW518iMWi/s8OKLRdF9gRyxosYBx+xboP
         Cux2h7ITUfHw8+viZw8vnHS4VwoR2fGINOrZiS2ASqxOx1+HLRNlE6yahxPSTBFQwE
         8E/ZBMbFnKlkOUYezybPEYk3gZ/sV792AbAiGYo474+i2UUJbRMe9rqOCzEB8uCKnr
         zj9upfEmEpJ8A==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id 94so409459uam.3;
        Tue, 21 May 2019 21:32:54 -0700 (PDT)
X-Gm-Message-State: APjAAAXi0MG3BB6NOIuSCZTsveRL2UEFKPwsEcJm2RB1YsJx0/EYRB35
        DrFwt/jm5gMY6/PPmFRAjW5HUE2U7nvBehRQbW8=
X-Google-Smtp-Source: APXvYqxg/yUldZEzMfWPj1/0j+jU/P/riMEwQo13Wixk1wypsPYU92HqetuDLIw5cXGC7DnHWIIhdz8QPm6mj0SULVA=
X-Received: by 2002:ab0:1c45:: with SMTP id o5mr18665216uaj.25.1558499573372;
 Tue, 21 May 2019 21:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190521133257.GA21471@kroah.com>
In-Reply-To: <20190521133257.GA21471@kroah.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 22 May 2019 13:32:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASZWLwYC2E3vBkXhp7wt9zBWkFrR+NTnxTyLn1zO66a0w@mail.gmail.com>
Message-ID: <CAK7LNASZWLwYC2E3vBkXhp7wt9zBWkFrR+NTnxTyLn1zO66a0w@mail.gmail.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
>
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc2
>
> for you to fetch changes up to 7170066ecd289cd8560695b6f86ba8dc723b6505:
>
>   treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 25 (2019-05-21 11:52:39 +0200)
>
> ----------------------------------------------------------------
> SPDX update for 5.2-rc2, round 1
>
> Here are series of patches that add SPDX tags to different kernel files,
> based on two different things:
>   - SPDX entries are added to a bunch of files that we missed a year ago
>     that do not have any license information at all.
>
>     These were either missed because the tool saw the MODULE_LICENSE()
>     tag, or some EXPORT_SYMBOL tags, and got confused and thought the
>     file had a real license, or the files have been added since the last
>     big sweep, or they were Makefile/Kconfig files, which we didn't
>     touch last time.
>
>   - Add GPL-2.0-only or GPL-2.0-or-later tags to files where our scan
>     tools can determine the license text in the file itself.  Where this
>     happens, the license text is removed, in order to cut down on the
>     700+ different ways we have in the kernel today, in a quest to get
>     rid of all of these.



I have been wondering for a while
which version of spdx tags I should use in my work.


I know the 'GPL-2.0' tag is already deprecated.
(https://spdx.org/licenses/GPL-2.0.html)


But, I saw negative reaction to this:
https://lore.kernel.org/patchwork/patch/975394/

Nor "-only" / "-or-later" are documented in
Documentation/process/license-rules.rst


In this patch series, Thomas used 'GPL-2.0-only' and 'GPL-2.0-or-later'
instead of 'GPL-2.0' and 'GPL-2.0+'.

Now, we have a great number of users of spdx v3 tags.
$ git grep -P 'SPDX-License-Identifier.*(?:-or-later|-only)'| wc -l
4135



So, what I understood is:

  For newly added tags, '*-only' and '*-or-later' are preferred.

(But, we do not convert existing spdx v2 tags globally.)



Joe's patch was not merged, but at least
Documentation/process/license-rules.rst
should be updated in my opinion.

(Perhaps, checkpatch.pl can suggest newer tags in case
patch submitters do not even know that deprecation.)


Thanks.



> These patches have been out for review on the linux-spdx@vger mailing
> list, and while they were created by automatic tools, they were
> hand-verified by a bunch of different people, all whom names are on the
> patches are reviewers.
>
> The reason for these "large" patches is if we were to continue to
> progress at the current rate of change in the kernel, adding license
> tags to individual files in different subsystems, we would be finished
> in about 10 years at the earliest.
>
> There will be more series of these types of patches coming over the next
> few weeks as the tools and reviewers crunch through the more "odd"
> variants of how to say "GPLv2" that developers have come up with over
> the years, combined with other fun oddities (GPL + a BSD disclaimer?)
> that are being unearthed, with the goal for the whole kernel to be
> cleaned up.
>
> These diffstats are not small, 3840 files are touched, over 10k lines
> removed in just 24 patches.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


-- 
Best Regards
Masahiro Yamada
