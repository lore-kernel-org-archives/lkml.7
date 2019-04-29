Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C977C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E822054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lq16odbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfD2IhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:37:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42607 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbfD2IhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:37:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so14676161wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=agVhEcGJdzb8562le7X/E/t0SK2Qx5M+g8VydHvaGpw=;
        b=lq16odbprAohUmfTfhpjj8gwQRF2zrgU+73q9yPr0yG1qXQSw9Y7XOZsEOUnZYLB8n
         bvjiUbNiaOHWyCSsvx+cjQO9j6VVI1/sDo3QurO40SfgaqzS8+ASyI+HnSsquqyfFDS0
         RMO350H6EJk48pioJ1cXZgOyGcdJ4urzFvWywO30B6hjh+IAaUDlrlsqpYCvYpdnHF0q
         BTtbRhipt48ijn6jptwQOEraWz8ywX0GQ48qehCgr7x7gmm4N2rJJmLrbTM4KZ/D5Bbj
         4viIXdZwwnzpDOa0o2YYeQjbIJJyFokSGwUp0AhdA1++XCkQaajIy8Zam2AYpt6VzrxF
         9CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=agVhEcGJdzb8562le7X/E/t0SK2Qx5M+g8VydHvaGpw=;
        b=PgkRjn8I4oqQ/F8qzjsTmZVze0FDTGb8HIfU3C4RMkSIzVBBNCjP2KdT/idXBKReV5
         TjVZeFWLnMKrDfcH1sewv48hfcD+eErBlY/cLGDn73EVSTOb1Lm+a1xgGbrE/0Q2UBxL
         lLrf5r7lZoJFEdnnVIMntRKoi+ry4acdoNcDGbtWhwmlHFUwU9cs0q7s/l3nmQlXtaEK
         5P+o6WlzzU8aEVoCZtgaE/CNKhtm3ACrKN0hERsRFR04BCQTJ6Qna6rXO3JP5NJQfB0d
         54B3rsZCpXH9154mn9LDvgWhftnf6Q+5brHq643poQI9r63gJYzrsHqrTMpP37avd8T4
         4viA==
X-Gm-Message-State: APjAAAW/49R8gqcTne33BpWLVchxMFxZkJRfA4ZkOVUpOR8Pac8s0+gL
        PWdryy8VMdgttQMSIAaYmCXIlg==
X-Google-Smtp-Source: APXvYqzOyqpOYA4BkuCjFmiDaYK22kcc5UFlaSUyptCSLjIeOdwpilmAXSobxLWvkP1nEd/Rgw7HDQ==
X-Received: by 2002:a05:6000:1108:: with SMTP id z8mr4892366wrw.317.1556527029587;
        Mon, 29 Apr 2019 01:37:09 -0700 (PDT)
Received: from [192.168.0.41] (129.201.95.92.rev.sfr.net. [92.95.201.129])
        by smtp.googlemail.com with ESMTPSA id y70sm7766358wmc.8.2019.04.29.01.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 01:37:09 -0700 (PDT)
Subject: Re: [PATCH - resend 1/3] thermal/drivers/cpu_cooling: Fixup the
 header and copyright
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
 <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a7b26683-0514-fd58-f5b1-d9128e490b84@linaro.org>
Date:   Mon, 29 Apr 2019 10:37:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2019 07:43, Viresh Kumar wrote:
> On 28-04-19, 11:51, Daniel Lezcano wrote:
>> The copyright format does not conform to the format requested by
>> Linaro: https://wiki.linaro.org/Copyright
>>
>> Fix it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Viresh Kumar <viresh.kumar@linaro.org>
> 
> What exactly have I done here ? :)

Argh!

Thanks for spotting it.


>> ---
>>  drivers/thermal/cpu_cooling.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index ee8419a6390c..42aeb9087cab 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -2,9 +2,11 @@
>>   *  linux/drivers/thermal/cpu_cooling.c
>>   *
>>   *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
>> - *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>>   *
>> - *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
>> + *  Copyright (C) 2012-2018 Linaro Limited.
>> + *
>> + *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
>> + *		Viresh Kumar <viresh.kumar@linaro.org>
>>   *
>>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   *  This program is free software; you can redistribute it and/or modify
>> -- 
>> 2.17.1
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

