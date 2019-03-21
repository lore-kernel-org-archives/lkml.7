Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00397C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75CF21915
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kUJv5YbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfCULDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:03:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35699 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbfCULDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:03:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190321110313euoutp02dbd0d10ff700425e337ea3aa90fa58d0~N9GybF11a1807518075euoutp02Y
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:03:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190321110313euoutp02dbd0d10ff700425e337ea3aa90fa58d0~N9GybF11a1807518075euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553166193;
        bh=qfcxdAoydAnEf7myJgMS4Qzf3Cb5Gp2H8XmQpuXa7tc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kUJv5YbJT3+rOV6/M4bw05mvRVtH+YRwDQKi8LPGlQp1xzS8s0Ng4s9pXkMzE/yXV
         ul62oPCrCCOTZEnTq7t4W+m70nK6HnDp9mOenUREGr1FUiEkDqghYPlQXqYIlpEszq
         zzghow7g78w4N6aos4CQp6/Q6eX7Btv6WlrOsnnM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190321110313eucas1p1eb5babedbc4132022d9b83df56cc66fb~N9GyFIQq01549215492eucas1p1J;
        Thu, 21 Mar 2019 11:03:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A6.1A.04441.17F639C5; Thu, 21
        Mar 2019 11:03:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190321110312eucas1p1012136d83bf2c38358a84573df113766~N9GxX5ybV2596525965eucas1p1S;
        Thu, 21 Mar 2019 11:03:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190321110312eusmtrp17c069d1ec56ee5862517ffab5a341160~N9GxMp04J2471724717eusmtrp1C;
        Thu, 21 Mar 2019 11:03:12 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-02-5c936f71a771
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6D.B8.04128.07F639C5; Thu, 21
        Mar 2019 11:03:12 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190321110311eusmtip28369a9275015794cfb63772676f5e1ab~N9GwtfSR10966909669eusmtip2_;
        Thu, 21 Mar 2019 11:03:11 +0000 (GMT)
Subject: Re: [PATCH] xen, fbfront: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        xen-devel <xen-devel@lists.xenproject.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ca45f983-9a42-6326-3c9a-5e239ddc4e46@samsung.com>
Date:   Thu, 21 Mar 2019 12:03:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <6675f2ed-6916-2be5-fb60-39c9436f53f7@embeddedor.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djPc7qF+ZNjDPqW81ms/fiWxeLK1/ds
        Flv3qFqc6c61ONH3gdXi8q45bBbft0xmcmD3mN1wkcVj3UFVj52z7rJ73O8+zuRx+MMVFo/P
        m+QC2KK4bFJSczLLUov07RK4Mq5fbGcrmClQ8fzWGfYGxq88XYwcHBICJhKLzuZ2MXJxCAms
        YJQ48GQ5axcjJ5DzhVHi3f9iiMRnRonG/Q8YYRr+LquHiC9nlPhx6jw7hPOWUeLb0kfsIN3C
        Ai4SR668ZwGxRQSMJGbP6GYFKWIWeMgo0XF+IjNIgk3ASmJi+ypGEJtXwE6isXcNWAOLgKrE
        u6PL2EC2iQpESPSfUYcoEZQ4OfMJC0iYU8BJ4kqzAUiYWUBeonnrbGaQ8RICq9gl1m79DzZS
        AuiGa/u3skPYwhKvjm+BsmUkTk/uYYFoWMco8bfjBVT3dkaJ5ZP/sUFUWUscPn6RFWQbs4Cm
        xPpd+hBhR4nFE2YwQUKCT+LGW0GII/gkJm2bzgwR5pXoaBOCqFaT2LBsAxvM2q6dK5khbA+J
        havfs01gVJyF5LNZSN6ZhbB3ASPzKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMBUc/rf
        8U87GL9eSjrEKMDBqMTDG+EwKUaINbGsuDL3EKMEB7OSCO+u6MkxQrwpiZVVqUX58UWlOanF
        hxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODilGhj9vjDE3Y/cN/nJmgsLuPbZvkjYp2AU
        /MB52quFTP1mrnxv/2qu3TZnuqvk659nD/m7CJ2vP+P3JsDg4kXDx+z7VtoGSrvNSDz9Z8vb
        X/HlxfNvWn1IW//43xSzGyJeTHvNJkdc21w5280//53h0yLWnd681coRxdMEZ+09sWnLwigZ
        7k9lgWc1lFiKMxINtZiLihMB/eIMJzEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7oF+ZNjDL7vFLJY+/Eti8WVr+/Z
        LLbuUbU4051rcaLvA6vF5V1z2Cy+b5nM5MDuMbvhIovHuoOqHjtn3WX3uN99nMnj8IcrLB6f
        N8kFsEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        ZVy/2M5WMFOg4vmtM+wNjF95uhg5OCQETCT+LqvvYuTiEBJYyigxaeEydoi4jMTx9WVdjJxA
        prDEn2tdbBA1rxklDk6YwQKSEBZwkThy5T2YLSJgJDF7RjcrRNFbRolld9awgDjMAg+BOvat
        ZQepYhOwkpjYvooRxOYVsJNo7F0D1s0ioCrx7ugyNhBbVCBC4tbDDhaIGkGJkzOfsIBcxCng
        JHGl2QAkzCygLvFn3iVmCFteonnrbOYJjIKzkHTMQlI2C0nZAkbmVYwiqaXFuem5xUZ6xYm5
        xaV56XrJ+bmbGIFxtO3Yzy07GLveBR9iFOBgVOLhXWAyKUaINbGsuDL3EKMEB7OSCO+u6Mkx
        QrwpiZVVqUX58UWlOanFhxhNgX6YyCwlmpwPjPG8knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC
        6YklqdmpqQWpRTB9TBycUg2Msxda3E9el39ezY7/Klsl51sZuVXVGt/e11ioaX4VTF83e7Lm
        z/VHLs3vsOIzSP126Iz8FKvoSf1/Z+2e7zfz4EV+GTHb30sKi2caSPZkP7Z8skxgnWm7CWPf
        go4tJRdSFKfu8uZ557/l72IV7Zl1ZW4T152YbLTr5rOlLsetDy5o5FBett52kxJLcUaioRZz
        UXEiAPrWtgW5AgAA
