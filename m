Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58647C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D79F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QOsekYg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfGQK1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:27:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57531 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGQK1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:27:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190717102742euoutp01624b1084bcad5c32e460850ba651af36~yKvdTDQuj0291402914euoutp01q
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:27:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190717102742euoutp01624b1084bcad5c32e460850ba651af36~yKvdTDQuj0291402914euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563359262;
        bh=iB1QtByjyd0P/XN/YkMVgR+nl43qh6xlM1ggN0/FSXc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QOsekYg7uDN/yWGFfk9LE3t/Ox1ujCFaU12WFqo6zVIzwSddz532IURaKgUy8Tsw4
         OwllVRW0RBHFM25w7xys1srQD4a0dLhDtcRiQGt8EwYd4uyQL6kRoO6SJyzkAEuWH1
         YbJiRbNweS68Mp/kwDC1Ew4GBUTOOFsJiiKfv0Lo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190717102741eucas1p23f3d8810e1929cc25f0052c815dbf389~yKvcbvz0Q3019930199eucas1p2s;
        Wed, 17 Jul 2019 10:27:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5F.9B.04298.D18FE2D5; Wed, 17
        Jul 2019 11:27:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190717102740eucas1p17ffdf3b1560ad6d56311b5a92e9a5e7a~yKvbfKdWR0755707557eucas1p1b;
        Wed, 17 Jul 2019 10:27:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190717102740eusmtrp23963acbd383cc2a0d250dd3a4f351c4c~yKvbQ3UTl1980319803eusmtrp2c;
        Wed, 17 Jul 2019 10:27:40 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-5a-5d2ef81d5c97
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.23.04140.C18FE2D5; Wed, 17
        Jul 2019 11:27:40 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190717102739eusmtip1d74ac72fc55f265d9c29d7e594ecb2d3~yKvagaTUm1611016110eusmtip1B;
        Wed, 17 Jul 2019 10:27:39 +0000 (GMT)
