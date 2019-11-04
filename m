Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27E6CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9058222C1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ttg4n6OD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ttg4n6OD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfKDKcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:32:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:32:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8EC2A60BE6; Mon,  4 Nov 2019 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572863537;
        bh=XEMORj6CAxshiDtzXTqMIOoW7d5P5+yV2qS8l6858TM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ttg4n6ODEEHEjhxaYVCBdGZx1P1/oLQVW9Be0x0LvsoNV76mnkbDGjJfp5pZQHtzp
         NtVuJP96IuLDYgYJ/Pup4lFFB80iVPScdxpcQU9gxvurpgphyubhzX18XwpKXvjYsY
         kIZV8q521JtJfPQco47Fsjz9h5RP6XbOfSVAZa6A=
Received: from [10.79.136.17] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E4D960B72;
        Mon,  4 Nov 2019 10:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572863537;
        bh=XEMORj6CAxshiDtzXTqMIOoW7d5P5+yV2qS8l6858TM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ttg4n6ODEEHEjhxaYVCBdGZx1P1/oLQVW9Be0x0LvsoNV76mnkbDGjJfp5pZQHtzp
         NtVuJP96IuLDYgYJ/Pup4lFFB80iVPScdxpcQU9gxvurpgphyubhzX18XwpKXvjYsY
         kIZV8q521JtJfPQco47Fsjz9h5RP6XbOfSVAZa6A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E4D960B72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/1] arm64: dts: sc7180: Add qupv3_0 and qupv3_1
To:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     mgautam@codeaurora.org, akashast@codeaurora.org,
        msavaliy@codeaurora.org, sanm@codeaurora.org,
        skakit@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191031074500.28523-1-rojay@codeaurora.org>
 <20191031074500.28523-2-rojay@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <9a52fee5-7e80-639f-248a-8a563113c470@codeaurora.org>
Date:   Mon, 4 Nov 2019 16:02:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031074500.28523-2-rojay@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2019 1:15 PM, Roja Rani Yarubandi wrote:
> Add QUP SE instances configuration for sc7180.
> 
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7180-idp.dts | 152 +++++-
>   arch/arm64/boot/dts/qcom/sc7180.dtsi    | 683 +++++++++++++++++++++++-
>   2 files changed, 828 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index e0724ef3317d..189254f5ae95 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -17,7 +17,8 @@
>   	compatible = "qcom,sc7180-idp";
>   
>   	aliases {
> -		serial0 = &uart10;

I will fix this up in the patch that added this when I respin.
I seemed to have overlooked the fact that each QUP instance on sc7180
has only 6 SEs (and not 8)

> +		hsuart0 = &uart3;
> +		serial0 = &uart8;


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
