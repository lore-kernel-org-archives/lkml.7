Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69850C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AD22147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e4yA5UhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfCSApE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:45:04 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:32415 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCSApD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:45:03 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190319004501epoutp04923b750d4e2ed25a78da2fa1aa8a4f2c~NNYcvMdyw0156301563epoutp04w
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 00:45:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190319004501epoutp04923b750d4e2ed25a78da2fa1aa8a4f2c~NNYcvMdyw0156301563epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552956301;
        bh=zg8UjjDRsydvRUzY+lMeWsNldQcfuojpEySIos3RfNM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=e4yA5UhJA/weOoysStEtv2n2Qz7m2So8LnRVTmPtAYWeh8PLpmd7AjKkDo5n4nBp6
         cRI8FDmI1S6GyJeL74zDj4vITEolPQtp+UVh1j5YxBI2JrVLU1OCKcIQGyJMG6xd3p
         IlebC+ludFHFuUa+bsa5Afw2ltW6P5lsOZ0pLa5I=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190319004458epcas1p1d98403fe05e2c736c6195181d2e52235~NNYZ7Iza61390813908epcas1p1a;
        Tue, 19 Mar 2019 00:44:58 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.5F.04108.68B309C5; Tue, 19 Mar 2019 09:44:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190319004454epcas1p481fd6f0f41aa016bd5b09ed912d78aef~NNYWYVNCJ2201322013epcas1p4m;
        Tue, 19 Mar 2019 00:44:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190319004454epsmtrp227cd6d51c951c5e533b748ad15e5b30e~NNYWXpdAF0955709557epsmtrp2g;
        Tue, 19 Mar 2019 00:44:54 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-53-5c903b86e4a9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.91.03692.68B309C5; Tue, 19 Mar 2019 09:44:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190319004454epsmtip2bb2b50b59369689d3cbebcf57d894500~NNYWKxrn00722907229epsmtip22;
        Tue, 19 Mar 2019 00:44:54 +0000 (GMT)
Subject: Re: [PATCH v1 2/2] extcon: mrfld: Introduce extcon driver for Basin
 Cove PMIC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ee02687f-059d-1d92-2d9f-ecd605c8ea41@samsung.com>
Date:   Tue, 19 Mar 2019 09:45:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318124653.GS9224@smile.fi.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTV7fNekKMwezNOha9TdOZLN4cBxKX
        d81hs7jduILNgcVj3slAj/f7rrJ59G1ZxejxeZNcAEtUtk1GamJKapFCal5yfkpmXrqtkndw
        vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5x
        ia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGizV/WAp2y1SsOtPE1sB4SKyLkZND
        QsBEoundUcYuRi4OIYEdjBKPn2xjAkkICXxilFgxRwXC/sYocWOFcBcjB1jDwxf8EPV7GSWu
        PbzMBuG8Z5R4d/oYC0iDsECExNMNl9hAbBEBc4l1kxaB2cwCBRLnjr4Eq2ET0JLY/+IGWJxf
        QFHi6o/HjCA2r4CdRGv/VLA4i4CqxORpy8EOEgWa+f7pbhaIGkGJkzOfgNmcQPP39txlgZgv
        LnHryXwmCFteonnrbGaQ4yQETrBJrGk+zwrxsovE7L7/LBC2sMSr41vYIWwpic/v9rJB2NUS
        K08eYYNo7mCU2LL/AlSzscT+pZOZQEHBLKApsX6XPsQyPol3X3tYISHEK9HRJgRRrSxx+cFd
        JghbUmJxeyfUeA+Jz/e2M05gVJyF5J1ZSF6YheSFWQjLFjCyrGIUSy0ozk1PLTYsMEWO602M
        4LSoZbmD8dg5n0OMAhyMSjy8AdP6Y4RYE8uKK3MPMUpwMCuJ8Np7AoV4UxIrq1KL8uOLSnNS
        iw8xmgJDeyKzlGhyPjBl55XEG5oaGRsbW5gYmpkaGiqJ8653cI4REkhPLEnNTk0tSC2C6WPi
        4JRqYCxg+hf2QVWZe3byd+3ZJqmtbNNkdh9ot9BMuPLXYEK9nMG8r19Yzi3tvXCKz+e27PdZ
        qm+NLB+vF7dMaJbSND617Wi1fvt9prib3/IVz76/EqxpWbjq+9utXzYrH7Dz928zuu5i7cz9
        d7Xw/IC+JXVfJ9Z23X2Vv5lb/BKvgZvBg7fR/5MlDiuxFGckGmoxFxUnAgCp3A9joQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvG6b9YQYg28/BCx6m6YzWbw5DiQu
        75rDZnG7cQWbA4vHvJOBHu/3XWXz6NuyitHj8ya5AJYoLpuU1JzMstQifbsErowXa/6wFOyW
        qVh1pomtgfGQWBcjB4eEgInEwxf8XYxcHEICuxkl+jf9Ye9i5ASKS0pMu3iUGaJGWOLw4WKI
        mreMEm9utDKB1AgLREg83XCJDcQWETCXWDdpEZjNLFAgMfvaQ3aIhmdMEuemTmcFSbAJaEns
        f3EDrIhfQFHi6o/HjCA2r4CdRGv/VLA4i4CqxORpy8EWiAItuHvxBQtEjaDEyZlPwGxOoGV7
        e+6yQCxTl/gz7xIzhC0ucevJfCYIW16ieets5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTn
        pucWGxYY5qWW6xUn5haX5qXrJefnbmIEx4iW5g7Gy0viDzEKcDAq8fCumNEfI8SaWFZcmXuI
        UYKDWUmE194TKMSbklhZlVqUH19UmpNafIhRmoNFSZz3ad6xSCGB9MSS1OzU1ILUIpgsEwen
        VAOjWIlk7pyXF9aJ7ahR0nkiU/9+blzNhnUT57/ZcMVingc/S44809u7qbsP1aXyKalwq+/k
        +/KF8Vr8xT8aGvnSk74+WjD5xk2fjSwP23j32Boask0OWrwzlT/aI+ttxgV5mWjWM5f3XqjY
        stLqjuJ98eq1/Vcf7nL3OxZ1I2BG8Kf+c8tEBetmK7EUZyQaajEXFScCALwEStWNAgAA
