Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDE5C742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBF2206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R56V/rCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGLKb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:31:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52701 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfGLKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:31:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190712103157euoutp029907e0f923ca31f42e83421fbb235ce8~wokvvJ3bH1445214452euoutp02B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:31:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190712103157euoutp029907e0f923ca31f42e83421fbb235ce8~wokvvJ3bH1445214452euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562927517;
        bh=YxnS2+3M6pr5GjcHTelq9Mz+os4Y/hjBeH+yjaPYcOc=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=R56V/rCIcT6N46VPqh0tmFBlPiHvgRJlSplqyU0+dQ//ST2YtixGtRd1BX3FBUdkH
         1RqUqgNO6SkbSt1iWhhdJZiW5TOcWoUk3UebV8ElRp+8TcNJEtQ0xLlJRmhqUMPZXb
         L3++JPDyZk4Aek/dXQyBsNIKZS0vWYJerq861bpk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190712103156eucas1p2aec8cd3026c079d2e2048d4e65ad5aed~wokuuCVrO2616926169eucas1p2s;
        Fri, 12 Jul 2019 10:31:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C3.F1.04325.C91682D5; Fri, 12
        Jul 2019 11:31:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190712103155eucas1p2927c238305fdacc674f91c488719967d~wokt3gomK0175901759eucas1p2M;
        Fri, 12 Jul 2019 10:31:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190712103155eusmtrp22fb95a427a341078d17a474032433829~woktpQ5Sn1432014320eusmtrp2v;
        Fri, 12 Jul 2019 10:31:55 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-11-5d28619ce435
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.53.04140.B91682D5; Fri, 12
        Jul 2019 11:31:55 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190712103154eusmtip2cac930228fdd8f39b08e3668355ec268~woks_lk4a1098410984eusmtip2j;
        Fri, 12 Jul 2019 10:31:54 +0000 (GMT)
Subject: Re: [PATCH 2/3] dt-bindings: display: sii902x: Change audio mclk
 binding
