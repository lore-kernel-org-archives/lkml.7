Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B568C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6CC20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDAUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:04:23 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:28652
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbfDAUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:04:22 -0400
X-IronPort-AV: E=Sophos;i="5.60,297,1549926000"; 
   d="scan'208";a="301442042"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 22:04:20 +0200
Date:   Mon, 1 Apr 2019 22:04:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: Coccinelle: put_device: reduce false positives
In-Reply-To: <94e2410b-d474-be9e-a69f-3851e609eed3@web.de>
Message-ID: <alpine.DEB.2.21.1904012203490.2530@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn> <179bbdd1-3fcb-bba5-52b3-7f96973c7650@web.de> <alpine.DEB.2.21.1903232104030.5660@hadrien> <20190326084512.GC32590@kadam> <alpine.DEB.2.20.1903261037320.5021@hadrien> <20190326101103.GH32613@kadam>
 <alpine.DEB.2.20.1903261115300.5021@hadrien> <CAK7LNAT9gKvEX9520Sd50vrS7Gug1JQCMx_TJO_KPQjhjPORXw@mail.gmail.com> <94e2410b-d474-be9e-a69f-3851e609eed3@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Apr 2019, Markus Elfring wrote:

> > I added Fixes: tag,
> > and applied to linux-kbuild/fixes.
>
> Will this extension trigger further adjustments for similar SmPL scripts?
>
> Example:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/scripts/coccinelle/free/pci_free_consistent.cocci?id=f7b167113753e95ae61383e234f8d10142782ace

If there are false positives caused by this or other scripts, feel free to
submit a patch.

julia
