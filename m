Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0474EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58A021479
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405007AbfHHXwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:52:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42456 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404428AbfHHXwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:52:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so125832234otn.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BuINmdazurXK5+WrNJ+ko6c/f8RaM+9Qyl91UH0I+j4=;
        b=tMA2UDzxm7YPTkQH0+RNQGcYk4zfjHA0ZAGaWWaOzNVdgMEIE7bku7Y1cj+zTp+kQ9
         i7M7qKEaoM1g3JNoMmxpU/cIVZp6JtFlFdCU4nnXwAGFdfflFjNNiJjsfbrxp5lodYuK
         3T40r248WAnPtP0/jsFVS4MnT7aawiwnEk+sA3pDDXRw0XDUjEKx3YVbeLtsDKyGULv7
         yJdqss6d02AUuKhXCOEASjQawfR/WstuyEIxUIP5/PJd4rZSLpgx6Mx5BxVA6OZApcFp
         26hknLKwH4OzDF4nfRI3QnjZeVveiJXNzmaFOtHHSgcSw71fpX+kKNJrNbQEILbYZvtU
         KPCg==
X-Gm-Message-State: APjAAAWzSSIX/ix00mHFZGzoE6APIsHqWEoad1540ZA4e9xdnXmov/ME
        PppQJlKYHyoWer3tydDynr8=
X-Google-Smtp-Source: APXvYqyWQgS9fIp7TU4wimr49b/zUxZEM2Sj2YO/+yAesfN7o7AKZlemB5ZB2XLZqatez/v/u+m2aA==
X-Received: by 2002:a9d:458f:: with SMTP id x15mr14420046ote.314.1565308331036;
        Thu, 08 Aug 2019 16:52:11 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id x19sm32064757oto.42.2019.08.08.16.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 16:52:10 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] nvme-pci: Support for Apple 201+ (T2 chip)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>
References: <20190807075122.6247-1-benh@kernel.crashing.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ae14ef26-b4a5-1ef2-e2a9-581e813893fe@grimberg.me>
Date:   Thu, 8 Aug 2019 16:52:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807075122.6247-1-benh@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This series combines the original series and an updated version of the
> shared tags patch, and is rebased on nvme-5.4.
> 
> This adds support for the controller found in recent Apple machines
> which is basically a SW emulated NVME controller in the T2 chip.
> 
> The original reverse engineering work was done by
> Paul Pawlowski <paul@mrarm.io>.

Thanks, pulled to nvme-5.4
