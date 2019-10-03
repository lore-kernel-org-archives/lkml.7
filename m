Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9375E20862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbfJCTfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:35:48 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20365 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730889AbfJCTfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:35:47 -0400
X-IronPort-AV: E=Sophos;i="5.67,253,1566856800"; 
   d="scan'208";a="404634649"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 21:35:45 +0200
Date:   Thu, 3 Oct 2019 21:35:45 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?ISO-8859-15?Q?Matthias_M=E4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
In-Reply-To: <9e15321d-5b95-c03c-e6eb-1d3d4a62478a@web.de>
Message-ID: <alpine.DEB.2.21.1910032135140.3451@hadrien>
References: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com> <9e15321d-5b95-c03c-e6eb-1d3d4a62478a@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1604499507-1570131345=:3451"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1604499507-1570131345=:3451
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 3 Oct 2019, Markus Elfring wrote:

> > Was this patch posted somewhere?
>
> Yes, of course.
>
> YueHaibing's update suggestions are available also by the usual
> mailing list archive interfaces.
> How do you think about to avoid the addition of the SmPL variable
> “virtual report” to the script “add_namespace.cocci” if you would dare
> to integrate my change proposal for an adjusted directory hierarchy?

Perhaps I'm lazy, but i seems simpler to add 20 characters than to move
all of the files around...

julia
--8323329-1604499507-1570131345=:3451--
