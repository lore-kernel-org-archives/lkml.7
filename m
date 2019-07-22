Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE4C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD372214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R3LqS7NN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfGVKrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:47:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46527 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbfGVKrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:47:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190722104704euoutp017a949aca9582ff5411ae748093dd3fc1~ztOzVK8sV2755327553euoutp01E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:47:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190722104704euoutp017a949aca9582ff5411ae748093dd3fc1~ztOzVK8sV2755327553euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563792424;
        bh=SU/b9A0zsnNhPkaLQo5sGUXkfyHQlTM+GWVxLlhikNU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=R3LqS7NN1841cneVf+Eeq+NokM14T+0kmmzgTnw7z8DurcfRcGDWKcIeN1BLR7Znu
         kF0aYIhxz+zV52YNv8lh373BBDhR3z91B1hJBe6zypoFaRefG5ZiRysJqsW2sXfS2N
         mmfZZ+lCRze3dl1M6FqLb9F18iwGyxmA8w222uMc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190722104703eucas1p1ca3ad44bf079e57560ed4abd64f1a90f~ztOyeqIGz1733317333eucas1p1C;
        Mon, 22 Jul 2019 10:47:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2E.38.04325.724953D5; Mon, 22
        Jul 2019 11:47:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190722104703eucas1p2c5bdf87985b37b8e0ffdb3ffb5aae4de~ztOxtRcAh3223832238eucas1p2s;
        Mon, 22 Jul 2019 10:47:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190722104702eusmtrp20dfdf63b5472e0e4ca7c4ca6353dafc3~ztOxe-CuS2917129171eusmtrp2Y;
        Mon, 22 Jul 2019 10:47:02 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-48-5d3594273b62
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 61.D9.04146.624953D5; Mon, 22
        Jul 2019 11:47:02 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190722104702eusmtip1609c60234108be50719c9071fe202060~ztOwxnrdM1710317103eusmtip1Q;
        Mon, 22 Jul 2019 10:47:02 +0000 (GMT)
