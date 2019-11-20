Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52449C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5222251E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c42UZB7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfKTOBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:01:36 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38872 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfKTOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:01:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191120140134euoutp01c9312870d18cfa694b7f0a653f85737a~Y48Jz4F7z0860808608euoutp01o
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 14:01:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191120140134euoutp01c9312870d18cfa694b7f0a653f85737a~Y48Jz4F7z0860808608euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574258494;
        bh=YoxJZPhSqKCy/ocofK80QmJ9H9riVpzQRCC94UudwZE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=c42UZB7d66hIuXBLEYhqKGIi5NEc7KTf9yuRCF+t5uXPkUjuCleQU7NfA8bcbB4PX
         H81ATbpCirfuct8aSqnsGef92UDtomJOSTJzuyLPAmYZ+Fzeol0sT+S9TcykHBNv1I
         /9lp/56onNOpnwIPA3sgEYO4nYPuchKraXdgvvi4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191120140133eucas1p2d776e707b67e02dc328923b7d628ca50~Y48JX6M5Q1046910469eucas1p2a;
        Wed, 20 Nov 2019 14:01:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2E.82.04374.D3745DD5; Wed, 20
        Nov 2019 14:01:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191120140133eucas1p253d10e944e04031d8e1a52fb42dd114a~Y48JBrOOC1428614286eucas1p21;
        Wed, 20 Nov 2019 14:01:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191120140133eusmtrp191cdd362b4ccee19339c01f9523cabe2~Y48JA8Ykw1670816708eusmtrp1M;
        Wed, 20 Nov 2019 14:01:33 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-11-5dd5473d36a5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9E.FB.04166.D3745DD5; Wed, 20
        Nov 2019 14:01:33 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191120140132eusmtip1acdb2d3f9957242710494d1770d0dcf8~Y48Il3ISp0041700417eusmtip11;
        Wed, 20 Nov 2019 14:01:32 +0000 (GMT)
Subject: Re: [PATCH] video: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <836ebffa-3074-7c98-c8f1-43227eacdaa1@samsung.com>
Date:   Wed, 20 Nov 2019 15:01:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191120135012.GA17348@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7q27ldjDf5clbc48+Yuu8WVr+/Z
        LFZ8mclucf78BnaL+1+PMlqc6PvAanF51xw2i/f7LzM5cHjsnHWX3WPTqk42jzvX9rB53O8+
        zuTxeZNcAGsUl01Kak5mWWqRvl0CV8a1pm7WguccFa9b9zA3MHazdzFyckgImEg0XPzM0sXI
        xSEksIJR4sGydcwQzhdGiW+X+1ghnM+MEpvaelhgWlZf+MAEkVjOKHFz8w8o5y2jxMWt/xlB
        qoQFjCXO9K0F6xARqJZo+fmGEaSIGaRj4saprCAJNgEriYntq4ASHBy8AnYSs3c6g4RZBFQl
        Nqw4wgxiiwpESHx6cBisnFdAUOLkzCdgMzkF9CUWnZkKZjMLiEvcejKfCcKWl9j+dg7YDxIC
        h9glTlw/DvWpi8TjzW+YIWxhiVfHt0DFZSROT+5hgWhYxyjxt+MFVPd2Ronlk/+xQVRZSxw+
        fpEV5FJmAU2J9bv0IcKOEt/v97KDhCUE+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDB
        rO3auZJ5AqPSLCSvzULyziwk78xC2LuAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZG
        YEI6/e/41x2M+/4kHWIU4GBU4uEVULsaK8SaWFZcmXuIUYKDWUmEd8/1K7FCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGMX//1G7xNFy8PfHCykasz0k
        je4lcjpxzHw4sdbqgcb7ha+rbqTrL62cZnsn8M33N1YfjSRFJr7UEi2ddyHzz7rF4ttu1oTa
        Lz555N2TJe+dHfxmPGN+N//SsoATKr2pWdMWXbl1Ibp23m8V5cJbLgYLula4TxPhPv219NNu
        Zf+27JmGHPtqBM2VWIozEg21mIuKEwEF/TBlRAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7q27ldjDbas4rY48+Yuu8WVr+/Z
        LFZ8mclucf78BnaL+1+PMlqc6PvAanF51xw2i/f7LzM5cHjsnHWX3WPTqk42jzvX9rB53O8+
        zuTxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqR
        vl2CXsa1pm7WguccFa9b9zA3MHazdzFyckgImEisvvCBqYuRi0NIYCmjxPWnM1m6GDmAEjIS
        x9eXQdQIS/y51sUGUfOaUWLzn71sIAlhAWOJM31rWUBsEYFaic5JX1hAipgFljNKXP43mx2i
        4wyjRPuEfrAqNgEriYntqxhBNvAK2EnM3ukMEmYRUJXYsOIIM4gtKhAhcXjHLEYQm1dAUOLk
        zCdgrZwC+hKLzkwFs5kF1CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERqFZSNpnIWmZhaRlFpKW
        BYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjb9uxn5t3MF7aGHyIUYCDUYmHV0DtaqwQ
        a2JZcWXuIUYJDmYlEd4916/ECvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MDXklcQbmhqa
        W1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgVL2T8NZ0+kHZ2UeUFl3qun/0
        cv+L7bNYl+Wm3q8vf3VvlvS/3XNV58XsZl/Wc8ZzyVWbwOdmKcF3BIps3lRyXjvHLX3ggXRX
        g0riFqtm7VSm2Ydrcoz37ZXn8Vpnp7ApwPpMSbKutuWSNuPIrCN7FkUGrhHffnvPt5j8CI1j
        P97XLg8+l7MrQomlOCPRUIu5qDgRADeAJjXVAgAA
X-CMS-MailID: 20191120140133eucas1p253d10e944e04031d8e1a52fb42dd114a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191120135021eucas1p206063d872dc96d25d0f10fc99ab41124
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191120135021eucas1p206063d872dc96d25d0f10fc99ab41124
References: <20191120133838.13132-1-krzk@kernel.org>
        <20191120134546.GA2654@pine>
        <CGME20191120135021eucas1p206063d872dc96d25d0f10fc99ab41124@eucas1p2.samsung.com>
        <20191120135012.GA17348@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ added Jiri to Cc: ]

On 11/20/19 2:50 PM, Krzysztof Kozlowski wrote:
> On Wed, Nov 20, 2019 at 08:45:46AM -0500, Daniel Thompson wrote:
>> On Wed, Nov 20, 2019 at 09:38:38PM +0800, Krzysztof Kozlowski wrote:
>>> Adjust indentation from spaces to tab (+optional two spaces) as in
>>> coding style with command like:
>>> 	$ sed -e 's/^        /\t/' -i */Kconfig
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> No particular objections but I wonder if this would be better sent to
>> trivial@kernel.org .
> 
> Thanks for feedback.
> 
> I sent to trivial and kernel-janitors my previous version of this
> patchset which was not split per-subsystem and there was no feedback.
> Few other patches already came through maintainers. If there will be no
> reply, I'll send next version through trivial.

If anyone wants to merge it through backlight or trivial tree:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Otherwise I'll queue this through drm-misc tree for v5.6.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
