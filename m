Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F9DC4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 20:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87345222CB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 20:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570305919;
	bh=C3dOcbNbvsVVNtkIVIpngy0VYlrwjiXnsg6x80Z5T9c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PH9PDDWLn1ap4mx3WC5hrlXC4H9Z9/NTq2jFl9+Vvqb3NeaBEF5eGh4AKaep34sWY
	 x1qAxEdabQ/nMeDMwrFJH3Uxuhr5vJhOXIYaK28SSsRECN20OGyRN6+y1/WkjpeRyl
	 gtSazma1KAyNkGECIyEDLG/fNTFmudDviFXBYmvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfJEUFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 16:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730245AbfJEUFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 16:05:15 -0400
Subject: Re: [GIT PULL] Kbuild fixes for v5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570305914;
        bh=C3dOcbNbvsVVNtkIVIpngy0VYlrwjiXnsg6x80Z5T9c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SdCOzdSS7ZhblZ7iAw3LshSRDKNedjH/PuEhmQ60HdDWIh/hQda+tjqb2q3Bz4tR3
         VMp2rkIL6H8TLDlEnF7NgPl0NOAi3RElo+KDOu3oJKiGVQcFOLVQeuwwQbu6jiVxAw
         lyJM/EwA6ilorrNlMH4ek9YvwPgt+crajaRe5HhM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATpmqt57w9m1keLKu4Y0zbvWjJX8SWqKC6b6mj-23Y0xg@mail.gmail.com>
References: <CAK7LNATpmqt57w9m1keLKu4Y0zbvWjJX8SWqKC6b6mj-23Y0xg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATpmqt57w9m1keLKu4Y0zbvWjJX8SWqKC6b6mj-23Y0xg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.4
X-PR-Tracked-Commit-Id: 86cdd2fdc4e39c388d39c7ba2396d1a9dfd66226
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d00aee21a5d4966e086d98f9d710afb92fb14e8
Message-Id: <157030591476.15791.17657287644153393351.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Oct 2019 20:05:14 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Oct 2019 17:21:15 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d00aee21a5d4966e086d98f9d710afb92fb14e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
