Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242DBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB98206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575336619;
	bh=IOaovBIYvr92zFfnKHiEh1+IA7205civJdeDvpjd0f0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tZhMrIbM2a7HNgP4wsGx6QNhmSy3QKkguteo4Un/3AFN3t3CduOp98ggieSm5tFqz
	 mtpQ20JzmuXn6dzqF0kV6nXp19M+qGPwa+cgIgM23PT7Z8Zb549cGgky3jttxa4Ofm
	 vSIttAGP6STzGBLfYSco9DzIQ/lOZNK3PizUivZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLCBaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfLCBaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:30:17 -0500
Subject: Re: [GIT PULL] UML changes for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575336616;
        bh=IOaovBIYvr92zFfnKHiEh1+IA7205civJdeDvpjd0f0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0/equPnpuOPxoltNUoG7eBs8j77vdgYZNuXXN2uEYxSCTbYdUBcp/z0MNf4lz+RLx
         iuhfAzSvxtJPY2GGw2AUL/gwya3EB0mlY93gzf8C5gUrrl4Dwtot7CAgTDzFJlmLE3
         LICNcBJKnw+MV2eZduNS0S8dwDB8YJrr9eBLbLEo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1468911323.103246.1575231534725.JavaMail.zimbra@nod.at>
References: <1468911323.103246.1575231534725.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1468911323.103246.1575231534725.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.5-rc1
X-PR-Tracked-Commit-Id: 9807019a62dc670c73ce8e59e09b41ae458c34b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcaa0ad72d8a14736595bb48c49f9ebd62963d63
Message-Id: <157533661673.4888.7011091357254529423.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 01:30:16 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Dec 2019 21:18:54 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcaa0ad72d8a14736595bb48c49f9ebd62963d63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
