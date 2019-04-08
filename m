Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A25C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A34C20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfDHTTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:19:45 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52161
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbfDHTTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:19:44 -0400
X-IronPort-AV: E=Sophos;i="5.60,326,1549926000"; 
   d="scan'208";a="302216733"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 21:19:42 +0200
Date:   Mon, 8 Apr 2019 21:19:41 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
cc:     yamada.masahiro@socionext.com, Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: kstrdup: Fix typo in warning messages
In-Reply-To: <20190408191432.1269-1-rikard.falkeborn@gmail.com>
Message-ID: <alpine.DEB.2.21.1904082119190.2612@hadrien>
References: <20190408191432.1269-1-rikard.falkeborn@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Apr 2019, Rikard Falkeborn wrote:

> Replace 'kstrdep' with 'kstrdup' in warning messages.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Julia.Lawall@lip6.fr

Thanks for the patch!

julia

> ---
>  scripts/coccinelle/api/kstrdup.cocci | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/coccinelle/api/kstrdup.cocci b/scripts/coccinelle/api/kstrdup.cocci
> index 09cba54ed0cf..6d13d54a6ee6 100644
> --- a/scripts/coccinelle/api/kstrdup.cocci
> +++ b/scripts/coccinelle/api/kstrdup.cocci
> @@ -76,7 +76,7 @@ p1 << r1.p1;
>  p2 << r1.p2;
>  @@
>
> -cocci.print_main("WARNING opportunity for kstrdep",p1)
> +cocci.print_main("WARNING opportunity for kstrdup",p1)
>  cocci.print_secs("strcpy",p2)
>
>  @script:python depends on org@
> @@ -84,7 +84,7 @@ p1 << r2.p1;
>  p2 << r2.p2;
>  @@
>
> -cocci.print_main("WARNING opportunity for kstrdep",p1)
> +cocci.print_main("WARNING opportunity for kstrdup",p1)
>  cocci.print_secs("memcpy",p2)
>
>  @script:python depends on report@
> @@ -92,7 +92,7 @@ p1 << r1.p1;
>  p2 << r1.p2;
>  @@
>
> -msg = "WARNING opportunity for kstrdep (strcpy on line %s)" % (p2[0].line)
> +msg = "WARNING opportunity for kstrdup (strcpy on line %s)" % (p2[0].line)
>  coccilib.report.print_report(p1[0], msg)
>
>  @script:python depends on report@
> @@ -100,5 +100,5 @@ p1 << r2.p1;
>  p2 << r2.p2;
>  @@
>
> -msg = "WARNING opportunity for kstrdep (memcpy on line %s)" % (p2[0].line)
> +msg = "WARNING opportunity for kstrdup (memcpy on line %s)" % (p2[0].line)
>  coccilib.report.print_report(p1[0], msg)
> --
> 2.21.0
>
>
