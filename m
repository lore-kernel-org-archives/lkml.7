Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D9DFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB456206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573235706;
	bh=f8Hoi7cBe7NO+DHEj/DMDLWexVAgDB0nHNhMp3Wpmyg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qJd2+5VDlq9FIXjpm3TWcasEB4bSPDofKBge0pdr/6zdBTe/4+C1rlo20FrefxmRp
	 BtsiaWy0KB3aWRqkorzCdBhMbCi3mLFZ0igSiJ5moDQnbHptjFeNCgDxtg51V2oueR
	 qxeEYsPacqMZb+T2dTm9iP5nzbd10A91UKBRYaio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfKHRzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfKHRzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:55:05 -0500
Subject: Re: [GIT PULL] XArray updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573235704;
        bh=f8Hoi7cBe7NO+DHEj/DMDLWexVAgDB0nHNhMp3Wpmyg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XJxvizkZco8cqrzA0470/t8bkIgrzjz01CmJawjtTzTCRw9AF0XM486uCkF/M9ZKc
         3pBWN0r57jb5rLBOy2eIazp882bow0rU+vKRXblPJfK74LLKB8QMxHy+OjeQ0+EhoW
         0hkdwlqZaHcWKVmiOybNhJ74o/RL73N92q2KfNr8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191108034727.GA30611@bombadil.infradead.org>
References: <20191108034727.GA30611@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191108034727.GA30611@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/linux-dax.git
 tags/xarray-5.4
X-PR-Tracked-Commit-Id: b7e9728f3d7fc5c5c8508d99f1675212af5cfd49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 410ef736a77b584e1c54a3784ee56ca63114ce11
Message-Id: <157323570484.12598.13165963828494055920.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 17:55:04 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Nov 2019 19:47:27 -0800:

> git://git.infradead.org/users/willy/linux-dax.git tags/xarray-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/410ef736a77b584e1c54a3784ee56ca63114ce11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
