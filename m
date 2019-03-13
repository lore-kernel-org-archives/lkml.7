Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F9FC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FEE2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552497025;
	bh=lKX2+KokHkXD7+WKOR98e/2DLyemVOYXoNQplzv4mHc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pZiWppD0B4Cajftl01F1PvhTs2chJEtQPlF/9I+ImNPLE3xIjvCE31roUb8rlMf42
	 zO5kJ0EIVay7X1pFBY4DJ8OaUgW3TlsD3OcPBTYgeQIPNtz0Q2gkLAqq7bJngRrZTo
	 ykSW+cfM5BO+JqMq8mGoyzuhAUr9fcV7sMXpNlp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCMRKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfCMRKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:10:18 -0400
Subject: Re: [GIT PULL] pwm: Changes for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552497017;
        bh=lKX2+KokHkXD7+WKOR98e/2DLyemVOYXoNQplzv4mHc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jvNWrr0t/XqTpzLgCvt0pUf7wjvVDHT/tUo7plMY3D6lmdcNNhxTuiVn2kWFPDD7O
         WbiWfCT3MPb0wdpWbGKV1C6RKcW6nw0hj+MY/jdZIACmpkvOlDn64vv6n6Xv/bPl8J
         eJlQAizoWRfw5HtKiuqreauV4z5cYdscfP5tiZXM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190313145118.21818-1-thierry.reding@gmail.com>
References: <20190313145118.21818-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190313145118.21818-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.1-rc1
X-PR-Tracked-Commit-Id: d7d96312fe108d0df50898d212770b0a5b2d491e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: add8462a60421ca1b03a6864e295d22de532a5e7
Message-Id: <155249701791.28396.12653606782831489104.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Mar 2019 17:10:17 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 13 Mar 2019 15:51:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/add8462a60421ca1b03a6864e295d22de532a5e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
