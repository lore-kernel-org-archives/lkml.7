Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F21CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E05218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfCUBqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:46:23 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:57530 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfCUBqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:46:22 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1h6mmg-0006cO-Dz; Thu, 21 Mar 2019 09:46:18 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1h6mmd-0002dO-Sx; Thu, 21 Mar 2019 09:46:15 +0800
Date:   Thu, 21 Mar 2019 09:46:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Josh Hunt <joshhunt00@gmail.com>
Cc:     Josh Elsasser <jelsasser@appneta.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Graf <tgraf@suug.ch>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH] rhashtable: Still do rehash when we get EEXIST
Message-ID: <20190321014615.lepugrlvdff6smkn@gondor.apana.org.au>
References: <20190123211758.104275-1-jelsasser@appneta.com>
 <20190124030841.n4jtsqka5zji3e62@gondor.apana.org.au>
 <D5A6C2E7-2AB1-46D0-8876-2D6AAAA3937F@appneta.com>
 <A247F887-832E-44AD-AC41-C22E124E44EE@appneta.com>
 <CAKA=qzY4Pzee9BVzRCciW32toeHSz7t0q9LuvQXKLG2fX9fBbg@mail.gmail.com>
 <20190321013952.3quw6bsqptyngzo5@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321013952.3quw6bsqptyngzo5@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 09:39:52AM +0800, Herbert Xu wrote:
>
> Dave, could you please apply this? Thanks!

I forgot to include the tested-by so here it is for patchwork:

Tested-by: Josh Elsasser <jelsasser@appneta.com>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
