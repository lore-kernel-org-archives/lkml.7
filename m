Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF635C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794C220675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Iik2LK6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCGA6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:58:16 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:10000 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGA6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:58:15 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190307005811epoutp0203fb0d443bdc05fb20538cc572865fee~Jh0hZoDci1677616776epoutp02c
        for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2019 00:58:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190307005811epoutp0203fb0d443bdc05fb20538cc572865fee~Jh0hZoDci1677616776epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551920291;
        bh=aZeTDhYbaUn9gCGAJ8a6cL+mzCECNnsmkBXn81xZ7vI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Iik2LK6Cg1s1NElvsWGtIGUpPArEWhfO+dyhkMKHTRv6V88V9NOcUwO4DCzJT+cRl
         wRQRYOvn+dorxkVwJCDm5XCqrpIDZnWs1UqFOexB05uxs+TzgAPMw4G/VP8PXXJM5h
         bBWT9Yi0FQTo2jhy9O1kytzWeyxT/mLigfcNqmfw=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190307005808epcas1p4113330af98ba4c607b3bc693245e1ff6~Jh0elTiLp2284722847epcas1p4Z;
        Thu,  7 Mar 2019 00:58:08 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.8E.04173.E9C608C5; Thu,  7 Mar 2019 09:58:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190307005805epcas1p165911dcb440d1d01454994291c71679e~Jh0cLftkL2109221092epcas1p1D;
        Thu,  7 Mar 2019 00:58:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190307005805epsmtrp2c8107af17da79401913e4b21541f1a25~Jh0cKpGxe2898928989epsmtrp2X;
        Thu,  7 Mar 2019 00:58:05 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-8d-5c806c9ef459
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.17.03971.D9C608C5; Thu,  7 Mar 2019 09:58:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190307005805epsmtip2135f34f2973efe9a7bbb5490d14bc06e~Jh0b_tsCF0243802438epsmtip2q;
        Thu,  7 Mar 2019 00:58:05 +0000 (GMT)
Subject: Re: [PATCH] extcon-ptn5150: fix COMPILE_TEST dependencies
To:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5dfa1660-d6f0-2307-77e7-baed8cb2eb62@samsung.com>
Date:   Thu, 7 Mar 2019 09:58:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <bcfbf645-c865-a7ad-ada6-bd77ac665f32@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmnu68nIYYgxlbhS3+TjrGbnF51xw2
        i9uNK9gs3t6ZzmLxcv90VgdWj9+/JjF67Jx1l91j8wotj74tqxg9Pm+SC2CNyrbJSE1MSS1S
        SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqtpFCWmFMKFApILC5W
        0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vOz7UyNDAwMgUqTMjOmNI8gaVgBn/F
        +hPaDYy/uLsYOTgkBEwkFs5j6mLk4hAS2MEoMf3WAlYI5xOjROuKyVDON0aJyR1n2bsYOcE6
        nv39ywKR2MsoMfXVNSjnPaPE6wmX2UCqhAWcJPofT2QEsUUEiiTutm1hBbGZBUIkZpxZDFbD
        JqAlsf/FDTCbX0BR4uqPx2D1vAJ2Ei+XTQCLswioSDzfvIkZxBYViJB4/3Q3C0SNoMTJmU/A
        bE4BR4nHZ9exQcwXl7j1ZD4ThC0v0bx1NjPIcRIC99kk7k1fCvWCi8TSrhYWCFtY4tXxLVBx
        KYnP7/ayQdjVEitPHmGDaO5glNiy/wIrRMJYYv/SyUyg0GMW0JRYv0sfYhmfxLuvPayQQOWV
        6GgTgqhWlrj84C4ThC0psbi9E2q8h0Tvtw3MExgVZyF5ZxaSF2YheWEWwrIFjCyrGMVSC4pz
        01OLDQuMkCN7EyM4WWqZ7WBcdM7nEKMAB6MSD2/E6foYIdbEsuLK3EOMEhzMSiK8ihkNMUK8
        KYmVValF+fFFpTmpxYcYTYGhPZFZSjQ5H5jI80riDU2NjI2NLUwMzUwNDZXEedc7OMcICaQn
        lqRmp6YWpBbB9DFxcEo1MG7UTpi5fl3xQ0FV38CMjQpzbwVcuhxj9KQgf11LnNCP4rlzL2df
        bbINn34uPfslA9fMuo0yHd/dH09/zHjowvw8YSvOzUqR2xkt3qsa775/IuPogdVMHXUrN920
        i5lrtvr6oSzT9Iu+TN77XX1CChSOX9Dk89ml178rrn8th/Mexc2NoqbbViixFGckGmoxFxUn
        AgDAE1bzrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXnduTkOMwcQXmhZ/Jx1jt7i8aw6b
        xe3GFWwWb+9MZ7F4uX86qwOrx+9fkxg9ds66y+6xeYWWR9+WVYwenzfJBbBGcdmkpOZklqUW
        6dslcGVMaZ7AUjCDv2L9Ce0Gxl/cXYycHBICJhLP/v5lAbGFBHYzSkxbKAsRl5SYdvEocxcj
        B5AtLHH4cHEXIxdQyVtGiUkXWxhBaoQFnCT6H08Es0UEiiQmXLnCCmIzC4RIdF85zgjRsJ9R
        YsuBZUwgCTYBLYn9L26wgdj8AooSV388BmvmFbCTeLlsAlicRUBF4vnmTcwgtqhAhMTdiy9Y
        IGoEJU7OfAJmcwo4Sjw+u44NYpm6xJ95l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllI
        WmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4arQ0dzBeXhJ/iFGAg1GJ
        hzfidH2MEGtiWXFl7iFGCQ5mJRFexYyGGCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJ
        pCeWpGanphakFsFkmTg4pRoYWdsvaNgp1724bvX17HlZXkeb/MBPW7y4mw5oZv/a8j0lnynR
        89VThohEfv1TEzsb2L08Nc1FZSUMNn1RVZRQUapZ0XHTLr2Gu/Ugm4Hh1uo732PrZ/Zwp826
        KHo+2T6uxy/LY89Rjcd5VaEZTCJhJ1Suc51WPtXfP9epedXlxR0PIqpCnimxFGckGmoxFxUn
        AgCT9wn8lgIAAA==
