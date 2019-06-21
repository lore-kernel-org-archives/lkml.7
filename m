Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6CCC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DA121530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561137908;
	bh=WJfaQHHTtyAG58jD/On+knb225KjDgZSrOCP4affZBI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b7e8wwa9ru5g4+WkhWMJNZ4NMHLTO+WNJfkDYCrh5GfkDWFD/tlYcxv9WWoIdPOmn
	 3hIaoPhXGLlMbUihxz/yNz1harM2M/54S2aREEZ1z7aAxeV+dKdp2ApZuH7eJnS7tJ
	 B/5yyj430NcCFv5oPGT/1empL79OCi0lR/EV4vHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFURZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFURZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:25:06 -0400
Subject: Re: [GIT PULL] SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561137905;
        bh=WJfaQHHTtyAG58jD/On+knb225KjDgZSrOCP4affZBI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2F0O1hG3XuCHJ4Ow0an69ruH6fAiFgzDJfthJQ8jBNDjtVSI6hCP14Z7+iDa7g8D1
         hZeZcqIzxTHRRAyVNuZsU9KnJaQdIpUx2KDHmtjWLTBeG4OwEnrMRC7BhFRsTzArxy
         Bq5QVSkqBH6kunplTC4yP8ynd2rkS5rwdlTYfysU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mumke0cYEdt3nCsmWmqgUcShYFMy6UacMnAuKcER4RNSQ@mail.gmail.com>
References: <CAH2r5mumke0cYEdt3nCsmWmqgUcShYFMy6UacMnAuKcER4RNSQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mumke0cYEdt3nCsmWmqgUcShYFMy6UacMnAuKcER4RNSQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.2-rc5-smb3-fixes
X-PR-Tracked-Commit-Id: 61cabc7b0a5cf0d3c532cfa96594c801743fe7f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05512b0f46526c4e248b1da9386d73a84b7d327b
Message-Id: <156113790569.2072.11730292495415983203.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jun 2019 17:25:05 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jun 2019 21:02:17 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.2-rc5-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05512b0f46526c4e248b1da9386d73a84b7d327b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
