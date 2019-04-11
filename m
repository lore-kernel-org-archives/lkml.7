Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEC7218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TM09KqEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDKX3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:29:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33553 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfDKX3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:29:44 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190411232940epoutp03c0aeb5480f589e389c30f48704a4588a~Uj1hOaqKY2376123761epoutp03W
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 23:29:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190411232940epoutp03c0aeb5480f589e389c30f48704a4588a~Uj1hOaqKY2376123761epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555025380;
        bh=eeA7iT8mPuMquIA0Pg7p9LbihwviJC895bKXwhRkWUs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TM09KqEALmWhyh5Se48XP//ANqUInIL+svEC50a7N3pHxXcGFafg8XDxCr0gX02Ey
         wTDc/7+nc0mEN5gpzC9iuZzbpK8ZXrtxdwtG6aCYgL8Ay4ZyiJ7bRJpsqD468FOaDm
         s7v5wFDDFj71QrlEj5gXZAs9fbNxJolYAUuuUDtc=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190411232939epcas1p4d00e44df9ee4025fdaa4e3b5f4a04810~Uj1fsaLr43248932489epcas1p4w;
        Thu, 11 Apr 2019 23:29:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.ED.04257.3EDCFAC5; Fri, 12 Apr 2019 08:29:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190411232938epcas1p173fb31206ad30eccb209ebdbd9d61aee~Uj1fOqiyu1959919599epcas1p1Y;
        Thu, 11 Apr 2019 23:29:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190411232938epsmtrp2fcf7192890bb344b5313f8251c3d2bfe~Uj1fN_L481129211292epsmtrp2g;
        Thu, 11 Apr 2019 23:29:38 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-0a-5cafcde341d7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.93.03662.2EDCFAC5; Fri, 12 Apr 2019 08:29:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190411232938epsmtip1170ab88479e6aab550a21bd3da0fe8a8~Uj1fDzKSR2185521855epsmtip1b;
        Thu, 11 Apr 2019 23:29:38 +0000 (GMT)
Subject: Re: [PATCH v2] extcon: axp288: Add a depends on ACPI to the Kconfig
 entry
To:     Yue Haibing <yuehaibing@huawei.com>, myungjoo.ham@samsung.com,
        wens@csie.org, hdegoede@redhat.com, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c11e2ae8-d785-902d-1469-4ff538ebe2ab@samsung.com>
