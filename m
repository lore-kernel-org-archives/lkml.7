Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E71C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBE020835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfCGOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:53:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37668 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfCGOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:53:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so11447880pgq.4;
        Thu, 07 Mar 2019 06:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bdoZ2wBQsvoxteguFZGi30H3tRdkSuqlEalxoasUInE=;
        b=FcICmPxKDbgsNSF/qu+8C5JK0pRwmgJNawZl6OEX3Z1dRt7JJLVPgrvoe52EZfG5PM
         ujEORLg0IcltrumiblS1IimIiG+6mM3eK/BRlYdq5SEcjfrUzLRAcdFzfRoFU3sk0AtH
         AkO3Vsr3RfHP37K4PiYJ2QUWWsQfg0p2ka5kW0/gxxfG69prahWICdo0wsfPoirNHPYf
         KoIuXoQ3PWk9NHeycFz+regwaki6AVXsepx02IYiT7/Z8wUEuCqGI2y3r26LPx2sjYtA
         FBAFddcxFxEA3dz6XrPJqABC08n796kTi6QAtUAEA4o3fXARR8QSw5BvNFAPfTBnarKt
         8BIw==
X-Gm-Message-State: APjAAAUfLdl6ZvVGZNbQlBkT2y/kDb0drSz7pFtxe5+cxK2pGzuhxV0D
        1oC3y6UvcWc1z7vMNaosuWyZsriDHIc=
X-Google-Smtp-Source: APXvYqzyDKNb/KMKGyK+FFq5sSuoGCLv0l0mDFAT5QwsxEAAocA0S4RtIzONE6UDSVyz8sbh4+seNg==
X-Received: by 2002:a63:6a47:: with SMTP id f68mr11673623pgc.82.1551970436290;
        Thu, 07 Mar 2019 06:53:56 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id j4sm6682299pfn.132.2019.03.07.06.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 06:53:55 -0800 (PST)
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <20190307072428.GJ1789@mtr-leonro.mtl.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4d90c392-5b6a-fea0-e6cf-c49ac19fdf30@acm.org>
Date:   Thu, 7 Mar 2019 06:53:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307072428.GJ1789@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 11:24 PM, Leon Romanovsky wrote:
> My simple patch passes too :).

Can you repost your patch?

Thanks,

Bart.
