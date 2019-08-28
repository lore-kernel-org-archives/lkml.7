Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E4FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFF8217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567014310;
	bh=hc0bjImHvnq/IxCT5s4NZI7gpFd6msv+Pulf0AYrCR4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xm0314bsA003OHsJ2nk1GBQkaKbI0sg3kYFFc+lIzr3cIE/M5AaNA6mDRXcM85hUh
	 pMd7mZFrKMDsmxvJyaLQnrHQ2Rln+w7NES7jtEXJ8ok6Y0vMTwC90yCm97ngt5dseX
	 6ffBXiFi0srZZa9WuOCNDTc2KxaKTpcaS4/EuCgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfH1RpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfH1RpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:45:08 -0400
Subject: Re: [GIT PULL] arm64: Fixes for -rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567014307;
        bh=hc0bjImHvnq/IxCT5s4NZI7gpFd6msv+Pulf0AYrCR4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Oe2zFU4HpEJT04R+CubK1ZvFncH0jBu+Vkbguy2huLOriKL/CTUcTaDPCYgaKJKei
         XVVJ3CUe00SyErsxbyAewrvodXJBzCciVlNo6Q9/Q8x3yallMOeG/uPT2Uo9GHA5NK
         qqSIR8ONUMBj7/2inMxN8JMfs5yti7gQAUwK25iE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190828173233.zqwm5nd4p5xa4jxi@willie-the-truck>
References: <20190828173233.zqwm5nd4p5xa4jxi@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190828173233.zqwm5nd4p5xa4jxi@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 82e40f558de566fdee214bec68096bbd5e64a6a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cf6b756cdf2cd38b8b0dac2567f7c6daf5e79d5
Message-Id: <156701430762.19174.2439398136739791001.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Aug 2019 17:45:07 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        marc.zyngier@arm.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Aug 2019 18:32:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cf6b756cdf2cd38b8b0dac2567f7c6daf5e79d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
