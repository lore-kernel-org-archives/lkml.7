Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54A3C352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C945222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eRH2SwUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfIZOrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:47:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43412 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfIZOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:47:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190926144703euoutp021e5a96ce89a118a45abaec505e045871~IBFLP-Gsl0611706117euoutp02Q
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 14:47:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190926144703euoutp021e5a96ce89a118a45abaec505e045871~IBFLP-Gsl0611706117euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569509223;
        bh=qILYkFcTsI422TRRt+JANEiHje4s3EJKrzcFzHpIfyk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eRH2SwUXVXmKpDf7QiqVVccn8v6D0UPyyYccptSxtw7oOcgEnA9hx0piWzNk1e1vN
         3xgXjN03YN7IChMtZ1zMQu7uI0Ae5RM4ueAX4MNhPKLrmA0YC3q6MFKV4co6ep8EJC
         Q9M4rnJoRSLue/ZxsyBI/8c5oYRYJToabdieG7oY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190926144703eucas1p2a442b25747da2d2eb1598bbdea927432~IBFKzgvwe1020710207eucas1p2E;
        Thu, 26 Sep 2019 14:47:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7A.3C.04469.76FCC8D5; Thu, 26
        Sep 2019 15:47:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190926144702eucas1p26e2cd223b736e5189acfa44eb5eea7b5~IBFKGlXW71952519525eucas1p2S;
        Thu, 26 Sep 2019 14:47:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190926144702eusmtrp267113900a2a5077ea07680ec8dff9744~IBFKF7pN-1915919159eusmtrp2y;
        Thu, 26 Sep 2019 14:47:02 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-0b-5d8ccf67eaed
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AE.77.04166.66FCC8D5; Thu, 26
        Sep 2019 15:47:02 +0100 (BST)
