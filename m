Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84587C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3D5214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560970809;
	bh=ZgZVTjeTzTGUzg2AGgT3SEiXGd4PdCUPlIAf6oTehhs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Bza/Dk94B8TbcSedoxdy8lwzOSbwx/qpvKx1x6rTwXlIhfbfVNknz4lwrie6nV9GV
	 cKkIP4wXyk49q1umm+6+w9iwRNBKP/iuL7CpF0Oye4+jIQl9RAlvm179LwK7KL/Oq1
	 Nw5tTpUF1sLJkVjcQZzWYnPYlD9E8HxuhbZvCKpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfFSTAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfFSTAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:00:07 -0400
Subject: Re: [git pull] Input updates for v5.2-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560970806;
        bh=ZgZVTjeTzTGUzg2AGgT3SEiXGd4PdCUPlIAf6oTehhs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RPfXO8sHQ4RBTqg4zrrMghCa+g1hX1jjXLeoISgRBrUmxM3IuEcP5H+3R8rn0/xY5
         tzgIgSdrHTGJfD/g8NXlbqnOixFTpRhWPLF9yNTy2VO4cqrSKeH8oi4Pbufj5CFeBY
         ACJN7D5HKlofCQ95X4rN13e0VXWKpUBZC1HhEqsI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190619001640.GA62849@dtor-ws>
References: <20190619001640.GA62849@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190619001640.GA62849@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 9843f3e08e2144724be7148e08d77a195dea257a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b6920ba26e1f24b949b9ca3bb782c7fac8be633
Message-Id: <156097080658.11094.10153677521407620995.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Jun 2019 19:00:06 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jun 2019 17:16:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b6920ba26e1f24b949b9ca3bb782c7fac8be633

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
