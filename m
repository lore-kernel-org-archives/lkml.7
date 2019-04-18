Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DB0C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3521B2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555608606;
	bh=WiDTNZE66AT4HWbj6HxKP0f3hcwPYxgRz98Fjv5RrCc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V99dj3bceG46iO0FVGspNs2c2jCAC4hG39Hu5xrT9zRLQ7jxUap0oqMUKmmj/Jdax
	 fbRIHXO3cMrOWUHmiOcPGtsPqn254vPHyVS4FGyK1C754/pAWMqm4NYVjrxNl1BnI9
	 muSXeRolgCYB/u3vNJT3zIi9kz340cHZddR9AqFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbfDRRaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733192AbfDRRaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:30:04 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555608603;
        bh=WiDTNZE66AT4HWbj6HxKP0f3hcwPYxgRz98Fjv5RrCc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t03KGBJpIMMWurTgd8LlynHfEa+s+A8tgbvLgJxWg8yTbvIq4usFrRHSmwFbjFuRr
         5h31IwrlqoLQLA1zpgEmy9Vq4B6XT1TaPgd8IIAPH886suv80lyxSDKUB6au6YmHwz
         JcK+zolheZSEIo0xJLWB3XRqg9gvBn0JKb7HC1Vk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190418172245.GA40357@arrakis.emea.arm.com>
References: <20190418172245.GA40357@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190418172245.GA40357@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: ff8acf929014b7f87315588e0daf8597c8aa9d1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d906f99817951e2257d577656899da02bb33105
Message-Id: <155560860372.5590.9126022469900642513.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Apr 2019 17:30:03 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Apr 2019 18:22:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d906f99817951e2257d577656899da02bb33105

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
