Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F3DC2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 04:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD342073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 04:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="EUsDVSAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfLMEGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 23:06:37 -0500
Received: from m228-4.mailgun.net ([159.135.228.4]:12524 "EHLO
        m228-4.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbfLMEGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:06:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576209996; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=t3WuJRdbhQpYuvgidbSiHcxucdQ22ZxkAD1DdKzZCFQ=; b=EUsDVSAsZJDpmWYySTAcYp4AE6lPdeSe4r2d/uUexVFBBb4KbCyTttVGwo+VYcrq5tNNTksZ
 WNktCbTAKQA8aXKvBGxkwBywIPbA4cd4rX2pQzI18DcO3IgbfGTlKzsDI8CaQ5QsujTadYV4
 xC4uquwlfWxOuD8joxUQKUbJn90=
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df30e4b.7f9bd3706ed8-smtp-out-n03;
 Fri, 13 Dec 2019 04:06:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 02BB4C447A1; Fri, 13 Dec 2019 04:06:34 +0000 (UTC)
Received: from [10.131.117.127] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F548C43383;
        Fri, 13 Dec 2019 04:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F548C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 0/7] arm64: dts: sc7180: Make dtbs_check mostly happy
To:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        swboyd@chromium.org, mka@chromium.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20191212193544.80640-1-dianders@chromium.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <5bccad6f-748e-1024-acd0-04af0a4cb731@codeaurora.org>
Date:   Fri, 13 Dec 2019 09:36:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191212193544.80640-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/2019 1:05 AM, Douglas Anderson wrote:
> This gets rid of all of the dtbs_check that showed up atop the current
> qcom maintainer tree for sc7180-idp, except the errors in the
> 'thermal-sensor' nodes.  I believe those are known / being dealt with
> separately [1] [2].
> 
> I don't expect this series to have any functional changes, it just
> makes the device tree cleaner.  I was able to boot after applying
> these patches atop a working tree.
> 
> I have tried to sort the changes here, first including the "obviously
> correct" changes and later changes I am less certain about.  There are
> no known dependencies between the changes.

Thanks Doug for these cleanups, for the series

Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>

> 
> [1] https://lore.kernel.org/r/CAD=FV=UXC3UT78vGBr9rRuRxz=8iwH4tOkFx6NC-pSs+Z5+7Xw@mail.gmail.com
> [2] https://lore.kernel.org/r/CAD=FV=UtHebABCpJo1QUc6C2v2iZq2rFL+pTMx=EHBL+7d=jTQ@mail.gmail.com
> 
> 
> Douglas Anderson (7):
>    arm64: dts: qcom: sc7180: Add SoC name to compatible
>    arm64: dts: qcom: sc7180: Rename gic-its node to msi-controller
>    arm64: dts: qcom: sc7180: Add "#clock-cells" property to usb_1_ssphy
>    arm64: dts: qcom: pm6150: Remove macro from unit name of adc-chan
>    arm64: dts: qcom: sc7180: Avoid "memory" for cmd-db reserved-memory
>      node
>    arm64: dts: qcom: sc7180: Avoid "phy" for USB QMP PHY wrapper
>    arm64: dts: qcom: sc7180: Use 'ranges' in arm,armv7-timer-mem node
> 
>   arch/arm64/boot/dts/qcom/pm6150.dtsi    |  2 +-
>   arch/arm64/boot/dts/qcom/sc7180-idp.dts |  2 +-
>   arch/arm64/boot/dts/qcom/sc7180.dtsi    | 45 +++++++++++++------------
>   3 files changed, 25 insertions(+), 24 deletions(-)
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
