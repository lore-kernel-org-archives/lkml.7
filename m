Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D680C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E585921743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rr83TGoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGQKMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:12:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42350 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:12:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190717101211euoutp02d4e0319e7dacf64222a57096177d62cc~yKh6t88M70820208202euoutp02A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:12:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190717101211euoutp02d4e0319e7dacf64222a57096177d62cc~yKh6t88M70820208202euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563358331;
        bh=msykPZ7nNZ5cKGhvIIQpKdQpce5ccuHAg0jMxr0HQxQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rr83TGoGUAuGjdlAyBxbxCc0TNqPpPS+qmtlLka8ivDg7ONhvDsE3eqTs9PSctzKV
         2osPCKnWLLz5FCtphADZFEDMY9vPpbXlz8fYp9nU0YtzIViDfcn6D7lDBKb2U7onpn
         wBSKf5q6I14/CficAXHL0GWqOJFp+Pj3j6e000kU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190717101211eucas1p2286cb55d32f69a6352eac20b051c1ef0~yKh54aJy72581725817eucas1p2d;
        Wed, 17 Jul 2019 10:12:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5A.F4.04325.A74FE2D5; Wed, 17
        Jul 2019 11:12:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190717101210eucas1p1eea10b59aecf5aaf5cac3a65d88e58b9~yKh5EVI_s2935029350eucas1p1X;
        Wed, 17 Jul 2019 10:12:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190717101209eusmtrp28b3e78eb7ba6e05908f153055725152c~yKh42FfH71055310553eusmtrp2L;
        Wed, 17 Jul 2019 10:12:09 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-99-5d2ef47a441f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.61.04140.974FE2D5; Wed, 17
        Jul 2019 11:12:09 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190717101209eusmtip189222d06d22c1d5296d08a5647aeb5e2~yKh4G4tPE0483704837eusmtip1y;
        Wed, 17 Jul 2019 10:12:09 +0000 (GMT)
Subject: Re: [PATCH v1 43/50] ARM: dts: exynos: add bus_isp in Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com, Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <c3c2ed20-fe6b-b395-001f-7319c72741ce@partner.samsung.com>
Date:   Wed, 17 Jul 2019 12:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcsH9YRzLOA1P5xc0Y3Zqh9+5o0RSxP-JcYOVEm7eO0Sw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3YuO1rTz2X5ZmWxiG44u/3x2Y2CivVXhhFZSM08qaS2dtTS
        blpYNkq7q0OzqKFby1KHpZnUJlqJmqxS1tVmBalYqFlkmqezyP9+z/M9L+/7wMdRSjcTyMUl
        JvH6RG28ivWmK+t/Ngen9asjFxpNauIqbWZIWd5thrT1f2ZIUd2ozHF3UaSl5Y6cNB3rlpNy
        90uGfDv9liHO6gKW5LXUysitujdyYmprlZHWp+vIq4wSlmQ+qJMTR/dJhgy/LKNXKzXWK1ak
        6W3PlGvKLadYTcWNo5psmwVp+sqDwtht3iui+fi4FF4fsmqnd6zhZgurK/E9UFXlYtJR03gD
        8uIALwWrNU9uQN6cEpcgaM++6hH9CNyP38ok0Yfge+lr9t9Ih93KSg/FCO7X/PKIHgRd5hxG
        TE3EG+BDn4sS2R/Pg7bfg4wYovALGn68G6QNiONYrIZ7ln0iKvB6yCpdLMZpPBuKOxv/jk7C
        W8Fpq0YiK7AfPMnvpEX2wpug2ZH516dwALg6i2QSz4C7PQWUuArwKQ5MlRmUdPVasJ8xexpM
        hC8NNrnE02CkShoGLED6mWtI4kPgzin0ZJaDo6GVEe+kRrvcrg6R7DXQYfrEijZgH2jv8ZNO
        8IHzlbmUZCsg64RSSs8F2+lnnkWTodh6WX4WqYxjihnHlDGOKWP8v/cqoi0ogE8WEmJ4YUki
        v18taBOE5MQY9a69CeVo9Os1DjcM3EO1Q1F2hDmkmqDQOIIjlYw2RUhNsCPgKJW/YuXAgkil
        Ilqbmsbr9+7QJ8fzgh1N5WhVgOLguPfblThGm8Tv4Xkdr//3KuO8AtPRlGPHgz5ewK+6B6Fi
        e27jSNfMwOu6uw9DtUts1iNf7GFffSe/v2KevtHZYKjvTYrXRYw0X4w7/9S8yL/CGffrZ2HH
        i4GMCHXxiS1VBRcsoYebpmXR5pRtKc+Dw+152Y/yl82M0OkiXSGbnemOKN++iEvskKxm97m6
        9epVNpdp1pxwFS3EahfNp/SC9g+b5kIbdgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsVy+t/xu7qVX/RiDc5+MbS4te4cq8XGGetZ
        La5/ec5qMf8IkNv/+DWzxfnzG9gtzja9YbfY9Pgaq8XHnnusFpd3zWGzmHF+H5PF2iN32S2W
        Xr/IZHHxlKvF7cYVbBate4+wWxx+085q8e/aRhYHIY8189Ywery/0crusWlVJ5vH5iX1Hn1b
        VjF6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZa
        pG+XoJfRtfo8W8EK/oqdO2+xNjCe5e5i5OSQEDCReHhoDVsXIxeHkMBSRolfEy4wQiTEJCbt
        284OYQtL/LnWBVX0mlFi+85pzCAJYQFPiUefb4HZIgKaEtf/fmcFKWIWuMoiMeXVRnaIjn4m
        iYvzjwK1c3CwCehJ7FhVCGLyCrhJdKwzAullEVCVWP7kNNgcUYEIib622WwgNq+AoMTJmU9Y
        QGxOgUCJc4dbwY5jFjCTmLf5ITOELS5x68l8JghbXmL72znMExiFZiFpn4WkZRaSlllIWhYw
        sqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjPRtx35u2cHY9S74EKMAB6MSD6/HYd1YIdbE
        suLK3EOMEhzMSiK8tl+1Y4V4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5iE8kriDU0NzS0s
        Dc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MK4y6Nn2kZ3JI1Pq+ozsWda3RK8I
        HTzBcs5Utoxp7soNnC2ti4UF7qytcOp6HOBixFPw+M8nvWfishJmpRcv9C2S1px74f5Cux1B
        rprHu/4mPjd6atL1wogx8czPIr3Kc3WTnjRuSsiIcv7OaafUorngePvVH93rr36JE+y5HOYv
        YeS3sv7FASWW4oxEQy3mouJEACuQ5WcKAwAA
