Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D78FC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4D1223BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pLNpkUwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbfGWPgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:36:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42302 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbfGWPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:36:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190723153648euoutp020b6b267343e738daa7b3e64cdc92bcab~0E1DUMWkt0992109921euoutp02P
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:36:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190723153648euoutp020b6b267343e738daa7b3e64cdc92bcab~0E1DUMWkt0992109921euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563896208;
        bh=faBCHNzVOX4xvur9dRjDf8G3Yu6o8drNcVqN2j+NkrM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pLNpkUwaOJkNXkQT7DYUsO0TnjgWqy+JNOQ+NWayqpziXUujF66p/tnTu3s/YA/U4
         fAjBnsEcDuBTjZmyZONUvwGFagLHnPyB7G1vNrHVr8o+t+Hg+304q0g+frBRPXvdW/
         2m7BYw0cpVlCCrI8+DHTc1IoMgSPmLdIbZNQSTrA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190723153648eucas1p2d1ab16e1997eb6c15d76d1fb7aea227f~0E1C6nA6L2270022700eucas1p2h;
        Tue, 23 Jul 2019 15:36:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D7.A4.04298.F89273D5; Tue, 23
        Jul 2019 16:36:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723153647eucas1p2b8f52335ab6d682ce17f59572c275d74~0E1CMCiO32268722687eucas1p2K;
        Tue, 23 Jul 2019 15:36:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723153646eusmtrp118486f2a4e90f3949510bfaa0deba07e~0E1B4yu5R2308223082eusmtrp1B;
        Tue, 23 Jul 2019 15:36:46 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-4f-5d37298fd48b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.D1.04140.E89273D5; Tue, 23
        Jul 2019 16:36:46 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190723153646eusmtip1e046a7d15dfcce43236fd92440ffdfc0~0E1BmaEB91331613316eusmtip1G;
        Tue, 23 Jul 2019 15:36:46 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: nvidia: Remove dead code
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     adaplas@gmail.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f44e60ed-2432-cf62-3426-d6c21e2081d7@samsung.com>
Date:   Tue, 23 Jul 2019 17:36:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zaNcNdxcT2WLOvL0LTX_R9ShRNx6UW6s4k+wc=Zj2MaSg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7r9muaxBrO3G1r87P7CZnHl63s2
        i2tXG5gtTvR9YLW4vGsOm8Wlj4eYHNg8ds66y+5xv/s4k8fnTXIBzFFcNimpOZllqUX6dglc
        Gdd/T2UpuMFccfaFVQPjL6YuRg4OCQETiStrTbsYuTiEBFYwSuzqXc8C4XxhlFj2bjEzhPOZ
        UeJN91KgDCdYx64fF6CqljNKzOu4yQrhvGWUWPzxDViVsIC1xN95j9hBbBEBbYm5h38xg9jM
        AksYJe7vFgex2QSsJCa2r2IEsXkF7CReLH8O1ssioCrR2NUFZosKREjcP7aBFaJGUOLkzCdg
        cU6BQImDGy6yQswUl7j1ZD4ThC0vsf3tHLCzJQQWsUtc6XnHDHG2i8Smf9/ZIGxhiVfHt7BD
        2DISpyf3sEA0rGOU+NvxAqp7O6PE8sn/oDqsJQ4fB1nHAbRCU2L9Ln1I6DlK3NovAGHySdx4
        KwhxA5/EpG3TmSHCvBIdbUIQM9QkNizbwAaztWvnSuYJjEqzkHw2C8k3s5B8Mwth7QJGllWM
        4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBKeb0v+OfdjB+vZR0iFGAg1GJh7eCyTxWiDWx
        rLgy9xCjBAezkghvYINZrBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC6YklqdmpqQWp
        RTBZJg5OqQbGWRYFLBM5Ixi95I+05/7UWMDwRXNlZdOGrWkzbs95/Es0Oa/fUf6lgXCCiPuv
        6li1uB2Hr3gu9vr0t05SbcNv4bePPX9Jc827eGTD/wdc1VMUm5t83dLcoi3qry5Pey1qEWaq
        095Sk7syUKvsRX/SkrfX48XW/9qYaOdxv2JHmZxb7q+blzOUWIozEg21mIuKEwEmhPUqLQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7p9muaxBg92WFj87P7CZnHl63s2
        i2tXG5gtTvR9YLW4vGsOm8Wlj4eYHNg8ds66y+5xv/s4k8fnTXIBzFF6NkX5pSWpChn5xSW2
        StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gdd/T2UpuMFccfaFVQPjL6Yu
        Rk4OCQETiV0/LrB0MXJxCAksZZR4cOkccxcjB1BCRuL4+jKIGmGJP9e62CBqXjNKTL59jg0k
        ISxgLfF33iN2EFtEQFti7uFfzCBFzAJLGCX+zpnLBNFxD8iZPJ0RpIpNwEpiYvsqMJtXwE7i
        xfLnLCA2i4CqRGNXF5gtKhAhceb9ChaIGkGJkzOfgNmcAoESBzdcZAWxmQXUJf7Mu8QMYYtL
        3HoynwnClpfY/nYO8wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLz
        czcxAuNq27GfW3Ywdr0LPsQowMGoxMNbwWQeK8SaWFZcmXuIUYKDWUmEN7DBLFaINyWxsiq1
        KD++qDQntfgQoynQcxOZpUST84Exn1cSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1
        ILUIpo+Jg1OqgXFt3Pdp13cp5Qa2HLv2/cOKOQe7bA/N25K77YWa3w6Oua4pSboWEW+3xPwX
        0BBl2cgW4PxfRfnMbzE7tZwrc6ZuuFlq+/VilKHAZSmDME8r2Rrj81f4o1O4063Wb+TTPGsV
        9fW7+4rW/QtcrtqJxj1yL9vzf+5G0+2qH4QixeQvZf1YpzH1fY0SS3FGoqEWc1FxIgCnAk3h
        wQIAAA==
X-CMS-MailID: 20190723153647eucas1p2b8f52335ab6d682ce17f59572c275d74
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722082707epcas1p389d73a3b7fd3bc960a4caf7bc42bd1e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722082707epcas1p389d73a3b7fd3bc960a4caf7bc42bd1e0
References: <1562782586-3994-1-git-send-email-jrdr.linux@gmail.com>
        <CGME20190722082707epcas1p389d73a3b7fd3bc960a4caf7bc42bd1e0@epcas1p3.samsung.com>
        <CAFqt6zaNcNdxcT2WLOvL0LTX_R9ShRNx6UW6s4k+wc=Zj2MaSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/19 10:26 AM, Souptick Joarder wrote:
> On Wed, Jul 10, 2019 at 11:41 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> This is dead code since 3.15. If there is no plan to use it
>> further, this can be removed forever.
> 
> Any comment on this patch ?
> 
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
