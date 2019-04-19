Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF49CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5942C222D2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="btfi5qmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfDSSWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:22:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35070 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfDSSWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:22:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190419133420euoutp01092c0b8d44672526165855d546864b5e~W44AKufXp0033800338euoutp01A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:34:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190419133420euoutp01092c0b8d44672526165855d546864b5e~W44AKufXp0033800338euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555680860;
        bh=0LI72Wl7YJAp64pzLBSUOIzhmPouVZZU8BFleXkj+X4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=btfi5qmdHmCyTVI4V/aZqGgcGeM/cJZlmsLkovhfKaHrNtNXG0t7nekYJ72DUZ63j
         H0Ohr1VOUhsuh+HdpWnzrqWXkdKCVQwX5B/9VKwt+6j0jpFmiHspyQVQmTBMUqiPod
         qXnUWdxs88TXwMY2eFdZrQSS17JqlLn7XlLrqDqM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190419133419eucas1p12d4ca51ad4d845940623a39a80f34209~W43-bucE71679616796eucas1p1E;
        Fri, 19 Apr 2019 13:34:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6B.58.04377.B5EC9BC5; Fri, 19
        Apr 2019 14:34:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190419133418eucas1p2baf1c185a476dbcf40d81f872762840d~W43_r8UjW3235232352eucas1p2_;
        Fri, 19 Apr 2019 13:34:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190419133418eusmtrp2c91028d4e7e98be02c615434296af2bd~W43_d1vmc2640526405eusmtrp2i;
        Fri, 19 Apr 2019 13:34:18 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-bb-5cb9ce5b6cd2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2C.DD.04140.A5EC9BC5; Fri, 19
        Apr 2019 14:34:18 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190419133417eusmtip1eddd38c6578df26440b1df3235fb8cca~W439zxjJP2921829218eusmtip1H;
        Fri, 19 Apr 2019 13:34:17 +0000 (GMT)
Subject: Re: [PATCH v2 2/4] drivers: devfreq: events: extend events by type
 of counted data
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <5ea36d22-d6c2-92a2-77e4-f9017d061f50@partner.samsung.com>
Date:   Fri, 19 Apr 2019 15:34:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555594712-18341-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUcRTH++3s7Izmxm9X05dFwpKRRloRNtEpRCxZFHQQrpWbjkfqajtq
        WVEmeWSZYrTZ4pHkhZiarsdaeW4eaB5EapkpKQWlQrpJQlaOs5L/fd57nx/f9+BHE/Ih0pEO
        1kSyWo06VCGxFle3zvVsUXUbfbZ+bJAxzzPKSGbA/JVkckzdJJM69p1genrKKeZN3ATFVIz1
        k8zbukwJM5NiQkxGT72IeWYappj8gT4RM3SrSMLEvzJRTMtEIsnMtn9GB7CyJLsEKY36YUpZ
        UXxHoqzMu6m8byhGypmK9ccl3tZ7/NnQ4GhW677P1zro4etZMiLe5Upctkkci4xOyciKBrwD
        kpryUTKypuW4CEHmfCIlFGYE2VP1lmIGwe2uUXLpSUl9EikMChG06wYt1iSCxuF2grds8VnI
        m/+5yHb4KYLZFm9eInCyCO6WVS4k0rQEu0Ft8SXekeJD8K7qPeJZjJ1hejRpkVfjMzDSWk4K
        jgw6Ho+LebbCXjD3RS/hmcAO8GE8RySwE9RMZhJ8FuB5CrKmUpCw9kEY0f2wsC18azNQAq+D
        v0bhMWAOYlNyLc51GEvNsji7oaWtj+R3JrALlNW5C21PaCioEfNtwKtgcFImrLAK0qsfEUJb
        CkkJcsHeBIZ7vZYgeygs0VFpSKFfdph+2TH6Zcfo/+c+QeJi5MBGcWGBLLddw15249RhXJQm
        0M0vPKwCLXy5zj9t5lpU9/tCM8I0UthIG9ONPnJSHc3FhDUjoAmFndTT3+Ajl/qrY66y2vDz
        2qhQlmtGa2mxwkF6bcWoSo4D1ZFsCMtGsNqlqYi2coxFVq6eiu4TXicdym1DnKLifY/qRti4
        QL1v6emJFD8Xc7Td/iEdtdLcKynQqJziyrpSm28UVB6hPDLJndKEUx57a4ZG/Ta4otqNVTZe
        ndNtHTa7ZP0vH9SpgjsuBgR42thzeZrxF3pDg0zlfHhNblB8+ebwT/W/Js8NVE40HStNMyrE
        XJB6myuh5dT/AJIp4+9uAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7pR53bGGCy6LGuxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaL1r1H2C0Ov2lntfh24hGjg4DHmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMfXo
        N9aCVs2KpnlHWBoYd8p3MXJySAiYSKzZ18HaxcjFISSwlFHictsJJoiEmMSkfdvZIWxhiT/X
        utggil4zSvQebgIrEhaIlej98AEsISKwmFHiR+MDMIdZoItJ4tGLd1At9xkldm15BeRwcLAJ
        6EnsWFUI0s0r4CZxdetNRhCbRUBV4tODDjBbVCBC4sz7FSwQNYISJ2c+AbM5Bbwlfj6bxQZi
        MwuYSczb/JAZwhaXuPVkPhOELS+x/e0c5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucW
        G+kVJ+YWl+al6yXn525iBMb2tmM/t+xg7HoXfIhRgINRiYf3wKSdMUKsiWXFlbmHGCU4mJVE
        eB1TtsQI8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4w7eSVxBuaGppbWBqaG5sbm1koifOe
        N6iMEhJITyxJzU5NLUgtgulj4uCUamBUUT+bFn2HqYhZOKbw3OzgOCWD1Hj9GTonbXlLfom9
        Egn4ojrr2K/slP2zMlYqKFQ+mOXFOqH7dPIrfnmOjMldUUH3bHd8vHzk+q/8vT08cvPfqHxI
        /Lv8r+YztoUb/v/Q9Vzuto7P/tyC7Rz+1bduNQbfV/l9b9134yKjM+selBv6TY5r3smpxFKc
        kWioxVxUnAgAOvFuggMDAAA=
