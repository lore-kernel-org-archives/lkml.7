Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA1EC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0035D2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559925922;
	bh=xHNLQKOgqwuG8+63U3xrvazYFXLVHXrx58xIhyZnOTM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dSjFvO03O14uf6U80ryRHMVudYAZJbfcTA2gj++gN9UuAUFjguU0C9UeFeNFuYMcu
	 aDunCZQnb76UhzepFzGfBplM3BhWSL0dESw9N6IBhPs7ddhATEXK099zoNL1VzWcUh
	 t2spc7J6iK19Cglc5KMyqhdx6eAUopMX4Sia7JU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfFGQpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729788AbfFGQpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:45:12 -0400
Subject: Re: [GIT PULL] arm64: fixes for -rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559925912;
        bh=xHNLQKOgqwuG8+63U3xrvazYFXLVHXrx58xIhyZnOTM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lAdkBBwpj4Jm5PHEjNQlN7AVHASpYyOIzVHAcZds3Dwarz8PIPKSoZqS9Xgkvu37s
         2bRRs5iioozoqds6qlgPaPm8JsVsnFLhGqyycotVSfpLZEf40WYj1F6DV+2LOzvl7O
         sWRO2KqXw9BPYamcX7DWUl5Da8YjMftzF7PpNJ0s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190607151316.GB19862@fuggles.cambridge.arm.com>
References: <20190607151316.GB19862@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190607151316.GB19862@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: ebcc5928c5d925b1c8d968d9c89cdb0d0186db17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a02a532c2a6c79a898cd6c430fe3ad011d9aece3
Message-Id: <155992591208.2725.17227157802689192114.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jun 2019 16:45:12 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Jun 2019 16:13:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a02a532c2a6c79a898cd6c430fe3ad011d9aece3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
