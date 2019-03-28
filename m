Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87416C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB3A20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfC1GJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:09:26 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:38043
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbfC1GJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:09:24 -0400
X-IronPort-AV: E=Sophos;i="5.60,278,1549926000"; 
   d="scan'208";a="300976876"
Received: from unknown (HELO hadrien) ([94.134.122.206])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 07:09:22 +0100
Date:   Thu, 28 Mar 2019 07:09:22 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     yamada.masahiro@socionext.com, Markus.Elfring@web.de,
        Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, yellowriver2010@hotmail.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?GB2312?Q?Re=3A_=B4=F0=B8=B4=3A_Re=3A_=5Bv5=5D_coccinelle=3A_s?=
 =?GB2312?Q?emantic_code_search_for_missing_put=5Fdevice=28=29?=
In-Reply-To: <201903281010336645826@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1903280708590.2756@hadrien>
References: 1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn,CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com,CAK7LNATjAsiSeZoTZ57zBHse0j5ZYY_12ZQ0gaF_oCziUWheOQ@mail.gmail.com <201903281010336645826@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Mar 2019, wen.yang99@zte.com.cn wrote:

> > > > When I searched "Wen Yang", v6 did not show up for some reasons.
> > > > https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=22638&state=*&q=&archive=&delegate=
> > >
> > > I find such a situation also interesting somehow.
> > > I assume that there was another temporary technical difficulty involved
> > > with the Linux mailing list (and related information systems).
> >
> >
> > I think v6 fell into a crack somehow.
> >
> >
> > Check the LKML archive:
> > https://lkml.org/lkml/2019/2/16
> >
> >
> > I see your reply:
> >
> > Re: [v6] coccinelle: semantic code search for missing put_device()Markus Elfring
> >
> >
> > But, I cannot find the v6 patch itself.
> >
>
> I am sorry to bother you.
> I checked it again and  found that I can not send mail to <linux-kernel@vger.kernel.org>
> via my private mailbox <yellowriver2010@hotmail.com>.
> The reject reply like this:
>
> for your MAIL FROM address <yellowriver2010@hotmail.com> policy analysis reported: Your address is not liked source for email
>
> Is it looked my mail as spam mail?
> Who should I send to for help me resolving this problem?

Maybe Konstantin Ryabitsev?

julia


>
>
> --
> Best Regards
> Wen
