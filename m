Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C6AC2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FF72072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="me620dy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfL3JLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:11:01 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:32037 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbfL3JLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:11:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577697060; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=mqSVD307H7KfRIlgHTgsORGzqh16/74mQbEwil/iTos=; b=me620dy17NDq+WtrzSKRyhVpQKOTSxGKe0x4B9y9/WlJI3ye64bvntiYbnaqPctSQOWZotzq
 72lJz135H//ZeWGYasF3D+yxSGbmAfVylBR2VnB3SGl3slgdGpDRcsnmAIrE/+m1gtpzGw63
 2dsa5GxEdUHQPcBU7I2vaPDmlig=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e09bf23.7f63b8ab31b8-smtp-out-n03;
 Mon, 30 Dec 2019 09:10:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9CB52C43383; Mon, 30 Dec 2019 09:10:59 +0000 (UTC)
Received: from [10.201.2.161] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D802C447A0;
        Mon, 30 Dec 2019 09:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D802C447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH V2 2/7] pinctrl: qcom: Add ipq6018 pinctrl driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        sivaprak@codeaurora.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1576752109-24497-1-git-send-email-sricharan@codeaurora.org>
 <1576752109-24497-3-git-send-email-sricharan@codeaurora.org>
 <20191229033530.GN3755841@builder>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <af83d26c-3f0f-3246-7270-522eeb4cb02d@codeaurora.org>
Date:   Mon, 30 Dec 2019 14:40:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191229033530.GN3755841@builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 12/29/2019 9:05 AM, Bjorn Andersson wrote:
> On Thu 19 Dec 02:41 PST 2019, Sricharan R wrote:
>> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq6018.c b/drivers/pinctrl/qcom/pinctrl-ipq6018.c
> [..]
>> +static const struct msm_function ipq6018_functions[] = {
> [..]
>> +	FUNCTION(qpic_pad),
>> +	FUNCTION(qpic_pad0),
>> +	FUNCTION(qpic_pad1),
>> +	FUNCTION(qpic_pad2),
>> +	FUNCTION(qpic_pad3),
>> +	FUNCTION(qpic_pad4),
>> +	FUNCTION(qpic_pad5),
>> +	FUNCTION(qpic_pad6),
>> +	FUNCTION(qpic_pad7),
>> +	FUNCTION(qpic_pad8),
> 
> Shouldn't the qpic_padN entries be removed now? (Please double check the
> rest as well)
> 

 ok, will fix and others as well.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
