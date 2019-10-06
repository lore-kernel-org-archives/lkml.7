Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB349C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D242080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfJFF2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 01:28:21 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9983 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbfJFF2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 01:28:20 -0400
X-IronPort-AV: E=Sophos;i="5.67,263,1566856800"; 
   d="scan'208";a="321746809"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 07:28:16 +0200
Date:   Sun, 6 Oct 2019 07:28:16 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Martijn Coenen <maco@android.com>,
        =?ISO-8859-15?Q?Matthias_M=E4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
In-Reply-To: <f64fc086-7852-b074-6247-108b753dc272@web.de>
Message-ID: <alpine.DEB.2.21.1910060727580.4623@hadrien>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com> <21684307-d05c-1856-c849-95436aedeb86@web.de> <alpine.DEB.2.21.1910051425050.2653@hadrien> <f64fc086-7852-b074-6247-108b753dc272@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-169822186-1570339697=:4623"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-169822186-1570339697=:4623
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 6 Oct 2019, Markus Elfring wrote:

> >> Would you like to take the change possibility into account
> >> that the coccicheck system configuration should be adapted instead?
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccicheck?id=4ea655343ce4180fe9b2c7ec8cb8ef9884a47901#n257
> >
> > I prefer the one line change for now.  If more issues arise one can see
> > what is more desirable at a larger scale.
>
> I got the impression that the script “add_namespace.cocci” should never
> be automatically called by the current default setting of the tool “coccicheck”
> also because it requires the input parameter “name space” (SmPL identifier “virtual.ns”).
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/scripts/coccinelle/misc/add_namespace.cocci?id=eb8305aecb958e8787e7d603c7765c1dcace3a2b
>
> Would you like to increase your software development attention for
> efficient system configuration on this issue?

No.

julia
--8323329-169822186-1570339697=:4623--
