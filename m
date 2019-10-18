Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C02CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1628222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VhXGib72";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aCVuMCz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410487AbfJRPZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:25:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56290 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406633AbfJRPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:25:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91B9B60A0A; Fri, 18 Oct 2019 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571412313;
        bh=LHeUP3VNTKAVLeAs05C0PcwWEJt3gamUsr2irOrRhp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VhXGib720fQw8hco8AqyzOug+2BiFus6Kcn8+RTTXpnbhDC+e0oC437rJ/0UbbjQx
         RoQKmod8TutYolDnn4OIqDivZ+GtY74yzHKxrbJUPkjCKDkNwy/I8z2r9xOiFMNv0p
         rNCDQ+HeIdTb2zwkph6et1y2lUs9+OgI3AzEYv7o=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B79BF609C4;
        Fri, 18 Oct 2019 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571412312;
        bh=LHeUP3VNTKAVLeAs05C0PcwWEJt3gamUsr2irOrRhp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aCVuMCz8LsHuHec1dAaNfyYP+tZCgA3IJv7crZRZQFtBvNfF1Zw8wuAm/opZ3n5aq
         Up1tdFZ5DXN0zLzMi/RemwzDwrTGfeWB0Q90NVQ3ANOyg8jggEEfzmZXutJcK17aQa
         D2XwyZ3NOO0rP6tqZZXpFJoEnO09jXcpdQDhU0x8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Oct 2019 20:55:12 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: llcc: Add configuration data for SC7180
In-Reply-To: <5da9ccba.1c69fb81.3cae7.0064@mx.google.com>
References: <cover.1571406041.git.saiprakash.ranjan@codeaurora.org>
 <d0fd71fbeff6cd040335846cb65e125a89412d43.1571406041.git.saiprakash.ranjan@codeaurora.org>
 <5da9ccba.1c69fb81.3cae7.0064@mx.google.com>
Message-ID: <48921db5b5d5b713f971af60bf96642a@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-18 20:01, Stephen Boyd wrote:
> Quoting Sai Prakash Ranjan (2019-10-18 06:57:08)
>> diff --git a/drivers/soc/qcom/llcc-qcom.c 
>> b/drivers/soc/qcom/llcc-qcom.c
>> index 4bd982a294ce..4acb52f8536b 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -91,6 +91,13 @@ struct qcom_llcc_config {
>>         int size;
>>  };
>> 
>> +static struct llcc_slice_config sc7180_data[] =  {
> 
> const?
> 

Will do in next version.

>> +       { LLCC_CPUSS,    1,  256, 1, 0, 0xf, 0x0, 0, 0, 0, 1, 1 },
>> +       { LLCC_MDM,      8,  128, 1, 0, 0xf, 0x0, 0, 0, 0, 1, 0 },
>> +       { LLCC_GPUHTW,   11, 128, 1, 0, 0xf, 0x0, 0, 0, 0, 1, 0 },
>> +       { LLCC_GPU,      12, 128, 1, 0, 0xf, 0x0, 0, 0, 0, 1, 0 },
>> +};
>> +
>>  static struct llcc_slice_config sdm845_data[] =  {
> 
> This one should be const too I guess but it's not part of this patch.
> 

Will change this as well.

>>         { LLCC_CPUSS,    1,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 1 
>> },
>>         { LLCC_VIDSC0,   2,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0 
>> },
>> @@ -112,6 +119,11 @@ static struct llcc_slice_config sdm845_data[] =  
>> {
>>         { LLCC_AUDHW,    22, 1024, 1, 1, 0xffc, 0x2,   0, 0, 1, 1, 0 
>> },
>>  };
>> 
>> +static const struct qcom_llcc_config sc7180_cfg = {
>> +       .sct_data       = sc7180_data,
>> +       .size           = ARRAY_SIZE(sc7180_data),
>> +};
>> +
>>  static const struct qcom_llcc_config sdm845_cfg = {
>>         .sct_data       = sdm845_data,
>>         .size           = ARRAY_SIZE(sdm845_data),
> 
> Otherwise looks OK to me.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
