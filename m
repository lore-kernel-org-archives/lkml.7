Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F375C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82BA2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfCMI3q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:29:46 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38186 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfCMI3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:29:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 047BD608A380;
        Wed, 13 Mar 2019 09:29:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AygfTiTM_92y; Wed, 13 Mar 2019 09:29:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 769BB608A3A1;
        Wed, 13 Mar 2019 09:29:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X01h783-jNPS; Wed, 13 Mar 2019 09:29:43 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 2F68D608A380;
        Wed, 13 Mar 2019 09:29:43 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] UBI/UBIFS updates for 5.1-rc1
Date:   Wed, 13 Mar 2019 09:29:42 +0100
Message-ID: <1772218.nkLIIC4SQU@blindfold>
In-Reply-To: <CAHk-=wiR64B3MY852L64auE8ZGBhfFoTNXG=F=h5TVEM5gxRtg@mail.gmail.com>
References: <6283638.XALati16HY@blindfold> <CAHk-=wixZBzR5nbPZ3Y1=VahyVDsqVZhRfRhewJybx2-yA_FEQ@mail.gmail.com> <CAHk-=wiR64B3MY852L64auE8ZGBhfFoTNXG=F=h5TVEM5gxRtg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. März 2019, 00:40:33 CET schrieb Linus Torvalds:
> On Tue, Mar 12, 2019 at 3:18 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Mar 12, 2019 at 8:13 AM Richard Weinberger <richard@nod.at> wrote:
> > >
> > >   git://git.infradead.org/linux-ubifs.git tags/upstream-5.1-rc1
> >
> > Pulling this thing is taking forever for me. I can _ping_ the site,
> > but the "git pull" has been hanging for a while.
> 
> Ok, after leaving it for an hour and a half I just gave up. It's not worth it.
> 
> Put your repos on some other host, and re-send the pull requests,

Will do. UML is on kernel.org since ever.
UBIFS is on infradead.org because it was already there when I took over
maintainership. So I will move UBIFS to kernel.org too.

Thanks,
//richard 


