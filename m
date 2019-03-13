Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DDCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BCE2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552495817;
	bh=eAdn95cCqjaeFLQ0TI34rqGTA70dQ1KID/+McbH4CE8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kNQNfIA/cgoPgD9Q6+WeSPxxZg+FbU01D6SNZpzFkLi5MnEGuBWumYqA/Hm01WiHW
	 bj1r4hAOPzYIn5vO6ui6En0gKmmBl6n4CcENvDGhHWHzy32DNwo6+ePE2RVWjG08Rs
	 +HyXA54llnGEyjg/oJ5ykisruU8+r6DfORUWuq8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCMQuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfCMQuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:50:15 -0400
Subject: Re: [GIT PULL] libnvdimm updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552495815;
        bh=eAdn95cCqjaeFLQ0TI34rqGTA70dQ1KID/+McbH4CE8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U4xqlsBTS+zE4G7uVI9loJnYDal6yw5WiQ1v48E115TLRBzIjHTOD7M9UNRmecuWs
         dMBx747UMNeBu6/CtdR5qfZJ10VSXBz64AK/zwfqxmhhEieSqOmbH5UB75s20T50aR
         Yc3aAUzJbbY3F8X/FnKQ87T9rqXy5mYGuSa1rgUE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4hPv7b1FWUxuDvcx8+kFWh7Npgk92P+SEpSPWvT2cxheg@mail.gmail.com>
References: <CAPcyv4hPv7b1FWUxuDvcx8+kFWh7Npgk92P+SEpSPWvT2cxheg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4hPv7b1FWUxuDvcx8+kFWh7Npgk92P+SEpSPWvT2cxheg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.1
X-PR-Tracked-Commit-Id: 4083014e32699af04a8e6eaa4855b08dba36a47a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ea6718b1f1bb58825426e19a21cdba47075a954
Message-Id: <155249581531.9487.8832163781314389778.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Mar 2019 16:50:15 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Mar 2019 14:54:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ea6718b1f1bb58825426e19a21cdba47075a954

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