Date:   Fri, 12 Apr 2019 08:30:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404141748.27048-1-yuehaibing@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe7a761WbPc3K0z7UvBWhoe6ms7vSMJJY5AejiArDLu6m4t66
        d0YWxCxLW1HZC+EKCiU0Ixa2wkk2MMssM7OEsjfJqCjT1LIUrLbdRX77nfOc/znn/zwPJVfV
        k2qq0GLnBQtnoskI4uadOG1C/yN3jnZgmGAH2s7K2NrbxxH7tOk8yb4srSPZjofdCna85bGM
        ffXjI5ERZrj27orCUNb6VWEYut1DGjw95YThmKceGUYb5mWTW4vSCnjOyAsa3pJnNRZa8tPp
        dRtyV+fqUrVMAqNnl9EaC2fm0+nMrOyENYUm/y60ZhdnKvansjlRpJNWpgnWYjuvKbCK9nSa
        txlNNr0tUeTMYrElPzHPal7OaLVLdf7C7UUFTZUOZHNE7u7rLpM50G/KicIpwCnwzdkuc6II
        SoUbETjejIdJwQiCnwdrSSkYQzAy2qH4J2l8cFohHTQj+DT4NSQZQjDRWY2ciKKi8UaY7NAE
        BLPwHqgrbSICLMdpUNP1AAWYxPHg+/ScDPAMHAs9v/qDeSVeCX8ee4NM4EXgrngbrJmNN8Pb
        e9cUUs1MaK96H+wZjlfAUO0lUuofA73vL8gkng8HbpyTB3YDPErC8NhwyEEmeD/fCpM4Gj63
        eUKshtHBZlLivXC5vZWUxBUIPL6ukDgZfJdOyQIm5TgO3E1J0rAoGPxxVBFIA1ZCxSGVVL0A
        nva9lkk8F2rKD4faG8A5+ROdQLGuKXZcUyy4plhw/R92ERH1aA5vE835vMjYUqa+dgMK/tN4
        thHd6sxqQZhC9HRlXZo7R6Xgdokl5hYElJyepdxI+FNKI1eyhxesuUKxiRdbkM5/25Vy9ew8
        q//XW+y5jG5pcnIym8Kk6hiGjlG6M1bnqHA+Z+eLeN7GC/90Mipc7UCpXVssRyayfr2Oivyi
        37Cp7zuX6PAU6fRxwhMjbj1z/3KjfV9SGdoc51519/SKiOby9UpyTSKUXF/cOwfX7wgfcy2k
        e6Oqqk96Rd+kvKZb+NDmPbjW57LHXlUvyeio0l8ntf3ENjL21PojqnhT5rSGZy+808YHxN6d
        pTcrT+ynCbGAY+Llgsj9BTx3V/q9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO6js+tjDGY3K1m8OT6dyWL5vn5G
        i8u75rBZ3G5cwWZx5vQlVoufh84zWdz5+pzFgd1jw6PVrB4tR96yerzfd5XNY8vVdhaPvi2r
        GD0+b5ILYIvisklJzcksSy3St0vgytg1sYGxoIG74sGlFqYGxn8cXYycHBICJhI7Tk1hBbGF
        BHYzSrx+ygcRl5SYdvEocxcjB5AtLHH4cHEXIxdQyVtGia67D9hB4sICIRJ/zyiAlIsIVEnM
        7znPDGIzC9hILL5wihFi5H5GiadXMkBsNgEtif0vbrCB2PwCihJXfzwGq+EVsJP4f34nmM0i
        oCqxvuM+WI2oQITEmfcrWCBqBCVOznwCZnMKWEu8X76UDWKXusSfeZeg9opL3HoynwnClpdo
        3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjB
        MaWltYPxxIn4Q4wCHIxKPLwrbNbHCLEmlhVX5h5ilOBgVhLhDWEBCvGmJFZWpRblxxeV5qQW
        H2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCUamBsCH0itF7bavGBD+/thV/1aUzSWjJ3
        xq93j++dfWK4esb0h8/uBH97ZCn/S0nkP7thRO+lzGVB3ecufYx4op51+a7Q87N+cjwO9yu2
        ZkXZ5eT795wT8M+JE3M8f/Eho8A3Z87TSd1av+Ny2m69/rvYf/PMJz3fJ3Gf9rzlofqQ4VXq
        +/qVcVJnlViKMxINtZiLihMBwj4526UCAAA=
X-CMS-MailID: 20190411232938epcas1p173fb31206ad30eccb209ebdbd9d61aee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190404142002epcas1p1a86f6d0d5d1a694581630a99532af633
References: <20190404104222.23900-1-yuehaibing@huawei.com>
        <CGME20190404142002epcas1p1a86f6d0d5d1a694581630a99532af633@epcas1p1.samsung.com>
        <20190404141748.27048-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 4. 4. 오후 11:17, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> As Hans de Goede pointed, using this driver without ACPI
> makes little sense, so add ACPI dependency to Kconfig entry
> to fix a build error while CONFIG_ACPI is not set.
> 
> drivers/extcon/extcon-axp288.c: In function 'axp288_extcon_probe':
> drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
>     put_device(&adev->dev);
> 
> Fixes: 0cf064db948a ("extcon: axp288: Convert to use acpi_dev_get_first_match_dev()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: rework patch
> ---
>  drivers/extcon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 1ed4b45..de06faf 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -30,7 +30,7 @@ config EXTCON_ARIZONA
>  
>  config EXTCON_AXP288
>  	tristate "X-Power AXP288 EXTCON support"
> -	depends on MFD_AXP20X && USB_SUPPORT && X86
> +	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
>  	select USB_ROLE_SWITCH
>  	help
>  	  Say Y here to enable support for USB peripheral detection
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
