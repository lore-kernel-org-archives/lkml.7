Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811AAC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D83321019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfEMLg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:36:59 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:18671 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729477AbfEMLg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:36:57 -0400
X-IronPort-AV: E=Sophos;i="5.60,465,1549926000"; 
   d="scan'208";a="382892366"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 13:36:56 +0200
Date:   Mon, 13 May 2019 13:36:52 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [1/5] Coccinelle: put_device: Adjust a message construction
In-Reply-To: <97f32bc1-f7ff-5777-21b5-5c4f85bb7276@web.de>
Message-ID: <alpine.DEB.2.20.1905131333560.1009@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn> <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de> <308f5571-68f3-7505-d5ad-59ee68091959@web.de> <alpine.DEB.2.20.1905131133570.3616@hadrien> <97f32bc1-f7ff-5777-21b5-5c4f85bb7276@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 May 2019, Markus Elfring wrote:

> >> Thus simplify a message construction in a SmPL rule by concatenating text
> >> with two plus operators less.
> >
> > Is there any way to unindent, so that the string doesn't exceed 80 characters,
> > or at least no so much?
>
> How does your concern fit to the string literal tolerance from
> the Linux coding style?

The point of view of the Linux kernel is that if there is no nicer way to
persent the string, exceeding 80 characters is preferable to breaking the
string.  But here, at least if Python was not indentation sensitive, there
are much nicer ways to present the string and not exceed 80 characters.

> > On the other hand, I would have much preferred the original msg = code.
> > I don't understand why it is so offensive.
>
> I suggested again to avoid the use of extra variables in such cases
> (also in the discussed bit of Python source code within a SmPL script).

I realize that you don't like it, although I have no idea why.  Does it
make the code slower? Less reliable? Less readable?  I doubt any of those
things.  I think that staying within 80 characters would be a much greater
benefit that all of these baseless concerns.

julia

>
> Regards,
> Markus
>
