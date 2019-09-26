Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B87C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AF721D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r+4zKtXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfIZLtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:49:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54075 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfIZLtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:49:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190926114911euoutp01677ab3b67adbf218de8634f45e47191c~H_p3r0QGT1255712557euoutp01T
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 11:49:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190926114911euoutp01677ab3b67adbf218de8634f45e47191c~H_p3r0QGT1255712557euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569498551;
        bh=BZepKz4s3f0hH8VdX/xzVxY/cw+IEqzC2BvljnieNfo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=r+4zKtXhS/N/MAlj5mLoQXwp+TiGJ3ZRxX1SeQJBJLDBuTdu5CFS8jujb+ZU5CI5+
         H9cHMohORFECkq7UbgeN/ECSYFd3/9YokxuG3CkDlLAX3i9EjxYMKYTgyP1B8YaWUz
         9m8nRwzacjXb7kzgeIPzn6rDV35pSHfJFizFatXs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190926114910eucas1p16728ac2239829b09c6cc666cd3da5431~H_p3EjocS0228002280eucas1p1L;
        Thu, 26 Sep 2019 11:49:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0B.CF.04374.6B5AC8D5; Thu, 26
        Sep 2019 12:49:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190926114910eucas1p15e7a562f8f80c3acea8a06427a0c57e2~H_p2pnpqG1908619086eucas1p1f;
        Thu, 26 Sep 2019 11:49:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190926114910eusmtrp2014e840fd7d0173045f47576f4f0778d~H_p2jWhyv1405114051eusmtrp2b;
        Thu, 26 Sep 2019 11:49:10 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-d8-5d8ca5b6d65b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.CF.04166.6B5AC8D5; Thu, 26
        Sep 2019 12:49:10 +0100 (BST)
