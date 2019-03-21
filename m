Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC7AC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05827218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553195113;
	bh=DkDvkqEhfd5viJFU8IfwF1dub0RghZ4OiOKZowabRn4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nHf4vdr2ceBzuCm8aO4nU7Ff4CTkM0iR9uoB/KaqZtmcnkWVsGe6VGdhpt/uKPhGQ
	 MchyQQiWamnRJu5eTfChgNcb9GNZ/Kj41m7yG1y/HawJ5qL0bSUxo2Acplms9QyOhj
	 Z7+Yekk4GedJKSD5Zgtx11/QAa8VeUULd5ey6qKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfCUTFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfCUTFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:05:11 -0400
Subject: Re: [GIT PULL] SELinux fixes for v5.1 (#2)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553195111;
        bh=DkDvkqEhfd5viJFU8IfwF1dub0RghZ4OiOKZowabRn4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r8giptS4XklnAfHflSYo1E/efGnsf+UXzK8nmLU2774s2TN4d/YByVIDJgqu8cOKP
         bXiMdvIios6mePf72U2YkTuuiUNJw4Coj9M/iHA2yPQ8YU/JjZ3pavSueLMVyULRrw
         c2rxk53LODRRM1ikINlRJrGv5ZEnCW1bwldlqfg0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRoo4_A0fg+Gp-Qsn_XVkTOQhe1pUShGig-k3ELKeW7XQ@mail.gmail.com>
References: <CAHC9VhRoo4_A0fg+Gp-Qsn_XVkTOQhe1pUShGig-k3ELKeW7XQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRoo4_A0fg+Gp-Qsn_XVkTOQhe1pUShGig-k3ELKeW7XQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190321
X-PR-Tracked-Commit-Id: 6a1afffb08ce5f9fb9ccc20f7ab24846c0142984
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb549c55475bbd6e34325005681d7801d9d6f6bd
Message-Id: <155319511109.18000.1867378123417599113.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Mar 2019 19:05:11 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Mar 2019 10:09:24 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190321

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb549c55475bbd6e34325005681d7801d9d6f6bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
