Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D02CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E8B218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575255040;
	bh=4wmDVoz/B+au5fCYnJjWlDzgVoBSXzzCWrwAfnWzI2I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CjHStfVnogtAqB5xnR1TfYimQEueFNooGnI8clRlbZbydmzzwqEtA/NYlX3FSGx7P
	 gcnYpBy322ZNUf8e1r7nU2pPG4OeYhKSfiAMizt47kfvhUTfjVyGqnj2j87bpcf4/3
	 ZplUofHCqauqxceAPeoKcGO4y5IuKi49evnryi40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLBCui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfLBCu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:50:28 -0500
Subject: Re: [GIT PULL] Mailbox changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575255028;
        bh=4wmDVoz/B+au5fCYnJjWlDzgVoBSXzzCWrwAfnWzI2I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mzi/gbOfVQJ3UyGxZMY8Yuaf8SKK2/5aQB7SVIHR6xVThucoPEXPDIRB8Df3qK4JV
         SaAVBNUmE0xE3cukeF5mtKtkEjJXhtsxn20E9vofT0U29qIlFu6XJXKAQex3lYc6lE
         YSIjtirV22qr8fvnwmnlejF803dlGwiStC55dV3Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY1dtWjRW4Wi3jX178Zyd+yNW_bGCwVm3DD4mNYz4ozd-A@mail.gmail.com>
References: <CABb+yY1dtWjRW4Wi3jX178Zyd+yNW_bGCwVm3DD4mNYz4ozd-A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY1dtWjRW4Wi3jX178Zyd+yNW_bGCwVm3DD4mNYz4ozd-A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-v5.5
X-PR-Tracked-Commit-Id: c6c6bc6ea9fce31baaca053befc31215cfcb3dd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43fd4bd72c85c1e8dac0f23dce16f0277791dcdd
Message-Id: <157525502822.1709.2747899209773989664.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:50:28 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Nov 2019 23:38:58 -0600:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43fd4bd72c85c1e8dac0f23dce16f0277791dcdd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
