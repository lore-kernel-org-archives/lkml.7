Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74424C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AB8217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RThNnBD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfKFF13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:27:29 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44856 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfKFF12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:27:28 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA65RN4I088440;
        Tue, 5 Nov 2019 23:27:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573018043;
        bh=HIfHBLV7UeDHKtYPr2RYwi8NU1tW9wFFxVN+30qfl3A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RThNnBD3ICA+EOkNwMYx3vJBgsn8k8XDnoSyC+2pThNzoisOEgoNQCYfVUvGEdQwk
         7XeKQ/komQw31waEOcO5W43mrmZMFPFceAhbdxM36K+ao9uPuGrR4V7h/OGmbuMWq7
         C0x5OBjmpFLlxdn7aXIw9GjFZSnSPRCUa5Ae0+/g=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA65RNGF003776;
        Tue, 5 Nov 2019 23:27:23 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 5 Nov
 2019 23:27:07 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 5 Nov 2019 23:27:07 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA65RGpK024151;
        Tue, 5 Nov 2019 23:27:17 -0600
Subject: Re: [PATCH v3 2/3] dt-bindings: phy-qcom-qmp: Add sm8150 UFS phy
 compatible string
To:     Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>
References: <20191024074802.26526-1-vkoul@kernel.org>
 <20191024074802.26526-3-vkoul@kernel.org>
 <20191105060249.GX2695@vkoul-mobl.Dlink>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <733450bb-640a-c680-7e36-3f0192a9b996@ti.com>
Date:   Wed, 6 Nov 2019 10:56:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105060249.GX2695@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vinod,

On 05/11/19 11:32 AM, Vinod Koul wrote:
> On 24-10-19, 13:18, Vinod Koul wrote:
>> Document "qcom,sdm845-qmp-ufs-phy" compatible string for QMP UFS PHY
>> found on SM8150.
>>
>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Kishon,
> 
> Can you pick this and 3rd patch please

This is already in phy -next. Will be sending a PR to Greg today.

Thanks
Kishon

> 
>> ---
>>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> index 085fbd676cfc..eac9ad3cbbc8 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> @@ -14,7 +14,8 @@ Required properties:
>>  	       "qcom,msm8998-qmp-pcie-phy" for PCIe QMP phy on msm8998,
>>  	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>>  	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
>> -	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
>> +	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845,
>> +	       "qcom,sm8150-qmp-ufs-phy" for UFS QMP phy on sm8150.
>>  
>>  - reg:
>>    - index 0: address and length of register set for PHY's common
>> @@ -57,6 +58,8 @@ Required properties:
>>  			"aux", "cfg_ahb", "ref", "com_aux".
>>  		For "qcom,sdm845-qmp-ufs-phy" must contain:
>>  			"ref", "ref_aux".
>> +		For "qcom,sm8150-qmp-ufs-phy" must contain:
>> +			"ref", "ref_aux".
>>  
>>   - resets: a list of phandles and reset controller specifier pairs,
>>  	   one for each entry in reset-names.
>> @@ -83,6 +86,8 @@ Required properties:
>>  			"phy", "common".
>>  		For "qcom,sdm845-qmp-ufs-phy": must contain:
>>  			"ufsphy".
>> +		For "qcom,sm8150-qmp-ufs-phy": must contain:
>> +			"ufsphy".
>>  
>>   - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
>>   - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
>> -- 
>> 2.20.1
> 
