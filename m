Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7064BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B612085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070199;
	bh=AWXZLvOvZnyiTri+mwqkysPE/3Pdn4XNg5sMsXCKTPg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ms0XC2NC3ucgEZY0X0XDP2u9XuorCScPQbRvSljHfij7qRIoO93U+N0O1yakvQB8O
	 jOnvdSArA1Bgr2175Muw7tL/PRXRb8iqkSnYB5MNjpZqlCTeXQ69BZ3Y11cd1TEvpx
	 S65Yz0/qFyq6zsRrhl0zUp7DwcobhMg9rsgWvhjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfCHSgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfCHSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:23 -0500
Subject: Re: [GIT PULL] hsi changes for hsi-5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070122;
        bh=AWXZLvOvZnyiTri+mwqkysPE/3Pdn4XNg5sMsXCKTPg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XGB2RVfIu3PfdvCfoQDNhpw+DN3jt3yYMTL2MdJ/nt4TLQns12TigmeOraAP7wHIW
         LvUxwBcTI/C2VDYUYujCUkd3NwmG8HJqtRUyw2mFe32gC9NvKzZ23zweIsHHr/K+T6
         URQ0absUaIX5P8dFian+5+MVL23U3JEA2fsCZ9N4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305220123.vxjgvbow2gcejxlw@earth.universe>
References: <20190305220123.vxjgvbow2gcejxlw@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305220123.vxjgvbow2gcejxlw@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git
 tags/hsi-for-5.1
X-PR-Tracked-Commit-Id: 1ff85bfa1614df6cacec780cd5922dc0b1c340c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7427e28688ed48b0a9484c4035f86e836d9787a2
Message-Id: <155207012264.7904.10410740145885460660.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:22 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 23:01:23 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7427e28688ed48b0a9484c4035f86e836d9787a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
