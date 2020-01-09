Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB017C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66C82075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgAIKlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:41:35 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35880 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729159AbgAIKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:41:34 -0500
X-IronPort-AV: E=Sophos;i="5.69,413,1571695200"; 
   d="scan'208";a="430595360"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 11:41:27 +0100
Date:   Thu, 9 Jan 2020 11:41:27 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?ISO-8859-15?Q?Matthias_M=E4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] coccinelle: semantic patch to check for inappropriate
 do_div() calls
In-Reply-To: <9a2b7d00-442e-0c1b-73cc-aed2bbecd13a@web.de>
Message-ID: <alpine.DEB.2.21.2001091140380.10786@hadrien>
References: <20200107170240.47207-1-wenyang@linux.alibaba.com> <9a2b7d00-442e-0c1b-73cc-aed2bbecd13a@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Jan 2020, Markus Elfring wrote:

> > +@script:python depends on org@
> > +p << r.p;
> > +ul << r.ul;
>
> I interpret this variable assignment in the way that it will work only
> if the corresponding branch of the SmPL disjunction was actually matched
> by the referenced SmPL rule.
> Thus I suggest now to split the source code search pattern into
> four separate rules.

Why?

julia
