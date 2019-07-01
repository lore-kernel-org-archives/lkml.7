Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E36C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 01:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9C62146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 01:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KeerZoGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfGABYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 21:24:42 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25877 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGABYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 21:24:41 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190701012438epoutp02fc8e5260dc3a6353bc9128f3cd20f5fa~tJAvMMQaK0782207822epoutp02d
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2019 01:24:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190701012438epoutp02fc8e5260dc3a6353bc9128f3cd20f5fa~tJAvMMQaK0782207822epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561944278;
        bh=LTF7GLbOV/sLEYbnK81j+o/pFOF7izsWGUeXSMtoTXc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KeerZoGrmvh2q1P/XwAK10Rl9TOsyCk090dYNLb2iwtFXu8VXG3Jmwk8AmXmvPExU
         Sg6I/jLe14Au0lsDE/7kab4ImKXTFNhTkqMBerpRO85zHsZ2D8q6rWk1E9g8CdzpIz
         K/M7owwUg03gfT5g1TJnvd9f9zSRpQlEggZFJtnM=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190701012436epcas1p44a606629cb7d52c81ddb8c416e7eb701~tJAs4ynGz2703727037epcas1p4w;
        Mon,  1 Jul 2019 01:24:36 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.58.04139.FC0691D5; Mon,  1 Jul 2019 10:24:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190701012430epcas1p4b40cec12a0797f691166877670995ec9~tJAnuAHuT2009720097epcas1p4h;
        Mon,  1 Jul 2019 01:24:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190701012430epsmtrp10007494aeceabc6d075eadf6881bcf78~tJAntR2Hw0366303663epsmtrp1D;
        Mon,  1 Jul 2019 01:24:30 +0000 (GMT)
X-AuditID: b6c32a35-973ff7000000102b-e3-5d1960cfac05
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.6C.03692.EC0691D5; Mon,  1 Jul 2019 10:24:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190701012430epsmtip27515a266b35faabd18d5638914427df6~tJAniEj1-1755717557epsmtip2I;
        Mon,  1 Jul 2019 01:24:30 +0000 (GMT)
Subject: Re: [PATCH] misc: fsa9480: Delete this driver
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <49002e6c-5c70-e70d-3eaa-618407cfd33b@samsung.com>
Date:   Mon, 1 Jul 2019 10:27:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190630140302.16245-1-linus.walleij@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTURj09dhd0OpaQD8x0bL6QxuBLlAsKsYDTYMkknjGSOoGVkroZbcF
        0UQbMXJo8KpGVgHjRcQDRVRAsbEggkZUsAYJxgPvxCMqalDUrluVf/PNm8m8ee8jpMpSLJzI
        sjhYu4UxUViw7ELTZE3k7VVj0jQX3QrdwK4WXJd/uBrTuX9USnSdDQcw3bfrJdJZcv33/l1I
        X88/xPU99y9jek/ZSVz/qWZcqnxF9gwjy2SwdhVrSbdmZFkyE6kFiwxzDdp4DR1JJ+imUioL
        Y2YTqaSU1Mj5WSZ/OKXKYUxOP5XKcBwVPXOG3ep0sCqjlXMkUqwtw2RLsEVxjJlzWjKj0q3m
        abRGE6P1C1dlGzsedchse/C1l18Md6E2eTEKIoCMg94nbXgxCiaUZB2Ck7WtcnH4iOBdYw8S
        hy8IvANn/1lu9vRLxINGBJtdJTJxeI/Ad2OzRFCFkPFw79CmP45QshzBjm2OYkQQUnIO3DyX
        JNAYqQbPqy5MwCPICPB960UCVpAzobndiwtyGTkRqvaZBDqMXA6dtQ0ByUhoK30mE3CQX36s
        ZjsuYCk5GrqfVUhEPB7yz++XClcDsheDQ3dOS8QCSfDTtTWAQ+DN9VpcxOHwevuWAF4Px9ua
        MdFciKDWcyfQPhY8R3dLxC6TobohWqQjoP57GRKDh8O7vm1yQQKkAgq3KEXJBOh8/DAQOwYO
        FxRhOxDFD6rDD6rAD6rA/w87iGRVaBRr48yZLEfb6MF/XYP+rKVaW4fc7SleRBKIGqZw9UCa
        Us7kcHlmLwJCSoUqypr8lCKDyVvH2q0Gu9PEcl6k9T/2Tml4WLrVv+QWh4HWxsTGxuri6Hgt
        TVOjFYahD1YqyUzGwWazrI21//VJiKBwFxrycfayvIEod1f+hmTftbeff7nP8L767vgTS6qn
        L2w/0Mc77z7eOPalqqxybB/5dPW8p3Ljzhj1pdD8hpTCgeBhIQWt/U9yj/NOX3NKUfmk560J
        3UnrjnT/KtpbUTEF77hlyy3XL/3aUhJ8Sg5X0rvWpOrYD7fa867ylQXqKm2yZzEl44wMrZba
        OeY3zbZGY6wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXvdcgmSswf/nuhZ/Jx1jt2hevJ7N
        Ysqf5UwWl3fNYbP4cbyP2YHV4/evSYweO2fdZfe4c20Pm8f+uWvYPT5vkgtgjeKySUnNySxL
        LdK3S+DKuHT/EkvBVPaKPc/4GhhPsnYxcnJICJhInL7zi6mLkYtDSGA3o8TGZfuZIRKSEtMu
        HgWyOYBsYYnDh4tBwkICbxkl7p0MALGFBcwkrixqYgXpFRGYxyhxd/tZFpB6ZgEnidObXSBm
        TmSU+HHxICNIA5uAlsT+FzfYQGx+AUWJqz8eg8V5Bewkjpw7xA7SyyKgIrFqRg5IWFQgQqKv
        bTYbRImgxMmZT1hAbE6g8mWb+tlBbGYBdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDwLSfss
        JC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcNRoae5gvLwk/hCj
        AAejEg9vwx2JWCHWxLLiytxDjBIczEoivHMPA4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07
        FikkkJ5YkpqdmlqQWgSTZeLglGpgVBKzM+U+u/YIkyXLrYVbV66vi3hv0vLql/p2g6sc5xUW
        bb1YfXlrO2NXrdz3cIOed3qbtdnMdnqx3jKu0tbuindl3aBhaGyuxaZj9+GOs2lwT3Nvp8pW
        JtVkVk1ZU6epGWzR6mLSNyZxxugem+908MHaC76L3kp/Z3JtvdzZEN9pH+1/q02JpTgj0VCL
        uag4EQBCPsARlgIAAA==
X-CMS-MailID: 20190701012430epcas1p4b40cec12a0797f691166877670995ec9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190630140521epcas3p4f9a3ee4d4ef3a1f6f57a855ef0eedb40
References: <CGME20190630140521epcas3p4f9a3ee4d4ef3a1f6f57a855ef0eedb40@epcas3p4.samsung.com>
        <20190630140302.16245-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 19. 6. 30. 오후 11:03, Linus Walleij wrote:
> The FSA9480 has a new driver more appropriately located
> in the drivers/extcon subsystem. It is also more complete
> and includes device tree support. Delete the old misc
> driver.
> 
> Cc: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/misc/Kconfig                  |   9 -
>  drivers/misc/Makefile                 |   1 -
>  drivers/misc/fsa9480.c                | 547 --------------------------
>  include/linux/platform_data/fsa9480.h |  24 --
>  4 files changed, 581 deletions(-)
>  delete mode 100644 drivers/misc/fsa9480.c
>  delete mode 100644 include/linux/platform_data/fsa9480.h
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi

