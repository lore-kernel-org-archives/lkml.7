Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C8CC32793
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E603E2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569779428;
	bh=sLpBK98JGjYLJeeMKeMxZXtgz3IbLinnFUJWoo1RwjE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WlbRaofbigg40gonnB1Cn/agECohBcZo7jTO4VFvJxCyD2Qx4PBCN0Ke1WT89gcZQ
	 8vfLV7hbwAnJDnmzd3RHQ5HCFELdWbY1gDj5qlyejE1UXLV0Dj/rRluZOmsegJuMPM
	 UQBIWIgc2yqVikz3kCDgVNJG1TUHSrSRe0rukEjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfI2RuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbfI2RuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:50:24 -0400
Subject: Re: [GIT PULL] libnvdimm fixes for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569779423;
        bh=sLpBK98JGjYLJeeMKeMxZXtgz3IbLinnFUJWoo1RwjE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S2FmXA27bktlnMH3emqurNob0egawmtiVT06arsVQPs65bcvb6jDvRzV6tR2k1x4d
         TZxuckVZTADTqO73grBvrAdyjVEreHwvqdvQsViA5PEgxFS3eCY1zYAQ4Dcws6cIry
         jeAD7YNIQvWgz4CDWZnneUAoM3x5w7tvn5pfPVwY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jJjjkXXSYpYNC3y2r2YJrcSYw=tZ9p=KyA8BS46kfFuA@mail.gmail.com>
References: <CAPcyv4jJjjkXXSYpYNC3y2r2YJrcSYw=tZ9p=KyA8BS46kfFuA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jJjjkXXSYpYNC3y2r2YJrcSYw=tZ9p=KyA8BS46kfFuA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fixes-5.4-rc1
X-PR-Tracked-Commit-Id: 4c806b897d6075bfa5067e524fb058c57ab64e7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3c0e7b1fe1fc62bba5f591c4bc404eea96823b8
Message-Id: <156977942385.28081.14590936149544081114.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Sep 2019 17:50:23 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Sep 2019 18:44:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3c0e7b1fe1fc62bba5f591c4bc404eea96823b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
