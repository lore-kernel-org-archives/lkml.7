Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AEBC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECEE21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563474632;
	bh=qZHMcMnRBTr/LKF9ulZ0FQG18lq34RDEgtPvWy2omN0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=n4UYTN854imXfMPbJ3GC63a9uI59PIIm4NQb/J/Pie3sdKiW+p66IOYdOS5+BqmNK
	 qkj1dUewE+bB+skQw4OFVhh5EHI0S+C9IuU0CD8h4ZPKXVJ+ZRGt21HOpkWD/RYV8T
	 d/xtpJFBnKZaaFDhWvMQxKpXd1yAZsWlr7DWfrVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391316AbfGRSab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391188AbfGRSaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:30:18 -0400
Subject: Re: [GIT PULL] Ceph updates for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563474617;
        bh=qZHMcMnRBTr/LKF9ulZ0FQG18lq34RDEgtPvWy2omN0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UNqIH+2dEtjY0pMu+XxRGarXfHVgfrxgCNbcDLHSrM6IjQFE2OhFdRYW8YgPFqqmb
         Y5pJl9aQVl7ru/7Hdv8b2xVbhStS2OEkRVr8VsymJQGA78ov6T74+bbUlWCBKSB8T/
         z+g2nIwcUbhSRceIR/Gg9qaUbPBwbyAM4XrkI9v0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190717112825.23829-1-idryomov@gmail.com>
References: <20190717112825.23829-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190717112825.23829-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.3-rc1
X-PR-Tracked-Commit-Id: d31d07b97a5e76f41e00eb81dcca740e84aa7782
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9b9c893048e9d308a833619f0866f1f52778cf5
Message-Id: <156347461755.12683.16079074350077877952.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 18:30:17 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Jul 2019 13:28:25 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9b9c893048e9d308a833619f0866f1f52778cf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
