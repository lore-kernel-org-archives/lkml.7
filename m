Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44184C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CAD20665
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576954519;
	bh=2T2FA1FjM6mGatVfejr1quAyRmsUT2sB/23Ev7hQrBE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kpWAt1WorP825qr37HgyZn2SxMnwbW/F2GzSdWxRcAyx0l/QeoO/DT1kwun7CZXam
	 SPEF5YbotxWVxRn5p94dQp3oo6so+k9zdhyoMYagG3AEh1NIcd2yY24eYiEhXGwBtX
	 fk+uZI1zRNeefx/AM9oi/0oo9bBh6/DbQ2ftBlc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLUSzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 13:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfLUSzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 13:55:10 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576954510;
        bh=2T2FA1FjM6mGatVfejr1quAyRmsUT2sB/23Ev7hQrBE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AVBcJgYdEArV7PVWnG1cjarDgVGNIPwvNyx6HxzAGenhkLoDw6u6dihq8x9LFFBVN
         T1bHSMlDiP1c27LpQHT1DdOtCXUUTXCXxv4zv5/NIp0P4NcJOp8B3XU3ObuJYNpNsN
         E+OVVRSmQlGGVz+ekJKHkAbUusb0AWEbxlhUFVlU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191221161624.GA130017@gmail.com>
References: <20191221161624.GA130017@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191221161624.GA130017@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 9f0bff1180efc9ea988fed3fd93da7647151ac8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4ff10efe8e487cd35f4475ed2dd1e5e0c6f784a
Message-Id: <157695451016.26122.9178391118315311913.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 18:55:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 17:16:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4ff10efe8e487cd35f4475ed2dd1e5e0c6f784a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
