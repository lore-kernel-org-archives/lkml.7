Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1DBC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674FA206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552161305;
	bh=0u51msjJriODVyFixvgKHW/sph8xM6W+1sfIyM9McHM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PhOpuP+lZ6xyA7RX/2kVblHs5jcPa+rLUM50q1qG3IJHe3PLz9uU13ed213g4UshF
	 H4/rsi0jsnry6BlfF0XH8RcRAPFETQJMgVrabVjUG9X0O4w4c3hwHGDFBSPKr+4XDR
	 TvGw+mWL9RVSa+0io1/eHBUKQIa2L/pxTOkKBLhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfCITzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfCITzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:55:03 -0500
Subject: Re: [GIT PULL] fscrypt updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552161302;
        bh=0u51msjJriODVyFixvgKHW/sph8xM6W+1sfIyM9McHM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fbtLgBFyBt8EXRum12vnUQ6SIINT0vbwYdRs0VT0s0Yn+tGl7+zvu5H+ExvBAL0Lv
         Nf0M26o+fb8CAPP/gPxpxrI/oDuIc63Z2pT2L6tKOc/6zc5uLhDD/G9biOavmsRs5u
         kGdPYS1b9t6aH0EgxHIHKX4DNQFF7lv847pWiNiw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190304214721.GA215807@gmail.com>
References: <20190304214721.GA215807@gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190304214721.GA215807@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 129ca2d2a83f44551e73a408fa5e75a7b5169abb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1cae94871330cb9f5fdcea34529abf7917e682e
Message-Id: <155216130292.23333.6899385660355512232.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Mar 2019 19:55:02 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Mar 2019 13:47:22 -0800:

> git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1cae94871330cb9f5fdcea34529abf7917e682e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
