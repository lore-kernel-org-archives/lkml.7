Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E28C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BD721783
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="sMunukT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfHOKz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 06:55:29 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:56180 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfHOKz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1565866527; x=1568458527;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3LyILGfeRPMBE9NSdD94bY413NLx+S0CS3m46Nnwsvc=;
        b=sMunukT7k2r9LlXUQ1Nl0ExoI64mel4rFXkW4lwHxTsB82hSFKzEClNZThQe/Uk2
        2JjO1UsP0EFqc7l/FPyV5cKGHGXBHm5JDSN4Cx6YdkEpSfCQiFLP5Rf7PgeK2SOk
        tYi5tlher3lE7jyyQwZuhWhPbV9+6LxyzIFqJri8q/w=;
X-AuditID: c39127d2-e31ff70000001af2-eb-5d553a1f94ae
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9A.55.06898.F1A355D5; Thu, 15 Aug 2019 12:55:27 +0200 (CEST)
Received: from [172.16.23.108] ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019081512552726-73915 ;
          Thu, 15 Aug 2019 12:55:27 +0200 
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6 UL/ULL
 devicetree bindings
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-imx@nxp.com
References: <1563954573-370205-1-git-send-email-s.riedmueller@phytec.de>
 <20190813160448.GA27548@bogus>
From:   =?UTF-8?Q?Stefan_Riedm=c3=bcller?= <s.riedmueller@phytec.de>
Message-ID: <073f9466-9dd3-a22c-e000-e9f4c60f90a0@phytec.de>
Date:   Thu, 15 Aug 2019 12:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813160448.GA27548@bogus>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 15.08.2019 12:55:27,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 15.08.2019 12:55:27,
        Serialize complete at 15.08.2019 12:55:27
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42JZI8DApStvFRprcO27mEVzh63F/CPnWC0e
        XvW32PT4GqtF16+VzBaXd81hs7jb0slqsfT6RSaL/3t2sFv83b6JxeLFFnEHbo8189Yweuyc
        dZfdY9OqTjaPO9f2sHlsXlLvsfHdDiaP/r8GHp83yQVwRHHZpKTmZJalFunbJXBlzF/Wz1zQ
        Jlzx9e9J1gbGrXxdjJwcEgImEv8aG1i6GLk4hAR2MEo8/t/ODOGcZpSY/HUhE0iVsECsxLvV
        81lAbBEBRYnfbdNYQYqYBV4zSXya2AaWEBLIlNi4/R6YzSbgJLH4fAcbiM0rYCOx4PJhZhCb
        RUBVYnPTNUYQW1QgQuLwjlmMEDWCEidnPgHr5RTQlph/cCsbyAIJgUYmiRP3IJolBIQkTi8+
        C2YzC8hLbH87B8o2k5i3+SGULS5x68l8pgmMQrOQzJ2FpGUWkpZZSFoWMLKsYhTKzUzOTi3K
        zNYryKgsSU3WS0ndxAiMtMMT1S/tYOyb43GIkYmD8RCjBAezkgjvhItBsUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5N/CWhAkJpCeWpGanphakFsFkmTg4pRoYTTtrjcNr+Pcme3u4xIhG8xt7
        r950LtfvYf8UtU9fTr5NENtS///ehE2bhTzL10qe+zOrsvxWON+rq1Fdjx89X235ISiG580k
        0QbZC7/eX3ggPKs81ar/p2qQR+Ziwbkic5VWnjly9mlg4lrz3LLLyudq78/gfGtYkPC05Pbu
        ExtsynjzzeN+KrEUZyQaajEXFScCABVjAPiiAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 13.08.19 18:04, Rob Herring wrote:
> On Wed, Jul 24, 2019 at 09:49:32AM +0200, Stefan Riedmueller wrote:
>> Add devicetree bindings for i.MX6 UL/ULL based phyCORE-i.MX6 UL/ULL and
>> phyBOARD-Segin.
>>
>> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
>> ---
>>   Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index 7294ac36f4c0..40f007859092 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -161,12 +161,20 @@ properties:
>>           items:
>>             - enum:
>>                 - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
>> +              - phytec,imx6ul-pbacd10     # PHYTEC phyBOARD-Segin with i.MX6 UL
>> +              - phytec,imx6ul-pbacd10-emmc  # PHYTEC phyBOARD-Segin eMMC Kit
>> +              - phytec,imx6ul-pbacd10-nand  # PHYTEC phyBOARD-Segin NAND Kit
>> +              - phytec,imx6ul-pcl063      # PHYTEC phyCORE-i.MX 6UL
> 
> This doesn't match what is in the dts files:
> 
> arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi:    compatible = "phytec,imx6ul-pcl063", "fsl,imx6ul";
> arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts:      compatible = "phytec,imx6ul-pbacd10", "phytec,imx6ul-pcl063",
> "fsl,imx6ul";
> arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi:    compatible = "phytec,imx6ul-pbacd-10", "phytec,imx6ul-pcl063",
> "fsl,imx6ul";

Shawn already applied my patches which rename the compatibles, see 
https://lkml.org/lkml/2019/7/23/42

Maybe I was a little too fast sending this patch.

Stefan

> 
>>             - const: fsl,imx6ul
>>   
>>         - description: i.MX6ULL based Boards
>>           items:
>>             - enum:
>>                 - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
>> +              - phytec,imx6ull-pbacd10    # PHYTEC phyBOARD-Segin with i.MX6 ULL
>> +              - phytec,imx6ull-pbacd10-emmc # PHYTEC phyBOARD-Segin eMMC Kit
>> +              - phytec,imx6ull-pbacd10-nand # PHYTEC phyBOARD-Segin NAND Kit
>> +              - phytec,imx6ull-pcl063     # PHYTEC phyCORE-i.MX 6ULL
>>             - const: fsl,imx6ull
>>   
>>         - description: i.MX6ULZ based Boards
>> -- 
>> 2.7.4
>>
