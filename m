Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A200CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB612184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553788513;
	bh=UeeV7UF9l3/umB/w5Xot7jX/Y25PIWuh93EB+C2/uVA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GXcd0yGKj9JgblbcUpmVNfE8hUOLb8bLM4Vms044jjHjqQ9NNAbwFOgbubF4pOwMI
	 Ge5sBxMiJRT+N4WvCmMtn708Y+y3QSvQg+bzi4m47eB0BAR8EUpiCXNO5A10iJga5n
	 gDgVRpfqxSxRAsulGacZFzyEVQzM2XZouuLKFd8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfC1PzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfC1PzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:55:11 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553788511;
        bh=UeeV7UF9l3/umB/w5Xot7jX/Y25PIWuh93EB+C2/uVA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qshrpRfjj6OvYdcJZ9x42luX+9VPKXla28AHauCcWHuvgMrbDDtd1aeIJYthr2EmE
         hnjzrOwJY5SMtlX/ndNG6qNaze6qI/Z3yKrWNgVyKqAgzUixEFZjm0R9XytpBMyD9s
         aiF9LnN7mMJ1syBpB1HeIyEonIoR4Mungdy0o+5c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1veuKq=3QNY-UrvpsK3RPCVNjf-uS+bwpyJzQfeXs-rA@mail.gmail.com>
References: <CAK8P3a1veuKq=3QNY-UrvpsK3RPCVNjf-uS+bwpyJzQfeXs-rA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1veuKq=3QNY-UrvpsK3RPCVNjf-uS+bwpyJzQfeXs-rA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 93958742192e7956d05989836ada9071f9ffe42e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97c41a6bdce506bad1cce623378656a5cb956a18
Message-Id: <155378851128.26949.4787806972246794563.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Mar 2019 15:55:11 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Mar 2019 11:03:04 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97c41a6bdce506bad1cce623378656a5cb956a18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
