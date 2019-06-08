Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F0C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00DD214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560025221;
	bh=SawyKQrvpZkjmG+jgFjsO9xisT+l2LhWU+JmZk8zYaM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ugdAu89R3cYlbnS5RVlkY+1SUr5NGFpcHpO70f524/lC4lwi3JzfOLf9O8fB3xZPk
	 +ZHuc8X4jcf5V9fxeDfj3+iJkGmN/2ocSXFGrL5Zb+H7P6OzfGvFCjDpzvG3W0axgM
	 982tAd7U144wB7tos+Uia6tz/zxK7jxKLCmoRMNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfFHUUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 16:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbfFHUUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 16:20:18 -0400
Subject: Re: [GIT PULL] xen: fix for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560025217;
        bh=SawyKQrvpZkjmG+jgFjsO9xisT+l2LhWU+JmZk8zYaM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EXxsEqSnzkeOh4U/jj8Di135srtDbeK2o7SXUUw+1jTL9InJWW3VkJV7ihm7sc6c/
         9Mf6GaOjBcQ1AOOVom9xF6pH1FcbKOSxr5ATXWqepZqhd0gpz+5Ank6fO+2qJ5nE/8
         4+WRsRWkJWvLERNcUpA5WXaP21jnQ1meRwP66Ir8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190608114326.4804-1-jgross@suse.com>
References: <20190608114326.4804-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190608114326.4804-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.2b-rc4-tag
X-PR-Tracked-Commit-Id: 1d5c76e66433382a1e170d1d5845bb0fed7467aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e61f6f7c308a828f8402db6651f6e38ba66c009
Message-Id: <156002521752.8142.408797817200882108.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jun 2019 20:20:17 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  8 Jun 2019 13:43:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.2b-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e61f6f7c308a828f8402db6651f6e38ba66c009

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
