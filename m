Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7260C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C86A20656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kKkGEuaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfF1KhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:37:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48250 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF1KhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:37:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190628103717euoutp01bcab2b4defa55e4f0347899f764a5470~sVnZjJMOR2952129521euoutp01V
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:37:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190628103717euoutp01bcab2b4defa55e4f0347899f764a5470~sVnZjJMOR2952129521euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561718237;
        bh=A3YT7mvbEnyhF8sgIIDRcFiVnS6/ZYDHzRlh/Z8RroM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kKkGEuaZTZFv0BgUFs68hQa0hEVmA3adhR4b5SyhD2Io/7mSs65KuUjNpycCtR/yU
         D3QlBLm5tO/k/xCH5cukDjJoMDI0GAkPzwx9GOEG7HDgf5XMXv8p3zeZomXVWxaoe6
         JAUxVken/a7q7/Ngq6fx2+KhPp7ULfqUWJqvmMBs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190628103716eucas1p105d9274e0550d634387197accbff735b~sVnZABy371454814548eucas1p1Y;
        Fri, 28 Jun 2019 10:37:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0F.D3.04298.CDDE51D5; Fri, 28
        Jun 2019 11:37:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190628103715eucas1p223f9d5f79bc6276e74f44956a0bc33c8~sVnYRZiwV1524415244eucas1p2r;
        Fri, 28 Jun 2019 10:37:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190628103715eusmtrp156cde791cd047c11e1ae3c3e114e9a80~sVnYDYrej2375123751eusmtrp1k;
        Fri, 28 Jun 2019 10:37:15 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-8c-5d15eddcdc17
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1C.9B.04146.BDDE51D5; Fri, 28
        Jun 2019 11:37:15 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190628103715eusmtip21309facbc69f7ed4970878d77faa6a3e~sVnXtOJax1858318583eusmtip2t;
        Fri, 28 Jun 2019 10:37:15 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: s3c-fb: fix sparse warnings about using
 incorrect types
To:     Jingoo Han <jingoohan1@gmail.com>
Cc:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <0c1c0ba0-a37b-2018-ab0a-ea89b99587d1@samsung.com>
Date:   Fri, 28 Jun 2019 12:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0662D369EFFABF260394F179AAFC0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7p33orGGmxoF7O48vU9m8WKLzPZ
        LU70fWC1uLxrDpsDi8fOWXfZPe53H2fy+LxJLoA5issmJTUnsyy1SN8ugSvj/JVZrAW7WCrW
        7V7N2MB4mbmLkZNDQsBEYt+EpSwgtpDACkaJVUfVuxi5gOwvjBIrlhxkh3A+M0rMXL8TruPi
        r4OMEB3LGSVerrWDsN8ySiw6HAliCwvESJzb/x9sqoiAqkTD+ZOsIIOYBY4zSkx9fhmsmU3A
        SmJi+yowm1fATmLvbgibBaih7cZ2NhBbVCBC4v6xDawQNYISJ2c+ARvKCbTg8MKpYPXMAuIS
        t57MZ4Kw5SW2v53DDLJMQqCfXWL+qzdQV7tIPH3ZxgphC0u8Or6FHcKWkTg9uYcFomEdo8Tf
        jhdQ3dsZJZZP/scGUWUtcfj4RaBuDqAVmhLrd+lDhB0lGueeYwMJSwjwSdx4KwhxBJ/EpG3T
        mSHCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS4tz01GLD
        vNRyveLE3OLSvHS95PzcTYzAhHL63/FPOxi/Xko6xCjAwajEw6uwUyRWiDWxrLgy9xCjBAez
        kgiv5DmgEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBkae
        kOoHN0XlZuoVuj684svI0K5x3yNVYHLh7zp/tqqHi3vvXvjI5sWzxHBTQrspk8ea3TvmLjxg
        KRrN9GDOqrRM9tmMwivr50nu3lTPXjo5bNKvoPoLIqtk9t3T9+K4yuHJrp+UccDi235tE5et
        fx4fuVS981zq0ROM7j2ibaeW8B3yS0hdFa/EUpyRaKjFXFScCADtj2qgJAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7q334rGGkxZrmhx5et7NosVX2ay
        W5zo+8BqcXnXHDYHFo+ds+6ye9zvPs7k8XmTXABzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G+SuzWAt2sVSs272asYHxMnMXIyeHhICJxMVf
        Bxm7GLk4hASWMkrMurWYpYuRAyghI3F8fRlEjbDEn2tdbBA1rxklTlzuZQdJCAvESJzb/58F
        xBYRUJVoOH+SFcQWEnjCKNHa4ArSwCxwnFFiy+V5TCAJNgEriYntqxhBbF4BO4m9uyFsFqDm
        thvb2UBsUYEIiTPvV7BA1AhKnJz5BMzmBFp2eOFUsHpmAXWJP/MuMUPY4hK3nsxngrDlJba/
        ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAGNp27Ofm
        HYyXNgYfYhTgYFTi4VXYKRIrxJpYVlyZe4hRgoNZSYRX8hxQiDclsbIqtSg/vqg0J7X4EKMp
        0HMTmaVEk/OB8Z1XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoEx
        /74Wu9KbI1nXArb8OAaMka2zc/Weqz3NPpgkafVpx7rVIkumhL/Nsz6zrmrihucLp8f652h/
        kDA8bal3Tc3Aec9rAdt3R8+FMmtu8AwWz1i/NrBbhJGn9mLXynfKRjJVzOf0M85E2q8NYQuQ
        7JrnyZLxJfzElzVXtn7+tifvwLUN17331t9VYinOSDTUYi4qTgQAULLzzbcCAAA=
X-CMS-MailID: 20190628103715eucas1p223f9d5f79bc6276e74f44956a0bc33c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5
References: <CGME20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5@eucas1p1.samsung.com>
        <908fc26e-3bfa-c204-6c32-7d814fdcb37b@samsung.com>
        <PSXP216MB0662D369EFFABF260394F179AAFC0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/28/19 7:50 AM, Jingoo Han wrote:
> On 6/27/19, 9:58 PM, Bartlomiej Zolnierkiewicz wrote:
>>
>> Use ->screen_buffer instead of ->screen_base to fix sparse warnings.
>>
>> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>>   pointer") for details. ]
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Thanks, I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
