Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95746C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E3D2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEOKTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:19:20 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:12170 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbfEOKTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:19:19 -0400
X-IronPort-AV: E=Sophos;i="5.60,472,1549926000"; 
   d="scan'208";a="383262488"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 12:19:17 +0200
Date:   Wed, 15 May 2019 12:19:13 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Ma Jiang <ma.jiang@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [3/3] Coccinelle: pci_free_consistent: Extend when constraints
 for two SmPL ellipses
In-Reply-To: <c53d5a80-7f80-535c-8394-a3289399feba@web.de>
Message-ID: <alpine.DEB.2.20.1905151217380.3231@hadrien>
References: <201905151043340243098@zte.com.cn> <alpine.DEB.2.21.1905150808180.2591@hadrien> <bfde9b91-0c5d-31a0-4b1b-5f675152b2f8@web.de> <alpine.DEB.2.20.1905151119070.3231@hadrien> <c53d5a80-7f80-535c-8394-a3289399feba@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-210433361-1557915553=:3231"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8323329-210433361-1557915553=:3231
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 15 May 2019, Markus Elfring wrote:

> >>> On the other hand, I do care about causing false negatives.
> >>
> >> Do you find the missing warning after the addition of such an exclusion
> >> specification interesting?
> >
> > I already suggested how to improve the code.
>
> I find that the idea “e2->fld” needs further clarification.
> Such a SmPL specification will be resolved also to an expression,
> won't it?

Saving in a local variable doesn't impact the need to free the object.  A
field is the most obvious case where the object may not need freeing.  But
there are many expressions that e2->fld will not match.

julia
--8323329-210433361-1557915553=:3231--
