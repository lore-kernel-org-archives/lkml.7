Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EFEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6562A208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568928648;
	bh=xwTJV+Y4QUUFIQZHtZTx+jn5DYCuQ/XItTrEl7d2g7E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YsLoSE1zl8heGPA5BsZ0J2x2eV/wao2u8cTl9xp33Q38LpUl1a1IK4UpqvFQE+0Az
	 h7ImdQ+2n7UYbtvk6cjWFJLXy8k+7uUf84l9lUIDhvrZUXOLpuPYYJjBAp6gnYIdmT
	 8bs2rF7WbMDG5a5480zx/mT3HcK31mkzeB+I6Icw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393032AbfISVar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404830AbfISVad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:30:33 -0400
Subject: Re: [GIT PULL] IPMI bug fixes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568928632;
        bh=xwTJV+Y4QUUFIQZHtZTx+jn5DYCuQ/XItTrEl7d2g7E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GUZheCmpm3FTJ9R7olxeR+XZtT924872y8gK8KTN9dFnw5a2n4Kh7p8+sVzPY3Nwm
         0hIoA6ci7cT55YXia83kOQpyhzN/YeQjn4M7a7Ol+NwXhjPhhD0lUBUNYVL831yrWk
         PmO/3+XlpQxhk1S/02bicYGTTfBn9Gfaf778Tceg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919160807.GL13407@t560>
References: <20190919160807.GL13407@t560>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919160807.GL13407@t560>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.4-1
X-PR-Tracked-Commit-Id: c9acc3c4f8e42ae538aea7f418fddc16f257ba75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9f8b38a071b468276a243ea3ea5a0636e848cf2
Message-Id: <156892863274.30913.4363982565614390979.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 21:30:32 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 11:08:07 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9f8b38a071b468276a243ea3ea5a0636e848cf2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
