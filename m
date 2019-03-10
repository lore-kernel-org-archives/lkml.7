Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A17FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A0C2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552241120;
	bh=UAGqjIAiRQv2iBIhyAADNKeFU2IbfvZHlaIr3FjXrt0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tqXGrTzOvu4p7kb5bhn+dOj50VhY2k963jPSxhfs+osMQwJfT+YqmLRpN9vtuWvY6
	 u+RrDhgOH0rOVZhaQfasCW/byDh64YmT7Smbr/t0J/nfi2ratQtU89ttnuNVdwBeM+
	 C7wGdiFFnbtaZhoiW9YwrlHC6ikuPaHlL30jK/qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCJSFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfCJSFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:05:14 -0400
Subject: Re: [GIT PULL] arm64 updates for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552241114;
        bh=UAGqjIAiRQv2iBIhyAADNKeFU2IbfvZHlaIr3FjXrt0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AvRM/WWbeD3Q8GP+8QAX7F7ZMMygFOtFX7I/uf8yavV3hqMEmgrGcusnZy4WGOuQl
         YJiddQcp/yxSfL7DIGc85dCugJO5U11rD62/5JC34nBTxMvWOUMbTWaXAO4j1jvb7R
         G/h1TrqX5M6RZc91tHVRhpPmQIPn87uVqC+iZJ0Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190308164221.GA126180@arrakis.emea.arm.com>
References: <20190308164221.GA126180@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190308164221.GA126180@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: b855b58ac1b7891b219e1d9ef60c45c774cadefe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d8dfe75ef69f4dd4ba35c09b20a5aa58b4a5078
Message-Id: <155224111416.12168.42921658416874256.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 18:05:14 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Mar 2019 16:42:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d8dfe75ef69f4dd4ba35c09b20a5aa58b4a5078

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
