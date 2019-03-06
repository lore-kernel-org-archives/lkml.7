Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDBEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3A321019
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897074;
	bh=8CXeQwniQSBSBUwRTJiZLhbqrTI+vL4pyBDPzUTl9FI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FwnkVzWHwS4psOsucLyEafUDfbB8FTeG8ogHRY0dB01HvntDe75bCnJZFftPhwQ3c
	 768XQxZUnQQHSfbcnR1df8tfS4FQFTzRb5Ird5nlJ++8trOqoT81YCJHu321aE7h+F
	 Qbqe2bw/itzBTLy8vdOhiEfKdEVz4C9Lvmyek7Gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfCFSaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfCFSaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:17 -0500
Subject: Re: [GIT PULL 1/6] ARM: SoC platform updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897017;
        bh=8CXeQwniQSBSBUwRTJiZLhbqrTI+vL4pyBDPzUTl9FI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hSX087NaTdxvtagMHft0qNy3U6s0xPgNqx/dxsQS6O1MqETkEBn+rM28qmHbYhVcM
         +wpzr3VWVR27zNOUPleF17KZqKmykA6+rF43g/+SAxWsOPtVEUdoB07WH7EGKGTMeB
         hsh9cGZk+5HU9zwC4EW2cima6roocpir+GqwjRvM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a01nxwLHDztQ-K8bLi0tz0QkwmmJvp+Raquqp_ikRrG6A@mail.gmail.com>
References: <CAK8P3a37Nz0bWJx+Ly4Ttk-pZQ3birJaN+SLsJHgYVe=5wX0Vw@mail.gmail.com>
 <CAK8P3a2sgn3Ai8m_yLX1kHdWrXT3aUFRS5Gzzy5V0dAqMpdGBw@mail.gmail.com>
 <CAK8P3a0k4AgROH3UBd6hCyF=9VbbY2kDMGN=KnuLZ7tQV2aSOQ@mail.gmail.com>
 <CAK8P3a2eH2W1Tmt5t7qtnPyhmhqKCtSOhQa-ugFvFW+NGbQOAQ@mail.gmail.com>
 <CAK8P3a3s3AQhq57UQ_07hGVfpipxhdihUKH5EdYHX2=yhrY=6w@mail.gmail.com>
 <CAK8P3a0XTa6kBKzzTM3H+Xu=RRSJ2R-oi5=aydVrF-AE5=wpSw@mail.gmail.com>
 <CAK8P3a01nxwLHDztQ-K8bLi0tz0QkwmmJvp+Raquqp_ikRrG6A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a01nxwLHDztQ-K8bLi0tz0QkwmmJvp+Raquqp_ikRrG6A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc
X-PR-Tracked-Commit-Id: 49b35cd5e7ddad04ae2fac614cd26f29c4851957
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aebbfafc74b8d4eac573aab47aaa2e7965295096
Message-Id: <155189701698.14612.10306238728748397286.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:16 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 16:30:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aebbfafc74b8d4eac573aab47aaa2e7965295096

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
