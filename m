Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E509C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD7220989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557377114;
	bh=a7wKrk/+U9dYpikcCuxOvvoT8wtcA2tPgI+RJ3LIVzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rCfcRfw8jfWuDpHfByg/OzgmwY2jZqAtdnZo7kuSpq7dbJCKyl6bzf/qtj1Lr0KaF
	 6WJisggbK2q2DeU/gDqfLd+A10/t7V8w4zd7DB6GHh66yLadgsOZfEU+BgYZpd1LRA
	 mSlVDJkoBOBqs5CUWB7i3+LBJiR6XmPdiA+HbDBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfEIEpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 00:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfEIEpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 00:45:12 -0400
Subject: Re: [GIT] IDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557377111;
        bh=a7wKrk/+U9dYpikcCuxOvvoT8wtcA2tPgI+RJ3LIVzc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jFFNmVrI6pyZzZA+p1qB2RFNDbMh26iR85GLe74/KJSxsjDoUnOe25oARS0EuoRLP
         q01PsHSOta0rZBb5kNTI+xarfOp7RIMLBCxLKekMpv3VpHi8OCfabRssxgBEVJE+kt
         t53axMymmLOcm1IZanZBwjWimROVULSetqzsWT5Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190508.165320.2267661705586017777.davem@davemloft.net>
References: <20190508.165320.2267661705586017777.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190508.165320.2267661705586017777.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
 refs/heads/master
X-PR-Tracked-Commit-Id: 7ad19a99ad431b5cae005c30b09096517058e84e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89c3b37af87ec183b666d83428cb28cc421671a6
Message-Id: <155737711172.32092.7824293216957147097.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 04:45:11 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 08 May 2019 16:53:20 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89c3b37af87ec183b666d83428cb28cc421671a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
