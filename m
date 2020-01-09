Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B517C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F7B2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgAIMRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:17:46 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45037 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730218AbgAIMRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:17:46 -0500
X-IronPort-AV: E=Sophos;i="5.69,413,1571695200"; 
   d="scan'208";a="430610150"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 13:17:44 +0100
Date:   Thu, 9 Jan 2020 13:17:44 +0100 (CET)
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
Subject: Re: [v2] coccinelle: semantic patch to check for inappropriate
 do_div() calls
In-Reply-To: <d0d7eda5-6f4b-8501-624c-1f25b481520a@web.de>
Message-ID: <alpine.DEB.2.21.2001091315560.10786@hadrien>
References: <20200107170240.47207-1-wenyang@linux.alibaba.com> <9a2b7d00-442e-0c1b-73cc-aed2bbecd13a@web.de> <alpine.DEB.2.21.2001091140380.10786@hadrien> <e479c5c7-2556-eb77-9e9c-8833fb883a39@web.de> <alpine.DEB.2.21.2001091304310.10786@hadrien>
 <d0d7eda5-6f4b-8501-624c-1f25b481520a@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-695649286-1578572264=:10786"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-695649286-1578572264=:10786
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 9 Jan 2020, Markus Elfring wrote:

> >> Does the Coccinelle software ensure that a variable like “r.ul” contains
> >> really useful data even if the expected branch of the SmPL disjunction
> >> was occasionally not matched?
> >
> > The python code will only be executed if it does.
>
> The Python scripts will be executed if the SmPL rule “r” found something.
> I suggest to take a closer look at the involved data types for
> really safe case distinctions.
> Does the dependency management around the application of SmPL disjunctions
> need any further clarification?

I already clarified it.  The python code will only be executed if the
variables that it references have values.  The criterion is not just
whether the rule r was matched.

To see that this is the case, all or you have to do is try it.  Or read
the Coccinelle source code.

julia
--8323329-695649286-1578572264=:10786--
