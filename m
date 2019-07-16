Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341C0C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099FD21738
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563251723;
	bh=bKqdpHWxT+TiiJERtZ0YmKsF4JvnVD0uSemmkoI7PHk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SKN07Xymfl9pxeycfNv/SmhaG7eDgj4NXr/CUwhFuBtegyCpgEzJ2V2nQw1D6nKMg
	 C6Y+jZlWAF9yBSe9rXp+vqzlvszkRlhuvctncCoSyrsh9Pqgb2dPtxEsKmn53FpUrl
	 bdIst3WXauE3a3YM6uW+dxNXoZZVc0dqCPCf7010=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbfGPEfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733198AbfGPEfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:35:21 -0400
Subject: Re: [GIT PULL] power-supply changes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563251720;
        bh=bKqdpHWxT+TiiJERtZ0YmKsF4JvnVD0uSemmkoI7PHk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n0j236Wzz7J9ywFaPQ0reAQ0ts019voK6JgarR/Epc4s9cauN17NL1++riw7l10cw
         EDlGUoGAp3Tuv3aBkkc9c5Gn9pxX9qQm5g719UL7BGURHV5NZ9IK/8M3Wfeyg8D+Nf
         fIl42ILEueRQckjS7dFG6EIQUlUQqtTzRyDqhRJY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190715194933.cq3cfz7g6j3mnbmc@earth.universe>
References: <20190715194933.cq3cfz7g6j3mnbmc@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190715194933.cq3cfz7g6j3mnbmc@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v5.3
X-PR-Tracked-Commit-Id: caa2b557841c8cedc1d4862cd31cf76ee940d105
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fe7b600a116187e10317d83fb56922c4ef6b76d
Message-Id: <156325172073.15429.16126501134617667212.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 04:35:20 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 21:49:33 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fe7b600a116187e10317d83fb56922c4ef6b76d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
