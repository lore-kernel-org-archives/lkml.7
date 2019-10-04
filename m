Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E71C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA68222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570213519;
	bh=azumKvVXU/f/c4++qv5jx5ut3OP6GQX4CtQeRWkAfbA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zb7f/CQ2LbCb1kVyufsOdvWgHLzmpiKLZgAh7i9pu6FCQfiDoLvWYTHq0nNJDBwVb
	 LCdRpTpZWNTF9bvvTLTJru/z6PgeuH9/hAB1wkXtbrVsf6YfgZfxuaszgt6leYr3Pg
	 z0sZuefM3UjD9E1VhoI24AZyWkV4xTu5KTbCYCbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfJDSZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729563AbfJDSZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:25:17 -0400
Subject: Re: [GIT PULL] process fixes for v5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570213517;
        bh=azumKvVXU/f/c4++qv5jx5ut3OP6GQX4CtQeRWkAfbA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kOLsVEGsHt/XnAU31gRyRWgDialt1HBuCdZB1TpoRSSrMpEHN+0WBcbtoHTzqh+m/
         RcatGlvx/y+VJeRvbKB+Of8UCnzaaYbxtopQLfnCExTdKCuY2rAG/2iA4R3J4vpzCG
         8RrFu4qlpMhnObI7FOporctIWdwE9G7juunsz2wA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191004093947.14471-1-christian.brauner@ubuntu.com>
References: <20191004093947.14471-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191004093947.14471-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-20191003
X-PR-Tracked-Commit-Id: 78f6face5af344f12f4bd48b32faa6f499a06f36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af0622f6ae416f9ac340d6d632be9879805c294a
Message-Id: <157021351695.30669.12447749330503006736.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Oct 2019 18:25:16 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  4 Oct 2019 11:39:47 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20191003

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af0622f6ae416f9ac340d6d632be9879805c294a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
