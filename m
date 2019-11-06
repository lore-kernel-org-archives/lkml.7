Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A0DC5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E386721D81
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AakFXTDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfKFCxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 21:53:47 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:51062 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbfKFCxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 21:53:46 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191106025343epoutp03ed7f08ac909af2359a27850ef20f9c3d~UczC-4IbM1274312743epoutp03P
        for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2019 02:53:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191106025343epoutp03ed7f08ac909af2359a27850ef20f9c3d~UczC-4IbM1274312743epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573008823;
        bh=c+htrw9iv9xikd9Wwvo79t4A1HBHKqx5O+jWGfGZChs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AakFXTDELDA3MD9jF32eUQen/Lflv9FjmswTv6uWInOBxTfW9Vp2yWdSSS0ing+3m
         j9gm8W91wL8JCTBdLt3FNhx5wBFDsnGQszY+cMxgHR41HxW9MeTf6WZyltsRQLXTIq
         vBcqVwvCe9gIZ/e11dI8B7QZayMv5azYJtdiT/74=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191106025342epcas1p1487f0bb0e8e66cfd9b96bb9200306e6b~UczCZiAiP1662516625epcas1p1N;
        Wed,  6 Nov 2019 02:53:42 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 477B1c0JwTzMqYlh; Wed,  6 Nov
        2019 02:53:40 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.A7.04135.3B532CD5; Wed,  6 Nov 2019 11:53:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191106025339epcas1p306fb60459576ef49b786d3722267296d~Ucy-twpnV1215812158epcas1p3K;
        Wed,  6 Nov 2019 02:53:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191106025339epsmtrp16de644898f53229341cab4841d289e45~Ucy-s5vYU1236412364epsmtrp1K;
        Wed,  6 Nov 2019 02:53:39 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-35-5dc235b331c5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.4D.25663.3B532CD5; Wed,  6 Nov 2019 11:53:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191106025339epsmtip1275826dcc7148b13f5f397a994defc1a~Ucy-gNNlK2316223162epsmtip15;
        Wed,  6 Nov 2019 02:53:39 +0000 (GMT)
