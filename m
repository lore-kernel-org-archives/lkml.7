Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75244C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4618520716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="URsFUMuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLQJug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:50:36 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:41182 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726859AbfLQJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:50:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576576235; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=3CUilBvV7ZA84ceFahgKnBFtukCYJ8i4/df1MQRWEkw=; b=URsFUMuLy7a8Eqwea9Ob3e90xawrRFmk4DXZrVcux0OqmiharYcRhar7jyS0a5tViny5aFXf
 46jzMm2+lvT3rPW+GoJ43pqwUF7y6L6l9iBCThfXb3JETqjNkQXbex89pi+Jc+bfFUFrKS2y
 /C5iDLZXt/CXVWajnjhWkOg90V0=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df8a4ea.7fb9893968f0-smtp-out-n02;
 Tue, 17 Dec 2019 09:50:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 700C9C447A5; Tue, 17 Dec 2019 09:50:34 +0000 (UTC)
Received: from [10.252.222.65] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3314FC447A2;
        Tue, 17 Dec 2019 09:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3314FC447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH] dt-bindings: geni-se: Convert QUP geni-se bindings to
 YAML
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org
References: <1576488351-22396-1-git-send-email-akashast@codeaurora.org>
 <5df7b3fa.1c69fb81.fa080.21a7@mx.google.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <70921be6-487b-ce59-ed71-4e7980dc66f4@codeaurora.org>
Date:   Tue, 17 Dec 2019 15:19:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5df7b3fa.1c69fb81.fa080.21a7@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/16/2019 10:12 PM, Stephen Boyd wrote:
> Quoting Akash Asthana (2019-12-16 01:25:51)
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>> new file mode 100644
>> index 0000000..2c3b911
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>> @@ -0,0 +1,196 @@
> [...]
>> +
>> +  "serial@[0-9]+$":
>> +    type: object
>> +    description: GENI Serial Engine based UART Controller.
>> +
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - qcom,geni-uart
>> +          - qcom,geni-debug-uart
>> +
>> +      reg:
>> +        description: GENI Serial Engine register address and length.
>> +
>> +      interrupts:
>> +        description: Contains UART core and wakeup interrupts for wakeup
>> +                     capable UART devices. We configure wakeup interrupt
>> +                     on UART RX line using TLMM interrupt controller.
>> +        maxItems: 2
> Shouldn't there be a minItems: 1 here? And then you should specify the order?
> Presumably something like
>
> 	interrupts:
> 	  minItems: 1
> 	  maxItems: 2
> 	  items:
> 	    - description: UART core irq
> 	    - description: Wakeup irq (RX GPIO)

Yeah ok, Thanks for correction.

I will update this in next version.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
