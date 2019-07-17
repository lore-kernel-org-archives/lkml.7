Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD75CC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3D92173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qnpMTFBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfGQKli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:41:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52105 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfGQKlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:41:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190717104136euoutp02b0e1c8a3eab4583ffdeb3a28436d7906~yK7mQ1wSH2400324003euoutp02U
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:41:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190717104136euoutp02b0e1c8a3eab4583ffdeb3a28436d7906~yK7mQ1wSH2400324003euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563360096;
        bh=ur/U/d/s9uABMg5oCLoBp1Iq4clZ6MAMcHqjH8l6u6s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qnpMTFBHAVao6jDySlOJVnFWhaXTGAEV+OLXyzQ8mOXQ9YHa5IWkmLAuQPYGuNBkg
         Rwi1CnCjIjwAqk4jbU23O2C86q0YQIWdk1z9Y9oyZ+7ELadGiBus6KChN5+PTfwZ0e
         fNkH+eKntukB5pSXs7lyR4g6VPMgFEIR3uiwOGwk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190717104135eucas1p297d04249c9be595e1401ad7fa74cb6b3~yK7lQSJUE0829608296eucas1p2N;
        Wed, 17 Jul 2019 10:41:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AA.4D.04298.F5BFE2D5; Wed, 17
        Jul 2019 11:41:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190717104134eucas1p2a35d37e96f71333e4be84bf4d5029aba~yK7kVMZ-P0935709357eucas1p22;
        Wed, 17 Jul 2019 10:41:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190717104134eusmtrp109bcda1aa5e79d9e3e8b5a2ff38b64d8~yK7kG9JHQ0641306413eusmtrp1O;
        Wed, 17 Jul 2019 10:41:34 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-20-5d2efb5f215f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 00.6D.04146.E5BFE2D5; Wed, 17
        Jul 2019 11:41:34 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190717104133eusmtip1ad16838f92af42c0f3768a6473d18284~yK7jUx3Q72450824508eusmtip1Y;
        Wed, 17 Jul 2019 10:41:33 +0000 (GMT)
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
Message-ID: <4d91a2fd-b6cf-37cc-d453-eb147ea6a1da@partner.samsung.com>
Date:   Wed, 17 Jul 2019 12:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdMUV6JP0R4kj=cFKd7QUdrtMXtSm4S9pfF77zvKu4v1g@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djP87rxv/ViDY68FLS4te4cq8XGGetZ
        La5/ec5qMf8IkNv/+DWzxfnzG9gtzja9YbfY9Pgaq8XHnnusFpd3zWGzmHF+H5PF2iN32S2W
        Xr/IZHHxlKvF7cYVbBate4+wWxx+085q8e/aRhYHIY8189Ywery/0crusWlVJ5vH5iX1Hn1b
        VjF6fN4kF8AWxWWTkpqTWZZapG+XwJVx8MFJloLDnBVXV61hbWDcxd7FyMkhIWAi8fZPNwuI
        LSSwglHi1UqmLkYuIPsLo8SMs1PZIJzPjBKf5y1hgum43HSXFaJjOaPEriYpiKK3jBKH3t0E
        GyssECoxYVYPmC0ioClx/e93VpAiZoGrLBI/7n8H2sfBwSagJ7FjVSFIDa+Am0TjpEawM1gE
        VCWmXd8EtkxUIELi8pZdjBA1ghInZz4Bq+EUCJTYfnsWWJxZQFzi1pP5TBC2vMT2t3OYIQ7t
        5JBo310OYbtIfOqYBfWAsMSr41ug3peROD25hwXCLpZo6F3ICGHXSDzunwtVYy1x+PhFVpCT
        mYF+Wb9LHyLsKPH98F92kLCEAJ/EjbeCEBfwSUzaNp0ZIswr0dEmBFGtIbGl5wLUAWISy9dM
        Y5/AqDQLyV+zkPwyC8kvsxD2LmBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGY8E7/
        O/5pB+PXS0mHGAU4GJV4eD0O68YKsSaWFVfmHmKU4GBWEuG1/aodK8SbklhZlVqUH19UmpNa
        fIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoHRk8s09Yo1T4vQebYf7TXXNtZZ3Xsj
        nr54nsyy6h3uNjb91RrP9Pk2bZrDnLWgyefUTNE9jTyFC93OzuxnMTr+xsHt58GFJspSve97
        lket73mxZup+5S9aPBcFZswqd4y6Ja/Z4Hoydh5vdO7OWWIRu2fm/3i/oZIrIU6zOLLvYaLJ
        Sv4fYqxKLMUZiYZazEXFiQDN73wsdAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xu7pxv/ViDZ4s5Le4te4cq8XGGetZ
        La5/ec5qMf8IkNv/+DWzxfnzG9gtzja9YbfY9Pgaq8XHnnusFpd3zWGzmHF+H5PF2iN32S2W
        Xr/IZHHxlKvF7cYVbBate4+wWxx+085q8e/aRhYHIY8189Ywery/0crusWlVJ5vH5iX1Hn1b
        VjF6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZa
        pG+XoJdx8MFJloLDnBVXV61hbWDcxd7FyMkhIWAicbnpLiuILSSwlFFi/6IsiLiYxKR926Fq
        hCX+XOtig6h5zSgxo80JxBYWCJWYMKsHrEZEQFPi+t/vQHO4OJgFrrJITHm1kR3EERKYzCwx
        +8oC5i5GDg42AT2JHasKQRp4BdwkGic1soDYLAKqEtOub2ICsUUFIiT62mazQdQISpyc+QSs
        hlMgUGL77VmMIDazgJnEvM0PmSFscYlbT+YzQdjyEtvfzmGewCg0C0n7LCQts5C0zELSsoCR
        ZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgnG879nPzDsZLG4MPMQpwMCrx8Hoc1o0VYk0s
        K67MPcQowcGsJMJr+1U7Vog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgSkoryTe0NTQ3MLS
        0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo8dqjkeJkYbLlxnLFn92XsTvz1u7
        +myzgbfS6dkrr4nt7099dq+udud79YduFnea5sS264uJ7l68zIPtgNgDc8YyUd1GewkBl5/L
        HpuqRXPPjgxN4TL9o6Q9+9nFR1uMuP6V59RGm/qpmM2I9fd7Zj7rmJnvDe80cfY/+418/ZZd
        i5hxVadKiaU4I9FQi7moOBEAzmjlkQkDAAA=
