Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5106FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CDE20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfCZVbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:31:14 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:7115 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731617AbfCZVbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:31:14 -0400
X-IronPort-AV: E=Sophos;i="5.60,274,1549926000"; 
   d="scan'208";a="300825014"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 22:31:11 +0100
Date:   Tue, 26 Mar 2019 22:31:11 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Michael Stefaniuc <mstefani@mykolab.com>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] scripts: coccinelle: Fix description of badty.cocci
In-Reply-To: <20190326212200.21168-1-mstefani@mykolab.com>
Message-ID: <alpine.DEB.2.21.1903262230490.3044@hadrien>
References: <20190326212200.21168-1-mstefani@mykolab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Mar 2019, Michael Stefaniuc wrote:

> Summary was copy and pasted from array_size.cocci.
>
> Signed-off-by: Michael Stefaniuc <mstefani@mykolab.com>
> ---
>  scripts/coccinelle/misc/badty.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/misc/badty.cocci b/scripts/coccinelle/misc/badty.cocci
> index 481cf301ccfc..08470362199c 100644
> --- a/scripts/coccinelle/misc/badty.cocci
> +++ b/scripts/coccinelle/misc/badty.cocci
> @@ -1,4 +1,4 @@
> -/// Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element
> +/// Correct the size argument to alloc functions

Oops!  Thanks.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>



>  ///
>  //# This makes an effort to find cases where the argument to sizeof is wrong
>  //# in memory allocation functions by checking the type of the allocated memory
> --
> 2.20.1
>
>
