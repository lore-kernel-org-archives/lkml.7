Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA1CC742DD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117A120896
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562978419;
	bh=N1eN8QH+7+JfYNNJ4yh+cOKi0l7F+Trf3hII8g1oIBg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KkpWzaIOMOvZGyaGZUp5XPHJ/IQklF8lL64ZwICc6pb3ZQbvLJ7sKJt4A4OhOwXly
	 85dkP/U+EQvRoiS+8LUOEhu4RSVEjWIKCwV7umHv+YSQT49SaSTXcgu6/aKR/hTfIn
	 O2895vZBfbm/CZTjnd8qHkwuCGWlKZABQLk680As=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfGMAkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 20:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfGMAkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:40:14 -0400
Subject: Re: [GIT PULL] 9p updates for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562978413;
        bh=N1eN8QH+7+JfYNNJ4yh+cOKi0l7F+Trf3hII8g1oIBg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DEyjTsKroaYPyBZpS5gupT9I0yQTFF2uDYIuKMAkT2Go+oJn4f6oH+lqgo8SqhowS
         YGzL0MJrcPOAfiOf4JeiEqsuvb8H9Djp7DUiSDsuhnDvcLDDOpq9Mzzqw+j6YTl+oD
         /4T3w8QDFtM1DBCbTPn5XdaFUJB4HzTGaLxwqOb0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712080446.GA19400@nautica>
References: <20190712080446.GA19400@nautica>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712080446.GA19400@nautica>
X-PR-Tracked-Remote: git://github.com/martinetd/linux tags/9p-for-5.3
X-PR-Tracked-Commit-Id: 80a316ff16276b36d0392a8f8b2f63259857ae98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23bbbf5c1fb3ddf104c2ddbda4cc24ebe53a3453
Message-Id: <156297841376.30815.4748359987826787756.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 00:40:13 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 10:04:46 +0200:

> git://github.com/martinetd/linux tags/9p-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23bbbf5c1fb3ddf104c2ddbda4cc24ebe53a3453

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
