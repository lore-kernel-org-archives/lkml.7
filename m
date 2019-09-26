Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911F5C352AA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E01D222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SZqsn4Kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfIZQyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:54:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37845 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfIZQyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:54:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190926165404euoutp01b9a9085e3f1a3f28260452bb8d619803~IC0Eh5Hhi0739607396euoutp01O
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 16:54:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190926165404euoutp01b9a9085e3f1a3f28260452bb8d619803~IC0Eh5Hhi0739607396euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569516844;
        bh=Fk+ENsDbI/3zLFGvOyn1aGDR60LyjbTSjWXCL3BgL6U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SZqsn4KxzYbLEXesIv/dpkHleaeEr139ZscNlRY0s4RlR/sDdPakZ+a0pHzr1HTj/
         xRYgGOZ9ZvpvXwj/2Bym7aOg0zPjnPR+fm05yU560ZpSXTQnSmgS7zTHj6GTziJIRj
         eZVm2D3DOg2d8JS9oXTvQrw3MwB/PSZv9RhGQQZs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190926165403eucas1p2d95e704cd2972823f64f77dfcc7704aa~IC0Dv6_oS1904119041eucas1p2P;
        Thu, 26 Sep 2019 16:54:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C8.B9.04309.B2DEC8D5; Thu, 26
        Sep 2019 17:54:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190926165402eucas1p2da22d0e506b1a29a1efa8349c96cc09f~IC0Cy5mq61511215112eucas1p2V;
        Thu, 26 Sep 2019 16:54:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190926165402eusmtrp2531ece75f393e6171739829d0a3aa4c7~IC0Cxnw-J1586915869eusmtrp2S;
        Thu, 26 Sep 2019 16:54:02 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-03-5d8ced2bafb3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A4.81.04166.A2DEC8D5; Thu, 26
        Sep 2019 17:54:02 +0100 (BST)