X-CMS-MailID: 20190717101210eucas1p1eea10b59aecf5aaf5cac3a65d88e58b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124509eucas1p1f2e44af951158fbef1a245467956ef93
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124509eucas1p1f2e44af951158fbef1a245467956ef93
References: <CGME20190715124509eucas1p1f2e44af951158fbef1a245467956ef93@eucas1p1.samsung.com>
        <20190715124417.4787-1-l.luba@partner.samsung.com>
        <20190715124417.4787-44-l.luba@partner.samsung.com>
        <CAJKOXPcsH9YRzLOA1P5xc0Y3Zqh9+5o0RSxP-JcYOVEm7eO0Sw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/17/19 12:02 PM, Krzysztof Kozlowski wrote:
> On Mon, 15 Jul 2019 at 14:45, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Add bus_isp which changes ACLK400_ISP clock speed according to the bus
>> documentation in the documentation. The bus_isp OPP table has been
>> aligned to the new parent rate.
> 
> Title and msg needs fixing.
> 
> Please squash it with patch 18.
You are right, it needs to be squashed. As I mentioned earlier Barek
suggested offline to make 'atomic modifications' of OPPs and PLL/clocks
rates for all affected children in the clock tree.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
>> This patch sets the proper parent and
>> picks the init frequency before the devfreq governor starts working.
>> It sets also parent rate (DPLL to 1200MHz).
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> index 990fe03fce75..852cb3dd495d 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> @@ -166,6 +166,18 @@
>>          status = "okay";
>>   };
>>
>> +&bus_isp {
>> +       devfreq = <&bus_wcore>;
>> +       assigned-clocks = <&clock CLK_MOUT_ACLK400_ISP>,
>> +                         <&clock CLK_MOUT_SW_ACLK400_ISP>,
>> +                         <&clock CLK_DOUT_ACLK400_ISP>,
>> +                         <&clock CLK_FOUT_DPLL>;
>> +       assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>,
>> +                                <&clock CLK_DOUT_ACLK400_ISP>;
>> +       assigned-clock-rates = <0>, <0>, <400000000>, <1200000000>;
>> +       status = "okay";
>> +};
>> +
>>   &cpu0 {
>>          cpu-supply = <&buck6_reg>;
>>   };
>> --
>> 2.17.1
>>
> 
> 
