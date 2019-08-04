Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8126AC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 17:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCC5206C1
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564939251;
	bh=9DvSzAj+eg7pHB33F4T4wdJQonqSQgo4d+S9hj/TGj8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gEZaP/7gT3nIlk95IsoyJ3Kghg8gUwcxxNXG+x70JzSQJmpkYTxtxn/w3R3st+Jbp
	 RAWH8gFlzG+tTR9FzHM8cIb0zgFJHZj3f82RxUY/Rh6TgJAUyRpkEK3zhRscR6KZji
	 TmnSjps/AnI2E2qRGOEcHracUpiYq2iI3WrRroRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfHDRUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 13:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfHDRUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 13:20:16 -0400
Subject: Re: [GIT PULL] Kbuild fixes for v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564939216;
        bh=9DvSzAj+eg7pHB33F4T4wdJQonqSQgo4d+S9hj/TGj8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oJmQI/JsuXnApN03wFq2BwpNXmDKkr9QLP9B7lkmhVagUfE4lQZlYH3MjHr1AL7Yo
         FyATULOBLnBMVygBnGPbfPj0ZtU+sICll+dWk51/PjNAGWof+gpIF/gWI7znw2fthF
         c9BbjR2KzSIBq5GGSzEuxHqZOo8AwZSuorbVxsUs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQNSjKcanh78mEJWeyO81xz9qBJ=_u=Dcqx+YcaT9pZig@mail.gmail.com>
References: <CAK7LNAQNSjKcanh78mEJWeyO81xz9qBJ=_u=Dcqx+YcaT9pZig@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQNSjKcanh78mEJWeyO81xz9qBJ=_u=Dcqx+YcaT9pZig@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.3-2
X-PR-Tracked-Commit-Id: 0c5b6c28ed68becb692b43eae5e44d5aa7e160ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05e4f88b7d25fa8bf65b846f05197c47ddece278
Message-Id: <156493921001.5657.3129106652808656430.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Aug 2019 17:20:10 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Aug 2019 01:07:14 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05e4f88b7d25fa8bf65b846f05197c47ddece278

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