X-CMS-MailID: 20190419133418eucas1p2baf1c185a476dbcf40d81f872762840d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190418133853eucas1p21ff5f58f5446b8452698910923524524
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190418133853eucas1p21ff5f58f5446b8452698910923524524
References: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190418133853eucas1p21ff5f58f5446b8452698910923524524@eucas1p2.samsung.com>
        <1555594712-18341-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

please ignore this patch there is a comment below.
It wrongly sets the default value.

On 4/18/19 3:38 PM, Lukasz Luba wrote:
> This patch adds posibility to choose what type of data should be counted
> by the PPMU counter. Now the type comes from DT where the event has been
> defined. When there is no 'event-data-type' the default value is used,
> which is 'read data in bytes'.
> It is needed when you want to know not only read+write data bytes but
> i.e. only write data in byte, or number of read requests, etc.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>   drivers/devfreq/event/exynos-ppmu.c | 61 +++++++++++++++++++++++++------------
>   include/linux/devfreq-event.h       |  6 ++++
>   2 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index c61de0b..9f12201 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -154,9 +154,9 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>   	if (ret < 0)
>   		return ret;
>   
> -	/* Set the event of Read/Write data count  */
> +	/* Set the event of proper data type monitoring */
>   	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
> -				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
> +			   edev->desc->data_type);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -368,23 +368,11 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>   	if (ret < 0)
>   		return ret;
>   
> -	/* Set the event of Read/Write data count  */
> -	switch (id) {
> -	case PPMU_PMNCNT0:
> -	case PPMU_PMNCNT1:
> -	case PPMU_PMNCNT2:
> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> -				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
> -		if (ret < 0)
> -			return ret;
> -		break;
> -	case PPMU_PMNCNT3:
> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> -				PPMU_V2_EVT3_RW_DATA_CNT);
> -		if (ret < 0)
> -			return ret;
> -		break;
> -	}
> +	/* Set the event of proper data type monitoring */
> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> +			   edev->desc->data_type);
> +	if (ret < 0)
> +		return ret;
>   
>   	/* Reset cycle counter/performance counter and enable PPMU */
>   	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
> @@ -508,6 +496,7 @@ static int of_get_devfreq_events(struct device_node *np,
>   	struct device *dev = info->dev;
>   	struct device_node *events_np, *node;
>   	int i, j, count;
> +	int ret;
>   
>   	events_np = of_get_child_by_name(np, "events");
>   	if (!events_np) {
> @@ -544,6 +533,40 @@ static int of_get_devfreq_events(struct device_node *np,
>   		desc[j].driver_data = info;
>   
>   		of_property_read_string(node, "event-name", &desc[j].name);
> +		ret = of_property_read_u32(node, "event-data-type",
> +					   &desc[j].data_type);
> +		if (!ret) {
It should be: if (ret)
then it means we do not have a value in DT and we are using
our defaults taking into account the right register type.

I am going to send v3 with this fix.

Regards,
Lukasz
> +			/* Set the event of proper data type counting.
> +			 * Check if the data type has been defined in DT,
> +			 * use default if not.
> +			 */
> +			if (of_device_is_compatible(np,
> +					"samsung,exynos-ppmu-v2")) {
> +				struct devfreq_event_dev edev;
> +				int id;
> +				/* Not all registers take the same value for
> +				 * read+write data count.
> +				 */
> +				edev.desc = &desc[j];
> +				id = exynos_ppmu_find_ppmu_id(&edev);
> +
> +				switch (id) {
> +				case PPMU_PMNCNT0:
> +				case PPMU_PMNCNT1:
> +				case PPMU_PMNCNT2:
> +					desc[j].data_type = PPMU_V2_RO_DATA_CNT
> +						| PPMU_V2_WO_DATA_CNT;
> +					break;
> +				case PPMU_PMNCNT3:
> +					desc[j].data_type =
> +						PPMU_V2_EVT3_RW_DATA_CNT;
> +					break;
> +				}
> +			} else {
> +				desc[j].data_type = PPMU_RO_DATA_CNT |
> +					PPMU_WO_DATA_CNT;
> +			}
> +		}
>   
>   		j++;
>   	}
> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
> index 4db00b0..cc160b1 100644
> --- a/include/linux/devfreq-event.h
> +++ b/include/linux/devfreq-event.h
> @@ -81,14 +81,20 @@ struct devfreq_event_ops {
>    * struct devfreq_event_desc - the descriptor of devfreq-event device
>    *
>    * @name	: the name of devfreq-event device.
> + * @data_type	: the data type which is going to be counted in the register.
>    * @driver_data	: the private data for devfreq-event driver.
>    * @ops		: the operation to control devfreq-event device.
>    *
>    * Each devfreq-event device is described with a this structure.
>    * This structure contains the various data for devfreq-event device.
> + * The data_type describes what is going to be counted in the register.
> + * It might choose to count e.g. read requests, write data in bytes, etc.
> + * The full supported list of types is present in specyfic header in:
> + * include/dt-bindings/pmu/.
>    */
>   struct devfreq_event_desc {
>   	const char *name;
> +	u32 data_type;
>   	void *driver_data;
>   
>   	const struct devfreq_event_ops *ops;
> 
