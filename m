Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C39ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AC82064B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gJz0d74X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gJz0d74X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391486AbfJPIPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:15:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfJPIPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:15:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 94C1360B16; Wed, 16 Oct 2019 08:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571213739;
        bh=y+xH4IuaFfx42JFLjffopIU8ggWRenGY2FyKqteYnWs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gJz0d74XxZUDt79qKZRI1kTGIxfCEBcvcRxitlh06T1UN8qN0tPcvlovSubDAwVzL
         9Y3wwULC8zFXHDlxLqwvvCX2EO+jlw/YQYhjgJY1g/UIk6HaYqtUPSEBrh0qb+TwOT
         7Y2hcsPD1a4zOuHKKeeQaaSiIA0k5GdTzmOWZd/c=
Received: from [10.79.136.17] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FA9960AD7;
        Wed, 16 Oct 2019 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571213739;
        bh=y+xH4IuaFfx42JFLjffopIU8ggWRenGY2FyKqteYnWs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gJz0d74XxZUDt79qKZRI1kTGIxfCEBcvcRxitlh06T1UN8qN0tPcvlovSubDAwVzL
         9Y3wwULC8zFXHDlxLqwvvCX2EO+jlw/YQYhjgJY1g/UIk6HaYqtUPSEBrh0qb+TwOT
         7Y2hcsPD1a4zOuHKKeeQaaSiIA0k5GdTzmOWZd/c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FA9960AD7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 2/2] arm64: dts: sc7180: Add minimal dts/dtsi files for
 SC7180 soc
To:     Vinod Koul <vkoul@kernel.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
References: <20191015103358.17550-1-rnayak@codeaurora.org>
 <20191015103358.17550-2-rnayak@codeaurora.org>
 <20191016052535.GC2654@vkoul-mobl>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <92363367-d12a-1fff-d527-417b591df4b0@codeaurora.org>
Date:   Wed, 16 Oct 2019 13:45:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016052535.GC2654@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2019 10:55 AM, Vinod Koul wrote:
> On 15-10-19, 16:03, Rajendra Nayak wrote:
> 
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +
>> +	clocks {
> 
> Can we have these sorted alphabetically please

will do, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