X-CMS-MailID: 20190319004454epcas1p481fd6f0f41aa016bd5b09ed912d78aef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190318101117epcas2p246ba2571549569d1ce18b829d6579bd3
References: <20190318095225.69200-1-andriy.shevchenko@linux.intel.com>
        <20190318095225.69200-2-andriy.shevchenko@linux.intel.com>
        <CGME20190318101117epcas2p246ba2571549569d1ce18b829d6579bd3@epcas2p2.samsung.com>
        <20190318101109.GP9224@smile.fi.intel.com>
        <3af26666-8913-c8bb-d2fb-64bd9ea0ec69@samsung.com>
        <20190318124653.GS9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 19. 3. 18. 오후 9:46, Andy Shevchenko wrote:
> On Mon, Mar 18, 2019 at 07:38:26PM +0900, Chanwoo Choi wrote:
> 
>> Thanks for comment. I add my comments
>> and then you have to rebase it on latest v5.0-rc1
>> because the merge conflict happen on v5.0-rc1.
> 
> Thanks for review, see my answers below.
> Non-answered items will be fixed accordingly.
> 
>>>> +config EXTCON_INTEL_MRFLD
>>>
>>>> +	tristate "Intel MErrifield Basin Cove PMIC extcon driver"
>>>
>>> ME -> Me (will be fixed)
>>>
>>>> +	depends on INTEL_SOC_PMIC_MRFLD
>>
>> This driver uses the regmap interface. So, you better to add
>> following dependency?
> 
>> - select REGMAP_I2C or REGMAP_SPI
> 
> None of them fits this or MFD driver. See below.
> 
>> But, if 'INTEL_SOC_PMIC_MRFLE' selects already REGMAP_*
>> configuration. It is not necessary.
> 
> https://lore.kernel.org/lkml/20190318095316.69278-1-andriy.shevchenko@linux.intel.com/
> 
> It selects REGMAP_IRQ which selects necessary bits from regmap API.

OK.

> 
>>>> +	help
>>>> +	  Say Y here to enable extcon support for charger detection / control
>>>> +	  on the Intel Merrifiel Basin Cove PMIC.
>>
>> What is correct word?
>> - Merrifield? is used on above
>> - Merrifiel?
> 
> Merrifield is a correct one. Thanks for spotting this.
> 
>>>> +static int mrfld_extcon_set(struct mrfld_extcon_data *data, unsigned int reg,
>>>> +			    unsigned int mask)
>>>> +{
>>>> +	return regmap_update_bits(data->regmap, reg, mask, 0xff);
>>>> +}
>>
>> mrfld_extcon_clear() and mrfld_extcon_set() are just wrapper function
>> for regmap interface. I think that you better to define
>> the meaningful defintion for '0x00' and '0xff' as following:
>>
>> (just example, you may make the more correct name)
>> #define INTEL_MRFLD_RESET	0x00
>> #define INTEL_MRFLD_SET		0xff
> 
> It makes a little sense here, the idea is to reduce parameters.
> 
> I could ideally write
> (..., mask, ~mask) for clear
> and
> (..., mask, mask) for set
> 
>> And then you better to use the 'regmap_update_bits()' function
>> directly instead of mrfld_extcon_clear/set'.
> 
> It will bring duplication of long definitions and reduce readability of the
> code.

Actually, it is not critical issue. If you don't agree my comments,
you keep your style on next version. I have no any strong objection.

> 
>>>> +	/*
>>>> +	 * It seems SCU firmware clears the content of BCOVE_CHGRIRQ1
>>>> +	 * and makes it useless for OS. Instead we compare a previously
>>>> +	 * stored status to the current one, provided by BCOVE_SCHGRIRQ1.
>>>> +	 */
>>>> +	ret = regmap_read(regmap, BCOVE_SCHGRIRQ1, &status);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (!(status ^ data->status))
>>>> +		return -ENODATA;
>>>> +
>>>> +	if ((status ^ data->status) & BCOVE_CHGRIRQ_USBIDDET)
>>>> +		ret = mrfld_extcon_role_detect(data);
>> This line gets the return value from mrfld_extcon_role_detect(data)
>> without any error handling and then the below line just saves 'status'
>> to 'data->status' regardless of 'ret' value.
>>
>> I think that you have to handle the error case of
>> 'ret = mrfld_extcon_role_detect(data)'.
> 
> I'm not sure of the consequences of such change.
> I will give it some tests, and then will proceed accordingly.

OK. Thanks.

> 
>>>> +		.name	= KBUILD_MODNAME,
>>
>> Where is the definition of KBUILD_MODNAME? Are you missing?
> 
> In the Makefile.
> Nothing is missed here.
> 
> But I could put its content explicitly here.

OK. Thanks.

> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
