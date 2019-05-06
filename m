Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A135C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3920835
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186043;
	bh=C3DxW0iM7YbgnkllOXTEU68bItN9PkZlWf+ubQ93Nc4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Nwg1e1cQES6GsoP0pck3fGY7Rbre2w26RZH9WMXN8jMeROgfXS4Pw2aSP7eyCT+4u
	 VzINZ771otEkmNE6DB6vI6YNuUq5smul/9H0hHtr384DmMCX1dhAhP0ihZplkoyRua
	 8Cxkas8/2UpKABTC5zMsZpm1xeDEzOC0jX4vmwjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfEFXkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfEFXkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:13 -0400
Subject: Re: [GIT PULL] x86/mm changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186012;
        bh=C3DxW0iM7YbgnkllOXTEU68bItN9PkZlWf+ubQ93Nc4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VvoUuoJXgjPln8vC2wcJQNJYYDcYizaJlnkxSlhsKq4EozVFds++ZcBtJYNaNhpHu
         N997LKC3NQV26c27S6KXO2R1AVIHrUE8mCa5xpvPyEngUZVUUvRSIpmbliaQvy/cDy
         HRPrhUL/Yry0tfwD+YJhNDZvoOvSa6UAJwqo3VjM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506104035.GA39266@gmail.com>
References: <20190506104035.GA39266@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506104035.GA39266@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus
X-PR-Tracked-Commit-Id: caa841360134f863987f2d4f77b8dc2fbb7596f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bc40e549aeea2de20fc571749de9bbfc099fb34
Message-Id: <155718601289.9113.11584977696832531909.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:40:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bc40e549aeea2de20fc571749de9bbfc099fb34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
