Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAEBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1FC206DC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575336625;
	bh=2HHNi9jt2CEjhhglrUy3+GonDpvuMHpqSRE7j1QJELo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qDkobS3cozVrzGPOxmmNqr75VNrAZhJ6zgMI4Stzrl6fxCgooXU6z1jOR2Wn8X6Lc
	 pxE6n/sKR9p3Q1CHjGOh+kVAgLKS2II5iHuxsfgOs7QvqWTin+ZTGZ+ISustaVSsys
	 8bAsQtuKbbfzNSqemgqgMQz3uBcDWneOIOWfcuOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfLCBaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:32796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfLCBaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:30:21 -0500
Subject: Re: [GIT PULL] OpenRISC updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575336621;
        bh=2HHNi9jt2CEjhhglrUy3+GonDpvuMHpqSRE7j1QJELo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cTasfkY68100KpxSVud6QK7y2niwnJx7hq0+Mr+9bAhC8Sj93MdklSXh0diHTFVLd
         JobIScItUtpCFb5WRZoapw7XaaFlgE233QVUvvS6rV0osrIJJWtduMXtCNnVeg5wKB
         fwshiyOBgL2Agt9jQqA23RD6RYILK7CTzy+qnzIk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191202115510.GO24874@lianli.shorne-pla.net>
References: <20191202115510.GO24874@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191202115510.GO24874@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 0ecdcaa6d5e78649578ff32c37556a4140b64edf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 120e47686a00144ef1195cfc137645d1bed46d23
Message-Id: <157533662106.4888.4608498727365693870.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 01:30:21 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Dec 2019 20:55:10 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/120e47686a00144ef1195cfc137645d1bed46d23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
