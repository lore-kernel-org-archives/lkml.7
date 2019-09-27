Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A415EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757B92075D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569625206;
	bh=lZdnGmEpHQjZEC9pHyYMZwLDTAoeVbVYJFbPvrM2Gog=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nMZdd0ft0lL/EitQEdPxii3W+3VmmCTK3zn6UbplsiDd7AR6FQvx1I3zHDJ0UwvUv
	 YXBatn+v8p/WUzfE1wj+5JgNwOFBOrreXdATX0LIJxK6Iha8S35XELUPE5oQ9zBx4P
	 b93AyobJA2MxKFZlxrCOFfInVkfnIXdyf74mFacU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfI0XAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 19:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI0XAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 19:00:05 -0400
Subject: Re: [GIT PULL] add virtio-fs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569625204;
        bh=lZdnGmEpHQjZEC9pHyYMZwLDTAoeVbVYJFbPvrM2Gog=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RLNZkEXkmtVATcT3eC83J6UAuJ3Ayf9N10slIKejiKMcwXitP2/4qJAreZs5CXw1V
         eLrCHP0Or21LRyTcHm4Ik8S9SHYqV31FnhPrZjKE1Ko19vkAVKs1mq4T3KelTDFByX
         bmy0W4HOkFOWx2Gd7ex27AVuVNfdlium6MpiNAcc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190926084340.GB1904@miu.piliscsaba.redhat.com>
References: <20190926084340.GB1904@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190926084340.GB1904@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/virtio-fs-5.4
X-PR-Tracked-Commit-Id: a62a8ef9d97da23762a588592c8b8eb50a8deb6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f744bdee4fefb17fac052c7418b830de2b59ac8
Message-Id: <156962520482.10299.16614851801819928945.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Sep 2019 23:00:04 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 10:43:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/virtio-fs-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f744bdee4fefb17fac052c7418b830de2b59ac8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