Subject: Re: [PATCH] MAINTAINERS: Update myself as maintainer for DEVFREQ
 subsystem support
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, myungjoo.ham@samsung.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "chanwoo@kernel.org" <chanwoo@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh@kernel.org" <robh@kernel.org>, CPGS <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6a94e191-b460-bd9c-cae1-50ac93163eb1@samsung.com>
Date:   Wed, 6 Nov 2019 11:59:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <11401342.1EApItjJl2@kreacher>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRD127a7Ra2uVWRCouLqHzBgFyysBFABscaLRE2MsambslJCr3Rb
        zz/FVhQjKGgkVsT7AI1HWwniUa1GRVQQrPGOBhLFi1jAKMSj7Wrk35v53sybN99IRfILeKy0
        yGjlLEZWT+HDxQ034xWJHqVfrfjxNp2pfPpYzHT745maVqeYcRw9hzMdTTU40xMsw5gXJadw
        5n5Lu4T5faWRmB2l8tY9w1Tu+jJc5TtwhlB5A1vFqgpvPVL1uifm4yuLM3QcW8BZ4jij1lRQ
        ZCzMpBYs1eRolKkKOpGeyaRRcUbWwGVSuQvzE/OK9KGhqLi1rN4WSuWzPE9Nz8qwmGxWLk5n
        4q2ZFGcu0JtnmpN41sDbjIVJWpMhnVYokpUh4upiXWfAh5kbiPVb7OW4HQ1ItqMoKZAzYMsv
        N7YdDZfKyUYE7c4+QgiCCFyf7iIh+Ibg/pPB0Is0UlJRtUbIX0XwapcHF4IeBKed5/Fw37Gk
        Gr42XI9ojCPnQmdVtTiMRWQAg94SPoxxMgF8759G+KPJyRD43onCWEZmQWXNzwhfTE6Fcvth
        SVg4mlwBLf2sQBkDzfu6IpQochq0N1UjoX0MPO86iAl4Ejgu7heFZwPSQUD/DQcSDOTCg7LV
        gv2x8OGOlxBwLHTvLP2LN0Fd8y1cqN2GwOtr+7uvFPAd342F+4jIeDjXNF1IT4ZLgweQgGVg
        vzBICDOMgi/9OySCrAy2lcoFyhToePMK24WmuIa4cQ1x4BriwPVf7BAS16PxnJk3FHI8bU4e
        +tduFDnXhNRGdOThQj8ipYgaKRu27oZaLmHX8hsMfgRSETVOtqoilJIVsBs2chaTxmLTc7wf
        KUO7rhTFRmtNoeM3WjW0MjklJYWZQacqaZqKkc05eVwtJwtZK1fMcWbO8q8Ok0bF2lHRQM/R
        2qRHvTvUDrc24Z0HrqVNmz/ho0er8Gb3XQkS5t0j6k5kR2eNOjlr75K8D2Myvr6sCrTr6lpK
        aksN/ntdi+0xPOGsf5G++XXrl2Wfzw5Qv2/P1tZa+iYs0n1qbp0nOpZ9k2tOCz6ZmtvWnZOb
        vTyQv8f57vLZBb22pLdB/VVKzOtYOkFk4dk/noMqU8QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnO5m00OxBjOvSVtMvHGFxeLlIU2L
        OedbWCyaF69ns7i8aw6bxftPnUwWtxtXsFmcOX2J1eL/nh3sDpweW1beZPLYtKqTzWP/3DXs
        HluutrN49G1ZxejxeZNcAFsUl01Kak5mWWqRvl0CV8bjq/uZCraxV7Q29LI1MP5i7WLk4JAQ
        MJHom5TWxcjJISSwm1Fi4yklEFtCQFJi2sWjzBAlwhKHDxd3MXIBlbxllFh17Cc7SI2wQKzE
        x20HWEFsEQFXiceTprOAFDELXGeSmDutmw2i4x5Qx891TCBVbAJaEvtf3GADsfkFFCWu/njM
        CGLzCthJTJzzlwXEZhFQkehtWAg2VVQgQuL59htQNYISJ2c+AavhFNCWuLRrOlicWUBd4s+8
        S8wQtrjErSfzmSBseYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCUl1qu
        V5yYW1yal66XnJ+7iREcaVpaOxhPnIg/xCjAwajEw8tQfjBWiDWxrLgy9xCjBAezkghvTB9Q
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA2PVr/rznfXT
        u9dveG4k/LDFn7vSJy7XYcm6Bd5Tb+W9lOfnMz9lwBFyOP1jQXfvJnlORmFXi7dMQtPOnvhj
        6KvGbxGr8ntRdb3J14z4JLdzZw5GGFl0nPtUzZ5waoeFS+/1O6cyv6TXRK/bWSS1a41xS3/3
        BZdJG57WuW17k/sk8GPYw6Pb+ZRYijMSDbWYi4oTAeliQQCwAgAA
X-CMS-MailID: 20191106025339epcas1p306fb60459576ef49b786d3722267296d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191105053547epcas1p248c5a77579a8dd6fbd3639a12f3ca4c5
References: <1019298652.01572934681167.JavaMail.epsvc@epcpadp2>
        <CGME20191105053547epcas1p248c5a77579a8dd6fbd3639a12f3ca4c5@epcms1p2>
        <1019298652.01572945181528.JavaMail.epsvc@epcpadp2>
        <11401342.1EApItjJl2@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 11. 6. 오전 1:44, Rafael J. Wysocki wrote:
> On Tuesday, November 5, 2019 8:35:05 AM CET MyungJoo Ham wrote:
>>> Update myself to the DEVFREQ entry as maintainer from reviewer and
>>> the git repository information to manage the devfreq patches. I've been
>>> reviewing and tesing the devfreq support for the couple of years as reviewer.
>> >From now, I'll help and reiview the devfreq as maintainer.
>>>
>>> Suggested-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>>
>>
>> Thanks a lot, Chanwoo!
> 
> I can take this one if no one is against that.

Thanks for picking up.

> 
> I will be expecting devfreq pull requests from Chanwoo going forward.
> 

After you applied it, If it's not late, I'll send the pull-request
of devfreq for v5.5. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
