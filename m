Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0437FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AB32146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gf8aCqdA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LN/oBY2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfC0N1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:27:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59962 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfC0N1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:27:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A3CF760364; Wed, 27 Mar 2019 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553693267;
        bh=+TLQQ0u4IfciTDa2AH1cuWXrbQskbKNjeH47EHeFnio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gf8aCqdA+sa5VVftHhYao4bl4dJ7ZUomiqcImcMwUelprRw2vb0U+Cn0uR5FR1QEc
         sNZZxjcXoLhDHXdR7s4nSfnmhoaTljnip7xiaReitr+FBAMcWD17+kqueyStz1Qe/z
         ieQK4E9wbNHtHPeJAVAtPoyELIzd9kICeSW4eVeI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6726260A44;
        Wed, 27 Mar 2019 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553693265;
        bh=+TLQQ0u4IfciTDa2AH1cuWXrbQskbKNjeH47EHeFnio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LN/oBY2aCyEgPKXtsPw8CFV41/EwpfyrSm8w3K9+xuOJsSuoGp1+RTMJwoYK1d7lR
         PJJz4TYdja8/gCoC/apNUNm8VSRuou3j2sms+IQutj7sJCk+pkkys3xZ7BNF4RwZ5W
         4DspjmVDheNjeP/MRMR2MBtuw1qkZ+D8kg3p/Q1s=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 Mar 2019 18:57:45 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 2/9] soc: qcom: rpmpd: Add support to set rpmpd state
 to max
In-Reply-To: <696866e5-740a-f7b0-5193-f79b5c1e908c@codeaurora.org>
References: <20190324175007.29040-1-sibis@codeaurora.org>
 <20190324175007.29040-3-sibis@codeaurora.org>
 <696866e5-740a-f7b0-5193-f79b5c1e908c@codeaurora.org>
Message-ID: <8543face9c79a2b04d4234c41a84897a@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-25 09:36, Rajendra Nayak wrote:
> On 3/24/2019 11:20 PM, Sibi Sankar wrote:
>> Add support to set rpmpd state to max across SoCs.
> 
> Changelog could be better, 'rpmpd max state varies across SoCs
> and SoC families, add support in the driver to make it SoC/SoC
> family specific'

will use this in v3

> 
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   drivers/soc/qcom/rpmpd.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
>> index 235d01870dd8..71fdfafad2ea 100644
>> --- a/drivers/soc/qcom/rpmpd.c
>> +++ b/drivers/soc/qcom/rpmpd.c
>> @@ -83,12 +83,14 @@ struct rpmpd {
>>   	const int res_type;
>>   	const int res_id;
>>   	struct qcom_smd_rpm *rpm;
>> +	unsigned int max_state;
>>   	__le32 key;
>>   };
>>     struct rpmpd_desc {
>>   	struct rpmpd **rpmpds;
>>   	size_t num_pds;
>> +	unsigned int max_state;
>>   };
>>     static DEFINE_MUTEX(rpmpd_lock);
>> @@ -114,6 +116,7 @@ static struct rpmpd *msm8996_rpmpds[] = {
>>   static const struct rpmpd_desc msm8996_desc = {
>>   	.rpmpds = msm8996_rpmpds,
>>   	.num_pds = ARRAY_SIZE(msm8996_rpmpds),
>> +	.max_state = MAX_RPMPD_STATE,
> 
> Maybe this needs to be renamed to avoid confusion, 
> MAX_8996_RPMPD_STATE?

sure

> 
>>   };
>>     static const struct of_device_id rpmpd_match_table[] = {
>> @@ -225,8 +228,8 @@ static int rpmpd_set_performance(struct 
>> generic_pm_domain *domain,
>>   	int ret = 0;
>>   	struct rpmpd *pd = domain_to_rpmpd(domain);
>>   -	if (state > MAX_RPMPD_STATE)
>> -		state = MAX_RPMPD_STATE;
>> +	if (state > pd->max_state)
>> +		state = pd->max_state;
>>     	mutex_lock(&rpmpd_lock);
>>   @@ -287,6 +290,7 @@ static int rpmpd_probe(struct platform_device 
>> *pdev)
>>   		}
>>     		rpmpds[i]->rpm = rpm;
>> +		rpmpds[i]->max_state = desc->max_state;
>>   		rpmpds[i]->pd.power_off = rpmpd_power_off;
>>   		rpmpds[i]->pd.power_on = rpmpd_power_on;
>>   		rpmpds[i]->pd.set_performance_state = rpmpd_set_performance;
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
