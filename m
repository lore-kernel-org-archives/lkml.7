Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15092C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D697D2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="arYpewWv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P4PdWykC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfCZKEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:04:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfCZKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:04:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EDCCE60DB4; Tue, 26 Mar 2019 10:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553594679;
        bh=t4OXr9rKENVI+XK7cOtbNWHKfAWco+U88scfuqy0QHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=arYpewWv4JMSCVo/Mu/6gK/5gy3sQpd7+rTv68fl9MgsvZnOM6DE3gFIB3eyfWrlj
         WnAG6UsCRMLjoxN55EokIscO+8sarNU/6kz41gIFXEU6I2GFPTtlrUBE/rGVi/5kDV
         qVFQLd2HGnHLG1cZjs4ugKI1WXZT9qYL/XSX9FRE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D687A60AA3;
        Tue, 26 Mar 2019 10:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553594678;
        bh=t4OXr9rKENVI+XK7cOtbNWHKfAWco+U88scfuqy0QHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P4PdWykChllUpvB1J6WCKa6LeiUWthU536kxc0tlm4bpvhGvigTFE6AvtMgHAAB1B
         Ut10lP1Iac1AHrYqiDxxTgOztvQJR7d2BpFpabZkCT4v+W4uGsbYBSJZfEzaXX0jjN
         ic6vQoYVuo2+zGMOdAfYfxga2lW6Z54y6rXEGpko=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Mar 2019 15:34:37 +0530
From:   c-hbandi@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip WCN3998
In-Reply-To: <20190325162935.GW112750@google.com>
References: <1553513800-27611-1-git-send-email-c-hbandi@codeaurora.org>
 <1553513800-27611-3-git-send-email-c-hbandi@codeaurora.org>
 <20190325162935.GW112750@google.com>
Message-ID: <0eecb0eec722f9246d2816bb0a2384d5@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-03-25 21:59, Matthias Kaehlcke wrote:
> On Mon, Mar 25, 2019 at 05:06:40PM +0530, Harish Bandi wrote:
>> This patch enables regulators for the Qualcomm Bluetooth WCN3998
>> controller.
>> 
>> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
>> ---
>> Changes in V4:
>> - Removed new compatible WCN3998
>> - changed wcn3990 to wcn399* to represent wcn399* family
>> ---
>>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 7 
>> ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> index 824c0e2..de9cefa 100644
>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> @@ -11,20 +11,21 @@ Required properties:
>>   - compatible: should contain one of the following:
>>     * "qcom,qca6174-bt"
>>     * "qcom,wcn3990-bt"
>> +   * "qcom,wcn3998-bt"
>> 
>>  Optional properties for compatible string qcom,qca6174-bt:
>> 
>>   - enable-gpios: gpio specifier used to enable chip
>>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>> 
>> -Required properties for compatible string qcom,wcn3990-bt:
>> +Required properties for compatible string qcom,wcn399*-bt:
> 
> I think in Linux drivers the use of 'x' is more common as a wildcard
> for a single letter than an asterisk. It is also in line with the
> function name in the driver, so I would suggest to keep thinkgs
> consistent and call it wcn399x everywhere.

[Harish] - ok, will change it to wcn399x
> 
>> 
>>   - vddio-supply: VDD_IO supply regulator handle.
>>   - vddxo-supply: VDD_XO supply regulator handle.
>>   - vddrf-supply: VDD_RF supply regulator handle.
>>   - vddch0-supply: VDD_CH0 supply regulator handle.
>> 
>> -Optional properties for compatible string qcom,wcn3990-bt:
>> +Optional properties for compatible string qcom,wcn399*-bt:
>> 
>>   - max-speed: see 
>> Documentation/devicetree/bindings/serial/slave-device.txt
>> 
>> @@ -44,7 +45,7 @@ serial@7570000 {
>> 
>>  serial@898000 {
>>  	bluetooth {
>> -		compatible = "qcom,wcn3990-bt";
>> +		compatible = "qcom,wcn399*-bt";
> 
> Typically wildcards aren't used in DT examples as Marcel already
> mentioned on v3. IMO the wildcard degrades the value of the example,
> rather than enhancing it. I think just listing the compatible string
> is enough, no need for an wcn3998/x specific example since it's
> essentialy the same as wcn3990.
[Harish] - So will keep as wcn3990 only here.
> 
> Thanks
> 
> Matthias
