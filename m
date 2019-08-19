Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9F9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D1120851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HZHqeg1r";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HZHqeg1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfHSMbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:31:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHSMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:31:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 88FE660A96; Mon, 19 Aug 2019 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566217882;
        bh=PpdYrg45vf2/v6VBtZ0pykTG/0kZfje1oN8mQVSf3sQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HZHqeg1rXA0HwrRbeonX9p4DV/RfqXdtbnVAZKXi9Czl2LnSUiusbdP/QYPFN4KTj
         P8GlceZhNrKKTUVnMMKrxPRRn2GEoCtqlhXSRA6L2WHqWiC/ownYWhteuQpnBnvsRe
         1SbTwOd+0DNKQ02e6K5r2hWCskPCBmgKPWRYdnIQ=
Received: from [10.206.28.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 040AC607EB;
        Mon, 19 Aug 2019 12:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566217882;
        bh=PpdYrg45vf2/v6VBtZ0pykTG/0kZfje1oN8mQVSf3sQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HZHqeg1rXA0HwrRbeonX9p4DV/RfqXdtbnVAZKXi9Czl2LnSUiusbdP/QYPFN4KTj
         P8GlceZhNrKKTUVnMMKrxPRRn2GEoCtqlhXSRA6L2WHqWiC/ownYWhteuQpnBnvsRe
         1SbTwOd+0DNKQ02e6K5r2hWCskPCBmgKPWRYdnIQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 040AC607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1 1/2] clk: qcom: Add DT bindings for SC7180 gcc clock
 controller
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
References: <20190807181301.15326-1-tdas@codeaurora.org>
 <20190807181301.15326-2-tdas@codeaurora.org>
 <20190807221442.01F8D2173C@mail.kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <139b48fd-2fcc-c6bb-ae6b-fb8cbbd82def@codeaurora.org>
Date:   Mon, 19 Aug 2019 18:01:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807221442.01F8D2173C@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2019 3:44 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2019-08-07 11:13:00)
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
>> index 8661c3cd3ccf..18d95467cb36 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
>> @@ -23,6 +23,7 @@ Required properties :
>>                          "qcom,gcc-sdm630"
>>                          "qcom,gcc-sdm660"
>>                          "qcom,gcc-sdm845"
>> +                       "qcom,gcc-sc7180"
>>
>>   - reg : shall contain base register location and length
>>   - #clock-cells : shall contain 1
> 
> Can you please list the clk inputs that you're expecting now? Similar to
> what Vinod did for the other most recent GCC driver. We should probably
> convert this binding to YAML.
> 

Thanks Stephen for review, will send the YAML binding in the next patch 
series along with the clock inputs updated.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
