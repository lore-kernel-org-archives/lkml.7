Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D083BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB7520842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551757218;
	bh=6EDaaOoOkIWJ1ZJEpxCzU5lRQiTYAU422k23nSea7eA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OnCc0D1YhrfjInze94L3j9Q84q99w9twkfI0PtQM4NN9poseQEXiStFKyaMcf+Dw2
	 AsXTnp6oADL7NQr+/HPR8bZ0yEqcfaa8eGrohhZUQZumzbwWTSG1slSjpfQjXU8w6a
	 xF5dbeWnra9v6vC7gx1ttSvdFb3fxOJ++ro7i4mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfCEDkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbfCEDkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:40:05 -0500
Subject: Re: [GIT PULL] i3c: Changes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551757204;
        bh=6EDaaOoOkIWJ1ZJEpxCzU5lRQiTYAU422k23nSea7eA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Rksw/BpTm15D18LH9Fpd8/AMSE3DOhC4uPrdkSFvS7gHsj6LC1glNTjHbAgG3Z1Os
         1ojgnSvG4IFypTNK8HhiTDs7aDlz0HUFq7UJ7yNgdN338z2jdKqvvxZFOhBbqW2C07
         wo8q173TLRDqXHmb7Inoj+6giIS/+8oQ13h2vNcQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190301103215.4ee6e758@collabora.com>
References: <20190301103215.4ee6e758@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190301103215.4ee6e758@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.1
X-PR-Tracked-Commit-Id: 988bb4a1937bd083267444dda21b901dc6a959b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8d950ab24987cad4fb4de60c554ac12c2658991
Message-Id: <155175720459.14960.18271051620848903433.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 03:40:04 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Mar 2019 10:32:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8d950ab24987cad4fb4de60c554ac12c2658991

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
