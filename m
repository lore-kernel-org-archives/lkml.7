Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F7C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B01C217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558468522;
	bh=eIpOw3kyNjsuf9y4SGhbSEns7aKrJ+UZytUElm9znZU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e8/Ylc0K9N/chDxZUpzAghw0BiP0IJvcV6Fc0HknERNCnbzijRo9NWEG0t07Er4Ns
	 a1K4pzFrP6yCGXMf9xwmm7jQaykHoCpMHApjwXURarTVqw7vyCHa5A4suRVoI2nMXb
	 HW+acm5k9Qzlm4DCty+ZOAvmkYVH979RgL8PWTAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfEUTzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbfEUTzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:55:21 -0400
Subject: Re: [GIT] Crypto Fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558468520;
        bh=eIpOw3kyNjsuf9y4SGhbSEns7aKrJ+UZytUElm9znZU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gGRR9Gx1Ek4KdX5fyqO+cxnBd1DI9RHmWYkrycIIbdOGBRffnf+o0WAUlwF3TBXzE
         TBY5JJcEVb6gUNoIKfgl7fX+MqfclfhJbA2QFCJjGSjVsaI+jo8+mDa3Y9poBtlESw
         c3R6T6ek6fEazcfcEZoMv3EKU1StG3r1VO7izTUw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190521125817.6lqknb2kztxddi4p@gondor.apana.org.au>
References: <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20181116063146.e7a3mep3ghnfltxe@gondor.apana.org.au>
 <20181207061409.xflg423nknleuddw@gondor.apana.org.au>
 <20190118104006.ye5amhxkgd4xrbmc@gondor.apana.org.au>
 <20190201054204.ehl7u7aaqmkdh5b6@gondor.apana.org.au>
 <20190215024738.fynl64d5u5htcy2l@gondor.apana.org.au>
 <20190312045818.bgpiuxogmaxyscdv@gondor.apana.org.au>
 <20190515060552.ecfwhazt2fnthepg@gondor.apana.org.au>
 <20190521125817.6lqknb2kztxddi4p@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190521125817.6lqknb2kztxddi4p@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 357d065a44cdd77ed5ff35155a989f2a763e96ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d53e860fd46f3d95c437bb67518f7374500de467
Message-Id: <155846852069.2650.10220458600061142386.pr-tracker-bot@kernel.org>
Date:   Tue, 21 May 2019 19:55:20 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 May 2019 20:58:17 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d53e860fd46f3d95c437bb67518f7374500de467

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
