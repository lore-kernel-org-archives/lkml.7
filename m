Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F13C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEA420748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573839310;
	bh=jnMB+9w/3Ip4sGA7Es+dzbI1sH9Fw+W6VDhSB9RCOXM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aepKMkR/NQCORNF6sc/nwCgFhfU8tn4myNIg1W8KVnPZOYHk+tmC50FiDxQnY0OGQ
	 Is16SAyajhe11MdIjFt1k06CvmXKqs1So8qiN2uFbjOthIAMhv7oXqGZOF5wde24Sz
	 RZ0jMxVSkK4UtDevQ/4+JQVCAZHayz5xrLwGX36w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfKORfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfKORfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:35:07 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.4-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573839307;
        bh=jnMB+9w/3Ip4sGA7Es+dzbI1sH9Fw+W6VDhSB9RCOXM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JoGST3XUz0Axrt+vgK0yEkOE1AN6c0PF4hat7kov0gHJqaU8+U7W+1Ks09S+CkbCu
         DJmMW9pcxvrfnS8r2UjPDqv66h6lxSpB59f0Wp/qFId9NHh6aivfmwz5ZZipJyGfbo
         aItCSkz8k9HdTz9l6fXkvGZkURI5yx6DOcC0ir/I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191115081252.20154-1-ulf.hansson@linaro.org>
References: <20191115081252.20154-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191115081252.20154-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc7
X-PR-Tracked-Commit-Id: fed23c5829ecab4ddc712d7b0046e59610ca3ba4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b675f7362ba9debfd6c3e38edda197b35a29f0f
Message-Id: <157383930707.31249.15471620871269233171.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Nov 2019 17:35:07 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Nov 2019 09:12:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b675f7362ba9debfd6c3e38edda197b35a29f0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
