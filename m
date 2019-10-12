Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4568C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3C2222BE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570919710;
	bh=/7o2qmc54YKDZd9/+fl9cBiJguaPlhmAXlQAccqkwlM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=K31qAc1kzkhUcs62+76YhhqeMhGIlKKaMfIV+YXFyGfa3smrUyOECNmhbsKyQ5kot
	 xhUfQc1aEoopD+5BENdTFpjT3ubUzCq+HYiRnqK8jLeIASbNAjGpnK5xs70GkrYLDz
	 YYDGayyCeVa8ppDpOYmybaTH7vhEwOfykp9hz5jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfJLWfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJLWfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:35:05 -0400
Subject: Re: [GIT PULL] EFI fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570919705;
        bh=/7o2qmc54YKDZd9/+fl9cBiJguaPlhmAXlQAccqkwlM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WGIhG9bkzaR+ZjH45oHcnnaYlxqgEhDBXshqH/27N6N5uoB4G4kyuerCUP8C3wlGe
         TGtbcz7fOPxFWmVzvxuyDpeBf6Imnx9K0u1N2J3Yczjq8XM70wLkJFM7H3Z26MjJOr
         S/12jmpu7j8x5h9LwOePSYbPaR6ggHqFA5Myfkak=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012130139.GA10386@gmail.com>
References: <20191012130139.GA10386@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012130139.GA10386@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: be59d57f98065af0b8472f66a0a969207b168680
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b4e40c8fe1e120fef93985de7ff6a97fe9e7dd3
Message-Id: <157091970525.17047.18085630474579119447.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-efi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 15:01:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b4e40c8fe1e120fef93985de7ff6a97fe9e7dd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