X-CMS-MailID: 20190321110312eucas1p1012136d83bf2c38358a84573df113766
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190320200813epcas3p20887ed1e3e3f1542f67f0b664f777a8c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190320200813epcas3p20887ed1e3e3f1542f67f0b664f777a8c
References: <20190227205303.GA1231@embeddedor>
        <f8ff03de-9d7c-233a-cd86-37269667db0c@gmail.com>
        <CGME20190320200813epcas3p20887ed1e3e3f1542f67f0b664f777a8c@epcas3p2.samsung.com>
        <6675f2ed-6916-2be5-fb60-39c9436f53f7@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 03/20/2019 09:08 PM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping:
> 
> Who can take this?

I'll take this for v5.2.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Thanks
> --
> Gustavo
> 
> On 2/28/19 5:51 AM, Oleksandr Andrushchenko wrote:
>> +Xen-devel list
>>
>> On 2/27/19 10:53 PM, Gustavo A. R. Silva wrote:
>>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>>> cases where we are expecting to fall through.
>>>
>>> This patch fixes the following warning:
>>>
>>> drivers/video/fbdev/xen-fbfront.c: In function ‘xenfb_backend_changed’:
>>> drivers/video/fbdev/xen-fbfront.c:678:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>     if (dev->state == XenbusStateClosed)
>>>        ^
>>> drivers/video/fbdev/xen-fbfront.c:681:2: note: here
>>>    case XenbusStateClosing:
>>>    ^~~~
>>>
>>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>>
>>> Notice that, in this particular case, the code comment is modified
>>> in accordance with what GCC is expecting to find.
>>>
>>> This patch is part of the ongoing efforts to enable
>>> -Wimplicit-fallthrough.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>   drivers/video/fbdev/xen-fbfront.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
>>> index 6a4bbc9e1fb0..a3d6b6db221b 100644
>>> --- a/drivers/video/fbdev/xen-fbfront.c
>>> +++ b/drivers/video/fbdev/xen-fbfront.c
>>> @@ -677,7 +677,7 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
>>>       case XenbusStateClosed:
>>>           if (dev->state == XenbusStateClosed)
>>>               break;
>>> -        /* Missed the backend's CLOSING state -- fallthrough */
>>> +        /* fall through - Missed the backend's CLOSING state. */
>>>       case XenbusStateClosing:
>>>           xenbus_frontend_closed(dev);
>>>           break;
