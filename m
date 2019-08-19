Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEA3C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940D12064A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qK1akU1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfHSOF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:05:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34967 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfHSOF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:05:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190819140557euoutp01c23fa4ffbd3d55a763e674e46546b7fb~8WAcCrTrz1730517305euoutp01W
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:05:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190819140557euoutp01c23fa4ffbd3d55a763e674e46546b7fb~8WAcCrTrz1730517305euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566223557;
        bh=98R+ncZrf3D3LHlzj47ZHJE47dDbcFjIanWT4RkYYs8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qK1akU1SlNAlThXPnvVK8aWJu2JU9APlCLI5PyQNEtpTrq99h/JwvsZOMQdKnK4Nv
         sc/ZYkUFvWfqBLeOPFOr/8iCL9CN3S1K3CauqcYNKXldxv5TkzA00ubk/n2N6DZqw8
         D/PhBWaslyEUOEGfeAZChpJSwHBSHGcKhkznpr+0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190819140557eucas1p2bcf8dc2a0a8c16dbaef13d2ae8ee11ff~8WAbtqphz0936409364eucas1p2_;
        Mon, 19 Aug 2019 14:05:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 08.64.04374.4CCAA5D5; Mon, 19
        Aug 2019 15:05:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190819140556eucas1p1c0dd0c9e196e16a5684ede4a57a16172~8WAa_yS8e1875818758eucas1p1K;
        Mon, 19 Aug 2019 14:05:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190819140556eusmtrp21804a7ef133f7c76e2973a9f1882a8d3~8WAav-qZr3227232272eusmtrp2B;
        Mon, 19 Aug 2019 14:05:56 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-2e-5d5aacc43762
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.55.04117.4CCAA5D5; Mon, 19
        Aug 2019 15:05:56 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190819140555eusmtip1eeaef4dc2e639d3ba5a5fc7adeb794c3~8WAaboXs80802708027eusmtip1i;
        Mon, 19 Aug 2019 14:05:55 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev:via: Remove dead code
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <0a2fd868-322a-d0cd-ac24-97a36c5af54e@samsung.com>
Date:   Mon, 19 Aug 2019 16:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYrX-5d8yYVwesYBPWQZK4iXPPv=2w7dqBtHvF9c1WJHA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87pH1kTFGnz5bm5x5et7NovOmdcY
        La5dbWC2ONH3gdXi8q45bA6sHjtn3WX3+PAxzuN+93Emj8+b5AJYorhsUlJzMstSi/TtErgy
        jj5eyFjwi7Xi2bEprA2Md1i6GDk5JARMJBqmvWfqYuTiEBJYwSgx7cV9ZgjnC6NEx52rjBDO
        Z0aJ03dPssO03FxxG6xdSGA5o8TbyeEQRW8ZJZYfWs4KkhAWMJc4e+w2E4gtIqAtMffwL2YQ
        m1mgSmLN8y1gNWwCVhIT21cxgti8AnYS1y6vZAOxWQRUJa50bwBbICoQIXH/2AZWiBpBiZMz
        n4DFOQUCJWbcPsoGMVNc4taT+UwQtrzE9rdzwF6QEJjMLnHs0nSoR10k1t3/ywRhC0u8Or4F
        6hsZif875zNBNKxjlPjb8QKqezvQO5P/sUFUWUscPn4R6AwOoBWaEut36UOEHSWWnFzNDBKW
        EOCTuPFWEOIIPolJ26ZDhXklOtqEIKrVJDYs28AGs7Zr50rmCYxKs5C8NgvJO7OQvDMLYe8C
        RpZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgUnm9L/jX3cw7vuTdIhRgINRiYfXY1pU
        rBBrYllxZe4hRgkOZiUR3oo5QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNT
        UwtSi2CyTBycUg2MHEWdPkHGF6vYVzDtOL6iIyfxd5TG08VX9KoOHv/alXdC7b7ThHk/m9do
        7HnxTPbyT0Zjo0mB76yXifhuE5TXN5Za8CxSadex7kafgypc3kvXMPPunHX5neAib50+d7Z3
        /qHyt0646z6SMM9l9+u/rnCxuU/2oWPywZl/+NerKsc+fvnw004fJZbijERDLeai4kQAa5EB
        BS4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7pH1kTFGnRvZrO48vU9m0XnzGuM
        FteuNjBbnOj7wGpxedccNgdWj52z7rJ7fPgY53G/+ziTx+dNcgEsUXo2RfmlJakKGfnFJbZK
        0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZRx8vZCz4xVrx7NgU1gbGOyxd
        jJwcEgImEjdX3AazhQSWMkp83qXWxcgBFJeROL6+DKJEWOLPtS42iJLXjBKr+4tAbGEBc4mz
        x24zgdgiAtoScw//YgaxmQWqJM7OugJkcwHVv2GS2L1mMSNIgk3ASmJi+yowm1fATuLa5ZVg
        Q1kEVCWudG8Au0FUIELizPsVLBA1ghInZz4BszkFAiVm3D7KBrFAXeLPvEtQy8Qlbj2ZzwRh
        y0tsfzuHeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgRG1
        7djPLTsYu94FH2IU4GBU4uH1mBYVK8SaWFZcmXuIUYKDWUmEt2IOUIg3JbGyKrUoP76oNCe1
        +BCjKdBzE5mlRJPzgdGeVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mD
        U6qB8bCTi77a3TU9n5qCJ/gWdjk8nXsmdvEVw49ZGnazK3yyr62/Okle9UmfkZK0dArDHn9D
        OyabaT7n1k/X4xE9UbhwU7DLjDKdC66ef6w4VfRc9x1h8ZkQ8C55aq/gClNPd0btt27tc002
        CkX8cmK/oHzTwXp+eGrtpGURL6QWrUnXfir3LHSeEktxRqKhFnNRcSIA1AlZcb4CAAA=
X-CMS-MailID: 20190819140556eucas1p1c0dd0c9e196e16a5684ede4a57a16172
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190818165955epcas2p4d3c25b533b9ca5419c3a6e397be56139
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190818165955epcas2p4d3c25b533b9ca5419c3a6e397be56139
References: <1564515200-5020-1-git-send-email-jrdr.linux@gmail.com>
        <CAFqt6zb5ySDbkHVpPkOKHTrF8jFuNh=dXtnwPKO6TuEHBCkYgg@mail.gmail.com>
        <CAFqt6zYsA_0YpZcZ8+LrMEjeWDJ5mwUDJNvqOW1H4ewgKbp+aQ@mail.gmail.com>
        <CGME20190818165955epcas2p4d3c25b533b9ca5419c3a6e397be56139@epcas2p4.samsung.com>
        <CAFqt6zYrX-5d8yYVwesYBPWQZK4iXPPv=2w7dqBtHvF9c1WJHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/18/19 6:59 PM, Souptick Joarder wrote:
> On Mon, Aug 12, 2019 at 5:37 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> On Wed, Aug 7, 2019 at 2:11 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>>
>>> On Wed, Jul 31, 2019 at 12:59 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>>>
>>>> This is dead code since 3.15. If there is no plan to use
>>>> it further, this can be removed forever.
>>>>
>>>
>>> Any comment on this patch ?
>>
>> Any comment on this patch ?
> 
> If no comment can we get this in queue for 5.4 ?
> 
>>
>>>
>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
