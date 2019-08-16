Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D4AC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACB9206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565978408;
	bh=dW5YFHRW8xSZ9ngplk7KwCK0vlp2/MMykcr/x8hk9xE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jlBSGryJ/Jh9DLxCtZtP95rT1qXph+WKrBPkboGgIPupJhwIIYQG2vks7bVNYEdNe
	 CQMjwiR4O1uNcLqM5LM0R0UssUFhLA+7eCHSjjvfAUxFU+dtS2I8wve6ew12NiPZgr
	 bLOibzvLgoPghGFMcyY4CxsXObAatDiTrJKg1/ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfHPSAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfHPSAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:00:07 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565978406;
        bh=dW5YFHRW8xSZ9ngplk7KwCK0vlp2/MMykcr/x8hk9xE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pEKhVKy6rw7zfO0pMPjmx0UgKYMqaxYg/IblUm5ytPMQ8DRpJfsaneDUiV60CT/yq
         tV6TmrGbcGitjI7Wg292TtnXvrtzfQ8Uw3VaGE4U6lbwpRyKu8PVFzIASROboUeMqw
         cH/00iqsKK6OwTMw0EmfIO0SOVKMTuq9r6aXhcws=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190816172411.GA36979@arrakis.emea.arm.com>
References: <20190816172411.GA36979@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190816172411.GA36979@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: b6143d10d23ebb4a77af311e8b8b7f019d0163e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7e7c85dc7b0ea5ff821756c331489e3b151eed1
Message-Id: <156597840617.938.7117793658442703288.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Aug 2019 18:00:06 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Aug 2019 18:24:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7e7c85dc7b0ea5ff821756c331489e3b151eed1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