To:     Olivier Moysan <olivier.moysan@st.com>, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        benjamin.gaignard@st.com, alexandre.torgue@st.com,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, jsarha@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <bc2b0a58-d5e2-ce82-d1c8-c17731e44e31@samsung.com>
Date:   Fri, 12 Jul 2019 12:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1562082426-14876-3-git-send-email-olivier.moysan@st.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhUWRjGO/fce+eONXId250Xi8KBPqGvLdkThSVUHPpiKeqPItq7ddFY
        HW1uuk1B34ZjaFqQ6Ygam2ZmWGMzrbMaNaV3bVjRNk1rw0qDPpykTCsqp7neIv/7ned93pfn
        gSNg8yE+Rthh2yXbbVKylY9gvU0fWmYVS9O3zC258CPJaWlmyOXeACK5pb0cCXnzMSm91cKR
        u4P9PGl/9xyT5r52lhxzZnHEmX/WQNw9HRz5z1fMk+yO8Eb5vTaG+HM3k5P1Lp5kNtwyLI2i
        1SXViPZ3Zhpow1AZS11ZhRx1Vzl5+k/eHYZeHXrE0e5jKkNrz+6n13NOsvTGtXn06fsGTNXO
        qwwdcE/6JXJTxOLtcvKODNk+J/7XiKSg838uzTV2d06mig+gP43ZyCiAuACuu1oN2ShCMIuV
        CLoq7vD64y2CvopGVnOZxQEEj9vDLmFkwxfaqMvnEBysTNM5iGAgSDSOFtfD0JmXI6vjxQ4M
        BUGqMS/OgM+1XbzGJjEeqgZrkMasOAU+qk1Y4x/EjfChzPnVEwXNhb0jd4ziCnj4xj2iY3Ey
        HPa4sM4WuN9bymiZQbwowLv6fkbPuQyGT6/TS0bDC/WKQeeJEKrT/Brvh+7KI1jfzULguVSH
        9cEiuKm2cdodHA5d45ujywkQ8lTw+vlI6AxG6REi4YS3AOuyCbKOmnV3LHT/6/l60ALlrYO8
        zhR6Sk7hPBRbNKpk0ahiRaOKFX3PUIbYKmSR05WURFmZb5P/mK1IKUq6LXH2ttQUNwr/zMCw
        OvgXuvbpNz8SBWQdZ+pcOG2LmZMyFEeKH4GAreNNVaGwZNouOfbI9tSt9vRkWfGjCQJrtZj2
        jnm02SwmSrvk32U5TbZ/mzKCMeYAajqfX7sgEPcq/naPN3I45mJcRsHPq1Z6RQ6/zFwSCq5b
        FHdBdVD3w7aWJ8WpO5dXT064kpQWW9dnkXYWPihvLIlbfdror82d5GAaD71x4PV5rkvup9PX
        dK34u76ysPFIevmGnwIzfWvveYa23YQJe9SpCYv3PVMC0cdb62tsvhevraySJM2bie2K9AV7
        JKmXlQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42I5/e/4Pd3ZiRqxBgdXSFn0njvJZLHxyWlG
        i775T1gt/m+byGwx/8g5VosrX9+zWVz9/pLZ4uSbqywW3Z0drBadE5ewW2x6fI3V4vKuOWwW
        XdeAOpZev8hkcagv2mLyntlsFq17j7A7CHqsmbeG0eP9jVZ2j73fFrB4zO6YyeqxaVUnm8eJ
        CZeYPLZ/e8Dqcb/7OJPH5iX1Hgd6J7N4HNxn6PH0x15mj+M3tjN5fN4kF8AXpWdTlF9akqqQ
        kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxtvMOa8Fs7ore1uPM
        DYyLObsYOTgkBEwkdv0P62Lk4hASWMooseb3C9YuRk6guLjE7vlvmSFsYYk/17rYIIpeM0rM
        +/OQCSQhLBAs8W3haxaQhIjANWaJXzu7WCCqrjJK7Dg/G6ydTUBT4u/mm2wgNq+AncSqr+sZ
        QWwWAVWJ38ePMYOcISoQJnH0RB5EiaDEyZlPWEBsTgE3ibufNoG1MguoS/yZd4kZwpaXaN46
        G8oWl7j1ZD7TBEbBWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC
        k8K2Yz+37GDsehd8iFGAg1GJh/eGpXqsEGtiWXFl7iFGCQ5mJRHeVf+BQrwpiZVVqUX58UWl
        OanFhxhNgX6byCwlmpwPTFh5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6
        mDg4pRoYA//OuqnL2hP6USA+fMKvBT/LYsU9Tuh2htW4dJ858ORD75SHpbcEnPJ4YoLjuLKT
        21cw/9tYnWHbap44z1dNLvNcOdvOGZ587wJ5yr9eDFmo//jThITufWsPyk+3lVHk+GJgMZH1
        9tVj9wLupDuo3nF96PD4ptrnfUdKVt1+s//DiazHX3kWKrEUZyQaajEXFScCAPejhnMgAwAA
X-CMS-MailID: 20190712103155eucas1p2927c238305fdacc674f91c488719967d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190702154806epcas3p4058827de402f54ea3911c56ee17ae631
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190702154806epcas3p4058827de402f54ea3911c56ee17ae631
References: <1562082426-14876-1-git-send-email-olivier.moysan@st.com>
        <CGME20190702154806epcas3p4058827de402f54ea3911c56ee17ae631@epcas3p4.samsung.com>
        <1562082426-14876-3-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.2019 17:47, Olivier Moysan wrote:
> As stated in SiL9022/24 datasheet, master clock is not required for I2S.
> Make mclk property optional in DT bindings.
>
> Fixes: 3f18021f43a3 ("dt-bindings: display: sii902x: Add HDMI audio bindings")
>
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/sii902x.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> index 2df44b7d3821..6e14e087c0d0 100644
> --- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> @@ -26,9 +26,8 @@ Optional properties:
>  	- clocks: phandle and clock specifier for each clock listed in
>             the clock-names property
>  	- clock-names: "mclk"
> -	   Describes SII902x MCLK input. MCLK is used to produce
> -	   HDMI audio CTS values. This property is required if
> -	   "#sound-dai-cells"-property is present. This property follows
> +	   Describes SII902x MCLK input. MCLK can be used to produce
> +	   HDMI audio CTS values. This property follows
>  	   Documentation/devicetree/bindings/clock/clock-bindings.txt
>  	   consumer binding.
>  

Acked-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

