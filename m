Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4781DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7342084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571912709;
	bh=trat/hM1iZw7v3j4+QzkKNY15YvQW3URoaxVJwxQYb0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CWHQ8HFTVgUBItrEn6Wrf82J7c6LF1DHTonlqkTXqfTbcbO3BmR3ipEv/8tU9LW/j
	 FGR8eHOKQEo+JGaCVTxkZfPfm88HqAEjawPm1si+iotpK4ssSP3vOa9wsBNCs6/SaU
	 I3+KQQSLc7Mad2elvXSH60t1PJqsKWY2UzdS68Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409069AbfJXKZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405702AbfJXKZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:25:07 -0400
Subject: Re: [GIT PULL] regulator fixes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571912707;
        bh=trat/hM1iZw7v3j4+QzkKNY15YvQW3URoaxVJwxQYb0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iLSUeP4Nzm5di0w5UjVX3CpUHiBfTFMGf/JBDc5mqUzGV5dcnQE+Qeu9gJdXozA3T
         8YMgDhAqyqEX4AwTpRggTV0K1KbOyKEDTPK5OQySsvAYcp5JHQf0qmtsossWSeau1C
         vjtjjC7UliiWTdk93BbdvH2gw0+vrO/R2T9XFxuE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191023164131.GJ5723@sirena.co.uk>
References: <20191023164131.GJ5723@sirena.co.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191023164131.GJ5723@sirena.co.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-fix-v5.4-rc4
X-PR-Tracked-Commit-Id: 77fd66c9ff3e992718a79fa6407148935d34b50f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: deed1d44699135e5af7678442607469d14a92141
Message-Id: <157191270707.16083.4149543236217077906.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 10:25:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Oct 2019 17:41:31 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/deed1d44699135e5af7678442607469d14a92141

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
