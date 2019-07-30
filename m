Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00812C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DD22087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfG3Lfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:35:36 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35318 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbfG3Lfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:35:36 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hsQPj-0008IG-Us; Tue, 30 Jul 2019 21:35:32 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hsQPh-000201-KB; Tue, 30 Jul 2019 21:35:29 +1000
Date:   Tue, 30 Jul 2019 21:35:29 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: tool: getstat: Fix unterminated strncpy
Message-ID: <20190730113529.GB7595@gondor.apana.org.au>
References: <20190730084018.26374-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730084018.26374-1-hslester96@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 04:40:18PM +0800, Chuhong Yuan wrote:
> strncpy(dest, src, strlen(src)) leads to unterminated
> dest, which is dangerous.
> Fix it by using strscpy.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  tools/crypto/getstat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This file no longer exists in cryptodev.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
