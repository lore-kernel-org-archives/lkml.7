Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FACB2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbfCYLsZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:48:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58550 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbfCYLsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:48:24 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7390ACF35C;
        Mon, 25 Mar 2019 12:56:24 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip WCN3998
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1553513491-25763-3-git-send-email-c-hbandi@codeaurora.org>
Date:   Mon, 25 Mar 2019 12:48:22 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        anubhavg@codeaurora.org, devicetree <devicetree@vger.kernel.org>,
        mark.rutland@arm.com, obh+dt@kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3AEE5277-5830-41FC-BC72-F5BE4B34B357@holtmann.org>
References: <1553513491-25763-1-git-send-email-c-hbandi@codeaurora.org>
 <1553513491-25763-3-git-send-email-c-hbandi@codeaurora.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harish,

> This patch enables regulators for the Qualcomm Bluetooth WCN3998
> controller.
> 
> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> ---
> Changes in V4:
> - Removed new compatible WCN3998
> - changed wcn3990 to wcn399* to represent wcn399* family
> ---
> Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 824c0e2..de9cefa 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -11,20 +11,21 @@ Required properties:
>  - compatible: should contain one of the following:
>    * "qcom,qca6174-bt"
>    * "qcom,wcn3990-bt"
> +   * "qcom,wcn3998-bt"
> 
> Optional properties for compatible string qcom,qca6174-bt:
> 
>  - enable-gpios: gpio specifier used to enable chip
>  - clocks: clock provided to the controller (SUSCLK_32KHZ)
> 
> -Required properties for compatible string qcom,wcn3990-bt:
> +Required properties for compatible string qcom,wcn399*-bt:
> 
>  - vddio-supply: VDD_IO supply regulator handle.
>  - vddxo-supply: VDD_XO supply regulator handle.
>  - vddrf-supply: VDD_RF supply regulator handle.
>  - vddch0-supply: VDD_CH0 supply regulator handle.
> 
> -Optional properties for compatible string qcom,wcn3990-bt:
> +Optional properties for compatible string qcom,wcn399*-bt:
> 
>  - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
> 
> @@ -44,7 +45,7 @@ serial@7570000 {
> 
> serial@898000 {
> 	bluetooth {
> -		compatible = "qcom,wcn3990-bt";
> +		compatible = "qcom,wcn399*-bt”;

I am not convinced that examples should have a * in the compatible string. So lets have Rob ack this one.

Regards

Marcel

