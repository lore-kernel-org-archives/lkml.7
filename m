Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD6EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373D72077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552586147;
	bh=nm7bdOn6QATyZrZWmCHNpBch7/ZG7ETHgay23KlHf/U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qwm5XY3hUYrkNGNWlPpxn+xlgys+pvedvm4xZlvjuXZc4F45JkBNqO1XvLDmjcaL/
	 1EqdYvapEd+P9kqdX5vtdNEqTJm1sKWy1zW67v0SwY6mFTbEE/32AqmFOfY0aNPxzQ
	 m7hlRJBBDuiyHStAVzSNQhg8HLb1RkaswGnlMOFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfCNRzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfCNRzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:55:16 -0400
Subject: Re: [GIT PULL] remoteproc updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552586116;
        bh=nm7bdOn6QATyZrZWmCHNpBch7/ZG7ETHgay23KlHf/U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=keuLvC8wFgm3LLzZtuq2jRtK+GiizpEg2nafTR7tDtBUQZMbA9KdNQr7eNX8xnIDO
         Sn2r1c6JTt3ejyM2wH1xJ+/BgzFuOcFFj1QCScGBqq9tZPatMgHrMzUSWw392VOKwo
         ZEIBvhgn4TFFqgvtR30q0gVnFdjXnWZWc8qFcTMY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190313182942.GA8726@builder>
References: <20190313182942.GA8726@builder>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190313182942.GA8726@builder>
X-PR-Tracked-Remote: git://github.com/andersson/remoteproc tags/rproc-v5.1
X-PR-Tracked-Commit-Id: d664ce75ae1c7c1e0e3fd8fa71f7ca779906a9be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f194646fecaa9fd4607b670ee9ef84d9ed04566
Message-Id: <155258611644.11723.735318736963710451.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Mar 2019 17:55:16 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ramon Fried <ramon.fried@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Xiang Xiao <xiaoxiang781216@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 13 Mar 2019 11:29:42 -0700:

> git://github.com/andersson/remoteproc tags/rproc-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f194646fecaa9fd4607b670ee9ef84d9ed04566

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