Received: from [106.120.51.95] (unknown [106.120.51.95]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190926165402eusmtip2da764e4a84f6a3aa8cbf9b5cd9989448~IC0CQQSLj2515325153eusmtip2O;
        Thu, 26 Sep 2019 16:54:01 +0000 (GMT)
Subject: Re: [PATCH v2] dt-bindings: gpu: Convert Samsung Image Scaler to
 dt-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>
From:   Maciej Falkowski <m.falkowski@samsung.com>
Message-ID: <f06da64d-58de-1d51-48d4-95a6efd417d0@samsung.com>
Date:   Thu, 26 Sep 2019 18:54:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL4LZdkWkDkZdEpv4Sh840GywfHhLgmWjYCm9z+QPxrLg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87rab3tiDdqfqFjMP3KO1eLK1/ds
        FpPuT2CxOH9+A7vF5V1z2CxmnN/HZLH2yF12i6XXLzJZtO49wu7A6bFm3hpGj02rOtk87ncf
        Z/Lo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujPnHIgpm6lb0PD7D3MB4RqWLkZNDQsBEYvbk
        fUxdjFwcQgIrGCVezrjLCuF8YZR4vL2ZEcL5zCix5F4vSxcjB1jLrVdhEPHlQEVvpkO1v2WU
        6Px0gA1krrBAqMTOzZOZQWwRARWJDc9vMYMUMQs8ZZI4tPM4O0iCTcBAov/NXhYQm1fATuJA
        /y+wOIuAqsSK7pdgzaICERKfHhxmhagRlDg58wlYPadAoMSWv2/A6pkF5CW2v53DDGGLS9x6
        Mh/sIgmBfewSS/4vZob41EVi4bHzLBC2sMSr41vYIWwZif87QRpAXquWuPZNFqK3hVHi+rS3
        bBA11hJ/Vk1kA6lhFtCUWL9LHyLsKLH60XdWiFY+iRtvBSFO4JOYtG06M0SYV6KjTQjCVJV4
        MyEWolFaonXNfsYJjEqzkPw1C8kvs5D8Mgth7QJGllWM4qmlxbnpqcVGeanlesWJucWleel6
        yfm5mxiBKen0v+NfdjDu+pN0iFGAg1GJh3fGqp5YIdbEsuLK3EOMEhzMSiK8vpFAId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYx9oS4H7pSfU6paN2G7
        3qTvUvc0zReeP3A7eq5zpP0R+SbN3im3FXgv79GWuz7HaeGpHzO3pP5JKCtpunlj5puYPaXz
        Dq2JclBZ+kxQvNYzfYbQdKeIv7+q7h34udUj9Yb40q/deSnn+FxmHzNO3r9/XcLMJf/Sy9ka
        uwRYWh4t/PrbvN0+UHOKEktxRqKhFnNRcSIA3G87xEUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7pab3tiDT4vkreYf+Qcq8WVr+/Z
        LCbdn8Bicf78BnaLy7vmsFnMOL+PyWLtkbvsFkuvX2SyaN17hN2B02PNvDWMHptWdbJ53O8+
        zuTRt2UVo8fnTXIBrFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2Nimp
        OZllqUX6dgl6GfOPRRTM1K3oeXyGuYHxjEoXIweHhICJxK1XYV2MXBxCAksZJWb/38XSxcgJ
        FJeW2H/tIzuELSzx51oXG0TRa0aJzhd3GEESwgKhEjs3T2YGsUUEVCQ2PL/FDFLELPCUSWLn
        msmsEB1rmCQe9s0AG8smYCDR/2YvmM0rYCdxoP8X2AoWAVWJFd0vwSaJCkRIHN4xixGiRlDi
        5MwnYPWcAoESW/6+AatnFjCTmLf5ITOELS+x/e0cKFtc4taT+UwTGIVmIWmfhaRlFpKWWUha
        FjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMxG3Hfm7ewXhpY/AhRgEORiUe3g9remKF
        WBPLiitzDzFKcDArifD6RgKFeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YJPJK4g1NDc0t
        LA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTB2bJkS9nIed/fOrz58igs3CLde
        LBNQjckPafW6dPb/3CmWvFZZ6Wqimlyhtd/Yd3FPFQyK1E60q2i4sPNN+vbCng8M0d6XBTf8
        r32UEGu+bl9n8Kp9M8LDbDJSRK27GZ8Jfd1+cF9G7Dd5xsLFClyzrcvcefZnBv9SLPJm+sp3
        sii24NRSeSWW4oxEQy3mouJEAEoO5hfaAgAA
X-CMS-MailID: 20190926165402eucas1p2da22d0e506b1a29a1efa8349c96cc09f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be
References: <CGME20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be@eucas1p2.samsung.com>
        <20190926125614.10408-1-m.szyprowski@samsung.com>
        <20190926140315.GA16002@pi3>
        <0d3831ae-e33d-774d-02f7-fba45a95d25c@samsung.com>
        <CAL_JsqL4LZdkWkDkZdEpv4Sh840GywfHhLgmWjYCm9z+QPxrLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/26/19 5:35 PM, Rob Herring wrote:
> On Thu, Sep 26, 2019 at 9:47 AM Maciej Falkowski
> <m.falkowski@samsung.com> wrote:
>>
>> On 9/26/19 4:03 PM, Krzysztof Kozlowski wrote:
>>> On Thu, Sep 26, 2019 at 02:56:14PM +0200, Marek Szyprowski wrote:
>>>> From: Maciej Falkowski <m.falkowski@samsung.com>
>>>>
>>>> Convert Samsung Image Scaler to newer dt-schema format.
>>>>
>>>> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>> v2:
>>>> - Removed quotation marks from string in 'compatible' property
>>>> - Added if-then statement for 'clocks' and 'clock-names' property
>>>> - Added include directive to example
>>>> - Added GIC_SPI macro to example
>>>>
>>>> Best regards,
>>>> Maciej Falkowski
>>>> ---
>>>>    .../bindings/gpu/samsung-scaler.txt           | 27 -------
>>>>    .../bindings/gpu/samsung-scaler.yaml          | 71 +++++++++++++++++++
>>>>    2 files changed, 71 insertions(+), 27 deletions(-)
>>>>    delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.txt
>>>>    create mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt b/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
>>>> deleted file mode 100644
>>>> index 9c3d98105dfd..000000000000
>>>> --- a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
>>>> +++ /dev/null
>>>> @@ -1,27 +0,0 @@
>>>> -* Samsung Exynos Image Scaler
>>>> -
>>>> -Required properties:
>>>> -  - compatible : value should be one of the following:
>>>> -    (a) "samsung,exynos5420-scaler" for Scaler IP in Exynos5420
>>>> -    (b) "samsung,exynos5433-scaler" for Scaler IP in Exynos5433
>>>> -
>>>> -  - reg : Physical base address of the IP registers and length of memory
>>>> -      mapped region.
>>>> -
>>>> -  - interrupts : Interrupt specifier for scaler interrupt, according to format
>>>> -             specific to interrupt parent.
>>>> -
>>>> -  - clocks : Clock specifier for scaler clock, according to generic clock
>>>> -         bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
>>>> -
>>>> -  - clock-names : Names of clocks. For exynos scaler, it should be "mscl"
>>>> -              on 5420 and "pclk", "aclk" and "aclk_xiu" on 5433.
>>>> -
>>>> -Example:
>>>> -    scaler@12800000 {
>>>> -            compatible = "samsung,exynos5420-scaler";
>>>> -            reg = <0x12800000 0x1294>;
>>>> -            interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH>;
>>>> -            clocks = <&clock CLK_MSCL0>;
>>>> -            clock-names = "mscl";
>>>> -    };
>>>> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
>>>> new file mode 100644
>>>> index 000000000000..af19930d052e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
>>>> @@ -0,0 +1,71 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: https://protect2.fireeye.com/url?k=1ffa720fd467d028.1ffbf940-9a5a550397b4da2b&u=http://devicetree.org/schemas/gpu/samsung-scaler.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Samsung Exynos SoC Image Scaler
>>>> +
>>>> +maintainers:
>>>> +  - Inki Dae <inki.dae@samsung.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - samsung,exynos5420-scaler
>>>> +      - samsung,exynos5433-scaler
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>> Hi Krzysztof,
> Please work on your quoting. Reply below what you are replying to.
>
>> By "Midgard" I assume that you referred to
>> 'Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml'.
>>
>> I think that 'clocks' and 'clock-names' properties before if statement
>> serve different purpose in this schema.
>> It totally has about 10 different compatibles grouped in five pairs.
>> Then schema declares for 'clocks' minItems as one and maxItems as two and
>> later it overrides this boundaries with if statement for particular
>> compatibles.
> It's not an override, but an AND. So what's under 'properties' has to
> be the looser constraints than what is under an if/then schema.
Hi Rob,
Thank you for explaining that.
>> Well, then clearly, the purpose is to declare boundaries for all of
>> pairs and
>> not to provide easy-to-find definition for this properties.
>>
>> In my schema I directly set boundaries per compatible with single
>> if-else statement.
>> I didn't know what to put before then as if statement is already
>> self-explanatory.
>>
>> Best regards,
>> Maciej Falkowski
>>
>>> I am repeating myself... leave the clocks and clock-names.
>>>
>>> "I think it is worth to leave the clocks and clock-names here (could be
>>> empty or with min/max values for number of items). This makes it easy to
>>> find the properties by humans.
> I agree.
>
> Let me put it another way. You need to add an 'additionalProperties:
> false' and (I think) to make that work you'll need them listed here.
>
> Rob

So when properties are only defined inside if-then scope,
they are labeled as 'additional' as they are not defined inside
scope of 'properties'. It is mandatory then to mention 'clock' and
'clock-names' there if 'additionalProperties: false' .

However I had not set it intentionally as there are additional 
properties in some bindings,
exactly 'iommu' and 'power-domains' are undocumented.
Is it a good way to put them in 'properties' just to be able to forbid 
additional properties?

Best regards,
Maciej Falkowski

>