X-CMS-MailID: 20190717104134eucas1p2a35d37e96f71333e4be84bf4d5029aba
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
        <8ed83c77-57f7-78a4-e437-714cfc7b5c58@partner.samsung.com>
        <CAJKOXPdMUV6JP0R4kj=cFKd7QUdrtMXtSm4S9pfF77zvKu4v1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/19 12:38 PM, Krzysztof Kozlowski wrote:
> On Wed, 17 Jul 2019 at 12:27, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>>
>> On 7/17/19 12:10 PM, Krzysztof Kozlowski wrote:
>>> On Mon, 15 Jul 2019 at 14:44, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>>>
>>>> The NOC100 has a parent which clock rate is set tot 400MHz. The OPPs which
>>>> are not possible to set are removed and new one is added.
>>>
>>> I think it is just NOC bus... or are there more of such and this is 100 MHz one?
>> Yes, there is a bus NOC100 with a dedicated clock tree in the HW (with
>> 3 muxes and one divider), which makes possible to take different PLL as
>> a source then WCORE have, divide the rate from it and even switch for a
>> while to alternative stable PLL (on the 2nd mux to SPLL (after a
>> divider)) to wait for main PLL rate change stability delay. Max rate is
>> limited to 100MHz for this NOC100 bus.
> 
> I think we misunderstood each other. I am saying, that the bus is
> called "NOC" in the DTSI. Not NOC100. So unless there are more of
> NOCs, stick to existing name NOC, even if it is not the most accurate.
OK, got it, thanks!

Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
