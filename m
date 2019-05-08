Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFAAC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F27320850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557291314;
	bh=RZZv8Z+8vzTN7CSY+CWRG1gv0zs/6ZX3a9s5gCH17sQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ywlh4tKGJ1UiN7M5wAGkHlkCjPnL39Bga3/G5OABRXYLx11r39IDCzlPmuXO2pILd
	 hxpqfZXRtA9JfUR+31E7NdS0joCvP+dMH3qtJl6BTqSDgwf+H8Ftu0d1KPZHdAxKu4
	 rvPde1InHMeyG7QcCSiD7iePoOJmiWhySrMMMdQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfEHEzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 00:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfEHEzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:55:07 -0400
Subject: Re: [git pull] vfs.git misc pieces
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557291306;
        bh=RZZv8Z+8vzTN7CSY+CWRG1gv0zs/6ZX3a9s5gCH17sQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HGai9Qd88VCATtse6fR02KKjEaE4KaAgbP9vKTrCpiOoEZh605JUE1/U2jtPeyDAk
         SEjswEPR7UbMC1CfH2+6rX/XHxjnAuzho/1+PicptYjJlpVF42zpxTB42Cs+qh9yn5
         554/gIUyOc8rXr14l1lH+BkToV/djiKGm/wRp5IQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507205319.GN23075@ZenIV.linux.org.uk>
References: <20190507205319.GN23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507205319.GN23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 6ee9706aa22e026f438caabb2982e5f78de2c82c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 149e703cb8bfcbdae46140b108bb6f7d2407df8f
Message-Id: <155729130686.10324.57160869690641491.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 04:55:06 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 21:53:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/149e703cb8bfcbdae46140b108bb6f7d2407df8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
