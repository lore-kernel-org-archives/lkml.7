Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B959CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9B821897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IYixdh9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409633AbfJRI4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:56:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57570 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJRI4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:56:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191018085601euoutp014aa2d2d6b16a3cabe3ebbf649fda5387~Ose9hpK4n1661716617euoutp01N
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:56:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191018085601euoutp014aa2d2d6b16a3cabe3ebbf649fda5387~Ose9hpK4n1661716617euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571388961;
        bh=q3xlbm1BY1W0K5WQh9byPKRVfevefn4Z2BQqp8kg1pc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IYixdh9Qr72oEwwu39eJW/pmsoetNyvudIbcMdJ2yIQEIGMjBM1akNE3G8N/Docwr
         s2++zOZIcgU3XqCUJ+gLx3jeoguX7psGnTaLU/YQdUrdOkxrvYVMXGIpVgHUyQnlSo
         CPielhJ3Qm3Clav/eo1UfZaFbCuYIBrxG210Z414=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191018085601eucas1p1627e3454057f0fb608eb0c3b4f5de391~Ose9TwDeG2450824508eucas1p1y;
        Fri, 18 Oct 2019 08:56:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4E.54.04469.12E79AD5; Fri, 18
        Oct 2019 09:56:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191018085601eucas1p2551a8254a4f6a9aaa0776f69d582ca80~Ose9ATwUq2612526125eucas1p2z;
        Fri, 18 Oct 2019 08:56:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191018085601eusmtrp2896e58267ab860b9349aa36512494d0e~Ose8-ojnk1671616716eusmtrp2g;
        Fri, 18 Oct 2019 08:56:01 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-c6-5da97e215e02
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3F.81.04166.02E79AD5; Fri, 18
        Oct 2019 09:56:01 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191018085600eusmtip255efb5c390c2eb11a25b0f648f4e5f71~Ose8lv-3l1114711147eusmtip2R;
        Fri, 18 Oct 2019 08:56:00 +0000 (GMT)
Subject: Re: [PATCH v2 28/33] ASoC: samsung: Use pr_warn instead of
 pr_warning
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <821f1fbf-8719-e0dc-d6d6-067376209243@samsung.com>
Date:   Fri, 18 Oct 2019 10:55:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018031850.48498-28-wangkefeng.wang@huawei.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGe3fv3b0bza5T82BRNBT68mMgMbIkoWTgHxkFfZrd8qKSTtl1
        pglmZqJmpinYhpVS6jYSzYafUDlNU8vlJJFETCYi0krnLETU2q6V//3Oe55znvPAS2HSVsKP
        SlSlsWoVkyQTivGW3mVL4J5sQ0yIbn67wmJpIhUjHVVCRWHHA0KxblsiFMN6p0DRsGgjFU2/
        GpDi9uIkOkYp23UTpDKvx04om42FQuVre51QWWIyImWj6TOuXGzeFU1eEB+JY5MS01l1cPgV
        cUJNSTeWaiYyama/YDloGC9CIgroUFjTDgmKkJiS0noE63XfCL5wIrCWF5F8sYigdcrxb6Qu
        /z3GN+oRzDkcGyN2BGXGFVSEKMqLjoYKU6gLvemDUNOtcUkw+q4Apt5oSdciIS2H++9KkIsl
        dDiMz+e6DXA6AGyfKt1rfOhzMLjE8BJP6NdOuyUiOgL655xuxmhfyHUaCJ53Q6u9CnONAj1A
        gi2RP/k42FZtGM9eMNdnInneCevtT93pgb6DoLhznOSLUgSTfdWIV4VBd98w4VqK0fugsSOY
        f46AZfOqgPfygDG7J3+CBzxsqdw4QQIF+VJe7Q8rxkoBz35wb3odL0Uy3aZguk1hdJvC6P77
        ViPciHxZDZccz3JyFXsjiGOSOY0qPuhaSnIz+vOdBtf6HG1oyXrVjGgKybZK2qL1MVKCSecy
        k80IKEzmLTkdZoiRSuKYzJusOiVWrUliOTPaQeEyX0nWlq8XpXQ8k8ZeZ9lUVv23K6BEfjno
        cua2wJmj/amPnof4d6mKL5WKPg58GDVPjJ48LFe/omr1xZ2RhhnRgd6msdoAU85CxfnZrNLq
        yH52Pq9g9dAPg2esjzGqs+Ztz6kqS8bQzzQt7vvibPn3hDNWa/7YcmGUUMA8Eb2sFoSdyPXe
        uzBYhi+dFjeNZN+qn3/ctSJ6FiTDuQRGvh9Tc8xvfrQyTkoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7qKdStjDS6uZ7I4f34Du8XlXXPY
        LDp39bNa/H/8ldXi4oovTBZrPz9mt9jwfS2jRePn+4wOHB47Z91l92g58pbVY9OqTjaPfW+X
        sXn0bVnF6LF+y1UWj8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQyFvYdZi44xFqx8MUt5gbGiyxdjJwcEgImEsvaTjB3MXJxCAksZZRY
        f/Q7excjB1BCSmJ+ixJEjbDEn2tdbBA1rxklNq1YyAiSEBbwk5h1bQUrSL2IgI7EwsOlIDXM
        Aq1MEg+fnGWHaGhgknjW8BqsgU3AUKL3aB+YzStgJ3H7QxPYFSwCqhKPL0wHi4sKREg8334D
        qkZQ4uTMJ2A1nAKOEidffQGzmQXUJf7Mu8QMYYtLNH1ZyQphy0tsfzuHeQKj0Cwk7bOQtMxC
        0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgTG57djPzTsYL20MPsQowMGoxMO7
        I2BFrBBrYllxZe4hRgkOZiUR3mDrlbFCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MF3kl
        8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhibHWJ/N4U84v5TMo/b
        4ZZDiT/P+qzNcnHzb/1d1nejr+INQ7/W088xico73gSrXVneW7R2nU/EPu99yhzn8pyy1p3f
        1StjcyLTZIdu7LVvs3r+Le78mS1eoD9xsXRwUAp7tcvmnZ/f8uec376rUyT5z89Dtp+2zytr
        Xvnph/P5c1tO1WU63r2mxFKckWioxVxUnAgA7qWudd8CAAA=
X-CMS-MailID: 20191018085601eucas1p2551a8254a4f6a9aaa0776f69d582ca80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191018031948epcas5p42a9c51ef72e83ba6c39dba80c9220d13
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191018031948epcas5p42a9c51ef72e83ba6c39dba80c9220d13
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
        <20191018031850.48498-1-wangkefeng.wang@huawei.com>
        <CGME20191018031948epcas5p42a9c51ef72e83ba6c39dba80c9220d13@epcas5p4.samsung.com>
        <20191018031850.48498-28-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/19 05:18, Kefeng Wang wrote:
> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.
> 
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sangbeom Kim <sbkim73@samsung.com>

> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

However you need to send this patch to the maintainer directly
(Mark Brown <broonie@kernel.org>).

-- 
Thanks,
Sylwester
