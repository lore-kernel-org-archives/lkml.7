Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED11CC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37CA206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RDk+DMH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfL0Goi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 01:44:38 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:34940 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfL0Gog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 01:44:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577429076; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=3CSvDtpGg7KClQhTEdyBaheE3oP4+TR2kHYW+0myb+w=; b=RDk+DMH7I3mtSYQlr5mETwOT8ufi7JvVejwmOtVuc/yYRIuNHwOfMNIoxqI6ReLl4NYo6ddg
 HyX9Kjl/kWxZF2pNdjHBMobbCF3Q6CB/dMs2TBsrR9HbFOyHgdYpZZzBNRnuf6y1pfkPy+sS
 s5daWHA9I8BIHGcjv3fcRDQ2RmQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e05a852.7f2673138ed8-smtp-out-n03;
 Fri, 27 Dec 2019 06:44:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 76EF2C433CB; Fri, 27 Dec 2019 06:44:34 +0000 (UTC)
Received: from [10.206.28.9] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DDE2C447A0;
        Fri, 27 Dec 2019 06:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DDE2C447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 0/8] Add GPU & Video Clock controller driver for SC7180
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org
References: <1573812304-24074-1-git-send-email-tdas@codeaurora.org>
 <20191224023250.5A3EC206D3@mail.kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <c2906227-fc53-895c-824c-13f4b69a3610@codeaurora.org>
Date:   Fri, 27 Dec 2019 12:14:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191224023250.5A3EC206D3@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/24/2019 8:02 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2019-11-15 02:04:56)
>> [v2]
>>   * Split Fabia code cleanup and calibration code.
>>   * Few cleanups for GPU/Video CC are
>>      * header file inclusion, const for pll vco table.
>>      * removal of always enabled clock from gpucc.
>>      * compatibles added in sorted order.
>>      * move from core_initcall to subsys_initcall().
>>      * cleanup clk_parent_data for clocks to be provided from DT.
> 
> Can you please resend with comments addressed?
> 

Next patches are submitted for review.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
