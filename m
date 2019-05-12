Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C22C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 22:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1A520989
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 22:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557699915;
	bh=RC/SFlx7pUbr2aKhL4Qp9KVW6/GsSP/cHWqzfSXiEmM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nLilLXZZCoRRql3FCLmjbr9J265C34GF2R45UazRti6Nqk9WDdYeycgRYelHn9t2b
	 YREnME5ABa4ZTNlkXXDzMuat+w9xCRhm3uVom30LGx6EGBVU93TONqYO15xCcaZtG/
	 TebuAbAtF9Le5uF7peNJ9sJdX0+cf1r4CkmB+uwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfELWZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 18:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfELWZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 18:25:13 -0400
Subject: Re: [GIT PULL] UML changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557699913;
        bh=RC/SFlx7pUbr2aKhL4Qp9KVW6/GsSP/cHWqzfSXiEmM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OYlesAXjP5WgQ6rWpenReliwyxNAwioEGooqA8ISK+Y1W7Lrm47rwel6Mf66r2os6
         RVrLw3rgQ7ggOC9MUGwPqMwu44E+uYRFXB3rLdTppPggu3HN6gBCmGmjGEacB1Q0Tl
         9/7WAQtZ6PsJXYr3MRrPzgRt40H17LUtCbe/OQHg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1836274340.56055.1557697309728.JavaMail.zimbra@nod.at>
References: <1836274340.56055.1557697309728.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1836274340.56055.1557697309728.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.2-rc1
X-PR-Tracked-Commit-Id: 1987b1b8f9f17a06255877e7917d0bb5b5377774
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 983dfa4b6ee556563f7963348e4e2f97fc8a15b8
Message-Id: <155769991315.32032.11407094999268511120.pr-tracker-bot@kernel.org>
Date:   Sun, 12 May 2019 22:25:13 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 May 2019 23:41:49 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/983dfa4b6ee556563f7963348e4e2f97fc8a15b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
