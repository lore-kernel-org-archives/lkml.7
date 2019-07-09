Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A81C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580102171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562642111;
	bh=kUCUIuuvcBdKnEGzrNhNOlf6e4V0XnVxsJjaK1hFxbI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vpqmE3BRDR8PW085ej9Jsd0paXZQLLGF0gtQjlicmFNJOo4FcAqbhOGaWEJA0uPKW
	 Ken3LxjCcSW66LEOqqA8r+fdYIPUxo7l/Bw9QmbX3pzRO6/34U/jH5J5MSu3LYFhXt
	 bN32sy+9NfjSqKI3jlQVjWCcMDw9tuIMSPm1xqkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfGIDPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbfGIDPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 23:15:07 -0400
Subject: Re: [GIT PULL] Audit patches for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562642106;
        bh=kUCUIuuvcBdKnEGzrNhNOlf6e4V0XnVxsJjaK1hFxbI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uvQkHgu3l/Ol/y/obZbi6XnmVTkkVtO+9DM6Hi8ezGRBl+53MNJNk3IuS51XGyzeH
         NQ3tx1rM+wrnBe6g/7lZLHx/Vue3K+lY0FxZ0MKS0OzBdFqySo59H2Xn5IgsXPQekw
         iCi/u7AxaPPCFxFXtglXgmXzEd0PvaYp9pD48zpk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQ7md3PmUkzv8DNL-RTrq_4r2sRzGjwwaT0ZS-CPOxGBw@mail.gmail.com>
References: <CAHC9VhQ7md3PmUkzv8DNL-RTrq_4r2sRzGjwwaT0ZS-CPOxGBw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQ7md3PmUkzv8DNL-RTrq_4r2sRzGjwwaT0ZS-CPOxGBw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20190702
X-PR-Tracked-Commit-Id: 839d05e413856bd686a33b59294d4e8238169320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61fc5771f5e729a2ce235af42f69c8506725e84a
Message-Id: <156264210680.2709.714753527819815674.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 03:15:06 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Jul 2019 13:28:33 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20190702

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61fc5771f5e729a2ce235af42f69c8506725e84a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
