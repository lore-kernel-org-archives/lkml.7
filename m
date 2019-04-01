Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C58C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBE820870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fKF/6sNI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xp6+B5iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDAMj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:39:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfDAMj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:39:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7B07E60779; Mon,  1 Apr 2019 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554122365;
        bh=jKPpvUQlb0jAwuVCl5AJJha/wolOgEBpiD5p4xWVcBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fKF/6sNIBEzuJep2kZK2VhSZy8g0fU1FzXGSgCNyi48mX6DOZhw8danZQpkXHOgYP
         lhbawJTFEYky2owG+TOLK6SWeTMU8ha3uaWAhOnI91wWI6DFtx0TNOyoeIeQydvEj5
         xc8AHT22r8c8378UKmJpQg5cqBEmfS5TwbH09+Jc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A03E56086B;
        Mon,  1 Apr 2019 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554122363;
        bh=jKPpvUQlb0jAwuVCl5AJJha/wolOgEBpiD5p4xWVcBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xp6+B5iHmGOncKnHFoZxtPdl760FV66QjisxC4Ta8JsNkVTYT2H2NBYe+3RGIEMci
         DCo8AWNJNpA6Ouhl7ILuwomuGm9ES5GhT2K9u28otfVXExOlOTRLjBh6IOwR2SSCre
         bVXzlyiina2XW/MduBdaUT1vSJS3DvRNlZ2Uim+Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Apr 2019 18:09:23 +0530
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, robh+dt@kernel.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip WCN3998
In-Reply-To: <1553689723-21017-3-git-send-email-c-hbandi@codeaurora.org>
References: <1553689723-21017-1-git-send-email-c-hbandi@codeaurora.org>
 <1553689723-21017-3-git-send-email-c-hbandi@codeaurora.org>
Message-ID: <e671ad7dee39bf5a0237f7d00553bf4c@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Could you please help to review DT bindings patch.


On 2019-03-27 17:58, Harish Bandi wrote:
> This patch enables regulators for the Qualcomm Bluetooth WCN3998
> controller.
> 
> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> ---
> Changes in V6:
> - no changes
> ---
>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 824c0e2..7ef6118 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -11,20 +11,21 @@ Required properties:
>   - compatible: should contain one of the following:
>     * "qcom,qca6174-bt"
>     * "qcom,wcn3990-bt"
> +   * "qcom,wcn3998-bt"
> 
>  Optional properties for compatible string qcom,qca6174-bt:
> 
>   - enable-gpios: gpio specifier used to enable chip
>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
> 
> -Required properties for compatible string qcom,wcn3990-bt:
> +Required properties for compatible string qcom,wcn399x-bt:
> 
>   - vddio-supply: VDD_IO supply regulator handle.
>   - vddxo-supply: VDD_XO supply regulator handle.
>   - vddrf-supply: VDD_RF supply regulator handle.
>   - vddch0-supply: VDD_CH0 supply regulator handle.
> 
> -Optional properties for compatible string qcom,wcn3990-bt:
> +Optional properties for compatible string qcom,wcn399x-bt:
> 
>   - max-speed: see 
> Documentation/devicetree/bindings/serial/slave-device.txt


Thanks,
Harish
