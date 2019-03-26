Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA13720863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfCZJ6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:58:11 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35338 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbfCZJ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:58:10 -0400
X-IronPort-AV: E=Sophos;i="5.60,271,1549926000"; 
   d="scan'208";a="375778464"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 10:58:08 +0100
Date:   Tue, 26 Mar 2019 10:58:06 +0100 (CET)
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
In-Reply-To: <CAK7LNATjAsiSeZoTZ57zBHse0j5ZYY_12ZQ0gaF_oCziUWheOQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1903261057380.5021@hadrien>
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn> <CAK7LNASzd=bL1H34w-E_UD9x6w2=ObyS+EPDZ_jrvfV+ncw-yA@mail.gmail.com> <1691b160-5558-d4c3-afed-5773e115c5aa@web.de> <CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com>
 <e2798cd9-1366-63a4-8638-037dc8a36618@web.de> <CAK7LNATjAsiSeZoTZ57zBHse0j5ZYY_12ZQ0gaF_oCziUWheOQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Mar 2019, Masahiro Yamada wrote:

> On Tue, Mar 26, 2019 at 6:06 PM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > When I searched "Wen Yang", v6 did not show up for some reasons.
> > > https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=22638&state=*&q=&archive=&delegate=
> >
> > I find such a situation also interesting somehow.
> > I assume that there was another temporary technical difficulty involved
> > with the Linux mailing list (and related information systems).
>
>
> I think v6 fell into a crack somehow.
>
>
> Check the LKML archive:
> https://lkml.org/lkml/2019/2/16
>
>
> I see your reply:
>
> Re: [v6] coccinelle: semantic code search for missing put_device()Markus Elfring
>
>
> But, I cannot find the v6 patch itself.
>
>
>
> >
> > > So, I just thought v5 was the latest one
> > > and I was completely missing the context.
> >
> > Did any messages for the sixth (and seventh) script version reach you?
> >
> > https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/
>
>
> I use both my corporate email address and Gmail,
> and play it by ear.
>
>
> I see it in my corporate mail box now.
> It reached me probably because I subscribe to cocci@systeme.lip6.fr
> with my socionext email address.
>
> However, this time I only checked my Gmail box,
> which subscribes to linux-kernel ML, but not cocci ML.
>
> I just skimmed over the thread, then
> I missed the fact you were giving some comments about v6.
>
>
>
> > https://lore.kernel.org/lkml/1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn/
>
>
> Yes. I see this one.
>
> I will apply it to fixes branch
> if nobody sees a problem in it.

This one is fine independent of anything else.

thanks,
julia
