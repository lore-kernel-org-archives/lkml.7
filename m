Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF58AC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C58C2189F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563393619;
	bh=Q9kRT38hMns1v4WM95QpcopuTQyHgTZK9MdQffyAbV8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Sf1yaEcw1KcMPJWGh5cCuZTdoFd0Ai1/XJu2hS1bhElsJ8M+IOZMOGv29NJHq/fDU
	 WkzPLuqt/lH9/hLFoGmHFzGpQ+U6rs/mXRZvL22y1oJal4tZ2OCNDfAkXPb56SIQ65
	 b49UcEM6wZ5BWr2OpScAGI6CI1sqpMbDdXWUksEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfGQUAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfGQUAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:00:18 -0400
Subject: Re: [GIT PULL] rpmsg updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563393617;
        bh=Q9kRT38hMns1v4WM95QpcopuTQyHgTZK9MdQffyAbV8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W9Xi3D1iOZmYGUIsAin6PbGQfRpKJe+raReZVOaDYde/RSbr3Xpj8YAcXeFP615mU
         EPuxtYYAse2/2Dmh0408ii8CdC9hGmWfqCZOJ3IDiqijZ+g72DAYWQ8X2Kh7npRLit
         sLafAiY/9OdEo+9XTRDlJT7ClYimtjqF0jTRnaoE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190716190057.GA8572@tuxbook-pro>
References: <20190716190057.GA8572@tuxbook-pro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190716190057.GA8572@tuxbook-pro>
X-PR-Tracked-Remote: git://github.com/andersson/remoteproc tags/rpmsg-v5.3
X-PR-Tracked-Commit-Id: 54119bc1110dab2fa389f45c73a0787b8e037e8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7636b7589f81940c6d6518786f93de74495575fa
Message-Id: <156339361704.17916.14367426118609792845.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 20:00:17 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Jul 2019 12:00:57 -0700:

> git://github.com/andersson/remoteproc tags/rpmsg-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7636b7589f81940c6d6518786f93de74495575fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
