Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B71C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946C021927
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RShI18E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfIRKIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 06:08:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51027 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfIRKIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:08:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190918100829euoutp02c893f820efb5ff1cad1cedac7ce882b8~FgHqnoZi_0857508575euoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:08:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190918100829euoutp02c893f820efb5ff1cad1cedac7ce882b8~FgHqnoZi_0857508575euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568801309;
        bh=SoPSWmL46dCyt6jpMsIRlH+mTit8bx9z6UaNw4gYnuI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RShI18E3AIkV+vc3zkY/d14qzsLlwmZSYxJ3+fLY7uKxFQo8eD5YYI5S5OypnlZ2+
         l22di0vlPDk/MIKb9Xl8nSmGFg/1vHvsZ/d3dLXuz4utwqAVhvWE6nmKs7hgQV0J4u
         yYOxTyYYf6N/ry5BNVy8g08breBk+Hf9XnDkjg2Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190918100828eucas1p2dd539e07f9d877b5259c14c70ebd3c5b~FgHp1uUNc1518015180eucas1p2A;
        Wed, 18 Sep 2019 10:08:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D4.11.04469.C12028D5; Wed, 18
        Sep 2019 11:08:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190918100827eucas1p236c0c2ac8b2b76a66165adb8cc8cb6b1~FgHpEl5C21741517415eucas1p2F;
        Wed, 18 Sep 2019 10:08:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190918100827eusmtrp13cd48098d61b1affadf4d1b91330fc83~FgHo0YvKq0828208282eusmtrp1j;
        Wed, 18 Sep 2019 10:08:27 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-c6-5d82021ca455
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 29.B1.04166.B12028D5; Wed, 18
        Sep 2019 11:08:27 +0100 (BST)
