Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0514C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD68206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570816209;
	bh=NxqhMUUqYKqpZ+su2wnhEd6+DDvgLijOHjy7ugQcnJw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nZg8Gj2sSqeqhsYYKFYcMlHE0WD6IxvpLONeCreMirJWLzG0COhD9STiBT4QR3BEP
	 Y0x84MZezbvNPnOvoxKQ93ZNHdAuWVxktqnB6RCVJAuYH81K7Bm5eArKzIL462bgtZ
	 BqzFdiAGRzApTH94b0gj+sKJLSre1VIcla/81ycY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfJKRuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbfJKRuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:50:07 -0400
Subject: Re: [GIT PULL] Modules fixes for v5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570816206;
        bh=NxqhMUUqYKqpZ+su2wnhEd6+DDvgLijOHjy7ugQcnJw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=slmEUlD+jLps32OLo4GSCPJqwqapgQaSlgAq/assFAC1eIEHpaBN3ilAeIWWOs4Ea
         0rrvLwHWSJPmq4ZBBnRrY3uZpBnVUerDHWFPEJ01wEN+HDMHs1Ez5nro2MfxdgyICe
         uknxB2YbR2FhsX5pRA/0oDndzyeTy+4oVSEQgHlA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191011170506.GA19908@linux-8ccs>
References: <20191011170506.GA19908@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191011170506.GA19908@linux-8ccs>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.4-rc3
X-PR-Tracked-Commit-Id: fcfacb9f83745d9fa97937b8bc94a73bb0607912
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6f6ebd77ce1bb8931f78412a841dd1371820181
Message-Id: <157081620665.1160.6691019040928497392.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Oct 2019 17:50:06 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Oct 2019 19:05:06 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6f6ebd77ce1bb8931f78412a841dd1371820181

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
