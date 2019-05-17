Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08015C04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC4920862
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558052728;
	bh=0RzTI5eZC27hvW7LiDE5bJwxYMzbHhab9LqWsZel2UM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MfxogFvw7lZs3b80i1YB9l5bl2xlLwnBQ5GNApavqedo+90mRRE5ZESGiYIAejlNM
	 g1tW0JxyrkYa2CLRzFwmUVLHP/78cA8zKbBaLHqyxNEcoaJUwK79UzYtzBp2VoTxab
	 r26IXJurEMgDJfknhbTzzCnILviTEOUE3cH1BVoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfEQAZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 20:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbfEQAZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 20:25:22 -0400
Subject: Re: [GIT PULL] afs: Fix callback promise handling
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558052722;
        bh=0RzTI5eZC27hvW7LiDE5bJwxYMzbHhab9LqWsZel2UM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Sn1fC9/LMfKVNi/vyElrLMPcZ68UTg/LgeGbvRiUP/o6ZS+RuN9yHtmgTi2dfBy6C
         0O+u3AVlpRcBigaGaD7QM0Gxb+X7qFkD5xscgfon+0uT6ZuMI1FViO4g38f+s9kBz/
         9wjs8Njt0BdqUmb1glc2fiCqckdum6xEqJ/HqXD8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <14598.1558047724@warthog.procyon.org.uk>
References: <14598.1558047724@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <14598.1558047724@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-b-20190516
X-PR-Tracked-Commit-Id: 39db9815da489b47b50b8e6e4fc7566a77bd18bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d74471924f2a01dcd32d154510c0500780b531a
Message-Id: <155805272252.4154.14037520601109942729.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 00:25:22 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Jonathan Billings <jsbillings@jsbillings.org>,
        dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 May 2019 00:02:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-b-20190516

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d74471924f2a01dcd32d154510c0500780b531a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
