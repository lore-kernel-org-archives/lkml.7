Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E84EC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 02:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261E120801
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 02:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573958111;
	bh=LNFsYyHzWydQXy/hj8/dS4SZ/uOhWm03xbFzignN6Q4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=h4KDNaMtWLcPgYzqQfLtuJ3fLrWR140jPUy2JfIZpaKnxHMiRUiWs95kwV2jndwuF
	 xawXNeo1z4O7/1KxNAdczrlDvA1BeC3/YYEnFWu2T8yjBn79UfqJBjKTycEwT2+Eem
	 Vfa/ewikcJrzCo1Ux9xpLFSJyeTFZSd8XK8omn0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfKQCfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 21:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfKQCfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 21:35:07 -0500
Subject: Re: [GIT PULL] Crypto Fixes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573958107;
        bh=LNFsYyHzWydQXy/hj8/dS4SZ/uOhWm03xbFzignN6Q4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=usyXxb2mi+c+hSxpbTIDfXSqf6qsc9CNnOophWj4Yh8/7obRDuVGulwdOe+it6iXd
         5XdM50voZLE5WiqJcKNSPcqN8ezhvlWXLx9NFRKJub8S3QQStlCnPS5VizAkufzopb
         ZOQybPAlsRKxNyHr7c/c03eUlWUZKG/dGv1UsZts=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191117010036.7vww6vqrakv3avkw@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191010123849.GA30001@gondor.apana.org.au>
 <20191117010036.7vww6vqrakv3avkw@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191117010036.7vww6vqrakv3avkw@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 08e97aec700aeff54c4847f170e566cbd7e14e81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d4c79ed324ad780cfc3ad38364ba1fd585dd2a8
Message-Id: <157395810692.19691.18012672586585444784.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Nov 2019 02:35:06 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Nov 2019 09:00:36 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d4c79ed324ad780cfc3ad38364ba1fd585dd2a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
