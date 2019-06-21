Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8983C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CD3208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561156507;
	bh=cOjZ5Vxa/1brXWo6D4pO6dasI063MAt+CmGb22YIA3w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=C9MfcZ9s8CdclWE+ZOknFapvheDj2eXfhK1+9xPLU6wEjHPNLUJo6isfrnTCAcKOm
	 WIi0W1MXDOICXHtXjkd4LiX7DVLu+U0pZf6ZOCi1zAUvpiR4xXG1f/YsZx9ZycBR1w
	 86oP5t//zvkCYdGVvec7kwtCQCwWh690BT/v9P/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFUWfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 18:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfFUWfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 18:35:05 -0400
Subject: Re: [PULL REQUEST] Please pull rdma.git
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561156505;
        bh=cOjZ5Vxa/1brXWo6D4pO6dasI063MAt+CmGb22YIA3w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lrjlYwR5uZ0h1ZSck6Fe5afZQY2DVhYz3CmT/rmrM67UXRoMKT6zmn19qhEXqAK+H
         qnUAAJvkGsbeqj7xetYJo6+pjclPvItoyu7Dhv31PHmzvlLfDVanfkA0vEtgC3lmBZ
         6eS4UbG8DmFW4cfy1JMF6FdNyhZ20kMe5BqJRBII=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3ed43fc8399c5b8efa262699a1d3559cbe41fed5.camel@redhat.com>
References: <3ed43fc8399c5b8efa262699a1d3559cbe41fed5.camel@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3ed43fc8399c5b8efa262699a1d3559cbe41fed5.camel@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 7a5834e456f7fb3eca9b63af2a6bc7f460ae482f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 121bddf39a8e39baf0df9ef1d688392c179935cd
Message-Id: <156115650496.19817.5999188001035010719.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jun 2019 22:35:04 +0000
To:     Doug Ledford <dledford@redhat.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jun 2019 15:42:09 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/121bddf39a8e39baf0df9ef1d688392c179935cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
