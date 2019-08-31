Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A381C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 16:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413FB23407
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567269910;
	bh=vubgKTpg5td5IeaSwB94NLqghhYsAWgqbVw40GiyhJg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LgFvcwf96It0Zm4618x33vnEnxy4/fsRivAYLQZeNPO9u0CAekYYe9oXCgNWW2d/B
	 fUCNHnXL3EcRmCsfa0fYQf6/MU/exFlZWTxw/aOycSClSukO1+wtwMJk1lumEjFbj2
	 Fj8H5EHZKxYfbPAponGcae2R5cnjKmyEd69j5kNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfHaQpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 12:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfHaQpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 12:45:09 -0400
Subject: Re: [GIT PULL] KVM fixes for Linux 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567269908;
        bh=vubgKTpg5td5IeaSwB94NLqghhYsAWgqbVw40GiyhJg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UJ1BchBbPQ751dZfaNv+ExXw4xwNDNOQXkBdtD8Ydi8jXJmm+u2nkl/VUkpVehri8
         ytLMzWW9IIAJ98aVQwwufkA0EHBXxgDm1vyrF5uCrJt29k/6hkDm11pGtXViEQsd28
         lMtGFrH26I1VZ4kGiG3z0N0Swtx6hUaC1X4VWe8Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190831022626.GA453351@flask>
References: <20190831022626.GA453351@flask>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190831022626.GA453351@flask>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus
X-PR-Tracked-Commit-Id: 75ee23b30dc712d80d2421a9a547e7ab6e379b44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 834354f642adfe7bb6d5dba5f7de6ecd3150fb2f
Message-Id: <156726990822.25629.14623210787018605059.pr-tracker-bot@kernel.org>
Date:   Sat, 31 Aug 2019 16:45:08 +0000
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 31 Aug 2019 04:26:26 +0200:

> git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/834354f642adfe7bb6d5dba5f7de6ecd3150fb2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