X-CMS-MailID: 20190307005805epcas1p165911dcb440d1d01454994291c71679e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190306154931epcas2p38e412aba6c0e5ed7650bbbedfc641de9
References: <20190306110906.2622957-1-arnd@arndb.de>
        <CGME20190306154931epcas2p38e412aba6c0e5ed7650bbbedfc641de9@epcas2p3.samsung.com>
        <bcfbf645-c865-a7ad-ada6-bd77ac665f32@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 19. 3. 7. 오전 12:49, Randy Dunlap wrote:
> On 3/6/19 3:08 AM, Arnd Bergmann wrote:
>> The PTN5150 dependencies look like they were meant to do the
>> right thing, but they actually should not allow building without
>> I2C for compile testing, as that results in a Kconfig warning
>> and subsequent build failure:
>>
>> WARNING: unmet direct dependencies detected for REGMAP_I2C
>>   Depends on [m]: I2C [=m]
>>   Selected by [y]:
>>   - EXTCON_PTN5150 [=y] && EXTCON [=y] && (I2C [=m] && GPIOLIB [=y] || COMPILE_TEST [=y])
>>   Selected by [m]:
>>   - EEPROM_AT24 [=m] && I2C [=m] && SYSFS [=y]
>>   - KEYBOARD_CAP11XX [=m] && !UML && INPUT [=y] && INPUT_KEYBOARD [=y] && OF [=y] && I2C [=m]
>>   - INPUT_DRV260X_HAPTICS [=m] && !UML && INPUT_MISC [=y] && INPUT [=y] && I2C [=m] && (GPIOLIB [=y] || COMPILE_TEST [=y])
>>   - ... [many others]
>>
>> Add parentheses around the expression so we can compile-test
>> without GPIOLIB but not without I2C.
>>
>> Fixes: 4ed754de2d66 ("extcon: Add support for ptn5150 extcon driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Hi Chanwoo,
> 
> You might want to drop my patch and use this one from Arnd instead...

Thanks for your comment. I'll do that.

> 
> 
>> ---
>>  drivers/extcon/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>> index 8e17149655f0..540e8cd16ee6 100644
>> --- a/drivers/extcon/Kconfig
>> +++ b/drivers/extcon/Kconfig
>> @@ -116,7 +116,7 @@ config EXTCON_PALMAS
>>  
>>  config EXTCON_PTN5150
>>  	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
>> -	depends on I2C && GPIOLIB || COMPILE_TEST
>> +	depends on I2C && (GPIOLIB || COMPILE_TEST)
>>  	select REGMAP_I2C
>>  	help
>>  	  Say Y here to enable support for USB peripheral and USB host
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
