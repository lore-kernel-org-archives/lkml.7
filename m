Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EBEC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE3221927
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576865721;
	bh=dMO6Gz3rK1orArIGzl2s0sDduo5Os8JtbIhNqO/3gEM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YYlCCdhTItslWvajzdJwp4ERB/SLxEibf/ptxPWrrxKvEfpZOU17x1CV8PXQKADmt
	 jTU6Qmu4RvhTFyiETXaGzZw1uoIUYKbXhuxfQc7viOo+NVdDh9L0GiyelJMyOmodc+
	 5e37r9UbViIw2/ECOSm4SGWkPfGe4sPkmH5TZJJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfLTSPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:15:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfLTSPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:15:12 -0500
Subject: Re: [GIT PULL] Staging driver fixes for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576865711;
        bh=dMO6Gz3rK1orArIGzl2s0sDduo5Os8JtbIhNqO/3gEM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jmdEs0KsaIYM8JFlZ4nmY8OI1xfTPK8/OObKuIGV9c+eCCTLWaZuIAaK5Kdfvojig
         PYxQmqgkfPMZVeBKThzO+9XS+J8uO/J8wa7HvzrzzM7Yb1uy9hf8CeCFvNLOLm4fFH
         yvlfkZr0rjEDOcCamjkoyvUDQxTgzp4MPuCUs5cU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191220070808.GA2190290@kroah.com>
References: <20191220070808.GA2190290@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191220070808.GA2190290@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.5-rc3
X-PR-Tracked-Commit-Id: c05c403b1d123031f86e65e867be2c2e9ee1e7e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 107aff96d36fc4bf2a9ad69bc2524e9f53bde7a6
Message-Id: <157686571171.29164.6597590371344210950.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 18:15:11 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 08:08:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/107aff96d36fc4bf2a9ad69bc2524e9f53bde7a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