Received: from [106.120.51.95] (unknown [106.120.51.95]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190918100826eusmtip19afee81663cbbea5348d86db266519e0~FgHoOsVsC1971319713eusmtip1J;
        Wed, 18 Sep 2019 10:08:26 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: Convert Samsung I2S
 controller to dt-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Maciej Falkowski <m.falkowski@samsung.com>
Message-ID: <40f56f61-a1db-a1a2-262e-1f4c771481e1@samsung.com>
Date:   Wed, 18 Sep 2019 12:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJmjUR63i_hKUuZwDu42rebwABHu62bQoxTRRJu5yObEA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djPc7oyTE2xBotmiFjcWneO1eLKxUNM
        FlMfPmGzmH8EyD1/fgO7xbcrHUwWl3fNYbOYcX4fk8XaI3fZLZZev8hk0br3CLvF4TftrBYX
        V3xhcuD12PC5ic1jzbw1jB47Z91l99i0qpPNo2/LKkaPz5vkAtiiuGxSUnMyy1KL9O0SuDKO
        9egV7NarOHFrLmMD4zulLkZODgkBE4lLl66xgthCAisYJX4sNO9i5AKyvzBKzHvzngXC+cwo
        Mf/+XSaYjt4rZ5khEssZJSat+8YI4bxllGj49wKsSlggVuJ591IWEFtEQEViw/NbYB3MAv+Z
        JeY/7WYDSbAJGEj0v9kLVsQrYCfx7Oh3dhCbRUBVoqHzCFhcVCBC4tODw6wQNYISJ2c+AYtz
        CgRKXGqGqGEWkJdo3jqbGcIWl7j1ZD4TyDIJgXvsElvW3mKGuNtF4snzHVA/CEu8Or6FHcKW
        kTg9uQdoEAeQXS1x7ZssRG8Lo8T1aW/ZIGqsJf6smsgGUsMsoCmxfpc+RNhRYtmL70wQrXwS
        N94KQpzAJzFp23RmiDCvREebEISpKvFmQixEo7RE65r9jBMYlWYh+WsWkl9mIfllFsLaBYws
        qxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQKT2Ol/xz/tYPx6KekQowAHoxIPr8TZhlgh
        1sSy4srcQ4wSHMxKIrwBtfWxQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqem
        FqQWwWSZODilGhhVdp8WvcO33PvEfslTesrytuueJ5mYxk7uKHe7s0pEwe3+bpbubI4jfn1T
        lvPwZXZfDzzDXD5953U1/kgBqYnOydPeX3BPawjnVI7fJ7jetE7vY5Po+jflp+cc0VcoKJgo
        f4g5WCBne9DKtKKJlo8OLeWWXP8h+hLLnzy7I2tDVt55eXPaDnElluKMREMt5qLiRACWyBR1
        XgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xu7rSTE2xBuubZS1urTvHanHl4iEm
        i6kPn7BZzD8C5J4/v4Hd4tuVDiaLy7vmsFnMOL+PyWLtkbvsFkuvX2SyaN17hN3i8Jt2VouL
        K74wOfB6bPjcxOaxZt4aRo+ds+6ye2xa1cnm0bdlFaPH501yAWxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnHevQKdutVnLg1l7GB8Z1SFyMn
        h4SAiUTvlbPMXYxcHEICSxklVl57xwSRkJbYf+0jO4QtLPHnWhcbRNFrRok/b5rZQBLCArES
        jaf+gNkiAioSG57fApvELNDIItGy+TPU2C4mibu//oCNZRMwkOh/s5cFxOYVsJN4dvQ72AoW
        AVWJhs4jYHFRgQiJwztmMULUCEqcnPkELM4pEChxqRmihlnATGLe5ofMELa8RPPW2VC2uMSt
        J/OZJjAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGL3bjv3c
        vIPx0sbgQ4wCHIxKPLwHTjXECrEmlhVX5h5ilOBgVhLhDaitjxXiTUmsrEotyo8vKs1JLT7E
        aAr03ERmKdHkfGBiySuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnV
        wNilcH1S89EHX33fWlcFpp6cc2NHvMqhe2LhgU3d0+/+WFJ73Lv7Q9s1/7Pev55kNwYeyHjD
        ejbngcZzx49hl1elnf7y/OnvBXO2xQkqKXC/N3x8dcZLDp9Ox2vzm2c4becULDGQljP4fNb3
        XM6+bc3VF5VevNn9f//s/2IWrVM2xG07Yam9JyNfiaU4I9FQi7moOBEAMz+JDPQCAAA=
X-CMS-MailID: 20190918100827eucas1p236c0c2ac8b2b76a66165adb8cc8cb6b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190917120517eucas1p1188d244fac2d10d7990363ff25ffb70d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190917120517eucas1p1188d244fac2d10d7990363ff25ffb70d
References: <CGME20190917120517eucas1p1188d244fac2d10d7990363ff25ffb70d@eucas1p1.samsung.com>
        <20190917111413.22711-1-m.falkowski@samsung.com>
        <20190917120452.28135-1-m.falkowski@samsung.com>
        <CAL_JsqJmjUR63i_hKUuZwDu42rebwABHu62bQoxTRRJu5yObEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/17/19 3:05 PM, Rob Herring wrote:

> On Tue, Sep 17, 2019 at 7:05 AM Maciej Falkowski
> <m.falkowski@samsung.com> wrote:
>> Convert Samsung I2S controller to newer dt-schema format.
>>
>> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> v2:
>> - Added missing Signed-off-by certificate
>> ---
>>   .../devicetree/bindings/sound/samsung-i2s.txt |  84 -------------
>>   .../bindings/sound/samsung-i2s.yaml           | 119 ++++++++++++++++++
>>   2 files changed, 119 insertions(+), 84 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt
>>   create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.yaml
>> diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
>> new file mode 100644
>> index 000000000000..59dc76035cb4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
>> @@ -0,0 +1,119 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/samsung-i2s.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Samsung SoC I2S controller
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzk@kernel.org>
>> +  - Sangbeom Kim <sbkim73@samsung.com>
>> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
>> +
>> +properties:
>> +  compatible:
>> +    description: |
>> +      samsung,s3c6410-i2s: for 8/16/24bit stereo I2S.
>> +
>> +      samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
>> +      secondary fifo, s/w reset control and internal mux for root clk src.
>> +
>> +      samsung,exynos5420-i2s: for 8/16/24bit multichannel(5.1) I2S for
>> +      playback, stereo channel capture, secondary fifo using internal
>> +      or external dma, s/w reset control, internal mux for root clk src
>> +      and 7.1 channel TDM support for playback. TDM (Time division multiplexing)
>> +      is to allow transfer of multiple channel audio data on single data line.
>> +
>> +      samsung,exynos7-i2s: with all the available features of exynos5 i2s.
>> +
>> +      exynos7 I2S has 7.1 channel TDM support for capture, secondary fifo
>> +      with only external dma and more no.of root clk sampling frequencies.
>> +
>> +      samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
>> +      stereo channels. exynos7 i2s1 upgraded to 5.1 multichannel with
>> +      slightly modified bit offsets.
>> +    enum:
>> +      - "samsung,s3c6410-i2s"
>> +      - "samsung,s5pv210-i2s"
>> +      - "samsung,exynos5420-i2s"
>> +      - "samsung,exynos7-i2s"
>> +      - "samsung,exynos7-i2s1"
> No need for quotes here.
>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  dmas:
>> +    description: list of DMA controller phandle and DMA request line ordered pairs.
> How many?

Hi Rob,

I have one problem with determining size of dmas.

It seems that there are only two options for dmas: tx, rx or tx, rx, tx-sec.

It looks like minItems should be two and maxItems should be three.

However, some of bindings have different definition of dmas.

When there is:

         dmas = <&pdma0 10
                 &pdma0 9
                 &pdma0 8>;

the number of Items for dmas is one,

when there is:

         dmas = <&pdma0 10>,
                      <&pdma0 9>,
                      <&pdma0 8>;

the number of Items is three.

Both of these are equal from perspective of dtc,

however from schema point of view, they have different size.


What is a proper solution to this kind of problem?

Best regards,

Maciej Falkowski

>> +
>> +  dma-names:
>> +    description: |
>> +      identifier string for each DMA request line in the dmas property.
>> +      These strings correspond 1:1 with the ordered pairs in dmas.
>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 3
>> +
>> +  clock-names:
>> +    oneOf:
>> +      - items:
>> +          - const: iis
>> +      - items:
>> +          - const: iis
>> +          - const: i2s_opclk0
>> +      - items:
>> +          - const: iis
>> +          - const: i2s_opclk0
>> +          - const: i2s_opclk1
>> +    description: |
>> +      "iis" is the i2s bus clock.
>> +      For i2s1 and i2s2 - "iis", "i2s_opclk0"
>> +      For i2s0 - "iis", "i2s_opclk0", "i2s_opclk1"
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  samsung,idma-addr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Internal DMA register base address of the audio
>> +      sub system(used in secondary sound source).
>> +
>> +  pinctrl-0:
>> +    description: Should specify pin control groups used for this controller.
>> +
>> +  pinctrl-names:
>> +    const: default
>> +
>> +  "#sound-dai-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - dmas
>> +  - dma-names
>> +  - clocks
>> +  - clock-names
>> +
>> +examples:
>> +  - |
>> +    i2s0: i2s@3830000 {
>> +        compatible = "samsung,s5pv210-i2s";
>> +        reg = <0x03830000 0x100>;
>> +        dmas = <&pdma0 10
>> +                &pdma0 9
>> +                &pdma0 8>;
>> +        dma-names = "tx", "rx", "tx-sec";
>> +        clocks = <&clock_audss 0>, // EXYNOS_I2S_BUS
>> +                <&clock_audss 0>, // EXYNOS_I2S_BUS
>> +                <&clock_audss 0>; // EXYNOS_SCLK_I2S
>> +        clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
>> +        #clock-cells = <1>;
>> +        samsung,idma-addr = <0x03000000>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&i2s0_bus>;
>> +        #sound-dai-cells = <1>;
>> +    };
>> +
>> --
>> 2.17.1
>>
>