Subject: Re: [PATCH v1 21/50] ARM: dts: exynos: add OPP into FSYS APB bus in
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
Message-ID: <7b662b86-f442-3de8-e357-88bf9eaffd5a@partner.samsung.com>
Date:   Mon, 22 Jul 2019 12:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPd0kzwZ9_eCK9r04Qj0Rf5SSSnMmwDj11cZozmu0gqsgw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRzt233s+ljdLdMfFQWDHhY+IoNPiqioGARRUKHJqKUXXc1pu85H
        VpqQqVmaWpnY00yxZbnUTNBiSpJhpuIjc1pNKM1V4soEtbzeSf53zu93ft85Bz6GUAxSSxmt
        PoYz6DU6Je1KVr+aeOuzJm+T2r/o5XrcW/6WwhX5jync7fhC4duNMzTL9o3Ara1PpLglZUSK
        zbYuCo9m9lO4o7aQxvmt9RL8qNEqxcXdbRLc1rwLfzhXSuPzdY1S3DBygcLTXRXkNoXKdMuE
        VD96zktV5rJ0WvX0fpLqcmUZUo2ZV+yjD7tuCeN02ljO4Lf1qGuEKbdZEj0hje+7+pBORsV0
        BnJhgA2AovQWlIFcGQVbiuDFz3JaJA4EKeUlTjKGYKKlk5w7qSp3SMRFCYLpN8NOYkdgdTRL
        BNViNhiyL1qRgD1Yb+ieGqcEEcF2kvBnYHzmKYahWV+oKTspaGTsbjC3WykBk+wqsPfZZ/ES
        Ngg6KmuRqJHD6xuDsylc2P1QPfSZEDDBekHv4G2JiFfCM3shIXgBm85AxdBHJMbeCV8nzc4K
        i2G4qVIq4uXw97l4DCwPyZfuOvWnwZZ106nZDA1NbZSQmZgp87jWTxxvh56Bh7QwBnYh9Njl
        YoSFkFN9nRDHMkhLVYjqtVCZ+c5p5AklpmvSbKQsmFesYF6ZgnllCv773kFkGfLijHxkOMdv
        1HNxvrwmkjfqw31DoyLNaObvvZlu+lWD6iePWRDLIKW7zL86QK2gNLF8QqQFAUMoPWR6/01q
        hSxMk3CKM0QdMRh1HG9ByxhS6SVLXPAxRMGGa2K4ExwXzRnmthLGZWky4ke/f+otytqs2xPs
        OOEdWLiaTv+9IyS+zjQ28mB94klLtA99MHVt62vtWWJRilxttOpIz+fFB0KvRE+3ZCV1B9kc
        yfdj1d+D+q/ZpmT5U0ZLoPu9vXmJ8jP5uavupg1PjYT6nfEI/UGWwCE3v6M9cadyJqveo3a3
        iODj9/bGyLVKko/QbFhHGHjNP53fZkJ3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xu7pqU0xjDT7ONre4te4cq8XGGetZ
        La5/ec5qMf8IkNv/+DWzxfnzG9gtzja9YbfY9Pgaq8XHnnusFpd3zWGzmHF+H5PF2iN32S2W
        Xr/IZHHxlKvF7cYVbBate4+wWxx+085q8e/aRhYHIY8189Ywery/0crusWlVJ5vH5iX1Hn1b
        VjF6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZa
        pG+XoJexZvIppoKf7BV3pq5ma2BcytbFyMkhIWAisXXdF6YuRi4OIYGljBKL51xkhEiISUza
        t50dwhaW+HOtiw2i6DWjxNm2J2AJYYFIiQndd8EaRAQ0Ja7//c4KUsQscJVFYsqrjewQHf1M
        Er2L3gC1c3CwCehJ7FhVCNLAK+AmsenSXVYQm0VAVeLtnbdgtqhAhERf22w2iBpBiZMzn7CA
        2JwCgRLbXj5iBrGZBcwk5m1+CGWLS9x6Mp8JwpaX2P52DvMERqFZSNpnIWmZhaRlFpKWBYws
        qxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJjfduxn5t3MF7aGHyIUYCDUYmH12CbSawQa2JZ
        cWXuIUYJDmYlEd48A9NYId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HpqG8knhDU0NzC0tD
        c2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MotJz7a903I+4yl495wTTKcmiyfUP
        lsxszbxmKRRu/NveKuub/7k1ul/WbFo6p2dx25rDDe713ge987hb5d/oJrNW7/+iZ1Z14EHX
        u32nU456txXdsjHXfFsxyVIm3lTnlG9blIZVse5Gqbr5Iaqcuz/Jit+etoz10qW7u8NOnz/I
        9+DXgc3aSizFGYmGWsxFxYkAD4ZHwgsDAAA=
X-CMS-MailID: 20190722104703eucas1p2c5bdf87985b37b8e0ffdb3ffb5aae4de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124451eucas1p2904b49f59cca0cbbc22381f168affbb5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124451eucas1p2904b49f59cca0cbbc22381f168affbb5
References: <CGME20190715124451eucas1p2904b49f59cca0cbbc22381f168affbb5@eucas1p2.samsung.com>
        <20190715124417.4787-1-l.luba@partner.samsung.com>
        <20190715124417.4787-22-l.luba@partner.samsung.com>
        <CAJKOXPd0kzwZ9_eCK9r04Qj0Rf5SSSnMmwDj11cZozmu0gqsgw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 7/17/19 10:48 AM, Krzysztof Kozlowski wrote:
> On Mon, 15 Jul 2019 at 14:44, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Add an OPP for FSYS APB which reflects the real possible frequency.
>> The bus will have a new parent clock which speed has 600MHz, thus
>> a new possible frequency provided by the clock divider is 150MHz.
>> According to the documentation max possible frequency for this bus is
>> 200MHz.
> 
> Commit msg is good but title could be improved. Focus in the title
> what problem/issue you are solving - add intermediate step in scaling
> of FSYS APB?
The devfreq governor for this bus device follows the set OPP of the
master device - WCORE bus and sets the OPP with corresponding ID.
Thus, jumping to max frequency 200MHz when the WCORE bus and other
devices are operating in the middle of their min-max speed is not
needed for FSYS APB and this patch adds the intermediate speed step.

Regards,
Lukasz

> 
> Best regards,
> Krzysztof
> 
> 