Subject: Re: [PATCH v1 26/50] ARM: dts: exynos: align NOC100 bus OPPs in
 Exynos5420
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
Message-ID: <8ed83c77-57f7-78a4-e437-714cfc7b5c58@partner.samsung.com>
Date:   Wed, 17 Jul 2019 12:27:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPc3qsM5Xe5JViDZXYfes+_veb-KX3fnZjpkUCrphBcu-Q@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRjt3XdVnH3Oygcro4FQicsi6IWsVljsV2QQSKK16kMjnbZPTbPL
        ilZW3ohIW2ZqmbbMy1pLJ2boSMps2UXNMA0XYToiL2iEq81vkf/Oc57zvOcceFlC5qCC2SOa
        NF6rUSfJaV/S8vyXPXz5jCIuouk9i/trX1O4obiOwr2T3yh82+YeC4ZHCWy31zO469wYg03D
        PRT+mfuZwu+sJTQutj+V4Ie2AQZX9nZLcPfLHfjT2Woa61tsDG4fu0hhV08DqZSpakprkOpH
        n55RmYyXaNWju2dU+WYjUk2YQnbT+3wjD/NJRzJ47dotB3wTmybGJakWOvP3SA6tQzrqMvJh
        gdsALZaLksvIl5Vx1QhuNn5C4jCJoNVh8G4mEDSP3SH/nXyZzSPERRUC/WsjIw5OBPambolH
        FcjthUJDLuPBi7jV0Ds7TXlEBPeBhJnBafdTLEtzCmg0HvNopNxOGCi00R5McqHw6P6NObfF
        XAy8M1uRqAmAFzccc7wPFw2VQ2VzeoILgn7HbYmIV8ATZ8lcOuAusVD07Lk3dhSUXzN5cSB8
        7zAzIl4Gf5rEY+AE0OWVIxGfhOGCW17NJmjv6KY8mQl3mTrrWpHeBtPts4yHBs4f+pwBYgR/
        uGopIkRaCjkXZKJ6FZhz33iNlkBVzXWmEMkN84oZ5pUxzCtj+O9bhkgjCuLTheQEXlin4Y8r
        BHWykK5JUBxKSTYh99/rdHWMN6KptwfbEMciuZ9U1R4eJ6PUGUJWchsClpAvkm6eCouTSQ+r
        s07w2pT92vQkXmhDS1lSHiTNXjAUK+MS1Gn8UZ5P5bX/thLWJ1iHFv/uqvg889HxvlSqLE0v
        FgwrH3ReyX4aPzCuZFr8opb3nl5oCW1ef60i7064Ky1yJGN06OF21Bkf/3hv5J6jzl3W1nrb
        vZCvro2Ndy0xtba6vtjo3LD8j61kR6p1LO9YTERRc6BfT8+gU6+SbH0VcYqY6o86jzJz0iqj
        Sz4o9/NyUkhUr1tDaAX1XwLB7od3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xu7oyP/RiDWY/5LC4te4cq8XGGetZ
        La5/ec5qMf8IkNv/+DWzxfnzG9gtzja9YbfY9Pgaq8XHnnusFpd3zWGzmHF+H5PF2iN32S2W
        Xr/IZHHxlKvF7cYVbBate4+wWxx+085q8e/aRhYHIY8189Ywery/0crusWlVJ5vH5iX1Hn1b
        VjF6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZa
        pG+XoJex8/MnpoJtbBW/X3awNTA2sHYxcnJICJhIPPzby9zFyMUhJLCUUeLj6RdQCTGJSfu2
        s0PYwhJ/rnWxQRS9ZpS4u7aXDSQhLBAqMWFWD1iRiICmxPW/31lBipgFrrJITHm1kR2io59J
        4sfESSxdjBwcbAJ6EjtWFYI08Aq4SdydcARsEIuAqsTmlTNZQGxRgQiJvrbZbBA1ghInZz4B
        i3MKBEosfbAALM4sYCYxb/NDZghbXOLWk/lMELa8xPa3c5gnMArNQtI+C0nLLCQts5C0LGBk
        WcUoklpanJueW2ykV5yYW1yal66XnJ+7iREY69uO/dyyg7HrXfAhRgEORiUeXo/DurFCrIll
        xZW5hxglOJiVRHhtv2rHCvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MA3llcQbmhqaW1ga
        mhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgFA2/NX9/W6Na69v9PGym0zU/7X2f
        H/BOi71vYcbmcJf2izfe31uw+8MaM+MTHpOvpoWe/jApuvPpG40PKwod5U3zLWv2bNg7nfGo
        5Ip1RUd6qnor9vJmzAtc3m370VxjavrFqt+/RCIrAk40mju8EX1/xTdO7uRhtv2/pibbHugq
        SGef0rfrjRJLcUaioRZzUXEiAHEFoU0LAwAA
X-CMS-MailID: 20190717102740eucas1p17ffdf3b1560ad6d56311b5a92e9a5e7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124455eucas1p13bfc0c1d113225db9607e4c0dbac353c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124455eucas1p13bfc0c1d113225db9607e4c0dbac353c
References: <CGME20190715124455eucas1p13bfc0c1d113225db9607e4c0dbac353c@eucas1p1.samsung.com>
        <20190715124417.4787-1-l.luba@partner.samsung.com>
        <20190715124417.4787-27-l.luba@partner.samsung.com>
        <CAJKOXPc3qsM5Xe5JViDZXYfes+_veb-KX3fnZjpkUCrphBcu-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/17/19 12:10 PM, Krzysztof Kozlowski wrote:
> On Mon, 15 Jul 2019 at 14:44, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> The NOC100 has a parent which clock rate is set tot 400MHz. The OPPs which
>> are not possible to set are removed and new one is added.
> 
> I think it is just NOC bus... or are there more of such and this is 100 MHz one?
Yes, there is a bus NOC100 with a dedicated clock tree in the HW (with
3 muxes and one divider), which makes possible to take different PLL as
a source then WCORE have, divide the rate from it and even switch for a
while to alternative stable PLL (on the 2nd mux to SPLL (after a
divider)) to wait for main PLL rate change stability delay. Max rate is
limited to 100MHz for this NOC100 bus.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
