Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6ADC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D832D21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ib6/tWOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfGVQux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:50:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54199 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbfGVQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:50:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190722165051euoutp01ebe91ca898367fa780b785d7cab4e727~zyMa8q4PG2794127941euoutp01S
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 16:50:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190722165051euoutp01ebe91ca898367fa780b785d7cab4e727~zyMa8q4PG2794127941euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563814251;
        bh=n2mOzIcROGQy02ewBXU5/Hf7nnCKgG6HQu/sJ+KOwOk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ib6/tWOhyDryjfUapfP2lOnU+n0R9azWp78sAGBB/p/O05B+Z+T2mV4+1oe/drLMD
         k70fSTL7Ei1X7Fa7TJ8UknaXUGKM3s4/lyYxPvqV4XXoPVo099xfXpnHMRHeIjdgVO
         QDpbtX2sp8NVnedqal7qdnKLIn+32AOr3yh1W2bk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190722165050eucas1p20c1ea3a3e707578c73c6ef8b92a76b1f~zyMaElXnu2485924859eucas1p2q;
        Mon, 22 Jul 2019 16:50:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 13.D5.04325.A69E53D5; Mon, 22
        Jul 2019 17:50:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190722165049eucas1p181bef94142ac67f7059255e80e1b67cf~zyMY43jc00735607356eucas1p1T;
        Mon, 22 Jul 2019 16:50:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190722165049eusmtrp2d931cc688786c0396312329269e56815~zyMYqzfQz2696726967eusmtrp2W;
        Mon, 22 Jul 2019 16:50:49 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-dd-5d35e96a4a23
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.16.04146.869E53D5; Mon, 22
        Jul 2019 17:50:49 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722165048eusmtip2dad28cf64a36365f4c9b82e7663951ce~zyMYWxQQP1205312053eusmtip2e;
        Mon, 22 Jul 2019 16:50:48 +0000 (GMT)
Subject: Re: [PATCH] phy: core: document calibrate() method
To:     Kishon Vijay Abraham I <kishon@ti.com>, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <6729fb28-29ef-a808-64b5-3eaaf7ac31e5@samsung.com>
Date:   Mon, 22 Jul 2019 18:50:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6345ff36-9ee3-fe41-e416-a1178087b2c7@ti.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7pZL01jDb7OE7DYOGM9q8WFpz1s
        Fpd3zWGzmHF+H5PFomWtzA6sHn1bVjF6HL+xncnj8ya5AOYoLpuU1JzMstQifbsEroze+wvY
        C/YIVBx8/ZSxgXEpbxcjJ4eEgInE//ZNjF2MXBxCAisYJV72r2OCcL4wSpy+c5EFwvnMKPG1
        YxYjTMuSy3+hEssZJdbO+A3V/5ZR4tTf02wgVcIC1hK7DjwGs0UEsiRuXfsO1s0sECHR3baH
        CcRmEzCU6HrbBVbDK2AnseL1Y7AaFgFViVltO9lBbFGBGImdb3qYIWoEJU7OfMICYnMKWEkc
        WNzOAjFTXmL72znMELa4xK0n88F+kBDoZ5f4tKKJDeJsF4mf62exQNjCEq+Ob2GHsGUk/u+E
        aWhmlHh4bi07hNPDKHG5aQbU09YSh49fZO1i5ABaoSmxfpc+RNhRYvvENhaQsIQAn8SNt4IQ
        R/BJTNo2nRkizCvR0SYEUa0mMev4Ori1By9cYp7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpa
        nJueWmycl1quV5yYW1yal66XnJ+7iRGYXk7/O/51B+O+P0mHGAU4GJV4eDfsMY0VYk0sK67M
        PcQowcGsJMKbZwAU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUIJsvE
        wSnVwHjg7c5ztp/mrma5p7e8J1dfav75Ngn1875pl8P1Lwpqa704d2BbWWgOS+V3ZWN7tZ28
        obLZ2twvZs3+9/HLu7D8Jcfarml/q/955vySL8e/6T7d+r3gQkzBq29TLl38fCJ9rrff4S3m
        Kx/OPloaP+cb61L+TXPv1Xc75iX8jBENLgtLlFPx+b5aiaU4I9FQi7moOBEABjL6RisDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7qZL01jDdZcYrTYOGM9q8WFpz1s
        Fpd3zWGzmHF+H5PFomWtzA6sHn1bVjF6HL+xncnj8ya5AOYoPZui/NKSVIWM/OISW6VoQwsj
        PUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYze+wvYC/YIVBx8/ZSxgXEpbxcjJ4eE
        gInEkst/WboYuTiEBJYySmy/eoMdIiEjcXJaAyuELSzx51oXG0TRa0aJpeensYEkhAWsJXYd
        eAxmiwhkSfy/8ZMZxGYWiJDonP6DGaJhGZPExx+9YAk2AUOJrrddYA28AnYSK14/ZgSxWQRU
        JWa17QTbLCoQI7HvzHZ2iBpBiZMzn7CA2JwCVhIHFrezQCwwk5i3+SHUMnmJ7W/nQNniEree
        zGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgPG079nPz
        DsZLG4MPMQpwMCrx8G7YYxorxJpYVlyZe4hRgoNZSYQ3zwAoxJuSWFmVWpQfX1Sak1p8iNEU
        6LmJzFKiyfnAWM8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cAo
        qyv8YiFTw1eFKzc8HjGIPbY9d/nL7Iz+PcwL7uaeqSr4dW1hXVt8wuPeGYKaCyvWfX+TJ76O
        Rb5B+MiRxs3yZiyC2asdWdcJRJwo9vbVrjyYwpFgt7Gt74L+Q63p8kcUGraYfdCI1+VZFfA9
        5KM5y63O+icTF928Fc3sOuWa57b9TO3mGW1KLMUZiYZazEXFiQCfogwCvQIAAA==
