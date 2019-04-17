Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE8EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD10204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lo64eg6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfDQI0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:26:02 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:50422 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbfDQI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:26:02 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190417082559epoutp03904fc67ef0413830ba87ec93ea34df36~WNYNNfvPc0646306463epoutp03b
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:25:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190417082559epoutp03904fc67ef0413830ba87ec93ea34df36~WNYNNfvPc0646306463epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555489559;
        bh=LPIUF6JsNanCNoL3FUadvI+9ApmhFJyPbs30UWNouHs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Lo64eg6uoxaPqSPYNzOgJbj95GdTblCtxgO3Rd33QTvNuELYe3KH1sSIQZ8x3+LWW
         sFYYUSDtOn9NYyKCOvi97StOotFgAHBGjKrTinKlZLKc1fVT6N92D5+6vr84LZRXy4
         o+I2zWSHGa0K70+IQ9X1ZNph8GB9wYiAXYonKnPQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190417082556epcas1p321d5ddc33815e9f1ac80fea4272ad3c5~WNYKlmYTk0752207522epcas1p3w;
        Wed, 17 Apr 2019 08:25:56 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.3F.04143.413E6BC5; Wed, 17 Apr 2019 17:25:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190417082555epcas1p4a58ab62f8752342190c9d12b73e84f2f~WNYJzxBLN2289822898epcas1p4p;
        Wed, 17 Apr 2019 08:25:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417082555epsmtrp297bdbb47a8e526f880ea94f8c2d1ca93~WNYJy2rii1126211262epsmtrp2D;
        Wed, 17 Apr 2019 08:25:55 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-2f-5cb6e3149975
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.CF.03662.313E6BC5; Wed, 17 Apr 2019 17:25:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190417082555epsmtip25941eca024b6083f0f995dfe9e92001c~WNYJnL0tn2835428354epsmtip2X;
        Wed, 17 Apr 2019 08:25:55 +0000 (GMT)
Subject: Re: [PATCH 3/3] Documentation: devicetree: add PPMU events
 description
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0d867843-ec56-f30b-8a3f-b3172f325bef@samsung.com>
Date:   Wed, 17 Apr 2019 17:26:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555487288-4777-4-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmrq7I420xBtM+cVlsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlYHfo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtKtsmIzUx
        JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
        YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xtTbZxgL
        VvNXtLdOZmtgPMjTxcjJISFgIvHi7SPGLkYuDiGBHYwSVx5cZ4VwPjFKvNuzmA2kSkjgG6PE
        2rsqXYwcYB3bLjtAhPcySnx7IgBR/55Rou/mJTaQGmGBQIm95+tB4iICZxklHjRtYwNxmAWu
        MEo8/bKIGaSbTUBLYv+LG2AL+AUUJa7+eMwIYvMK2Em8+D4PLM4ioCpxpuk/WFxUIELi/rEN
        rBA1ghInZz5hAbE5BbwkthxvZgKxmQXEJW49mQ9ly0s0b53NDLJYQmATu8T1W59YIH52kdi5
        7D47hC0s8er4FihbSuLzu71sEHa1xMqTR9ggmjsYJbbsv8AKkTCW2L90MhPIm8wCmhLrd+lD
        LOOTePe1hxUSQrwSHW1CENXKEpcf3GWCsCUlFrd3Qo33kPj97yj7BEbFWUjemYXkhVlIXpiF
        sGwBI8sqRrHUguLc9NRiwwJj5MjexAhOzFrmOxg3nPM5xCjAwajEw7vi59YYIdbEsuLK3EOM
        EhzMSiK8jilbYoR4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjBr5JXEG5oaGRsbW5gYmpka
        GiqJ8653cI4REkhPLEnNTk0tSC2C6WPi4JRqYAyQWlceXin290TikVsP2syu10aeVRTb9dlR
        THRVfFmGw+K0d2eXajwTnvBkk5fzBclP/+sldLWqhPnCYuSP3eS9O9PTZfrnp7P0+37wru+/
        +0jez63s+CKhuSJfdqy8dT6vWjmv7b3H5PIlKw7EfX57bGsR61TZOcn1x2r6LjNITldX4dDf
        HKHEUpyRaKjFXFScCABKDDVn4gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvK7w420xBj/a1C02zljPajH/yDlW
        i/7Hr5ktzp/fwG5xtukNu8WtBhmLTY+vsVpc3jWHzeJz7xFGixnn9zFZrD1yl91i6fWLTBa3
        G1ewWbTuPcJucfhNO6sDv8eaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6fN4kF8AWxWWTkpqT
        WZZapG+XwJUx9fYZxoLV/BXtrZPZGhgP8nQxcnBICJhIbLvs0MXIySEksJtRYtYMaRBbQkBS
        YtrFo8wQJcIShw8XdzFyAZW8ZZS4/esEWFxYIFBi7/l6kLiIwFlGiUWTFrCDOMwCVxglll+b
        zArRcZdRomnfM2aQqWwCWhL7X9xgA7H5BRQlrv54zAhi8wrYSbz4Pg8sziKgKnGm6T9YXFQg
        QuLM+xUsEDWCEidnPgGzOQW8JLYcb2YCsZkF1CX+zLvEDGGLS9x6Mh8qLi/RvHU28wRG4VlI
        2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCY1RLawfjiRPx
        hxgFOBiVeHhX/NwaI8SaWFZcmXuIUYKDWUmE1zFlS4wQb0piZVVqUX58UWlOavEhRmkOFiVx
        Xvn8Y5FCAumJJanZqakFqUUwWSYOTqkGxvJ22aSyJMWAm0a/plSVLq8skcpvmHliS1dW8hI+
        Ed61uaq6GVctTq7T2313TcAPBos0xxnsLUn50alPnk968+1LRT1Dpc6N7FePTpu8EJNJ6lm0
        0WrpexsWm6NzLfY9rk/Z+0dXaONco+A+7uOzir++nTb597pjUdJCvtMl+V5F2NpMiNrdpsRS
        nJFoqMVcVJwIAPwgOCzNAgAA
X-CMS-MailID: 20190417082555epcas1p4a58ab62f8752342190c9d12b73e84f2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417074835eucas1p19319bedd176d55e10b272881b7c68919
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074835eucas1p19319bedd176d55e10b272881b7c68919@eucas1p1.samsung.com>
        <1555487288-4777-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 4. 17. 오후 4:48, Lukasz Luba wrote:
> Extend the documenation by events description with new 'event-data-type'
> field. Add example how the event might be defined in DT.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> index 3e36c1d..47feb5f 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> @@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>  			reg = <0x104d0000 0x2000>;
>  			status = "disabled";
>  		};
> +
> +The 'event' type specified in the PPMU node defines 'event-name'
> +which also contains 'id' number and optionally 'event-data-type'.
> +
> +Example:
> +
> +		events {
> +			ppmu_leftbus_0: ppmu-event0-leftbus {
> +				event-name = "ppmu-event0-leftbus";
> +				event-data-type = <PPMU_RO_DATA_CNT>;
> +			};
> +		};
> +
> +The 'event-data-type' defines the type of data which shell be counted
> +by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for

I replied about 'pmu' name on patch2. Please check it.

> +all possible type, i.e. count read requests, count write data in bytes,
> +etc. This field is optional and when it is missing, the driver code will
> +use default data type.
> 
Looks good to me.
But, If you want to add the new 'event-data-type' property,
you better to add 'event-data-type' to Exynos dts file including
PPMU device.

If the dts file contain the data type information,
I think it is easy to understand for the user
what is monitoring on PPMU device.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
