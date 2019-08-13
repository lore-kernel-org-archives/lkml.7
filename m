Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440B2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C04020842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfHMVUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:20:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38642 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfHMVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:20:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id x4so9889713qts.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0y+xA4yq9k1MfUYROc/R4ymqEbAd0mXn2MH3goPeuIk=;
        b=spGI6IyA+KlaTio+zh3z8WjPksQj/SQtCiIhVUZF1mJoxJIyZChMqIRIMpZeYv1t1K
         GSHDjWfSakJmyTJOPntsr6OOERPLD1M37ujkmijjqMbe2w69cRtomO6qtviIaMs7wkbA
         3BmR8Mpn1bUTDCT7DxJneOT9/4F3AMEC4ftFmNV3Afm1f72XEbEVIaAiVoePheJwJTfT
         u4JTprG7JPjtBHasSrXBtcHAKiFVSY+3P8cJdICp2wdL2vV9jL4UN4ApjtHusnGoK8za
         fAiKJXPZTwFRHNFc0fVdxx33Fwl9a5hrvJiG+lX4eJ66VXTRaYCZfS/L8im7+tBn3Kin
         we1g==
X-Gm-Message-State: APjAAAV6IOj1Zzv6A2Z1u5Kl0Pea3rdkvvnExTmkNHbEvV/boZlYsrLC
        INDXe/3O90sZHc29PMiztHg=
X-Google-Smtp-Source: APXvYqyW2z3U2drQntXGk1OXXbAuNi4yvbuF8dvDKv04BFli2qxyjK3BWTjJkRISMZgumOIjY3fDfg==
X-Received: by 2002:ac8:7593:: with SMTP id s19mr27841639qtq.136.1565731241516;
        Tue, 13 Aug 2019 14:20:41 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id r15sm6983815qkm.27.2019.08.13.14.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2019 14:20:40 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Remove FMC subsystem
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Federico Vaga <federico.vaga@cern.ch>,
        Pat Riehecky <riehecky@fnal.gov>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190813061547.17847-1-efremov@linux.com>
 <CACRpkdaAE6RA1iQ-iqK3GGHOovTkuDDqi8vcoFnmG8UBwuim8w@mail.gmail.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <e52ce7fa-c4fc-04b4-36fb-a89222024d2e@linux.com>
Date:   Wed, 14 Aug 2019 00:20:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaAE6RA1iQ-iqK3GGHOovTkuDDqi8vcoFnmG8UBwuim8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.2019 11:54, Linus Walleij wrote:
> On Tue, Aug 13, 2019 at 8:15 AM Denis Efremov <efremov@linux.com> wrote:
> 
>> Cleanup MAINTAINERS from FMC record since the subsystem was removed.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Federico Vaga <federico.vaga@cern.ch>
>> Cc: Pat Riehecky <riehecky@fnal.gov>
>> Fixes: 6a80b30086b8 ("fmc: Delete the FMC subsystem")
>> Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Do you need help to merge the patch? I can take it in the
> GPIO tree since the subsystem was removed there.

Yes, please. I kindly ask you to take this patch in your tree.

Thanks,
Denis