Received: from [106.120.51.95] (unknown [106.120.51.95]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190926144702eusmtip13ca9025dd33721788f408fdf6119c5e0~IBFJpxFwx2822828228eusmtip1W;
        Thu, 26 Sep 2019 14:47:02 +0000 (GMT)
Subject: Re: [PATCH v2] dt-bindings: gpu: Convert Samsung Image Scaler to
 dt-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>
From:   Maciej Falkowski <m.falkowski@samsung.com>
Message-ID: <0d3831ae-e33d-774d-02f7-fba45a95d25c@samsung.com>
Date:   Thu, 26 Sep 2019 16:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926140315.GA16002@pi3>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7rp53tiDf4sFLaYf+Qcq8WVr+/Z
        LCbdn8Bicf78BnaLy7vmsFnMOL+PyWLtkbvsFkuvX2SyaN17hN2B02PNvDWMHptWdbJ53O8+
        zuTRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGU/+7GAvaNGpWNZ3mLGB8ZZSFyMnh4SAicS+
        VxuZuhi5OIQEVjBKLDm1lhXC+cIo0bWliR3C+cwo8fzUW2aYlqnz/jBDJJYzSqxvPwnV8pZR
        YsG/aawgVcICoRI7N08GquLgEBGIkNi+EmwSs8A7RomX05awg9SwCRhI9L/ZywJi8wrYSbw4
        vo8RxGYRUJW4POs+WFwUqPfTg8OsEDWCEidnPgGLcwpoSnSsPg8WZxaQl9j+dg4zhC0ucevJ
        fLCHJAQOsUvMWNDBCHG2i8TyLzdYIWxhiVfHt7BD2DIS/3eCNHAA2dUS177JQvS2MEpcn/aW
        DaLGWuLPqolsIDXMQIvX79KHCDtKrH70nRWilU/ixltBiBP4JCZtm84MEeaV6GgTgjBVJd5M
        iIVolJZoXbOfcQKj0iwkf81C8sssJL/MQli7gJFlFaN4amlxbnpqsWFearlecWJucWleul5y
        fu4mRmBSOv3v+KcdjF8vJR1iFOBgVOLhnbGqJ1aINbGsuDL3EKMEB7OSCK9vJFCINyWxsiq1
        KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QDo7PcRammSHenrxn+Sz6k
        y7Owfiq99XqhwfWJFjO4OaQNNO4c2rb7+TZbsfwrDKemLfkS63F7ifr5i+xzInyl2hfY3RRa
        0qW4rCEzYe9Ujm7j2ZI1XEsubTsT2MLz00Dlxq9lio4a6czMGSas+9VlmnWXfxFTdHWrP99i
        HrWyyPtmthxv2k59JZbijERDLeai4kQArLx9HEYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7pp53tiDTbdUbaYf+Qcq8WVr+/Z
        LCbdn8Bicf78BnaLy7vmsFnMOL+PyWLtkbvsFkuvX2SyaN17hN2B02PNvDWMHptWdbJ53O8+
        zuTRt2UVo8fnTXIBrFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2Nimp
        OZllqUX6dgl6GU/+7GAvaNGpWNZ3mLGB8ZZSFyMnh4SAicTUeX+Yuxi5OIQEljJK3D59gxki
        IS2x/9pHdghbWOLPtS42iKLXjBJf3m4DSwgLhErs3DwZrEFEIELi9Z17LCBFzALvGCU2TH4P
        ViQksIFR4tMNBRCbTcBAov/NXhYQm1fATuLF8X2MIDaLgKrE5Vn3weKiQIMO75jFCFEjKHFy
        5hOwOKeApkTH6vOsIDazgJnEvM0PmSFseYntb+dA2eISt57MZ5rAKDQLSfssJC2zkLTMQtKy
        gJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmAsbjv2c/MOxksbgw8xCnAwKvHwfljTEyvE
        mlhWXJl7iFGCg1lJhNc3EijEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cA0kVcSb2hqaG5h
        aWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbG044MYc6qKxDWm9v7nyvs+73qj
        keS9t++bgod19qLySbkbv2lNXTn5L+vxn28tfiU8Sb0dXBDeYPr74iX9BQuDFri6MKkq+2y4
        9ZK37ry9Zfjnswq91WVfUhe3ulybn8u/V5xj9ZSrhl//bsyKVc53E/rN2SKk9nLjLofJ92dM
        6Toc/3Tb0q9KLMUZiYZazEXFiQA66RiY2wIAAA==
X-CMS-MailID: 20190926144702eucas1p26e2cd223b736e5189acfa44eb5eea7b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be
References: <CGME20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be@eucas1p2.samsung.com>
        <20190926125614.10408-1-m.szyprowski@samsung.com>
        <20190926140315.GA16002@pi3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/26/19 4:03 PM, Krzysztof Kozlowski wrote:
> On Thu, Sep 26, 2019 at 02:56:14PM +0200, Marek Szyprowski wrote:
>> From: Maciej Falkowski <m.falkowski@samsung.com>
>>
>> Convert Samsung Image Scaler to newer dt-schema format.
>>
>> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> v2:
>> - Removed quotation marks from string in 'compatible' property
>> - Added if-then statement for 'clocks' and 'clock-names' property
>> - Added include directive to example
>> - Added GIC_SPI macro to example
>>
>> Best regards,
>> Maciej Falkowski
>> ---
>>   .../bindings/gpu/samsung-scaler.txt           | 27 -------
>>   .../bindings/gpu/samsung-scaler.yaml          | 71 +++++++++++++++++++
>>   2 files changed, 71 insertions(+), 27 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.txt
>>   create mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt b/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
>> deleted file mode 100644
>> index 9c3d98105dfd..000000000000
>> --- a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
>> +++ /dev/null
>> @@ -1,27 +0,0 @@
>> -* Samsung Exynos Image Scaler
>> -
>> -Required properties:
>> -  - compatible : value should be one of the following:
>> -	(a) "samsung,exynos5420-scaler" for Scaler IP in Exynos5420
>> -	(b) "samsung,exynos5433-scaler" for Scaler IP in Exynos5433
>> -
>> -  - reg : Physical base address of the IP registers and length of memory
>> -	  mapped region.
>> -
>> -  - interrupts : Interrupt specifier for scaler interrupt, according to format
>> -		 specific to interrupt parent.
>> -
>> -  - clocks : Clock specifier for scaler clock, according to generic clock
>> -	     bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
>> -
>> -  - clock-names : Names of clocks. For exynos scaler, it should be "mscl"
>> -		  on 5420 and "pclk", "aclk" and "aclk_xiu" on 5433.
>> -
>> -Example:
>> -	scaler@12800000 {
>> -		compatible = "samsung,exynos5420-scaler";
>> -		reg = <0x12800000 0x1294>;
>> -		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH>;
>> -		clocks = <&clock CLK_MSCL0>;
>> -		clock-names = "mscl";
>> -	};
>> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
>> new file mode 100644
>> index 000000000000..af19930d052e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
>> @@ -0,0 +1,71 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: https://protect2.fireeye.com/url?k=1ffa720fd467d028.1ffbf940-9a5a550397b4da2b&u=http://devicetree.org/schemas/gpu/samsung-scaler.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Samsung Exynos SoC Image Scaler
>> +
>> +maintainers:
>> +  - Inki Dae <inki.dae@samsung.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - samsung,exynos5420-scaler
>> +      - samsung,exynos5433-scaler
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +

Hi Krzysztof,

By "Midgard" I assume that you referred to 
'Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml'.

I think that 'clocks' and 'clock-names' properties before if statement 
serve different purpose in this schema.
It totally has about 10 different compatibles grouped in five pairs.
Then schema declares for 'clocks' minItems as one and maxItems as two and
later it overrides this boundaries with if statement for particular 
compatibles.
Well, then clearly, the purpose is to declare boundaries for all of 
pairs and
not to provide easy-to-find definition for this properties.

In my schema I directly set boundaries per compatible with single 
if-else statement.
I didn't know what to put before then as if statement is already 
self-explanatory.

Best regards,
Maciej Falkowski

> I am repeating myself... leave the clocks and clock-names.
>
> "I think it is worth to leave the clocks and clock-names here (could be
> empty or with min/max values for number of items). This makes it easy to
> find the properties by humans.
>
> Midgard bindings could be used as example."
>
>> +if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: samsung,exynos5420-scaler
>> +then:
>> +  properties:
>> +    clocks:
>> +      items:
>> +        - description: mscl clock
>> +
>> +    clock-names:
>> +      items:
>> +        - const: mscl
>> +else:
>> +  properties:
>> +    clocks:
>> +      items:
>> +        - description: mscl clock
>> +        - description: aclk clock
>> +        - description: aclk_xiu clock
>> +
>> +    clock-names:
>> +      items:
>> +        - const: pclk
>> +        - const: aclk
>> +        - const: aclk_xiu
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/exynos5420.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    scaler@12800000 {
>> +        compatible = "samsung,exynos5420-scaler";
>> +        reg = <0x12800000 0x1294>;
>> +        interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&clock CLK_MSCL0>;
>> +        clock-names = "mscl";
>> +    };
>> +
> Unneeded trailing line.
>
> Best regards,
> Krzysztof
>
>
>
