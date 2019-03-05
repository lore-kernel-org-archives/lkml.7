Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33105C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E886C20848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jrcqwknm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCELgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:36:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57501 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfCELgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:36:11 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190305113609euoutp013d1f66cf3a7c6b526d02b4aa7219b6b0~JDO_KGNuQ1772817728euoutp01P
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 11:36:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190305113609euoutp013d1f66cf3a7c6b526d02b4aa7219b6b0~JDO_KGNuQ1772817728euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551785769;
        bh=bJN4GpXkx2QuYAstq27vzyfQ/iRzO7UxcJWeDBEOgw4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jrcqwknmB6++pHsBhGW2zuavMdx9A9aBjrZCSfh5vV1fBxnCBKgAyY8spDk4RIOlw
         RNCstkeQFJ6QQTKwnn5pa2m1zkJpwJ7GotWhQfGDNC0Tl2zVgqX2NTYN1R7fZtMzHG
         tjFvS9reD6VhORJsvlrH0Ep8QCUJHU/+LibZoh14=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190305113608eucas1p1c6bac012af139a6e95c1249457fe6eb4~JDO9mWKTa0047200472eucas1p1R;
        Tue,  5 Mar 2019 11:36:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A7.4B.04294.82F5E7C5; Tue,  5
        Mar 2019 11:36:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190305113608eucas1p1be65d85922319d6c2a9601e433fb4af7~JDO8zVKFC0059700597eucas1p1J;
        Tue,  5 Mar 2019 11:36:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190305113607eusmtrp222d15b0140e6fe1975fbbd4f497e08c2~JDO8lMLY40972309723eusmtrp26;
        Tue,  5 Mar 2019 11:36:07 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-ec-5c7e5f28a967
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 97.CB.04128.72F5E7C5; Tue,  5
        Mar 2019 11:36:07 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190305113607eusmtip2d568d9944a721edc8c08fd41ff8d503e~JDO8RqOTE1830318303eusmtip2Y;
        Tue,  5 Mar 2019 11:36:07 +0000 (GMT)
Subject: Re: [PATCH] fbdev: mbx: fix a misspelled variable name
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <3568c648-2ef2-bd25-7918-3599b140f035@samsung.com>
Date:   Tue, 5 Mar 2019 12:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190304195249.971696-1-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7oa8XUxBpvnaln8nXSM3eLK1/ds
        Fs2L17NZnOj7wGpxedccNgdWj9+/JjF67J+7ht3jfvdxJo/Pm+QCWKK4bFJSczLLUov07RK4
        Ms50PWUp+MJecX5JZAPjYbYuRk4OCQETibb3e4FsLg4hgRWMEtMn3meFcL4wSjx5t4oZwvnM
        KLF2/2u4lm2vv7FAJJYzSlz5MJkJJCEk8J5R4tl1PRBbWMBeYvKZv+wgtoiAosTUF8/AJjEL
        TGaU+PfpHliCTcBKYmL7KkYQm1fATuLR9k9gcRYBFYnju3qA7uDgEBWIkOg/ow5RIihxcuYT
        FhCbE+iIR+9+gh3ELGAgcWTRHFYIW15i+9s5YLskBPrZJR5de8wOcbWLxNPZK6FsYYlXx7dA
        2TIS/3fOZ4JomM4o8ebXUhYIZz2jxJozx5ggqqwlDh+/yAphO0qcvt7OCHKdhACfxI23ghCb
        +SQmbZvODBHmlehoE4KoVpPYsGwDG8yurp0rmSFsD4neewcYJzAqzkLy2ywk/8xC8s8CRuZV
        jOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgQnl9L/jX3Yw7vqTdIhRgINRiYc3w6w2Rog1
        say4MvcQowQHs5II7x/xuhgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1ML
        UotgskwcnFINjD5v9Tq2WS/wVr76RXntGvHpZkbPN3FM4tleu7q3sEYlduL+1Gk3w7vvRly8
        /ug6x+VnkZzuUra+UW9Dnd9VGHM5lM+Wu9xpOXuPWp1CfZDZLj9Zsaj9Lxb9Ynk4acOpDcxp
        jC03dqxhf9rENDvNV/EY7+1D/TenvVz60WbLHucHopb3G8794VdiKc5INNRiLipOBADMjZEw
        JAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7rq8XUxBit2GFj8nXSM3eLK1/ds
        Fs2L17NZnOj7wGpxedccNgdWj9+/JjF67J+7ht3jfvdxJo/Pm+QCWKL0bIryS0tSFTLyi0ts
        laINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Ms50PWUp+MJecX5JZAPjYbYu
        Rk4OCQETiW2vv7F0MXJxCAksZZTo+H6BvYuRAyghI3F8fRlEjbDEn2tdbBA1bxklJt/6zAqS
        EBawl5h85i87iC0ioCgx9cUzZoiidkaJ3htzwTqYBSYzStx7voMJpIpNwEpiYvsqRhCbV8BO
        4tH2T2DdLAIqEsd39YBNFRWIkLj1sIMFokZQ4uTMJ2A2J9Cpj979BDubWUBPYsf1X6wQtrzE
        9rdzmCcwCs5C0jILSdksJGULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbJtmM/t+xg
        7HoXfIhRgINRiYc3w6w2Rog1say4MvcQowQHs5II7x/xuhgh3pTEyqrUovz4otKc1OJDjKZA
        T0xklhJNzgfGcF5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsYF
        Z1fO3pw7PdLv9wyGFXOSF/AdDtjz6+OML+qfbTK3Xm3jEOTKWt3wZtF3pW5Gi8B/BTy7+n7N
        1K2/aR55pP63ZCTjn56LM+0qK67s6fKv2li5slztumf+V5tT0vNd5sk5FpXtP9j3ja9+xmF3
        bc6UMoOoj4fXaj714NNJ11+sv2FD8Qy/wyuVWIozEg21mIuKEwEm4SEiqQIAAA==
X-CMS-MailID: 20190305113608eucas1p1be65d85922319d6c2a9601e433fb4af7
X-Msg-Generator: CA
X-RootMTR: 20190304195258epcas2p40c27a5bdcea32c4f03dfea58abc4cde8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190304195258epcas2p40c27a5bdcea32c4f03dfea58abc4cde8
References: <CGME20190304195258epcas2p40c27a5bdcea32c4f03dfea58abc4cde8@epcas2p4.samsung.com>
        <20190304195249.971696-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/04/2019 08:52 PM, Arnd Bergmann wrote:
> A recent cleanup introduced a build failure when a variable
> was spelled incorrectly:
> 
> In file included from drivers/video/fbdev/mbx/mbxfb.c:881:
> drivers/video/fbdev/mbx/mbxdebugfs.c: In function 'mbxfb_debugfs_init':
> drivers/video/fbdev/mbx/mbxdebugfs.c:217:2: error: 'mbfi' undeclared (first use in this function); did you mean 'mfbi'?
>   mbfi->debugfs_dir = dir;
>   ^~~~
>   mfbi
> drivers/video/fbdev/mbx/mbxdebugfs.c:217:2: note: each undeclared identifier is reported only once for each function it appears in
> drivers/video/fbdev/mbx/mbxdebugfs.c:213:21: error: unused variable 'mfbi' [-Werror=unused-variable]
>   struct mbxfb_info *mfbi = fbi->par;
>                      ^~~~
> 
> Fixes: 72aed9e31344 ("fbdev: mbx: fix up debugfs file creation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
