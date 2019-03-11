Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4172054F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552319724;
	bh=GtGqvj/rp/pOUfXRUKwvpILN1KIyEizam+KPHPm0UQo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mgODko6kcPPFUUGFLfPcYqkiOUfxzgMLFPwX/YXtaxniYCKdkTvLEK2hyAlqcIoFE
	 GAHsFctw6wIfqw01YwPjdkowhtOR4VkwEYi+yY9EFVWZPhlLQbb0dIzLf3mPKt1qin
	 5TpApoQ5c0605Q+rjnTMc3PMjmyDk70EwVTnyxLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfCKPzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfCKPzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:55:16 -0400
Subject: Re: [GIT PULL] Kbuild updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552319716;
        bh=GtGqvj/rp/pOUfXRUKwvpILN1KIyEizam+KPHPm0UQo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D5fI7BDlXh0zNPjKekz8q0GtVzPJBVsOzv3xWzVrAaOVUQnI84J8nFZ4eQk+9/HHJ
         mxM59c0Va1D+1CAr+N/fMm2ldKlc05Sd2DLg86xbSYP0hSaCHIhuUSfMIFNLrVoxQx
         xTYQNoW2aFiMJ8pDlxJm92FC98PGe/FqELKRGag8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAS2zf1yEmZhTa9h+73hk3ZMHMgBLHhzwS8-zu2fZ+MeAA@mail.gmail.com>
References: <CAK7LNAS2zf1yEmZhTa9h+73hk3ZMHMgBLHhzwS8-zu2fZ+MeAA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAS2zf1yEmZhTa9h+73hk3ZMHMgBLHhzwS8-zu2fZ+MeAA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v5.1
X-PR-Tracked-Commit-Id: 9250d20e9ecedab6aa331a127fbfc1272383ed72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffd602eb4693bbb49b301fa059b109bbdebf9524
Message-Id: <155231971614.7015.18170863459174985254.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Mar 2019 15:55:16 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Mar 2019 10:31:35 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffd602eb4693bbb49b301fa059b109bbdebf9524

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
