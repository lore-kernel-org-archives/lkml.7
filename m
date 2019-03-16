Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E6EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B155218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552758618;
	bh=Z/lvWcfUpxFt8Lfiovyw4C4Z/EpMYt5KSHuA7LJsOpw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Z9ZDp1qLE42CJVN6pl13Bh1NwqlGV1hCIPxXRhpgVR7+Kqs1t6osynVhsbMJF9kiX
	 sbaVH88WftP47tgWVsvIcFJGkjPPVrHDYaE6b5syn0QSKJm9Qfm3F+GGiwlojYZmgn
	 Ed+26wUEG+mwhKV5CCcTrTsjBjVRq62CZoI0twF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfCPRuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPRuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:50:16 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552758615;
        bh=Z/lvWcfUpxFt8Lfiovyw4C4Z/EpMYt5KSHuA7LJsOpw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F6IipztyHyVbXvLhqrtROSHP4z67TMAy9kgwZB+vP/xt6bxElVf27FEhwmMq5cu49
         wZ7JX4RYSyKgQs93Jd7VvJtSd89evXM9NpPAUTo5+abek2wlu6tNcXS5FHlw/0A+zj
         jyfu7IOikjddyf2M/4XfZcoCJ/WVSis/njpDRE0M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y35f6osv.fsf@concordia.ellerman.id.au>
References: <87y35f6osv.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y35f6osv.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.1-2
X-PR-Tracked-Commit-Id: de3c83c2fd2b87cf68214eda76dfa66989d78cb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9c55d58bc36b5a0ef7021772fc2508e693ed534
Message-Id: <155275861590.4422.2038912118529779484.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Mar 2019 17:50:15 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.ibm.com,
        joel@jms.id.au, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com,
        malat@debian.org, yanaijie@huawei.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Mar 2019 22:28:48 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9c55d58bc36b5a0ef7021772fc2508e693ed534

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
