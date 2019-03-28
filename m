Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A69C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF742075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rEJVab+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfC1NYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:24:23 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50839 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1NYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:24:22 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2SDOFbG011926
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 22:24:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2SDOFbG011926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553779455;
        bh=rg6O0bH8r6eBYFN10boIZbRo4/182uJ7aj8JKWzN1HE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rEJVab+7NT1fi9v4cUHPhc+cGIrfUDDj5OIt23+pkemXA/RuZxxcDCavv8Q5LTULX
         p7uFugMzQF2G+ejexHz9NXs755teH5L/HPXLFSZw5w/pqIuvphheHpKTw9yGXIDjnT
         aFAU04Jbx2m270wD+d+0VfEismSw+ILedJ9pqJU0bxewucCdtuHxA8swkMvlrd+1rq
         Rj+bS4h4+qwkRGez3UWsapMqHbQ8Vjt2zcIAsg1rk/oT15Ite/YockYOjPRlruBmfJ
         HTPg9ok1PIkucoQKV59zbXZd290z49y801b8Rno/TmQVKnyQMy5Sn0Nv0aIrJu4SJm
         cNYeqhGsHYA+g==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id d4so6829899uap.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 06:24:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVBSze0MRw5IvYmrjSMlcgni4eDiutXckxs4JHLVbC1MPAg++2S
        9vhayeq5ulm2WGXEQSy9cWo4PdBezp9SmxsGW6o=
X-Google-Smtp-Source: APXvYqzbT/uN4geExS7/rbsLhrJbQYZQZuCwZauULmqbWd8/qfUIg1+Sw6L6N4dbKQuu3ntu/DFI3SBh7V1q4RNKD8o=
X-Received: by 2002:ab0:7493:: with SMTP id n19mr24651111uap.121.1553779454420;
 Thu, 28 Mar 2019 06:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190326212200.21168-1-mstefani@mykolab.com>
In-Reply-To: <20190326212200.21168-1-mstefani@mykolab.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 28 Mar 2019 22:23:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQgYBpELOiXd7zYsK+d-jMDuoj-wD7nPb847oGFfWvHGA@mail.gmail.com>
Message-ID: <CAK7LNAQgYBpELOiXd7zYsK+d-jMDuoj-wD7nPb847oGFfWvHGA@mail.gmail.com>
Subject: Re: [PATCH] scripts: coccinelle: Fix description of badty.cocci
To:     Michael Stefaniuc <mstefani@mykolab.com>
Cc:     cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 6:24 AM Michael Stefaniuc <mstefani@mykolab.com> wrote:
>
> Summary was copy and pasted from array_size.cocci.
>
> Signed-off-by: Michael Stefaniuc <mstefani@mykolab.com>


Applied to linux-kbuild/fixes. Thanks.


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
>  ///
>  //# This makes an effort to find cases where the argument to sizeof is wrong
>  //# in memory allocation functions by checking the type of the allocated memory
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
