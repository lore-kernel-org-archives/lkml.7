Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22946C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0A4218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553900113;
	bh=C30dQuPQY6z/MIzuozVUNRbKpHIzjZdPMzW5q9bAi+U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tzzJnXA3JpsHxoM6tHf0iY3+OsFHOxqnXCI9HylftObDrfr50z//opqwiZ1sDB+7f
	 ZLqhN4A6GTyVFbC8q3CTSEJfIaE2kbBuwgNeiVwa1c+8gZH7DPd8N04O/+UXSLdYlD
	 9YPDzi50fZSMN6syQB0EjEM928gdCIB0ttgNYBCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfC2WzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730537AbfC2WzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:55:12 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553900111;
        bh=C30dQuPQY6z/MIzuozVUNRbKpHIzjZdPMzW5q9bAi+U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K01UHg+WjUMkvYMe4eRXlhz07udvjGc5yxVYoxZdju6zzhyw2JQPkUcLP4DQ+5oBj
         5w5AY49t01MCqgijxsEGRh9U+Uu2YngfctG9p445rejwqfXiAodu6bFVhrl6uKZQ1d
         5T+V7kcbzmCLibMQ6zurSntEbyXcEjbEN00ktlZo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190329162636.GA29901@8bytes.org>
References: <20190329162636.GA29901@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190329162636.GA29901@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.1-rc3
X-PR-Tracked-Commit-Id: 8aafaaf2212192012f5bae305bb31cdf7681d777
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0b7f2a5fb957f2d5429b603b1a131ed7c8b4a30
Message-Id: <155390011171.19491.14295145911465779412.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 22:55:11 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 17:26:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0b7f2a5fb957f2d5429b603b1a131ed7c8b4a30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
