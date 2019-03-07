Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C724BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8018C20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r9f6oreW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfCGBK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:10:28 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:18255 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfCGBK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:10:27 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190307011023epoutp010b99d58413fcb5e44746eddd8dbd5890~Jh-LWbn-f2361223612epoutp01Q
        for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2019 01:10:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190307011023epoutp010b99d58413fcb5e44746eddd8dbd5890~Jh-LWbn-f2361223612epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551921023;
        bh=opX/UAceXoB66vD3guMP+2MKNvq5nneCNG4qAEaHgYQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=r9f6oreWBoqJuLLX7nzZDMvc+021g6B2tA+hXJQQ3Z+3pthd30R94Xy8tDAWcWmuu
         NtpeKeW3r4nMnjyFYvymsVY5gxEuF6VhjJA6y2j31QWjnjlabi8xaql9y/9Od8unh2
         WizHQwQ1azM8AhNweTJWqqdXG9hourI2ZJEKcRMw=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190307011020epcas1p4315a8e538ac206b3a716a45bc7011294~Jh-IW6_iW0371403714epcas1p4F;
        Thu,  7 Mar 2019 01:10:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.DE.04206.87F608C5; Thu,  7 Mar 2019 10:10:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190307011015epcas1p461177da9511988c3232e5e2d30025b4e~Jh-EKvPL01900919009epcas1p40;
        Thu,  7 Mar 2019 01:10:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190307011015epsmtrp1183bab91546742c9b73c8519421a7423~Jh-EJLA2G3006830068epsmtrp1R;
        Thu,  7 Mar 2019 01:10:15 +0000 (GMT)
X-AuditID: b6c32a39-d65ff7000000106e-66-5c806f7846a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.46.03601.77F608C5; Thu,  7 Mar 2019 10:10:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190307011015epsmtip29168ee05852697d3909e3d9dbb2fd932~Jh-D9M1Jh0635106351epsmtip2e;
        Thu,  7 Mar 2019 01:10:15 +0000 (GMT)
Subject: Re: [PATCH v4 4/8] drivers: devfreq: add DMC driver for Exynos5422
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>, cwchoi00@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4bbc0f61-952e-bcdb-4645-2644a122ac99@samsung.com>
Date:   Thu, 7 Mar 2019 10:10:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <94e169cf-4dc2-82ec-1385-852bc7853931@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmnm5FfkOMwaU2M4uNM9azWjw7qm0x
        /8g5Vov+x6+ZLc6f38BucbbpDbvFrQYZi02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfd4nbj
        CjaLw2/aWR34PHbOusvusWlVJ5vH5iX1Hgff7WHy6NuyitHj8ya5ALaobJuM1MSU1CKF1Lzk
        /JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoFuVFMoSc0qBQgGJxcVK+nY2
        RfmlJakKGfnFJbZKqQUpOQWWBXrFibnFpXnpesn5uVaGBgZGpkCFCdkZd+92MRc8F6t4cqOu
        gfGNYBcjJ4eEgInE1M0/WLsYuTiEBHYwSpxv/MgI4XxilPg1+RALhPONUeJk41RmmJaWsw+Z
        IRJ7GSV2tT+HannPKLH+0VuwKmEBb4m1HcvBbBGBfInft0+ygxQxC/xlllhw5xkjSIJNQEti
        /4sbbCA2v4CixNUfj8HivAJ2Es9m/2cBsVkEVCRabvSDDRIViJB4/3Q3C0SNoMTJmU/AbE4B
        e4mr926zgtjMAuISt57MZ4Kw5SWat84GO1VCYBm7xP17i9kgfnCROHLwMSuELSzx6vgWdghb
        SuJlfxuUXS2x8uQRNojmDkaJLfsvQDUYS+xfOhloAwfQBk2J9bv0IZbxSbz72sMKEpYQ4JXo
        aBOCqFaWuPzgLhOELSmxuL2TDaLEQ+LU3pQJjIqzkHwzC8kHs5B8MAth1wJGllWMYqkFxbnp
        qcWGBabIsb2JEZyOtSx3MB4753OIUYCDUYmHl+FkfYwQa2JZcWXuIUYJDmYlEd5JuQ0xQrwp
        iZVVqUX58UWlOanFhxhNgYE9kVlKNDkfmCvySuINTY2MjY0tTAzNTA0NlcR51zs4xwgJpCeW
        pGanphakFsH0MXFwSjUwMqb8y9px79ySnD+T70+eXDWxXr3NsfLBR1HTkqRsj3QGFdOdsocr
        oqf9mvt+UlHEej3f8xP+GYWdeM//lqFr6o7e5N6YOtkqm5XLWk2+Hr58JWuyTbUzy9aILoXH
        FtM+7GzUrGh6+G5CdYJ3wP/s1N8v5ELdOXYe3KxqZMfce+jAU40Wq7C7SizFGYmGWsxFxYkA
        d6yoI90DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvG55fkOMwcXVphYbZ6xntXh2VNti
        /pFzrBb9j18zW5w/v4Hd4mzTG3aLWw0yFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xe3G
        FWwWh9+0szrweeycdZfdY9OqTjaPzUvqPQ6+28Pk0bdlFaPH501yAWxRXDYpqTmZZalF+nYJ
        XBl373YxFzwXq3hyo66B8Y1gFyMnh4SAiUTL2YfMXYxcHEICuxklprReYoFISEpMu3gUKMEB
        ZAtLHD5cDFHzllHi45sbrCA1wgLeEms7ljOD2CIC+RL3HzxkBCliFmhkkZh8+zQbRMdtJol9
        z5aBdbAJaEnsf3GDDcTmF1CUuPrjMSOIzStgJ/Fs9n+wzSwCKhItN/rBpooKREjcvfiCBaJG
        UOLkzCdgNqeAvcTVe7fBZjILqEv8mXeJGcIWl7j1ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRl
        FpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgiNTS2sH44kT8YcYBTgYlXh4
        I07XxwixJpYVV+YeYpTgYFYS4Z2U2xAjxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6
        YklqdmpqQWoRTJaJg1OqgdGxKytgXsD5lW2v2Xaw+CfOFtrlYnCHs1qh2u5pWd5Tpc5gA41E
        Pm7vq9tc5i0yKlnA8YjzZmJvlkCXYteZ7+0fZP5NqZdT7hPljRZlWqal8+2rxD+fS/UsYTk7
        VzqucCnU+W6luLCh4+hRPfeXP3Z//qotOtvvLS+f+t+5i97Nvu6vkGImo8RSnJFoqMVcVJwI
        AOKAT8TIAgAA
