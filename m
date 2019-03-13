Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD625C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700492173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QCFfCOno";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P9T5B3QV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCMGaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:30:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfCMGaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:30:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A8E360767; Wed, 13 Mar 2019 06:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552458607;
        bh=WEKJ6FoXB8ZrcU7i05ArFOL0m+acC/e/JxSlTAsEymw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QCFfCOno589ZptV8ZdIMASw5gaKjIio0aaSDYFaqsEOzMkDs41PlTAOMuckGgFAtS
         mvHGC6PlTC7eydd/HovL36Cv5lkR48H8B+nXTQU60NcZIl7pEgd8r8wLD/GHGlnJsI
         2l625yq7zlMvv3GlMB5UX1+e36k+vssxFPzZ6Er0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4DDDF60312;
        Wed, 13 Mar 2019 06:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552458606;
        bh=WEKJ6FoXB8ZrcU7i05ArFOL0m+acC/e/JxSlTAsEymw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P9T5B3QVPshLYPdFgHG7/P3Z/rIGx8Ngo34uuAn40NekTgOjsJWposIdStd4snq1G
         8d0Z2OTXkvm42Ky1dMUWOA1C+unQlqryXmbvaKGOAjMhtCLz44IELfy8vw4XyqrlvI
         c7ZOuH34halUeM7YI0XfB3DVMCPcL0tp9jR0VdaE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 13 Mar 2019 12:00:06 +0530
From:   c-hbandi@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3998
In-Reply-To: <20190312165928.GD200579@google.com>
References: <1552393379-26330-1-git-send-email-c-hbandi@codeaurora.org>
 <1552393379-26330-3-git-send-email-c-hbandi@codeaurora.org>
 <20190312165928.GD200579@google.com>
Message-ID: <88a923e02073461abb5f3a7674150615@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,


On 2019-03-12 22:29, Matthias Kaehlcke wrote:
> +DT folks
> 
> Please add them in future versions (script/scripts/get_maintainer.pl
> <patches> should have listed them)

[Harish] -- Will add them in new version of patches.
> 
> On Tue, Mar 12, 2019 at 05:52:59PM +0530, Harish Bandi wrote:
>> This patch enables regulators for the Qualcomm Bluetooth wcn3998
>> controller.
> 
> No, it doesn't.
> 
> The next version should probably say something like "Add compatible
> string for the Qualcomm WCN3998 Bluetooth controller.
> 
[Harish] -- From new patch onwards will add all patch
version changes and add proper description.

> Is there any particular reason why QCA drivers folks use 'wcn' instead
> of 'WCN'? The QCA documentations calls it WCN399x, so I'd suggest to
> consistently use the uppercase name in comments and documentation (and
> log messages?).
> 
[Harish] -- I think in DT we need to have small case like wcn, i think
that is the reason it started using in code, comments and dt 
documentation.

>> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
>> ---
>> changes in v3:
>> - updated to latest code base.
> 
> This comment is useless, please describe what changed wrt the previous
> version.
[Harish] --  added details in v2, and v3 uploaded just to rebase on tip 
of bluetooth-next
for better understanding of code in review. From new patch onwards will 
add all patch
version changes and add proper description.
> 
>> ---
>>  .../devicetree/bindings/net/qualcomm-bluetooth.txt        | 15 
>> +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> index 824c0e2..1221535 100644
>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> @@ -53,3 +53,18 @@ serial@898000 {
>>  		max-speed = <3200000>;
>>  	};
>>  };
>> +
>> +&blsp1_uart3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&blsp1_uart3_default>;
>> +	status = "okay";
>> +
>> +	bluetooth: wcn3998-bt {
>> +		compatible = "qcom,wcn3998-bt";
>> +		vddio-supply = <&vreg_l6_1p8>;
>> +		vddxo-supply = <&vreg_l5_1p8>;
>> +		vddrf-supply = <&vreg_s5_1p35>;
>> +		vddch0-supply = <&vdd_ch0_3p3>;
>> +		max-speed = <3200000>;
>> +	};
>> +};
>> \ No newline at end of file
> 
> I think the example isn't really needed since it's essentially the
> same as the one for 'qcom,wcn3990-bt'.
> 
> But the important part is missing: add the new compatible string under
> ´Required properties´. You also want to update the documentation that
> mentiones 'qcom,wcn3990-bt' to 'qcom,wcn399x-bt' (assuming for now
> that other possible WCN399x chips would be similar).
> 
[Harish] -- Will check the DT properties, documentation and update
accordingly in new patch.

> You mentioned in an earlier version of the series that there are
> multiple WCN3998 variants with different requirements for
> voltage/current. This seems to suggests that multiple compatible
> strings are needed to distinguish between them.
> 
[Harish] -- for now we want to add WCN3998 support only, What i mean to 
say in my earlier
explanation that. WCN3990 is base variant and on top of that we have 
variants like WCN3990,
WCN3998 and WCN3998-0,WCN3998-1 like that..
So I think wcn399x would make sense for this series.

> Thanks
> 
> Matthias

Thanks,
Harish
