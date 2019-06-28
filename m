Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B981C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373722063F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jt4uE0Aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfF1MxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:53:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35215 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfF1MxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:53:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190628125312euoutp013cd84edf06846a81abffe93c2e9d7a1d~sXeE7XE5k3015130151euoutp01e
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:53:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190628125312euoutp013cd84edf06846a81abffe93c2e9d7a1d~sXeE7XE5k3015130151euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561726392;
        bh=KaumQltM0TQXsxUYD5nd8HElvlSt7Uf+bry2dirxe/E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jt4uE0AqVFtrgrD/wA6LNimTv/iGmiRgOOuBtKAzID9TQ3c355q//eGLpsmhT5o+S
         St27mL5JdxqB6957DkusMskdUNG3z4gP3a2X5J9WwWEOe22gIRQSdPn0n0+QZ0Z+0u
         DHyphDQ/Rc91wUVHS1f5+zmQ7x64Yd5xxr4dDA3A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190628125312eucas1p131164f69bbc54a06a3121abf7907d217~sXeESNh_33049630496eucas1p1Y;
        Fri, 28 Jun 2019 12:53:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F0.B1.04325.7BD061D5; Fri, 28
        Jun 2019 13:53:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190628125311eucas1p1dfa2eedb5cecdd390471bc7ffae9e6dc~sXeDkYP_m3048730487eucas1p1K;
        Fri, 28 Jun 2019 12:53:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190628125311eusmtrp1599f6533f1c1b26d546ed726cd910664~sXeDWHsfB1299212992eusmtrp1U;
        Fri, 28 Jun 2019 12:53:11 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-c2-5d160db79421
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.73.04140.6BD061D5; Fri, 28
        Jun 2019 13:53:11 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190628125310eusmtip165c1bbd0f238dba9686fe08819eb584a~sXeC9SRKT0155001550eusmtip1D;
        Fri, 28 Jun 2019 12:53:10 +0000 (GMT)
Subject: Re: [PATCH 11/43] docs: console.txt: convert docs to ReST and
 rename to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <aab88ea1-0309-c18c-5ea6-3bdd72b45169@samsung.com>
Date:   Fri, 28 Jun 2019 14:53:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e8cee712026b042eacf3e003a57578d963f24ad8.1561723980.git.mchehab+samsung@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRT2t3t3d7eaXOfS4wofgwINnZXUzcKMIpb+E/0lmdhyF5V02q6u
        TAhJ8bFCzRnZtJoZTs0XZr7yhZlLJcXKCP1jEqImTMUHEb5yu0n+933nfOc754NDYpJOvoyM
        16QwWo0qQU6I8JaBP6P+rWK3qEDTnIKe7s1B9Le1RYLOrGgg6OLGJR5dnv0apz/lL/Hprx1l
        BL24nMej24ZeYaFC5dsqP2VTTR6h7HleK1BaH1p4yop8A1/Z0DyOK1eaPK8IronOqpmEeB2j
        VYTcEMWVjkQn/yLuFryoQxmohq9HQhKoIOhtm+TpkYiUUFUIOn7OII6sIpgfq3KoJNQKgnqb
        Zneic7ST4ERmBJ11kzhHbAimKoZ5dpUrFQEF49W4HUupkzA48tExgVEdPJjotgjsDYIKhsc5
        NciOxVQILFsXHMM4dRi6cmYd+MCOkXWgkc9pXGDw2bTDVEipYNRQ6vDBKHeYmH7J47AXtNrK
        MO7UIQFMmGR6RO7gi7C+cJ0ru8K8pVnA4UMwbHjkCABUPYLN3DmMI60IzIYtglOdgQ+WMb7d
        CKN8oaFDwZXPQ7fRhnH+zvDD5sKd4AxFLU//lcWQmy3h1EegsbKR2F2rb6/GCpHcuCeYcU8Y
        454wxv97TQivQe5MKpsYy7AnNMydAFaVyKZqYgNikhKb0M5PDW9Z1tpQ98bNPkSRSL5fbBK5
        RUn4Kh2bltiHgMTkUrHHiDRKIlar0u4x2qRobWoCw/ahgyQudxenO01FSqhYVQpzi2GSGe1u
        l0cKZRlIWaIgVhNCmeOV6wuBEWVdFybYpbDb4ZdBGvK+Nl9Hm9MNPpufzcFSgWY6a8O38Ci5
        nSldxNzfCLKKesaLw2Vhv32u6urUQftkJfLS4gB1P1PuOfsuZMb7tNAqHXsQ5q25FBOHpek9
        7kduFza3t+qs3528ZvxNT5b7mVPnvshxNk51zA/Tsqq/qD1PJ08DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7rbecViDdYlWjw50M5oceXrezaL
        5sXr2SymbPjAZLGwbQmLxYm+D6wWl3fNYbN4/6mTyWLHqUXMDpwem1doeWxa1cnmsX/uGnaP
        +93HmTwW901m9Vi/5SqLx+dNcgHsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFW
        RqZK+nY2Kak5mWWpRfp2CXoZs8/FF7xkq+ift5axgXEVaxcjJ4eEgInEnvN72LoYuTiEBJYy
        SjxbO4uxi5EDKCEjcXx9GUSNsMSfa11QNa8ZJR63LGUHSQgLREg8alrIBmKLCJhJnDx3FMxm
        FtjDJLGzVwWi4QWjxL/GXYwgCTYBK4mJ7avAbF4BO4lP998xgdgsAqoSe9ufg9miQEPPvF/B
        AlEjKHFy5hMwm1MgUeL85NnsEAvUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGoVlI2mchaZmF
        pGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAuNy27GfW3Ywdr0LPsQowMGoxMO7
        gEssVog1say4MvcQowQHs5IIr+Q5kVgh3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgemjLyS
        eENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYyTvkWxtE84I+66JfF5
        0OSfHBZyE/Zce3jybEGfaeGXqpVxrqdWVHk9nLet/FFx1d+DrZZZRkoi9mfmLJwQvZVPYumR
        J7wnDop29v1N8lppxnRW8ZPulxP7S5t8fgsePxR+fYOQXfGsVVsPP+9zjb/Pup7t8ZTYgxs0
        zcX4Hm0X2uLX+HhR9tp4JZbijERDLeai4kQAuhltmuECAAA=
X-CMS-MailID: 20190628125311eucas1p1dfa2eedb5cecdd390471bc7ffae9e6dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190628122050epcas1p28436f681c27ed04495778771e032c6de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190628122050epcas1p28436f681c27ed04495778771e032c6de
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
        <CGME20190628122050epcas1p28436f681c27ed04495778771e032c6de@epcas1p2.samsung.com>
        <e8cee712026b042eacf3e003a57578d963f24ad8.1561723980.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/28/19 2:20 PM, Mauro Carvalho Chehab wrote:
> Convert this small file to ReST in preparation for adding it to
> the driver-api book.
> 
> While this is not part of the driver-api book, mark it as
> :orphan:, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  .../console/{console.txt => console.rst}      | 63 ++++++++++---------
>  Documentation/fb/fbcon.rst                    |  4 +-
>  drivers/tty/Kconfig                           |  2 +-
>  3 files changed, 38 insertions(+), 31 deletions(-)
>  rename Documentation/console/{console.txt => console.rst} (80%)
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
