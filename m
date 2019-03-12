Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D7A2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552429205;
	bh=M0fOMWYASKb7F6SSDWFE3P0KtJBUjeyjXtdWcNx+tFw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xjRXGgDq5cMAAdb4HMZN+psxjg0r9YYSDBa9/y9sq1Q+FS4syVxNjpH50ttikAedx
	 zl6Bbr6HDb4ky9BQPKZ65Q0U70QpsG3w50JCeTWlAH7+poSsaCXuFCd6dYzzEG3KpK
	 OPt8i6WXR7i5/IZ3x3WPJpIF3IbjJetn6f/eVdfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfCLWUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfCLWUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:20:03 -0400
Subject: Re: [GIT PULL] Please pull NFS client updates for Linux 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552429202;
        bh=M0fOMWYASKb7F6SSDWFE3P0KtJBUjeyjXtdWcNx+tFw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xh+u8bNFiXnX5T0QS9cQaDEY/zpcKw9Fr525unQOv2q+nzWQ0+OwtW4dulB1uwSEE
         y9g7ZN3xIlIsBY98ULY6BH86mX1AqkA7EGjN9WmSBXCwDzW0kDuU+IMyG3wSrN8QMz
         45qBdnJZHaDLNrMpKj7tQyOreLsfCEspuBmB0Bn0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <96ed9b50bba1d5d2929f42f41109e122d6aac5e9.camel@hammerspace.com>
References: <96ed9b50bba1d5d2929f42f41109e122d6aac5e9.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <96ed9b50bba1d5d2929f42f41109e122d6aac5e9.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
 tags/nfs-for-5.1-1
X-PR-Tracked-Commit-Id: 4d6c671ace569d4b0d3f8d92ab3aef18a5d166bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fbf3e48123d701584bc75ccac67ef2fe412ac4c
Message-Id: <155242920257.11942.17914469869639564742.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Mar 2019 22:20:02 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Mar 2019 11:46:27 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fbf3e48123d701584bc75ccac67ef2fe412ac4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
