Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C2C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57489206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556304007;
	bh=YqS/TftSlFL9lVhVTHSdP22PlkXMhQ/xEjYhSSyRZCs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=beDvhiqTkFO3A52vfiOCezjiMo+l4Bd68RRnStLjKGpizo/uVwRv6rTKFLlPxVySK
	 VGWvpgAAUs4I+OuycExIhhU8O/Ki2bYbi4AkR8p39qqDpGUB3YS2DgRAM3+7Ve/n0j
	 tZzgf3SpcO+i79qAyYE44EdRClD6HOd1e8fZ2aE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfDZSkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfDZSkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:40:04 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.1-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556304003;
        bh=YqS/TftSlFL9lVhVTHSdP22PlkXMhQ/xEjYhSSyRZCs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I14NP+Z1isGjp84dRPWd1eQJU5lQkCWI9Ud4fm8D8PEO6S9hdEKSxzg6cvPeFENvJ
         Dh5EhuprB1sGqwmlZQ3NTQjv2XKOvwNcdPwzIRp5zR7gMKzELMRB+su5PpvaAuauS4
         awHqdHo89y57I6JzW76GqTw9m7ezsunh+dPnwlOU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190426171251.GA24143@arrakis.emea.arm.com>
References: <20190426171251.GA24143@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190426171251.GA24143@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 4e69ecf4da1ee0b2ac735e1f1bb13935acd5a38d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 857e17c2ee7c426c1f8998ccd48e2d5a7542148d
Message-Id: <155630400349.7251.7298031269500401150.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Apr 2019 18:40:03 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Apr 2019 18:12:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/857e17c2ee7c426c1f8998ccd48e2d5a7542148d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
