Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A3DC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 06:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C82120835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 06:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfJFGog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 02:44:36 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:63139
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbfJFGog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 02:44:36 -0400
X-IronPort-AV: E=Sophos;i="5.67,263,1566856800"; 
   d="scan'208";a="321749807"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 08:44:14 +0200
Date:   Sun, 6 Oct 2019 08:44:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     YueHaibing <yuehaibing@huawei.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        =?ISO-8859-15?Q?Matthias_M=E4nnich?= <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: add_namespace: Fix coccicheck failed
In-Reply-To: <f9862128-8fa2-812e-cfb3-c9953b9e98a2@web.de>
Message-ID: <alpine.DEB.2.21.1910060843030.4623@hadrien>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com> <20191006044456.57608-1-yuehaibing@huawei.com> <f9862128-8fa2-812e-cfb3-c9953b9e98a2@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1244363809-1570344254=:4623"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1244363809-1570344254=:4623
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 6 Oct 2019, Markus Elfring wrote:

> > Now all scripts in scripts/coccinelle to be automatically called
> > by coccicheck. However new adding add_namespace.cocci does not
> > support report mode, which make coccicheck failed.
> > This add "virtual report" to  make the coccicheck go ahead smoothly.
>
> I find that this change description needs improvements and corrections.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=43b815c6a8e7dbccb5b8bd9c4b099c24bc22d135#n151
>
> I would find a commit subject like “scripts: add_namespace:
> Add support for the default coccicheck operation mode” more appropriate
> (if this software development will be clarified further in the shown direction
> at all).

Please let this go.  Please stop criticizing the English of others.  The
message is understandable, and even more informative than what you
propose.

julia

>
>
> > Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependencies.")
>
> I got the impression that a sub-optimal solution approach would be chosen here.
> The automatic script execution is requested despite of the fact
> that the input parameter “name space” (SmPL identifier “virtual.ns”)
> will be required.
>
> I am curious under which circumstances an other transformation
> can become more attractive.
> [PATCH 0/2] Coccinelle: Extend directory hierarchy
> https://lore.kernel.org/cocci/d8c97f0a-6ce2-0f5a-74a9-63366c17f3a6@web.de/
> https://lore.kernel.org/patchwork/project/lkml/list/?series=412494
> https://lkml.org/lkml/2019/10/2/60
>
>
> > +++ b/scripts/coccinelle/misc/add_namespace.cocci
> > @@ -6,6 +6,8 @@
> >  /// add a missing namespace tag to a module source file.
> >  ///
> >
> > +virtual report
> > +
> >  @has_ns_import@
>
> If you would insist on the complete support for the operation mode “report”
> of the tool “coccicheck”, I would eventually expect that another SmPL rule
> will provide a helpful message instead of immediately exiting after
> the script variable “ns” was defined.
> Are you going to take any additional software design options better
> into account?
>
> Regards,
> Markus
>
--8323329-1244363809-1570344254=:4623--
