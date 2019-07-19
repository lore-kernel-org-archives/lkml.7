Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4239C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B112173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ssvriqIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfGSMVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:21:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45818 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfGSMVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:21:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190719122103euoutp02a1d68aef5a49dfe9a4b61addbe5369a5~yzlALAQOd2314923149euoutp02o
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 12:21:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190719122103euoutp02a1d68aef5a49dfe9a4b61addbe5369a5~yzlALAQOd2314923149euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563538863;
        bh=AkuwhZsflWxMXUSYgKx6guf5e1rL6IupidnXfiBZd8s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ssvriqIpsLeB+ToRpRalsCZAaR75IjkgxeynIhQvAen7qw8Fu7QJ7vJnUfCF4YWRl
         hc0enUQzsMff5XgMGYhHW/d23EmtlYNJAkEIZ2gq5i8jlBw2ZpsoXPl/PbYRAR8gQG
         fakjfJ1UBZYob9Z6wiAm4pGL5Ue2rJ7MGCITwhW8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190719122103eucas1p14d41939bf6a118ab6e0eea9afef0323c~yzk-1OhZI2099320993eucas1p1e;
        Fri, 19 Jul 2019 12:21:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4D.30.04325.FA5B13D5; Fri, 19
        Jul 2019 13:21:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719122102eucas1p1a23e35476bd6203cc11bc503b6cd30ee~yzk-GNFF02097120971eucas1p1P;
        Fri, 19 Jul 2019 12:21:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719122102eusmtrp2d36b25121083461a91d10adf3e5f1ac3~yzk_3CbsC2520025200eusmtrp23;
        Fri, 19 Jul 2019 12:21:02 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-84-5d31b5af1b68
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E0.C4.04140.DA5B13D5; Fri, 19
        Jul 2019 13:21:01 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719122101eusmtip1f1aca9fb75903b6d1bf116560b8e4579~yzk_JRCQV2514225142eusmtip1K;
        Fri, 19 Jul 2019 12:21:01 +0000 (GMT)
