Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA6C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 18:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2E121BE5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 18:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfI2SFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 14:05:35 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:48721 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728994AbfI2SFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 14:05:35 -0400
X-IronPort-AV: E=Sophos;i="5.64,563,1559512800"; 
   d="scan'208";a="403859097"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2019 20:05:32 +0200
Date:   Sun, 29 Sep 2019 20:05:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     cocci@systeme.lip6.fr, Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: Re: [Cocci] [RFC PATCH] scripts: Fix coccicheck failed
In-Reply-To: <90cea5d2-b586-6f82-34dd-d7a812f57396@web.de>
Message-ID: <alpine.DEB.2.21.1909292004460.4485@hadrien>
References: <alpine.DEB.2.21.1909291810300.3346@hadrien> <90cea5d2-b586-6f82-34dd-d7a812f57396@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-964066602-1569780332=:4485"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-964066602-1569780332=:4485
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Sep 2019, Markus Elfring wrote:

> > Maybe the problem would be solved by putting virtual report at the top of the rule.
>
> I assume that support for the operation mode “patch” can eventually be considered.
>

Coccicheck requires that all rules support the report mode.

julia

>
> > But it might still fail because nothing can happen without a value
> > for the virtual metavariable ns.
>
> I imagine that the safe handling of this command line input parameter
> will trigger further software development concerns.
>
>
> > Should the coccinelle directory be only for things that work with make coccicheck,
>
> I hope not.
>
> But it seems that a filter command expressed such a restriction so far.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccicheck?id=02dc96ef6c25f990452c114c59d75c368a1f4c8f#n257
>
> Is this place an update candidate now?
>
>
> > or for all Coccinelle scripts?
>
> I would prefer file storage selections in this direction.
> How do you think about to improve the software taxonomy accordingly?
>
> Regards,
> Markus
>
--8323329-964066602-1569780332=:4485--
