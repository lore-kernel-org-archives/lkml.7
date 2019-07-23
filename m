Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F0C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B6E223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="t2sXYvg2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="j0vPgDuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390738AbfGWPO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:14:27 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38866 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729004AbfGWPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:14:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A8C8B8EE147;
        Tue, 23 Jul 2019 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563894866;
        bh=w7q5QNoBfsqpgw7GXu/6oW54dlngCPjMzC6fAoZt/Bs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t2sXYvg2AcoJg19sebikgnWmsovJMQ2xg0q6uyzfwFKqu3LYgvcILcbZ7tgSehK1z
         ZYo7LhAoHE4cbqadBcNGFJW6J8u2dq0DhUe9m5ww7t0zwjgp2Gi/ObVJp4E6ZXuLPK
         UAwazd5xLlyfVzc7tjkkij3Z+aeDVpDd3m33Cqqo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rfahQdfxX0zQ; Tue, 23 Jul 2019 08:14:25 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6274D8EE0EF;
        Tue, 23 Jul 2019 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563894864;
        bh=w7q5QNoBfsqpgw7GXu/6oW54dlngCPjMzC6fAoZt/Bs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j0vPgDujNCWgZRs4QVk4lgNq+IOhbdpTDTceLlR7BJA6soPPp93VBdCAoXMVUo2fj
         a8TRyzDkakVHu76IjrPdOl5TBsZpTnO3QIgcQ4hzkjgVdcHdq9nQq5dUhj7F362TZt
         SAJDfDdVuyLs+WD2e9yNsYEjxo+AGy6z5LJYvR2A=
Message-ID: <1563894861.3609.6.camel@HansenPartnership.com>
Subject: Re: Linux 5.3-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Tue, 23 Jul 2019 08:14:21 -0700
In-Reply-To: <20190723145805.GA5809@roeck-us.net>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
         <20190722222126.GA27291@roeck-us.net> <20190723054841.GA17148@lst.de>
         <20190723145805.GA5809@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 07:58 -0700, Guenter Roeck wrote:
> On Tue, Jul 23, 2019 at 07:48:41AM +0200, Christoph Hellwig wrote:
> > The fix was sent last morning my time:
> > 
> > https://marc.info/?l=linux-scsi&m=156378725427719&w=2
> 
> Here is the updated bisect for the ppc scsi problem.
> 
> Guenter
> 
> ---
> # bad: [f65420df914a85e33b2c8b1cab310858b2abb7c0] Merge tag 'scsi-
> fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> # good: [168c79971b4a7be7011e73bf488b740a8e1135c8] Merge tag 'kbuild-
> v5.3-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> git bisect start 'f65420df914a' '168c79971b4a'
> # good: [106d45f350c7cac876844dc685845cba4ffdb70b] scsi: zfcp: fix
> request object use-after-free in send path causing wrong traces
> git bisect good 106d45f350c7cac876844dc685845cba4ffdb70b
> # bad: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi: core: take
> the DMA max mapping size into account
> git bisect bad bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1
> # good: [0cdc58580b37a160fac4b884266b8b7cb096f539] scsi: sd_zbc: Fix
> compilation warning
> git bisect good 0cdc58580b37a160fac4b884266b8b7cb096f539
> # bad: [7ad388d8e4c703980b7018b938cdeec58832d78d] scsi: core: add a
> host / host template field for the virt boundary
> git bisect bad 7ad388d8e4c703980b7018b938cdeec58832d78d
> # good: [f9b0530fa02e0c73f31a49ef743e8f44eb8e32cc] scsi: core: Fix
> race on creating sense cache
> git bisect good f9b0530fa02e0c73f31a49ef743e8f44eb8e32cc
> # first bad commit: [7ad388d8e4c703980b7018b938cdeec58832d78d] scsi:
> core: add a host / host template field for the virt boundary

And reverting that commit fixes your problem?

James

