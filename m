Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA46C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB622184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ga67oaul";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ga67oaul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfB1GCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:02:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfB1GCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:02:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C949F60A0A; Thu, 28 Feb 2019 06:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551333762;
        bh=4a2doqCaXGrfLeMm1efJ927W0CVnGe0qa6x6U1JFquw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ga67oaulhRA/RkspIfRHLSCkvmWwdZWDx8wXnbbSDMZQz5aZBfExvFWyBFSIXUTvI
         g90WDuqX6Pbk2V84NPFon2/wTLCaQKufmD4YA2RdWdIS0WHLPDV5RuVsS2bsECa748
         VxxKJwdT5kahCfhjBnjFLl7OSBecKhvwimeD+u2g=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 310A9608CE;
        Thu, 28 Feb 2019 06:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551333762;
        bh=4a2doqCaXGrfLeMm1efJ927W0CVnGe0qa6x6U1JFquw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ga67oaulhRA/RkspIfRHLSCkvmWwdZWDx8wXnbbSDMZQz5aZBfExvFWyBFSIXUTvI
         g90WDuqX6Pbk2V84NPFon2/wTLCaQKufmD4YA2RdWdIS0WHLPDV5RuVsS2bsECa748
         VxxKJwdT5kahCfhjBnjFLl7OSBecKhvwimeD+u2g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Feb 2019 11:32:42 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 0/3] RPMPD for QCS404
In-Reply-To: <c4b2a60c-80a5-8491-38fb-1fed3dee2e8a@codeaurora.org>
References: <20190221064434.2760-1-bjorn.andersson@linaro.org>
 <c4b2a60c-80a5-8491-38fb-1fed3dee2e8a@codeaurora.org>
Message-ID: <9eb3dc7ee6e871e62c34aaa804d8971e@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-25 18:18, Rajendra Nayak wrote:
> On 2/21/2019 12:14 PM, Bjorn Andersson wrote:
>> Reworkd the macros of the rpmpd driver and add qcs404 power domains, 
>> then add
>> this to the dts.
> 
> For the entire series,
> 
> Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>

I'll post v2 of this series with support
for msm8998 and a few fixes.

> 
>> 
>> Bjorn Andersson (3):
>>    soc: qcom: rpmpd: Modify corner defining macros
>>    soc: qcom: rpmpd: Add QCS404 corners
>>    arm64: dts: qcom: qcs404: Add rpmpd node
>> 
>>   .../devicetree/bindings/power/qcom,rpmpd.txt  |  1 +
>>   arch/arm64/boot/dts/qcom/qcs404.dtsi          | 35 +++++++++++
>>   drivers/soc/qcom/rpmpd.c                      | 63 
>> +++++++++++++------
>>   include/dt-bindings/power/qcom-rpmpd.h        |  9 +++
>>   4 files changed, 88 insertions(+), 20 deletions(-)
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
