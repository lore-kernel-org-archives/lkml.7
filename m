Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D63DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C132084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F0ZoIxdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDIQJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:09:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35401 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDIQJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:09:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190409160932euoutp02aafffffa2d03d26f0a0bd50314f4ffe6~T2iqWSw5H3276132761euoutp023
        for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2019 16:09:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190409160932euoutp02aafffffa2d03d26f0a0bd50314f4ffe6~T2iqWSw5H3276132761euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554826172;
        bh=u6Z/OMmWHC6ss2pITts3drgys85PGJnDF+5FLakx8FE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=F0ZoIxdTJLjwMHh5tgZqcDKE32Z7EcwRJaOl6UyIeh4LSrbhPnj+41jimWKhY3GCu
         X8VAae+v/dpJnN2eK3kLunuPSLuI4yhQ14NalK5zOrO5Hn7HP/farENMK9pbKSyG/9
         GEijCyvodSBTldt6QoyVvBvsv2yxusRs70pv+bEg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190409160932eucas1p2420e40ab26c6cc2b91a2d7b85104eb07~T2ipl1JY81594415944eucas1p2_;
        Tue,  9 Apr 2019 16:09:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7A.1C.04325.BB3CCAC5; Tue,  9
        Apr 2019 17:09:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190409160931eucas1p23ee0ca79d00f9c72a7a2d3e07a6c8703~T2io5NzRL1796217962eucas1p21;
        Tue,  9 Apr 2019 16:09:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190409160931eusmtrp2ece2fff7c98f35d2af8de835d7ce0593~T2io4oTzG1280112801eusmtrp2C;
        Tue,  9 Apr 2019 16:09:31 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-33-5cacc3bbc91a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C7.46.04140.BB3CCAC5; Tue,  9
        Apr 2019 17:09:31 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190409160930eusmtip1f935a21834f1f6f98cabdfe167d58632~T2ioa4lXI2971229712eusmtip1f;
        Tue,  9 Apr 2019 16:09:30 +0000 (GMT)
Subject: Re: [PATCH 2/2] ARM: dts: exynos: Remove console argument from
 bootargs
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, notify@kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <fb27dff4-7b1f-3010-2f04-8c0a3f8d8de6@samsung.com>
Date:   Tue, 9 Apr 2019 18:09:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408051926.462-2-krzk@kernel.org>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SXUhTYRj229nZzlaTz2n6olE5JCxQE7s4ZFhBxG4C80KkDJ15UMlN2dTU
        YYqB5d/UutCWP8uKchrqtFkKKtM5LXOZIZaV4Q+Z0wtzDUTT3I6Vd8/7/Hzv88JHEeIXpC+V
        oshglApZqoQn5BqH1seCegZaYk84fgfS7TWtJN0wOEbSFXM2grZa2/i0YW6SpCe6a3l0jbWX
        Qz8f/MKnP8xtkfTthR/EWaHUoC/mSTse50s1nXokXTMciuReFp5OZFJTshhlSES8MFkzbCfT
        P3Oyyx9oyQL0hFOCBBTgk1CjreKXICElxs8QGI2lpFMQYzuCyaf+rLCGYLay7l/CUfCRwwpP
        EazbG0l2WEHQqKvnOl2eOArM1mnkFLywFUHrpt41EM6IVWNzuXg4FMrNGuTEIhwBuvaJnaco
        iosDoHUhwUkfwDEwM9RGshYPGLk/74oKcBjYRmZdmMA+UGhvIll8GLpWagnnLsAmPlgWH+72
        Pg/9nzpIFnvCkqWTz+KDsP2qgcMGbiEo65nms0MlghmLDrGucBiwjLvaEfgYtHaHsPQ56P/u
        4DhpwO4wteLBlnCHu8ZqgqVFcKdIzLoDYENfvVvHF0rnt7mVSKLdc5p2zznaPedo/+/VIa4e
        +TCZKnkSowpTMDeCVTK5KlORFHwtTW5AO5/pzZbl10vUu5lgQphCkv2imPqWWDEpy1LlyE0I
        KELiJRLE7VCiRFlOLqNMi1NmpjIqE/KjuBIfkdrt2xUxTpJlMNcZJp1R/lU5lMC3AJmso436
        mzbB+3sBPgFN5uVVvPG2UWzOrZJ2Eq/pR9PS5qb1LY5//pn1pXH9EQ2vLyjnagat8X6XsFxB
        x0f6DcuGsz2b29b2RV8cd2yGamIu6S4ombyuSADDavGGe6YST0Wr0wOPLoT3uY2e6q8rK47K
        K1KHlSzyfn71LlRLuKpkWehxQqmS/QE4Lo6ySAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7q7D6+JMdhxg8ti44z1rBbzj5xj
        teh//JrZ4vz5DewWmx5fY7W4vGsOm8WM8/uYLNYeuctuceXxP1aL9qcvmR24PDat6mTz2Lyk
        3qNvyypGj8+b5AJYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
        MstSi/TtEvQy+k58YS24w1TRO3sWawPjUqYuRk4OCQETiW8NN4FsLg4hgaWMEstbNjN3MXIA
        JaQk5rcoQdQIS/y51sUGUfOaUeL1up1sIAlhgSCJo+dvM4IkRATOM0qc2rmUFcRhFljOKDF3
        6SywFUIC0RIr1veA2WwChhK9R/sYQWxeATuJBRsvs4JsYxFQkVj/NAkkLCoQIXHm/QoWiBJB
        iZMzn4DZnALGEq9PPgKzmQXUJf7Mu8QMYYtLNH1ZyQphy0tsfzuHeQKj0Cwk7bOQtMxC0jIL
        ScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgXG47djPLTsYu94FH2IU4GBU4uENmL4m
        Rog1say4MvcQowQHs5IIL2c8UIg3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgSkiryTe0NTQ
        3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDI9/0nxfUQtblMa7+JNTRaM44
        3/bh6rZb+/ZrHHEwnJ55m7k1tV5ceDd7TJHjI74f0xP81y7b8rZZ4uAD3ylRTCanbuc2xUVm
        3+1NK1155sESS6EnS7pc2aU2NV6eeK964csaq21hMcJVXCu8d//YJpS6ea+0fc6Zm3/+du0Q
        XWG3trb34tlZOkosxRmJhlrMRcWJADUnyNvZAgAA
X-CMS-MailID: 20190409160931eucas1p23ee0ca79d00f9c72a7a2d3e07a6c8703
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190409160931eucas1p23ee0ca79d00f9c72a7a2d3e07a6c8703
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190409160931eucas1p23ee0ca79d00f9c72a7a2d3e07a6c8703
References: <20190408051926.462-1-krzk@kernel.org>
        <20190408051926.462-2-krzk@kernel.org>
        <CGME20190409160931eucas1p23ee0ca79d00f9c72a7a2d3e07a6c8703@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 07:19, Krzysztof Kozlowski wrote:
> Remove the "console=ttySAC..." argument from DTSes having a proper
> stdout-path property.  To make the code functionally equivalent, add the
> serial port baud rate and parity.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
