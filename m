Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C86C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB50F20989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kmwjFiFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfEJRWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:22:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55949 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfEJRWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:22:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190510172238euoutp018d763ff8bfb05adb0f6f919c66f1378d~dYiU5bXFY1840718407euoutp01W
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 17:22:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190510172238euoutp018d763ff8bfb05adb0f6f919c66f1378d~dYiU5bXFY1840718407euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557508958;
        bh=6acAZu8dGZA1MIPBWkPAY4AMzfaBXTL9zJwV22dhf8Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kmwjFiFO6E/bT98t7wPgx0DrAHSvets0l0hWKn3cz5/fKKZiC7xzGSFTLAX85gvaC
         U5Jb2ridMvbbMGgYMSvmwolbwFbIcsmpjK2ln5HyOnY4sMReYIbxmhCZizXaBjClxK
         43YtRRjKV6fBbEnv2I7o2JKxoqD0WsVZYys2+zoQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190510172237eucas1p289163bd8bc5396258c2f87c575fee4a8~dYiUEt3N82447524475eucas1p2D;
        Fri, 10 May 2019 17:22:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9F.CB.04298.C53B5DC5; Fri, 10
        May 2019 18:22:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190510172236eucas1p138115389e72802f72e47158df6ed9871~dYiTP6brX0098100981eucas1p1o;
        Fri, 10 May 2019 17:22:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190510172236eusmtrp2027c35dd302262b10122232ea04f2343~dYiTB_iE92211822118eusmtrp28;
        Fri, 10 May 2019 17:22:36 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-85-5cd5b35c5a05
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 37.CA.04140.C53B5DC5; Fri, 10
        May 2019 18:22:36 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190510172235eusmtip11faddbb27905632231565d9ba21940f9~dYiSsoVci0695706957eusmtip1u;
        Fri, 10 May 2019 17:22:35 +0000 (GMT)
Subject: Re: [GIT] IDE
To:     David Miller <davem@davemloft.net>, torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <4b706a9a-5cfd-db15-456b-b06476a7bc31@samsung.com>
Date:   Fri, 10 May 2019 19:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190508.165320.2267661705586017777.davem@davemloft.net>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOd2YzVdjDDruWlvMWb+GzWLO+RYW
        i2M7HjFZXN41h83iUd9bdgdWjy0rbzJ5nJjxm8Xj8ya5AOYoLpuU1JzMstQifbsErowd9/ey
        F1xirrjTcICxgfElUxcjJ4eEgInE1StvGbsYuTiEBFYwSny4fI0ZwvnCKLF83T1WCOczo8Ts
        QyeAWjjAWuZvMYCIL2eUePmnkwnCecso0dO3D2yusICYxLZfbxhBbBEBV4kdsx6AxZkFIiTW
        LNoFZrMJWElMbF8FVsMrYCexpPsEG8gCFgFVietn/UBMUaDy/jPqEBWCEidnPmEBsTkF3CTm
        b7vLDDFRXmL72zlgR0sI/GeTODRnDjPEay4SF9sPskDYwhKvjm9hh7BlJP7vnM8E0bCOUeJv
        xwuo7u1AL0/+xwZRZS1x+PhFVpArmAU0Jdbv0ocIO0q83/iaDRIQfBI33gpCHMEnMWnbdGaI
        MK9ER5sQRLWaxIZlG9hg1nbtXAl1mofEmZ8rWCcwKs5C8tosJO/MQti7gJF5FaN4amlxbnpq
        sWFearlecWJucWleul5yfu4mRmACOf3v+KcdjF8vJR1iFOBgVOLhFUi+GiPEmlhWXJl7iFGC
        g1lJhLdI50qMEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6p
        BsZpnxh1e860KkhI/vKU4D6hLed3qcJRqf6/WVVW+Mw62ZREB/6fE+se9zwK163dWsOVfnRS
        mnlTeuobZw/XVgXdB/bfheRvC+97Jqevc32P96PwaKn5B/69jP++7Mv96R66i16L3Df6dNI+
        ab2u8Y5T3xm/xC8tZ1KUyDs6JXrChB3z7+09tVKJpTgj0VCLuag4EQAtuV7dHAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42I5/e/4Xd2YzVdjDO5OZbGYs34Nm8Wc8y0s
        Fsd2PGKyuLxrDpvFo7637A6sHltW3mTyODHjN4vH501yAcxRejZF+aUlqQoZ+cUltkrRhhZG
        eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehk77u9lL7jEXHGn4QBjA+NLpi5GDg4J
        AROJ+VsMuhi5OIQEljJKzNx3DiouI3F8fVkXIyeQKSzx51oXG0TNa0aJB81zWUESwgJiEtt+
        vWEEsUUEXCV2zHrABGILAdl7Pj0Gs5kFIiRaVi0Gs9kErCQmtq8Cq+cVsJNY0n2CDWQXi4Cq
        xPWzfiBhUaDyWw87WCBKBCVOznwCZnMKuEnM33aXGWKkusSfeZegbHmJ7W/nME9gFJyFpGUW
        krJZSMoWMDKvYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIyLbcd+btnB2PUu+BCjAAejEg+v
        QPLVGCHWxLLiytxDjBIczEoivEU6V2KEeFMSK6tSi/Lji0pzUosPMZoC/TCRWUo0OR8Ys3kl
        8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhhbtzaLcawL9dMzjIvV
        /+eeV/D758eHV9u6DjFEiv0Pv9t8qy30no9i/krvG7H2P+6vuLzpdknRm4Is282Hfux/V3bW
        NJHxRNv++kjr7Y9/9D5srV28dEHSjidMf3Mrdmcmc8cbcQlJ9neJF+YeYyg1/3tFpzIhJYN5
        tfK9pWfMeM+431zZE6jEUpyRaKjFXFScCAAr4T6voQIAAA==
X-CMS-MailID: 20190510172236eucas1p138115389e72802f72e47158df6ed9871
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190510172236eucas1p138115389e72802f72e47158df6ed9871
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190510172236eucas1p138115389e72802f72e47158df6ed9871
References: <20190508.165320.2267661705586017777.davem@davemloft.net>
        <CGME20190510172236eucas1p138115389e72802f72e47158df6ed9871@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/09/2019 01:53 AM, David Miller wrote:
> 
> Finally deprecate the legacy IDE layer.
> 
> Frankly this is long overdue.
> 
> Please pull, thanks a lot!

Thank you for applying this.

I'll continue to assist in moving legacy IDE users to libata
(when time permits).

> Christoph Hellwig (1):
>       ide: officially deprecated the legacy IDE driver

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
