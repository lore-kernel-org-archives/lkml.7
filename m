Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB9C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DA9217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557509717;
	bh=Vy6xQGylcbxiGbM+ApIXen4eTGPQocx7PLEXHm0BHp0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=K2/FdmlRRv8gTf4KySnCLLjmYaQZ6cobo7C3sy6Ekpyz5USgPAYq03ppCIv4XfbQT
	 zahtjTrraZwG95kBJwEuRzB2NZ1K+OYqU6XvAPhwmGclWgjqe/pMhaUWyplX7LU8io
	 pSv3gmHUpznfztj6Q/qqk+1EoavzuaVBELNSKxTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfEJRfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfEJRfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:35:15 -0400
Subject: Re: [GIT PULL] pwm: Changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557509714;
        bh=Vy6xQGylcbxiGbM+ApIXen4eTGPQocx7PLEXHm0BHp0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CAPLDetF9wGqdXUddtPdskx+F5J+uWwHe3jyVMlduXFiW/o0X+BNMQcTw/EKM3HPr
         CCR5Nld5JLcI47zXq+BEmSRiQdpBlBDwzdKRPUqo7kUKDOcN91/bxyqn9mnfysrtww
         jVLONX4C4EwGLbi7a2coFgx9D8F9T2FU/wli3J8k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190510111203.14436-1-thierry.reding@gmail.com>
References: <20190510111203.14436-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190510111203.14436-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.2-rc1
X-PR-Tracked-Commit-Id: f41efceb46e697a750e93c19e4579dc50697effe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cece6460c24386d15503ad4e07f740a88f3c8403
Message-Id: <155750971442.27249.17384710804023485623.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 17:35:14 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 13:12:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cece6460c24386d15503ad4e07f740a88f3c8403

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
