Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A110C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA6521726
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyVI902L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfCaGUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:20:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44503 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfCaGUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:20:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so2913052pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 23:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5iSzvmBZ185g3r5prUMNlBUrqHP2e0lRMJA3YXzhNds=;
        b=kyVI902LMHqMjqSL+r/7CQKA6B64zwqVF9Xo/6BMNdkXRN/27UnpFE+v+bAgF8Jjmx
         Ka8Xc2dtp4r0c76bpKaIjcgoC52bM1X55KmbzZ6YCUKI9aHH6kn0Dtd7TyB6ek2dbE8+
         NLKo2GTIPKgF9q6N8yJb2RmflypK6MoDHbMhEmob84FvX2bTKvvz2A5U4ITd7W5ECkwr
         AyKXOaGWL+5ixyTBNGe4fRWxWqwzarZUZi+o9LHEN3LzEqDN8NNLUWHbv1nbFVcRzEEc
         +620avVJiC2v9OLdv4Gh3Kg5LBTGN6qFv44SdKBwD5Twrvbqg9WekfiUSejQCmBwe/Gp
         0o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5iSzvmBZ185g3r5prUMNlBUrqHP2e0lRMJA3YXzhNds=;
        b=A4t3BJuGnqt2UCmQBP0m2CAtnC1NKVhc34M7h/5qgMDvTFEwjYK/BIoekUaMRxtHNq
         CDaXalfkYxxLleCoREsRvmJGxHFkDtVZ8Jqw8mLXkUdkn+DyFEZFPE4hNpLvEorLpD8J
         26uF3XZvOcs4rj5vW15fKuuKJuH2yw6zzbn8XfprOQDfpTf/nOW54wYzAtyC3Y4dbeAT
         /F/KcPi/Hs4ESydm7N4M7NUXFObfo5bWpDWFS2gf/BMQcOudSNhHUqIN/bQTbZBSa4HT
         LsyCndK3EoLt/jfCzR0x3Kj52ovVuV+N626UZu0gybf2Wi0SBbPCSW6AzI4yELQNCJav
         m3JQ==
X-Gm-Message-State: APjAAAUG+crsaV9maHMRj+2zG892crhBTGwJ7fsZvbu6T1jVp1VB08lc
        5Pg1emWJhpFZhG14M8TVbu+itA==
X-Google-Smtp-Source: APXvYqwGWH5dGvXdBCSJB0SFbUIFnZAP/fwd5hXcR4+wY5LkQT9IYxGUUHcse1Z2TUIdbiVym4tvZA==
X-Received: by 2002:a17:902:8f92:: with SMTP id z18mr5361997plo.123.1554013221039;
        Sat, 30 Mar 2019 23:20:21 -0700 (PDT)
Received: from [10.71.10.192] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id p2sm22948796pfi.73.2019.03.30.23.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 23:20:20 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] Staging: greybus: usb: Fixed a coding style
 error
To:     Joe Perches <joe@perches.com>,
        Will Cunningham <wjcunningham7@gmail.com>, johan@kernel.org
Cc:     devel@driverdev.osuosl.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20190331053040.GA12974@titus.pi.local>
 <41750e16d14a967529d7cb5e315110ee5ccd313c.camel@perches.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <5c95c177-b8fe-ab0b-eb7a-d270e35a7ce6@linaro.org>
Date:   Sun, 31 Mar 2019 01:20:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <41750e16d14a967529d7cb5e315110ee5ccd313c.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/19 1:04 AM, Joe Perches wrote:
> On Sun, 2019-03-31 at 01:30 -0400, Will Cunningham wrote:
>> Line was >80 characters.
> []
>> diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
> []
>> @@ -169,8 +169,8 @@ static int gb_usb_probe(struct gbphy_device *gbphy_dev,
>>  		return -ENOMEM;
>>  
>>  	connection = gb_connection_create(gbphy_dev->bundle,
>> -					  le16_to_cpu(gbphy_dev->cport_desc->id),
>> -					  NULL);
>> +				le16_to_cpu(gbphy_dev->cport_desc->id),
>> +				NULL);
> 
> Blind adherence to 80 column limits leads to poor looking
> code.  Especially with longish identifier lengths.

I agree.  If it were me, I'd use a local variable.  For example:

        struct greybus_descriptor_cport *cport_desc = gbphy_dev->cport_desc;

	...

        connection = gb_connection_create(gbphy_dev->bundle,
                                          le16_to_cpu(cport_desc->id), NULL);

Or maybe better:

	u16 cport_id = le16_to_cpu(gbphy_dev->cport_desc->id);

	...

        connection = gb_connection_create(gbphy_dev->bundle, cport_id, NULL);

					-Alex




> 
> Another way to do this, which is not necessarily actually
> better is to position the left side of the assignment on a
> separate line like:
> 
> 	connection =
> 		 gb_connection_create(gbphy_dev->bundle,
> 				      le16_to_cpu(gbphy_dev->cport_desc->id),
> 
> Is that better?  <shrug>  I prefer the original.
> It was better before as it was aligned to open parenthesis.
> 
> 
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 

