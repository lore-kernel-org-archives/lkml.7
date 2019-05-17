Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15BDC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772422083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfEQGAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 02:00:15 -0400
Received: from [128.1.224.119] ([128.1.224.119]:54042 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbfEQGAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 02:00:15 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hRVuf-0007s2-In; Fri, 17 May 2019 14:00:13 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hRVua-0000Y1-Ne; Fri, 17 May 2019 14:00:08 +0800
Date:   Fri, 17 May 2019 14:00:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: caam - fix typo in i.MX6 devices list for errata
Message-ID: <20190517060008.pcjwjlsiscmjtlht@gondor.apana.org.au>
References: <1557853989-29075-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557853989-29075-1-git-send-email-iuliana.prodan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 08:13:09PM +0300, Iuliana Prodan wrote:
> Fix a typo in the list of i.MX6 devices affected by an
> issue wherein AXI bus transactions may not occur in
> the correct order.
> 
> Fixes: 33d69455e402 ("crypto: caam - limit AXI pipeline to a depth of
> 1")
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  drivers/crypto/caam/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
