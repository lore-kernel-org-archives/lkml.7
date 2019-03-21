Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1450F218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCUU6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:58:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53224 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfCUU6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:58:22 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 60CAD133E9775;
        Thu, 21 Mar 2019 13:58:22 -0700 (PDT)
Date:   Thu, 21 Mar 2019 13:58:22 -0700 (PDT)
Message-Id: <20190321.135822.1822446805173888702.davem@davemloft.net>
To:     herbert@gondor.apana.org.au
Cc:     joshhunt00@gmail.com, jelsasser@appneta.com, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] rhashtable: Still do rehash when we get EEXIST
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190321014615.lepugrlvdff6smkn@gondor.apana.org.au>
References: <CAKA=qzY4Pzee9BVzRCciW32toeHSz7t0q9LuvQXKLG2fX9fBbg@mail.gmail.com>
        <20190321013952.3quw6bsqptyngzo5@gondor.apana.org.au>
        <20190321014615.lepugrlvdff6smkn@gondor.apana.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Mar 2019 13:58:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 21 Mar 2019 09:46:15 +0800

> On Thu, Mar 21, 2019 at 09:39:52AM +0800, Herbert Xu wrote:
>>
>> Dave, could you please apply this? Thanks!
> 
> I forgot to include the tested-by so here it is for patchwork:
> 
> Tested-by: Josh Elsasser <jelsasser@appneta.com>

Thanks for providing this.
