Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F04C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC8120880
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575155128;
	bh=5hJM3lKegDFz7tztvw/2Xk/m4wcryOYeSfLekR5jvtQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WhpRN5DlSgGvCT0nN7jeHm+o0VFuY4//agxe/7x86eKaDM3J81OaIOqnulOVpM9WH
	 Dc86K3+QozFvmbHNwPFkc9KpKubXNYjr8kIzMbyNhtwXEZ8iEoSRrimSjv42e74xMX
	 CMu+KEU+fsF2qxgsEiX1p81k8+Z1+7lStG+5Jd9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfK3XF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 18:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfK3XFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 18:05:21 -0500
Subject: Re: [GIT PULL] RAS urgent for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575155121;
        bh=5hJM3lKegDFz7tztvw/2Xk/m4wcryOYeSfLekR5jvtQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Nl2FwzA+Y0ZWxkhpIjbpBvvSd5CHAWraNpQ5fttIynflV8FnUBn0A5pUVC0kv6SqC
         l/tbo2A+HLwXYY7p+JWDsMN+t8jZwB+6Xdfvd6bNP0mqyi1K/xhjQ+ZDfRVUFwh7g9
         c8Du0RIOugN0pE/nPj+h6eNQIcK8tnVD6Mb41Luo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191130184612.GA17459@zn.tnic>
References: <20191130184612.GA17459@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191130184612.GA17459@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 ras-urgent-for-linus
X-PR-Tracked-Commit-Id: 5a43b87b3c62ad149ba6e9d0d3e5c0e5da02a5ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fa91bfa9ba4060347c45673f8ee990a2a1d760e
Message-Id: <157515512126.27985.14802978774335184426.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 23:05:21 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Nov 2019 19:46:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fa91bfa9ba4060347c45673f8ee990a2a1d760e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