Subject: Re: [PATCH] phy: core: document calibrate() method
To:     Kishon Vijay Abraham I <kishon@ti.com>, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1865da50-000f-e235-4090-1058d2aa217b@samsung.com>
Date:   Fri, 19 Jul 2019 14:21:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <085b8093-d7bc-d960-f0d8-8776818ebab0@ti.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87rrtxrGGnxq4LHYOGM9q8WFpz1s
        Fpd3zWGzmHF+H5PFomWtzA6sHn1bVjF6HL+xncnj8ya5AOYoLpuU1JzMstQifbsEroxbzbEF
        V3krnu+ezNLA+J6ri5GTQ0LARGLG3z9sILaQwApGibuziroYuYDsL4wSjTf+skA4nxklmnec
        YIfpeLvhDCNEYjmjxLb1u5ggnLeMEpte/mEFqRIWsJbYdeAx2FwRgSyJW9e+M4LYzAIREt1t
        e5hAbDYBQ4mut11gNbwCdhLNP5exgNgsAqoSX9/fAqsXFYiR2PmmhxmiRlDi5MwnYDWcAlYS
        01dMYoKYKS+x/e0cZghbXOLWk/lgB0kI9LNL7HxwmRnibBeJJVeuskDYwhKvjm+BekdG4v9O
        mIZmRomH59ayQzg9jBKXm2YwQlRZSxw+fhHoNQ6gFZoS63fpQ4QdJbZPbGMBCUsI8EnceCsI
        cQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkLw2C8k7s5C8Mwth7wJGllWM4qml
        xbnpqcXGeanlesWJucWleel6yfm5mxiBqeX0v+NfdzDu+5N0iFGAg1GJhzcg1yBWiDWxrLgy
        9xCjBAezkgjv7Zf6sUK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphakFsFk
        mTg4pRoYLTQ73R9/udsdtV5nzgUd7amRRklMj9796bH4pBnEv88pS1ptrrIQ79RXqUeWJc0z
        aFjY4Lys/RWTr86nTQV7t1w3rEwWMJuQNTdjy5RXNU/WytbxmrX/2SyxzuncTEHfd37+1zge
        mB+1+7BxS7Pk6ZoT19Nea50p453yM3DLnJqSThnpOKnTSizFGYmGWsxFxYkAYN8XLSkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xu7rrthrGGmyYLWGxccZ6VosLT3vY
        LC7vmsNmMeP8PiaLRctamR1YPfq2rGL0OH5jO5PH501yAcxRejZF+aUlqQoZ+cUltkrRhhZG
        eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehm3mmMLrvJWPN89maWB8T1XFyMnh4SA
        icTbDWcYuxi5OIQEljJKXDp7lhkiISNxcloDK4QtLPHnWhcbRNFrRonH8/YzgSSEBawldh14
        zAZiiwhkSfy/8ROsmVkgQqJz+g9miIaDjBJnzraCTWITMJToetsF1sArYCfR/HMZC4jNIqAq
        8fX9LUYQW1QgRmLfme3sEDWCEidnPgGr4RSwkpi+YhITxAIziXmbH0Itk5fY/nYOlC0ucevJ
        fKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG07ZjP7fs
        YOx6F3yIUYCDUYmHNyDXIFaINbGsuDL3EKMEB7OSCO/tl/qxQrwpiZVVqUX58UWlOanFhxhN
        gZ6byCwlmpwPjPS8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M
        iZtNRDZIt855smtvj+784p5c6fKTyWXlHurTFQ85yWx7auWsdS0ruuLk+hPlRf4u65/Esz8w
        PX4p5LnldPulizyUXRtMrymyxPvcmK+5e27OxiQ1A5PvbxdPe5MeJv/hTtZvhzmHFU6dW9VZ
        cI6tJ1vC6dZp27KsluCdxQuD758VqwzJPHxKiaU4I9FQi7moOBEALP9t17wCAAA=
X-CMS-MailID: 20190719122102eucas1p1a23e35476bd6203cc11bc503b6cd30ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485
References: <CGME20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485@eucas1p2.samsung.com>
        <20190719095245.17401-1-m.szyprowski@samsung.com>
        <085b8093-d7bc-d960-f0d8-8776818ebab0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 2019-07-19 12:04, Kishon Vijay Abraham I wrote:
> Hi Marek,
>
> On 19/07/19 3:22 PM, Marek Szyprowski wrote:
>> Commit 36914111e682 ("drivers: phy: add calibrate method") added support
>> for generic phy_calibrate() method, but it didn't explain in detail when
>> such method is supposed to be called. Add some more documentation directly
>> to the phy.h to make it clean that it is intended to be called after every
>> host controller reset.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   include/linux/phy/phy.h | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> index 15032f145063..46775e8b0ed9 100644
>> --- a/include/linux/phy/phy.h
>> +++ b/include/linux/phy/phy.h
>> @@ -101,6 +101,18 @@ struct phy_ops {
>>   	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
>>   			    union phy_configure_opts *opts);
>>   	int	(*reset)(struct phy *phy);
>> +
>> +	/**
>> +	 * @calibrate:
>> +	 *
>> +	 * Optional.
>> +	 *
>> +	 * Used to calibrate phy, typically by adjusting some parameters
>> +	 * in runtime, which are otherwise lost after host controller
>> +	 * reset and cannot be set in phy_init() and phy_power_on().
>> +	 *
>> +	 * Returns: 0 if successful, an negative error code otherwise
>> +	 */
>>   	int	(*calibrate)(struct phy *phy);
> This should be added in drivers/phy/phy-core.c before phy_calibrate()?

Okay. Do you want to keep it also in phy.h (like for validate and 
configure)?


> We could
> add a separate section in Documentation/phy.txt to document these phy_ops.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

