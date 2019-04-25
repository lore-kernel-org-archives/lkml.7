Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FFFC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA554205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfDYMoB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:44:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49535 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:44:00 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 68306CEE16;
        Thu, 25 Apr 2019 14:52:08 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v7 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip WCN3998
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1556194416-30842-3-git-send-email-c-hbandi@codeaurora.org>
Date:   Thu, 25 Apr 2019 14:43:56 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B3F78119-055C-41EB-BE3B-C5C94825B93E@holtmann.org>
References: <1556194416-30842-1-git-send-email-c-hbandi@codeaurora.org>
 <1556194416-30842-3-git-send-email-c-hbandi@codeaurora.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harish,

> Add compatible string for the Qualcomm WCN3998 Bluetooth controller
> 
> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> ---
> Changes in V6:
> - Changed Commit text
> ---
> Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 824c0e2..7ef6118 100644
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
> +Required properties for compatible string qcom,wcn399x-bt:
> 
>  - vddio-supply: VDD_IO supply regulator handle.
>  - vddxo-supply: VDD_XO supply regulator handle.
>  - vddrf-supply: VDD_RF supply regulator handle.
>  - vddch0-supply: VDD_CH0 supply regulator handle.
> 
> -Optional properties for compatible string qcom,wcn3990-bt:
> +Optional properties for compatible string qcom,wcn399x-bt:

wasn’t the conclusion to _not_ use x things in compatible strings? I would personally prefer you list these two compatible strings separately. However I let Rob comment and Ack this if this is fine for him.

Regards

Marcel

