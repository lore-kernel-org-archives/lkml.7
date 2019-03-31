Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FB9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B3720882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTlrkwhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfCaGnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:43:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35727 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfCaGnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:43:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so3168593pgf.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/n4niWVQi8jTBY6ilEtFcT+UjcEGI3MHmo1ftQPG2DY=;
        b=iTlrkwhXeC2mCKfqCscakW+Z89avQzGqRnkxt9kP5PzlFkonDew+mM8Wl4cKLVrK0O
         iEWT4qX5VC7VV/wpZncYjsXeqVBEd3GGb6k4j3rYtWEUPcxgL52gBz+QJ8t8B/wPZFV+
         E/xBWjHLEdr4nTUKyNYuXQuc4cTZ7w/ljqPvAd9sLo7+IP/OKqr8wHtfDCxTpJOflpEZ
         vWVZa9ufh9qNU+aBoXqy72jSP3vfrNNfzLJlINd2qwdSY9On7xlT0e5lrp9XFlCUlT9l
         E4wvBZkxeMhURzqBa/W68LOv5YWTTBY5iVmmTEw//sT6LoGc8JkxyQY+1YyiYltMcSa+
         QVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/n4niWVQi8jTBY6ilEtFcT+UjcEGI3MHmo1ftQPG2DY=;
        b=TFam0H3oE4dRxnJM3ZMGlpnoMrjDdPwFdE1eeSQmF38ICEbB4+9pzVMftwGS6IAI4E
         BnMYEgivycrIhhF1m0z2Z4Kbb+BE00YuPQ9GwfDRN4C0UEN7NT+wRkzS2WQoRLhKEaBX
         e8V0sHRsI8Z8A2tXIA5ZtXNHqq0gRqGKA7wlnNrkYXYbsgYeUGG9TxZdDGAeU5aAV1SU
         HW6+9YQyrgEfc3RwdzdlXw88b+/FDEWpVOeD7r0CnWIAo6lFyZtQbAg9ISIZl+my30s9
         ryZ7jZvS0Ms7oc4s+h+oGyIif4fjH2JysVv9ypjDQgkb1y3nQ9yzi2jC0WoBIR+B+HkQ
         GSSA==
X-Gm-Message-State: APjAAAWcdX3Pj+dZtCxBiznE24aZaoRatZ6K7xn639nK2hMH17HcAJuS
        LUwWQaKwr9GSehM5eCETAQd3wQ==
X-Google-Smtp-Source: APXvYqydfW5dvS0ONN522kI06NlMKm3Ha5qMXZ8ZqKIM2MXwFXtQhOLPtiLv83XcXSOpV3OCjtMIgQ==
X-Received: by 2002:a63:530e:: with SMTP id h14mr30589531pgb.136.1554014603264;
        Sat, 30 Mar 2019 23:43:23 -0700 (PDT)
Received: from [10.71.10.192] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id p17sm9701480pfn.157.2019.03.30.23.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 23:43:22 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] Staging: greybus: usb: Fixed a coding style
 error
To:     Joe Perches <joe@perches.com>,
        Will Cunningham <wjcunningham7@gmail.com>, johan@kernel.org
Cc:     devel@driverdev.osuosl.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20190331053040.GA12974@titus.pi.local>
 <41750e16d14a967529d7cb5e315110ee5ccd313c.camel@perches.com>
 <5c95c177-b8fe-ab0b-eb7a-d270e35a7ce6@linaro.org>
 <8b6afee25fe6d2248353015fe2303d793b2a1d49.camel@perches.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <65efe8c2-3091-61d5-3eb6-fcc505727394@linaro.org>
Date:   Sun, 31 Mar 2019 01:43:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8b6afee25fe6d2248353015fe2303d793b2a1d49.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/19 1:40 AM, Joe Perches wrote:
> On Sun, 2019-03-31 at 01:20 -0500, Alex Elder wrote:
>> On 3/31/19 1:04 AM, Joe Perches wrote:
>>> Blind adherence to 80 column limits leads to poor looking
>>> code.  Especially with longish identifier lengths.
>> I agree.  If it were me, I'd use a local variable.  For example:
>>
>> 	struct greybus_descriptor_cport *cport_desc = gbphy_dev->cport_desc;
>> 	...
>> 	connection = gb_connection_create(gbphy_dev->bundle,
>> 					  le16_to_cpu(cport_desc->id), NULL);
>>
>> Or maybe better:
>>
>> 	u16 cport_id = le16_to_cpu(gbphy_dev->cport_desc->id);
>> 	...
>> 	connection = gb_connection_create(gbphy_dev->bundle, cport_id, NULL);
> 
> True.
> 
> A possible negative though:
> 
> Temporaries that are only used once are sometimes
> less readable as the declaration is supposed to be
> done at an open brace and that could be relatively
> far away from the set and use.

Then assign it where it's used.  The point is we're talking about
a readability issue (long lines), and no matter how you try to fix
it there are tradeoffs, and it's subjective.  In any case, I prefer
the use of the local variable to solve this readability problem over
splitting the line.

					-Alex

