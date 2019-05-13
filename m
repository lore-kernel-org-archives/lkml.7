Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2944BC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF87721019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557788119;
	bh=zoUDwhLvAd1vhaGU8kBKsxlklp/ynJ4RVpUUR8CYCX0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IhiYOzOMcVPTRKt7YqYHmZpLG8r8HgLWw2t0T9s6LK+zIfw1Q+oKlY7OIMnci0ruq
	 z9x93X2rQrjTdld5+Ig2t1zPA4pr04Cnt7MSycWSKBIN7GBlRKEVlBKYcExTxfuQ6y
	 0F/E0J8EwwvnenWa7ibGIiedKoUqosym9AU4915w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfEMWzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfEMWzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:55:16 -0400
Subject: Re: [GIT PULL] percpu changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557788115;
        bh=zoUDwhLvAd1vhaGU8kBKsxlklp/ynJ4RVpUUR8CYCX0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KyFd5GNJcWCd8uLj33Y8/HURKSkaKNmVgzqUOGuiThMNJ7NFnfPjFWziVUxw8TUcz
         5QPVZ2GhLw5TMrqMA/l2b/qKr3/+eIBQM1UKW6Z6BCW9Rpfx55qGqH2sRjQ2bW63Zx
         SqsegLhcxqbDzDzUyRphYbsVO/L1NqRixMGDUFis=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513185241.GA74787@dennisz-mbp>
References: <20190513185241.GA74787@dennisz-mbp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513185241.GA74787@dennisz-mbp>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.2
X-PR-Tracked-Commit-Id: 198790d9a3aeaef5792d33a560020861126edc22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3aff5fac54d722f363eac7db94536bffb55ca43f
Message-Id: <155778811588.1812.12003345020716870482.pr-tracker-bot@kernel.org>
Date:   Mon, 13 May 2019 22:55:15 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 14:52:41 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3aff5fac54d722f363eac7db94536bffb55ca43f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
