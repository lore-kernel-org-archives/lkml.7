Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1BCC17447
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E8206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKLCPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 21:15:15 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:35330 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfKLCPP (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Mon, 11 Nov 2019 21:15:15 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iULi1-0007XR-N1; Tue, 12 Nov 2019 10:15:09 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iULhz-0004Xt-II; Tue, 12 Nov 2019 10:15:07 +0800
Date:   Tue, 12 Nov 2019 10:15:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, cyrille.pitchen@atmel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH -next] crypto: atmel - Fix randbuild error
Message-ID: <20191112021507.y52sqecdaotqptcf@gondor.apana.org.au>
References: <20191111133901.19164-1-yuehaibing@huawei.com>
 <20191112021350.qu44becwmwom7ywu@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112021350.qu44becwmwom7ywu@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:13:50AM +0800, Herbert Xu wrote:
>
> What we should do instead is turn DEV_ATMEL_AUTHENC into a bool,

Oh and DEV_ATMEL_AUTHENC should also depend on CRYPTO_DEV_ATMEL_AES
and lose all its selects.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