X-CMS-MailID: 20190307011015epcas1p461177da9511988c3232e5e2d30025b4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190201164720eucas1p13aac6550399d240b261a2cbe489d3dfc
References: <CGME20190201164720eucas1p13aac6550399d240b261a2cbe489d3dfc@eucas1p1.samsung.com>
        <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <1549039612-28905-5-git-send-email-l.luba@partner.samsung.com>
        <CAGTfZH0o6dHQj00vHwZBn05AT-Z_oAWHfBX0eATQ12NPmfw4fg@mail.gmail.com>
        <94e169cf-4dc2-82ec-1385-852bc7853931@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On 19. 3. 6. 오후 10:44, Sylwester Nawrocki wrote:
> Hi,
> 
> On 2/3/19 13:23, Chanwoo Choi wrote:
> 
>> 2019년 2월 2일 (토) 오전 2:42, Lukasz Luba <l.luba@partner.samsung.com>님이 작성:
> 
>>> +/**
>>> + * exynos5_dmc_pause_on_switching() - Controls a pause feature in DMC
>>> + * @dmc:       device which is used for changing this feature
>>> + * @set:       a boolean state passing enable/disable request
>>> + *
>>> + * There is a need of pausing DREX DMC when divider or MUX in clock tree
>>> + * changes its configuration. In such situation access to the memory is blocked
>>> + * in DMC automatically. This feature is used when clock frequency change
>>> + * request appears and touches clock tree.
>>> + */
>>> +static int exynos5_dmc_pause_on_switching(struct exynos5_dmc *dmc, bool set)
>>
>> Don't need to make it as the separate function. It is only used on
>> probe() function.
> 
> It seems fine to me to have this functionality in a separate function, 
> it's self-contained and it's now pretty well documented.
> 
>>> +{
>>> +       unsigned int val;
>>> +
>>> +       val = readl(dmc->base_clk + DMC_PAUSE_CTRL);
>>> +       if (set)
>>> +               val |= DMC_PAUSE_ENABLE;
>>> +       else
>>> +               val &= ~DMC_PAUSE_ENABLE;
>>> +       writel(val, dmc->base_clk + DMC_PAUSE_CTRL);
>>
>> The dt-binding file doesn't explain the 'reg' property for 'base_clk'.
>> You are missing.
>> When I tried to find what are the base address, it is the register map
>> of clock-controller.
>> This driver accesed the register of clock controller without any
>> functions of CCF
>> (common clock framework). It is wrong.
>>
>> If you need to get the some information of clock, must have to use the CCF.
> We talked a little about this issue with Lukasz in person and it looks
> like there are some DMC related registers in the clock controller register 
> region, I'd say those registers are better handled by the DMC driver rather
> than the clocks controller driver. Moreover, we should avoid abusing clk API
> for not strictly clocks related functionality as it appears to be above.
> It might be more appropriate to add in the dmc DT node a phandle to a regmap
> exposed by the clock-controller node. It seems there will be even no single
> register that would be shared between the DMC and the clock controller.
> 

I agree to share the regmap instance of clock controller
with syscon_regmap_lookup_by_phandle() and then add the detailed
description about this to dt-binding documentation.


And,
This patch has the another quetion about the clocks in
exynos5_dmc_init_clks(). This functions used 'clk_set_parent'
to make the hierarchy between clocks. I think it is possible to make
the relation of clocks in DT by using the 'assigned-clocks'.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
