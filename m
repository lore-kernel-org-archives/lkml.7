Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B07C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC1120851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551983429;
	bh=UX1i2AXaWteYVYwuxRL9+5ZGn3uNTVc9vCRAF4CE1eM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e78yXR9VvnTEQxSayoTDi+TYFoW7BL9Ow9qm+qobelXS1KzrJohDu8FtuTmJLSW7l
	 oceObX6aZ482SGa8JhWE8w8UPjSRS+WFV9PGkWrwwPQdZS79c+r7w3+zp1qR35CtUw
	 yQ6XJVfWVPl2eO4tfLKG2k72fxOHBlFol7qdTtR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCGSaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfCGSaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:30:16 -0500
Subject: Re: [GIT PULL] workqueue changes for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551983415;
        bh=UX1i2AXaWteYVYwuxRL9+5ZGn3uNTVc9vCRAF4CE1eM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uybaVKEsrxzpXSN8w8sNSSKagbwZGVZaemU0+QSE+z3tkbyWLo869icDI68/dkwPf
         NRAkr6iLnDOQ9NSwGPNz8v5QQ+JPAQp+S50V8MCslMmh9dbgG9EKqUtJ3mXysBoJso
         yqd7VR6Kpfsv84W60tGHWAtnOr2hO+RZ38oG1GkE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306183257.GH50184@devbig004.ftw2.facebook.com>
References: <20190306183257.GH50184@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306183257.GH50184@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
 for-5.1
X-PR-Tracked-Commit-Id: bf393fd4a3c888e6d407968f461900481bd0c041
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abf7c3d8ddea3b43fe758590791878e1fd88ac47
Message-Id: <155198341583.27511.18079371904938504726.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 18:30:15 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 10:32:57 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abf7c3d8ddea3b43fe758590791878e1fd88ac47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
