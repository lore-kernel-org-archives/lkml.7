Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5646C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 21:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8025420896
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554587711;
	bh=vQGHdZSIG7KaFTmFkE9xM1r1hv3EXOoM6oZvzk2StnQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V4lbPJ0KoC1etjnYVfhe9UUxFHNtuQbW7bgA30vJyaXRIb3kZKl64N06qkVKJU3QF
	 7vXBZjzu8ZLEk+e0okaM+RwqKi14liykpcok/JEtf/KMX2mT5VoE1+QbUf17a5rlB5
	 Hfl0S7eCWApYRanR1pAT74xhiPOR1ubQ4jAHeqfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDFVzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 17:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfDFVzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 17:55:07 -0400
Subject: Re: [PULL REQUEST] i2c for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554587706;
        bh=vQGHdZSIG7KaFTmFkE9xM1r1hv3EXOoM6oZvzk2StnQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Tlv9wYCtSIk6aHTCZ3O87Q35d2FAAUnuVJ8aWlLSM04Y6xoqhQKT9TnGt6jmwB9PE
         7VN71sYdKhOnUi1bSnNgnG/BB7PJF+QnKQWKWrAZN6Xt0PhN1f0zp3ZHckZNO/rhtD
         I+ifpbLbrvygfwYestum3rWVcAK7PjB9ZvCIsmtc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190406213039.GA8502@kunai>
References: <20190406213039.GA8502@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190406213039.GA8502@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 i2c/for-current-fixed
X-PR-Tracked-Commit-Id: 3ace6891ce8bb9e1267358cb58f93b4fd8b72b69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: faac51ddac4575880f20e5c70fa1d50401dd940a
Message-Id: <155458770652.7219.5087610305029684790.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Apr 2019 21:55:06 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Apr 2019 23:30:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/faac51ddac4575880f20e5c70fa1d50401dd940a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
