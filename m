Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC28EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774002075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfCZHTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:19:21 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:3021 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726042AbfCZHTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:19:20 -0400
X-IronPort-AV: E=Sophos;i="5.60,271,1549926000"; 
   d="scan'208";a="300715099"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 08:19:17 +0100
Date:   Tue, 26 Mar 2019 08:19:16 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Markus Elfring <Markus.Elfring@web.de>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v5] coccinelle: semantic code search for missing put_device()
In-Reply-To: <CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903260818460.2463@hadrien>
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn> <CAK7LNASzd=bL1H34w-E_UD9x6w2=ObyS+EPDZ_jrvfV+ncw-yA@mail.gmail.com> <1691b160-5558-d4c3-afed-5773e115c5aa@web.de> <CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Mar 2019, Masahiro Yamada wrote:

> On Sun, Mar 24, 2019 at 1:19 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > Applied to linux-kbuild.
> >
> > A questionable development version was integrated for this SmPL script.
>
>
> Sorry for my bad job.
>
> I usually use LKML patchwork to find patches.
>
> When I searched "Wen Yang", v6 did not show up for some reasons.
> https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=22638&state=*&q=&archive=&delegate=
>
> So, I just thought v5 was the latest one
> and I was completely missing the context.

I think it is a minor detail that will have no impact in practice.

julia


>
>
> Apology.
>
> Masahiro
>
>
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/scripts/coccinelle/free/put_device.cocci?id=da9cfb87a44da61f2403c4312916befcb6b6d7e8
> >
> > https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/
> >
> >
> > Now I am curious on how such a source code analysis approach will be
> > improved further.
> > Which changes will get the desired acceptance?
> >
> > https://lore.kernel.org/patchwork/patch/1053979/
> > https://lore.kernel.org/lkml/1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn/
> > https://systeme.lip6.fr/pipermail/cocci/2019-March/005679.html
> >
> > Regards,
> > Markus
> --
> Best Regards
> Masahiro Yamada
>
