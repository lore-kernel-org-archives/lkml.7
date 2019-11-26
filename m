Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B682EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7F320836
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796632;
	bh=zV/qFJ8LbkYg4KxajLHIUU6iEpef37n4wLjSsxRyhDM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bFSprlQfU0lHR/o69YcltrhscTl1NB+QKx7QLjU+p2eRAoTPT6j4aXzBvUvWLM1wA
	 SIhrHIK0jUav2E/9RT+rsR8oL7V847+nLFVe43+ztzjDvzxZ0kURZvDJG146o94FNC
	 YoghNbtK6SZfbuglgoZF/HQ/3oY7dIkCdUbcDnyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfKZTaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfKZTaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:24 -0500
Subject: Re: [GIT PULL] x86/iopl changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796624;
        bh=zV/qFJ8LbkYg4KxajLHIUU6iEpef37n4wLjSsxRyhDM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LumiMXD0QEBuzLki3xLdniz7c2yop9dRA2qecz5KbzNKQFAXpvhtYMLlT4KdLXSdD
         GP71QBdN+PMXu6Ku6fkmGgC0/YhseLUc9arorw6C/cj/wv7Fl0L7gdaJ1GvZ+mxRHX
         hcQC4/bLHF1uZcvkvkUqgWKW+H0zakzdEVPm8Etc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125161626.GA956@gmail.com>
References: <20191125161626.GA956@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125161626.GA956@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-iopl-for-linus
X-PR-Tracked-Commit-Id: e3cb0c7102f04c83bf1a7cb1d052e92749310b46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab851d49f6bfc781edd8bd44c72ec1e49211670b
Message-Id: <157479662409.2359.1611643917689966549.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 17:16:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-iopl-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab851d49f6bfc781edd8bd44c72ec1e49211670b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
