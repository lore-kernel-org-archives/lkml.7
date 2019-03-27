Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2443C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C782082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WASTaHcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfC0Uoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:44:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32904 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfC0Uop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:44:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so15685022ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=v917pyRtGOyVkbOiDvAfnEAK+M55xmpSEek8ITXe/RI=;
        b=WASTaHcg1eNLAgVsdGJrRduZyaBfdO5Pl6rYKJBz+7ci5ZIrxglrw0N1J2f7yMBAt9
         5MqaXfIyE264Xyy1ixClc8aBxyMxhIKWkJrN8057u0KM4Lq3x7vQqVVhePBpBiVWq9o9
         NEatGec4Patv+Rd79BOGmWS/hD+z+qytF5SANrW/SqiTJe6Nedem8IXCSvN2KWSNU7hv
         Yzi58Nm22wvh9ybhNxI6HRgdlgzoixfg7dCSp8XuE72CZy3AlquL52tg84RHdfFH0+F0
         +1vvM+RMnHiPkC300MGN+/Qwthw+s5cWeuCRKlT9zt63faYy45VSyC5WmbikS99IoSa/
         IXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v917pyRtGOyVkbOiDvAfnEAK+M55xmpSEek8ITXe/RI=;
        b=B79umU1CDTaxYBWzyyi2ASHMoc5vggXwQZB1aLRtlaTr4sEi865Nxx43nz/L+jOR3z
         DqkxczDzVYt32Dr4qTszTmzfrSNcqZrATMJvRy27InfcZAwvmeuAlFr7c2e6N2txFn6+
         Jsmg/RZ5hsdR6BTqam5FQRke7WcPMwn1lw31Hd9b8nMHUqY8QruHrehWX75twhRh9I9Q
         Q/QBa9nIWcL707lOhGPl6MKuwlLxEmk+poZARBJCiEwY/uoSfQ6kR0FRxXbu2Nb5if9m
         Uje63lwaRE9VfhyDbCmnqcNeLaZMu/lE0REeOWrmTBHzP5K4y4ohUpsKGoTw3JKrVJmm
         tMGg==
X-Gm-Message-State: APjAAAVMrOmWdfhXHecQF8tUVZIBxCNyGql5s2vX5GpTvi9vtjI2YvGS
        C1dFjff9qqopmbxRvyqXNSvhcpwBuqc=
X-Google-Smtp-Source: APXvYqwU+pjuRnV7stiuLRi+ONwFVRTKQPLtxcnwsiNcP0u10bD9YpdbiluRPJ8EfOttBv59bJJIpg==
X-Received: by 2002:a2e:998d:: with SMTP id w13mr7279599lji.110.1553719482976;
        Wed, 27 Mar 2019 13:44:42 -0700 (PDT)
Received: from macbook.djakov.com ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id t14sm4682340lfl.38.2019.03.27.13.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 13:44:42 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commit in the icc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190328073843.18533a29@canb.auug.org.au>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <ba9f72b4-6298-22e2-8333-d719a4dced18@linaro.org>
Date:   Wed, 27 Mar 2019 22:44:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190328073843.18533a29@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.19 22:38, Stephen Rothwell wrote:
> Hi Georgi,
> 
> Commit
> 
>    dae6d5996c36 ("interconnect: convert to DEFINE_SHOW_ATTRIBUTE")
> 
> is missing a Signed-off-by from its committer.
> 

Thanks Stephen! It's fixed now.

BR,
Georgi
