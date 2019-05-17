Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002FCC04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB4320868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558052722;
	bh=McIpRs2wSDRc6VoR3FMzvT7sgEWNgCv8ej9oIMNSf8U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SIhE42HxWSGm8UhpTujSJrWBtMoNRX4k8yvo7B0to/S5VXEbPKODJsRCzatg1kmh+
	 uHa+Caq83HgrFMK2/nGIf9rx3XEWEDymgwY5dwSFzsjOEYCjyfwJmKizt/yELe5+xJ
	 3TwfW+HYFogwNqaSkX3AfFNJ8ZERKEiJYAJdvG70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfEQAZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 20:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfEQAZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 20:25:21 -0400
Subject: Re: [GIT PULL] Ceph updates for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558052720;
        bh=McIpRs2wSDRc6VoR3FMzvT7sgEWNgCv8ej9oIMNSf8U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CljhJlq4bckDDrk9wSxSwyhkgd2U9cChuB27VIP10l5nqTJQr162eFwXiN7Qctmk9
         6daqR/uq8Im+btCpjgXLMNaRSFkKsrkFM3BJXbLyXM848vvIifwDr5fU+Ch/VFc+HG
         M1a9zaYRx/zsm40IPXmLdn+B3z7/KDefB2/6f8/Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516154005.22583-1-idryomov@gmail.com>
References: <20190516154005.22583-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516154005.22583-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.2-rc1
X-PR-Tracked-Commit-Id: 00abf69dd24f4444d185982379c5cc3bb7b6d1fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d9d7cbf28a1c2f84f2a0224466f8eb5f0a62ace
Message-Id: <155805272075.4154.6587064893151214738.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 00:25:20 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 17:40:05 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d9d7cbf28a1c2f84f2a0224466f8eb5f0a62ace

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
