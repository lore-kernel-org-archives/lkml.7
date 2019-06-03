Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78CDC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ADF27AC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfFCOL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:11:58 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41113 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfFCOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:11:57 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0F1D1E0004;
        Mon,  3 Jun 2019 14:11:52 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: unable to fetch the mvebu tree
In-Reply-To: <20190603082346.7bd1d7a4@canb.auug.org.au>
References: <20190603082346.7bd1d7a4@canb.auug.org.au>
Date:   Mon, 03 Jun 2019 16:11:51 +0200
Message-ID: <87y32ikbbs.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> Hi all,
>
> Tyring to fetch the mvebu tree
> (git://git.infradead.org/linux-mvebu.git#for-next) for the past several
> days produces this error message:
>
> fatal: Couldn't find remote ref refs/heads/for-next

Sorry for this, the main reason was that I didn't create a for-next
branch for this new cycle.

I was waiting for 5.2-rc1 and then didn't take time to merge our current
branches in the for-next branch.

But now it should be available.

Gregory

>
> -- 
> Cheers,
> Stephen Rothwell

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
