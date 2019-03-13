Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D125BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EA62077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552497021;
	bh=b+WYz61EZeViDmiFAn/H8hKbTbhE3237+mK5wOlE4gM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uZ+5tKiJ2ef9p5LqhwEXmDf5oR8yYysbsQW0LjqiQlG3wLPpnowliDca8rubeCS+I
	 jxZjcYfxVD7KXS+OuVwJyuvER/DE82yFWs8Bm3nnZNJ5GKKbSL4PlXk6WZlUQUmKW0
	 i6W00oVbYsC+Z420s8f6QNrjvnWAJ1vbdNiTqAYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCMRKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfCMRKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:10:16 -0400
Subject: Re: [GIT PULL] Mailbox changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552497016;
        bh=b+WYz61EZeViDmiFAn/H8hKbTbhE3237+mK5wOlE4gM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K9/ow9FrEt45XkguR3KtZGDt31Vi6UsBjxKdYFnaKfjXcAbLXgIwHb0UGzJBIDRM6
         fMYBuitF84npagS7OLFACkNwuHu1h768/p1nszenfPd9xN4v3FB6zQ5sMVzZn0ePOO
         4o+fDsiMd8PEiFOcX/Eo4cQNnevPJ7/pfCBUUxuU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY0bhhq1H5ogHOWxX1csSzmTd2jziryZCNtugUye9-LWTQ@mail.gmail.com>
References: <CABb+yY0bhhq1H5ogHOWxX1csSzmTd2jziryZCNtugUye9-LWTQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY0bhhq1H5ogHOWxX1csSzmTd2jziryZCNtugUye9-LWTQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-v5.1
X-PR-Tracked-Commit-Id: 17b860bbfc844a3d8e38135ef430d4af8e436b9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a186d38561d2844072829c6c0811e407c6ec1aa
Message-Id: <155249701604.28396.6429149220990847526.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Mar 2019 17:10:16 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Mar 2019 10:13:28 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a186d38561d2844072829c6c0811e407c6ec1aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
