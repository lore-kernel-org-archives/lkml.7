Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD370C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A5E214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565822108;
	bh=+XFoGOE8vFi2OMlqKzNPrlgZuGbhcK6T9DiWxiyJzdk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Tyy6DM72oMbLNC6/n8RaThViruMUdua3KwFUV5580PkAdzL6oEsoSfUaI5FFjLaZa
	 NC2lWKrToQFdkwnERzO+GW/lI90BUJfj7dlFQIszPpUB+9qKysDDSIANI822sltjdb
	 a/9Q24IvMI1eNU00xpAk+x5C47GE6pqF63M2b3rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfHNWfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfHNWfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:35:06 -0400
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565822106;
        bh=+XFoGOE8vFi2OMlqKzNPrlgZuGbhcK6T9DiWxiyJzdk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vVvwssPt7kbMSQISv6bwePtnLBAN8E2VIwPunq8TNFIjHHsSH83YhYTnv0ykuD3zF
         Uay6T0LyfBmJ9S8+BxsRZHU+R3eZGPV6QuLJnhSRF54HgOwwDx+NqBcNUVtYiQUABT
         hFDp47NoLIhQtqDYt8TH12EO9TPbioxibuWvxVFQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190814184901.GA16709@embeddedor>
References: <20190814184901.GA16709@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190814184901.GA16709@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/Wimplicit-fallthrough-5.3-rc5
X-PR-Tracked-Commit-Id: 1ee1119d184bb06af921b48c3021d921bbd85bac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41de59634046b19cd53a1983594a95135c656997
Message-Id: <156582210598.11528.2788392621579499903.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Aug 2019 22:35:05 +0000
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Aug 2019 13:49:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41de59634046b19cd53a1983594a95135c656997

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
