Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD723C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09372084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U+xNfmPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDIQG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:06:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34593 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbfDIQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:06:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190409160611euoutp026dfb92b282ee58854070a02fe1fd2223~T2fvPUXsk2815228152euoutp02Y
        for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2019 16:06:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190409160611euoutp026dfb92b282ee58854070a02fe1fd2223~T2fvPUXsk2815228152euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554825971;
        bh=uu6ne7RtoX5QG+Dzo0JC6OittQTw6i2wQvnqHPR/LiU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=U+xNfmPxi7YXsYhN5RdHnIgJkXONcE85KaYIoCir4YIkQrYmpdety7x+rywplkYQL
         8UxJqAZWDpH5SitN2PGio4CI+GNQ4pkQ9sAeR1d4G1J7fNxe7Wu8VPf6opQMWFPOt3
         4Vtnaj7kdgWWfMkhWbqMBaldjPL9F2YGz1oW7Y58=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190409160610eucas1p190c484414e0dd3324d753979c1562a98~T2ft40guz0136801368eucas1p1D;
        Tue,  9 Apr 2019 16:06:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6E.39.04298.2F2CCAC5; Tue,  9
        Apr 2019 17:06:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190409160609eucas1p25a095acfb1c324c219609fca5a4308a5~T2ftJt4gv1503115031eucas1p2y;
        Tue,  9 Apr 2019 16:06:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190409160609eusmtrp2c556104f5e1be9846b24f36abcd10a00~T2fs7pwoX1119511195eusmtrp2W;
        Tue,  9 Apr 2019 16:06:09 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-37-5cacc2f236f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.06.04140.1F2CCAC5; Tue,  9
        Apr 2019 17:06:09 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190409160608eusmtip2f6db75efaabaa71594877a64627ba8c0~T2fshH27k3080630806eusmtip2p;
        Tue,  9 Apr 2019 16:06:08 +0000 (GMT)
Subject: Re: [PATCH 1/2] ARM: dts: exynos: Use stdout-path property instead
 of console in bootargs
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, notify@kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <8266444a-007b-9fb7-b726-e7599f965a92@samsung.com>
Date:   Tue, 9 Apr 2019 18:06:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408051926.462-1-krzk@kernel.org>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7qfDq2JMWhezm2xccZ6Vov5R86x
        WvQ/fs1scf78BnaLTY+vsVpc3jWHzWLG+X1MFmuP3GW3uPL4H6tF+9OXzA5cHptWdbJ5bF5S
        79G3ZRWjx+dNcgEsUVw2Kak5mWWpRfp2CVwZ7U9eMxUcZarY+j6igXESUxcjJ4eEgInEsc+v
        2UFsIYEVjBJNV8O7GLmA7C+MEkenTGaFcD4zSiw928jSxcgB1rGlKRgivpxR4tG5e0wQzltG
        iY41pxlBRgkLpEjs3L6BHSQhInCeUWL9n1WMIA4zSMv5vtcsIFVsAoYSvUf7wDp4Bewk2i7d
        BzuKRUBFomnzCzYQW1QgQuL+sQ2sEDWCEidnPgHr5RQwljhwaQeYzSwgLtH0ZSUrhC0vsf3t
        HGaQZRICh9glJq++zQLxqYvE16XPGSFsYYlXx7ewQ9gyEv93zmeCaGhmlOjZfZsdwpnAKHH/
        +AKoDmuJw8cvsoJCgFlAU2L9Ln2IsKNE/6srbJCA4ZO48VYQ4gg+iUnbpjNDhHklOtqEIKpV
        JH6vmg4NeCmJ7if/WSYwKs1C8tosJO/MQvLOLIS9CxhZVjGKp5YW56anFhvmpZbrFSfmFpfm
        pesl5+duYgSmpdP/jn/awfj1UtIhRgEORiUe3oh5a2KEWBPLiitzDzFKcDArifByxgOFeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MC6ek3MqzFBFTeU5
        +7UivVvhHUwxHzfO2rZGa9Eur3MsRpE6/1xPVgld19jWOSNdM22zZvn58PPOXVKmRs6nOZ68
        Zb0t4KNlm9DBvDL8bvnylqU8ypdt8hilPPRmv7U3eReg/PK4eEKVOb/g8hMPdKek7L7ieG49
        l2bG38NSv6+5vExv2i86X4mlOCPRUIu5qDgRAAAhuGxHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7ofD62JMfh9UNJi44z1rBbzj5xj
        teh//JrZ4vz5DewWmx5fY7W4vGsOm8WM8/uYLNYeuctuceXxP1aL9qcvmR24PDat6mTz2Lyk
        3qNvyypGj8+b5AJYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
        MstSi/TtEvQy2p+8Zio4ylSx9X1EA+Mkpi5GDg4JAROJLU3BXYxcHEICSxkldp84BhWXkpjf
        otTFyAlkCkv8udbFBlHzmlFiwoSNLCAJYYEUib6jLxhBEiIC5xklTu1cygriMAssZ5SYu3QW
        E0iVkICRRNuRfcwgNpuAoUTv0T5GEJtXwE6i7dJ9sBoWARWJps0v2EBsUYEIiTPvV7BA1AhK
        nJz5BMzmFDCWOHBpB5jNLKAu8WfeJWYIW1yi6ctKVghbXmL72znMExiFZiFpn4WkZRaSlllI
        WhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjMJtx35u2cHY9S74EKMAB6MSD2/A9DUx
        QqyJZcWVuYcYJTiYlUR4OeOBQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTBB5JfGGpobm
        FpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4pRoYzRM8nY7Z769/do/366eCTQLZ
        jderbGP7J+T1608331zmtvX5bCZnLq5Ts3M90lLP1T3dl1n5dJ/gjNRzvsGqah6dv4UyXsgt
        evjiYLq17qt5x9dv/601n90iIe/b5Syun6faVicvTN2p+jMpsy5KKFl4XuLPxNUOYaWl9hf1
        jm5W15jixNmhxFKckWioxVxUnAgAdcDcr9gCAAA=
X-CMS-MailID: 20190409160609eucas1p25a095acfb1c324c219609fca5a4308a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190409160609eucas1p25a095acfb1c324c219609fca5a4308a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190409160609eucas1p25a095acfb1c324c219609fca5a4308a5
References: <20190408051926.462-1-krzk@kernel.org>
        <CGME20190409160609eucas1p25a095acfb1c324c219609fca5a4308a5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 07:19, Krzysztof Kozlowski wrote:
> Replacing bootargs with stdout-path property in chosen node allows using
> early console by adding just 'earlycon' parameter to the kernel command
> line.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