Received: from [106.120.51.95] (unknown [106.120.51.95]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190926114909eusmtip22854c372d5aa31c8477fa118027379bf~H_p2FPnJS1433814338eusmtip2J;
        Thu, 26 Sep 2019 11:49:09 +0000 (GMT)
Subject: Re: [PATCH] dt-bindings: sound: Convert Samsung Exynos5433 TM2(E)
 audio complex with WM5110 codec to dt-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>
From:   Maciej Falkowski <m.falkowski@samsung.com>
Message-ID: <50932d65-6d8b-aca2-2bec-d4eedaba0bdc@samsung.com>
Date:   Thu, 26 Sep 2019 13:49:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924152028.GD9218@pi3>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87rblvbEGsz6pWhx5eIhJoupD5+w
        Wcw/co7V4vz5DewW3650MFlc3jWHzWLG+X1MFmuP3GW3WHr9IpNF694j7BaH37SzOnB7bPjc
        xOaxZt4aRo+ds+6ye2xa1cnm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBmbvt9mLpiqWvF2
        yUKmBsarsl2MnBwSAiYS07/8ZAGxhQRWMEos6pTrYuQCsr8wSiw485wNwvnMKPHv+35mmI77
        vVdZIRLLGSVu9F9ihHDeMkps+PQJyOHgEBaolPjbLwRiighESGxfyQ5Swiywj0niz7ytTCCD
        2AQMJPrf7AVbzStgJ/GhYT8jiM0ioCqxo/sRG4gtCtT76cFhVogaQYmTM5+A1XMKaEhM2P4T
        rJ5ZQF5i+9s5zBC2uMStJ/OZQJZJCNxil9g44zwLxNUuEn0tbVAfCEu8Or6FHcKWkfi/E6SB
        A8iulrj2TRait4VR4vq0t2wQNdYSf1ZNZAOpYRbQlFi/Sx8i7Cjx9slVRohWPokbbwUhTuCT
        mLRtOjNEmFeio00IwlSVeDMhFqJRWqJ1zX7GCYxKs5D8NQvJL7OQ/DILYe0CRpZVjOKppcW5
        6anFxnmp5XrFibnFpXnpesn5uZsYgenq9L/jX3cw7vuTdIhRgINRiYf3QFh3rBBrYllxZe4h
        RgkOZiURXt/Inlgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwc
        nFINjKFpF3ffW2Sz1U9j7uyqD/uT1jsXzD/LZXZ3q1XM5ZJDJyf91Jy+TC+nRq7V3jRuxaQn
        O4MWFgqamIf9nbn5gqjt//CDyZ85dnK1JX5Jt7t1nHvDhvMnQmd1XwyaXfrD4Z3Cyo1LVpTf
        /cc3u6r9t9dCZdVSVTdeppvmeu1vHm17NnUTZ4ui+nclluKMREMt5qLiRADsk6FCUwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7rblvbEGtzpZrW4cvEQk8XUh0/Y
        LOYfOcdqcf78BnaLb1c6mCwu75rDZjHj/D4mi7VH7rJbLL1+kcmide8RdovDb9pZHbg9Nnxu
        YvNYM28No8fOWXfZPTat6mTz6NuyitHj8ya5ALYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
        E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxN328zF0xVrXi7ZCFTA+NV2S5GTg4JAROJ+71X
        WUFsIYGljBKznhdCxKUl9l/7yA5hC0v8udbF1sXIBVTzmlGi7+ULpi5GDg5hgUqJv/1CIDUi
        AhESr+/cYwGpYRbYxyRxdtcDdoiGtYwSu38tZQSpYhMwkOh/s5cFxOYVsJP40LAfLM4ioCqx
        o/sRG4gtCjTp8I5ZjBA1ghInZz4Bq+cU0JCYsP0nWJxZwExi3uaHzBC2vMT2t3OgbHGJW0/m
        M01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBOtx37uXkH
        46WNwYcYBTgYlXh4D4R1xwqxJpYVV+YeYpTgYFYS4fWN7IkV4k1JrKxKLcqPLyrNSS0+xGgK
        9NxEZinR5HxgCskriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cBY
        WH/Fh4d/wdkE7Z8H1j2SMqqedOh3xMsbSXYajYcmnLq5+ZlgjyjHiggpDsG1p2fGLXis8vsh
        TwVDrvcty6ml/KkL/mbMS71ot5T5a6xBjauLM/91BmvOvfcUA5uu83LVppo4F+9P1f3Z6h2y
        Q7eWW6p9fevhxVyq+T2HbVUUZCdc6bptJqnEUpyRaKjFXFScCAAcT8No6QIAAA==
X-CMS-MailID: 20190926114910eucas1p15e7a562f8f80c3acea8a06427a0c57e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190924150230eucas1p295da8f6aa018aec4acabc068f6e1afa1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190924150230eucas1p295da8f6aa018aec4acabc068f6e1afa1
References: <CGME20190924150230eucas1p295da8f6aa018aec4acabc068f6e1afa1@eucas1p2.samsung.com>
        <20190924150146.15972-1-m.szyprowski@samsung.com>
        <20190924152028.GD9218@pi3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/19 5:20 PM, Krzysztof Kozlowski wrote:
> On Tue, Sep 24, 2019 at 05:01:46PM +0200, Marek Szyprowski wrote:
>> From: Maciej Falkowski <m.falkowski@samsung.com>
>>
>> Convert Samsung Exynos5433 TM2(E) audio complex with WM5110 codec to newer dt-schema format.
>>
>> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   .../bindings/sound/samsung,tm2-audio.txt      | 42 ----------
>>   .../bindings/sound/samsung,tm2-audio.yaml     | 83 +++++++++++++++++++
>>   2 files changed, 83 insertions(+), 42 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>>   create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>> deleted file mode 100644
>> index f5ccc12ddc00..000000000000
>> --- a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>> +++ /dev/null
>> @@ -1,42 +0,0 @@
>> -Samsung Exynos5433 TM2(E) audio complex with WM5110 codec
>> -
>> -Required properties:
>> -
>> - - compatible		 : "samsung,tm2-audio"
>> - - model		 : the user-visible name of this sound complex
>> - - audio-codec		 : the first entry should be phandle of the wm5110 audio
>> -			   codec node, as described in ../mfd/arizona.txt;
>> -			   the second entry should be phandle of the HDMI
>> -			   transmitter node
>> - - i2s-controller	 : the list of phandle and argument tuples pointing to
>> -			   I2S controllers, the first entry should be I2S0 and
>> -			   the second one I2S1
>> - - audio-amplifier	 : the phandle of the MAX98504 amplifier
>> - - samsung,audio-routing : a list of the connections between audio components;
>> -			   each entry is a pair of strings, the first being the
>> -			   connection's sink, the second being the connection's
>> -			   source; valid names for sources and sinks are the
>> -			   WM5110's and MAX98504's pins and the jacks on the
>> -			   board: HP, SPK, Main Mic, Sub Mic, Third Mic,
>> -			   Headset Mic
>> - - mic-bias-gpios	 : GPIO pin that enables the Main Mic bias regulator
>> -
>> -
>> -Example:
>> -
>> -sound {
>> -	compatible = "samsung,tm2-audio";
>> -	audio-codec = <&wm5110>, <&hdmi>;
>> -	i2s-controller = <&i2s0 0>, <&i2s1 0>;
>> -	audio-amplifier = <&max98504>;
>> -	mic-bias-gpios = <&gpr3 2 0>;
>> -	model = "wm5110";
>> -	samsung,audio-routing =
>> -		"HP", "HPOUT1L",
>> -		"HP", "HPOUT1R",
>> -		"SPK", "SPKOUT",
>> -		"SPKOUT", "HPOUT2L",
>> -		"SPKOUT", "HPOUT2R",
>> -		"Main Mic", "MICBIAS2",
>> -		"IN1R", "Main Mic";
>> -};
>> diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
>> new file mode 100644
>> index 000000000000..377f8cbe17b8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: https://protect2.fireeye.com/url?k=ccb9abe11b8a2745.ccb820ae-a91cd712f01d248e&u=http://devicetree.org/schemas/sound/samsung,tm2-audio.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Samsung Exynos SoC Exynos5433 TM2(E) audio complex with WM5110 codec
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzk@kernel.org>
>> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: samsung,tm2-audio
>> +
>> +  model:
>> +    maxItems: 1
> $ref to string, then maxItems are not needed.
> Add description (copy-paste).

Hi Krzysztof,

You're right, model is not a standard property.

>> +
>> +  audio-codec:
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
>> +      - items:
>> +          - description: |
>> +              phandle of the wm5110 audio codec node,
>> +              as described in ../mfd/arizona.txt;
>> +          - description: phandle of the HDMI transmitter node.
>> +
>> +  i2s-controller:
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
>> +      - items:
>> +          - description: phandle of the I2S0.
>> +          - description: phandle of the I2S1.
>> +
>> +  audio-amplifier:
> Can you order the nodes here and in required section by name (except
> compatible which should be first)?

Current order is already well-established across bindings (even example).
I think that sorted properties are undesired with that.

Best regards,
Maciej Falkowski

>
> Best regards,
> Krzysztof
>
>
>