X-CMS-MailID: 20190722165049eucas1p181bef94142ac67f7059255e80e1b67cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485
References: <CGME20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485@eucas1p2.samsung.com>
        <20190719095245.17401-1-m.szyprowski@samsung.com>
        <085b8093-d7bc-d960-f0d8-8776818ebab0@ti.com>
        <1865da50-000f-e235-4090-1058d2aa217b@samsung.com>
        <6345ff36-9ee3-fe41-e416-a1178087b2c7@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 2019-07-19 14:25, Kishon Vijay Abraham I wrote:
> On 19/07/19 5:51 PM, Marek Szyprowski wrote:
>> On 2019-07-19 12:04, Kishon Vijay Abraham I wrote:
>>> On 19/07/19 3:22 PM, Marek Szyprowski wrote:
>>>> Commit 36914111e682 ("drivers: phy: add calibrate method") added support
>>>> for generic phy_calibrate() method, but it didn't explain in detail when
>>>> such method is supposed to be called. Add some more documentation directly
>>>> to the phy.h to make it clean that it is intended to be called after every
>>>> host controller reset.
>>>>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>>    include/linux/phy/phy.h | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>>>> index 15032f145063..46775e8b0ed9 100644
>>>> --- a/include/linux/phy/phy.h
>>>> +++ b/include/linux/phy/phy.h
>>>> @@ -101,6 +101,18 @@ struct phy_ops {
>>>>    	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
>>>>    			    union phy_configure_opts *opts);
>>>>    	int	(*reset)(struct phy *phy);
>>>> +
>>>> +	/**
>>>> +	 * @calibrate:
>>>> +	 *
>>>> +	 * Optional.
>>>> +	 *
>>>> +	 * Used to calibrate phy, typically by adjusting some parameters
>>>> +	 * in runtime, which are otherwise lost after host controller
>>>> +	 * reset and cannot be set in phy_init() and phy_power_on().
>>>> +	 *
>>>> +	 * Returns: 0 if successful, an negative error code otherwise
>>>> +	 */
>>>>    	int	(*calibrate)(struct phy *phy);
>>> This should be added in drivers/phy/phy-core.c before phy_calibrate()?
>> Okay. Do you want to keep it also in phy.h (like for validate and
>> configure)?
> No. Adding in phy.txt and before phy_calibrate() should suffice IMO.

OKay, I will move it to phy.c. Generic PHYs documentation is converted 
to RST (Documentation/driver-api/phy/phy.rst), so it could simply 
include those comments from .c file. This can be done in separate patch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

