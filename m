Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D195C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 17:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4782184D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560621315;
	bh=2htXWJdjd+iLtonxjiD0hHLYRT968pKJOxcef9OBGVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uXcuF1kMay9iLdfzZgWkMSCuDnf8xDM57ILm6pfmuhzRReY/U2Bp9aWaQxi+SIcK6
	 U59mi6sKdpuWerXAOiMKrIP/tVGb7ioA8IqM/hXdOioqJr4SsMgN3BQ0NSEUIuHBMW
	 Cs1YhoGEr/kW7ANi1iDnwaw8le5IYmbsOwUlLmKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfFORzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 13:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfFORzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 13:55:06 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.2-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560621306;
        bh=2htXWJdjd+iLtonxjiD0hHLYRT968pKJOxcef9OBGVc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U4+zqiDX0t+a+BemSzueLY9oOi7qPdSyEt+t+fTcozxW2Rkkkn3WQHD9B2zNtdVaH
         QhDOwaLpKscq4GmlLHZd03VKUf6IQhVhq/G6aMKPtYzZvF7IBtYTP+r6v1KAiJVY4u
         8yXwbVYgXYzQexDyVTl2jPHnwH5dIWGW8qnlESpw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v9x7nf9l.fsf@concordia.ellerman.id.au>
References: <87v9x7nf9l.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v9x7nf9l.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.2-4
X-PR-Tracked-Commit-Id: c21f5a9ed85ca3e914ca11f421677ae9ae0d04b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa1827d7731ac24f44309ddc2ca806650912bf0e
Message-Id: <156062130614.5191.12937398987487945534.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jun 2019 17:55:06 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Jun 2019 23:34:46 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa1827d7731ac24f44309ddc2ca806650912bf0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
