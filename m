Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3937AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091B421871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554508214;
	bh=u3P4tk1kvMghjUHx88TH8Usa4r9gAwWAha6tlz56KsA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dPpENHgtm/NmBsd5eukXzQF2Ln2kbCnuR4CHOZGYDkh6KhLtjr4qqS2PzoMqeXx2A
	 DBeYXNpoErTDd7LJ1djoXMKk/jK6wjEtunfS/YJk36/D5pcQGzxkxAwaVUUAnKoUIi
	 RgUSoQjaogkto6GSG8OIqxygMYDLQAVHAVz/1UYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDEXuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfDEXuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 19:50:07 -0400
Subject: Re: [GIT PULL] tracing/syscalls: Remove args i and n from
 syscall_get_arguments()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554508207;
        bh=u3P4tk1kvMghjUHx88TH8Usa4r9gAwWAha6tlz56KsA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Prb93HlEMEuzcLEq9LLGPDErx4xR4SaPcM82hoq/3T0rMEQBvahURCQCIUZAUOQS1
         mnpfJpGPEvXgnnl36ovEsYNg7IPn2zqZ9EPQzTTvl2dAcjN9cVc6S05euTFHyLaeZF
         zM3hYVFjFlZL3vBqvUzhGmf5pGvOBOYqit9/YyoM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190405101832.1273bfac@gandalf.local.home>
References: <20190405101832.1273bfac@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190405101832.1273bfac@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-5.1-rc3
X-PR-Tracked-Commit-Id: 32d92586629a8b3637a3c9361709818e25f327ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 970b766cfd3f3cb7275bf51144b1678c547882fc
Message-Id: <155450820724.23520.4400725686653324143.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Apr 2019 23:50:07 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Palmer Dabbelt <palmer@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Apr 2019 10:18:32 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/970b766cfd3f3cb7275bf51144b1678c547882fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
