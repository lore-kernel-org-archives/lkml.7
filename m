Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAFBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501FE218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lhzNZaAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfCUBj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:39:59 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:54419 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUBj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:39:58 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190321013955epoutp0433157e0e0297b3b3203f8b3d4de3010d~N1a9YK5u13230032300epoutp04G
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:39:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190321013955epoutp0433157e0e0297b3b3203f8b3d4de3010d~N1a9YK5u13230032300epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553132395;
        bh=oYSpwt8VRK/3qu/1kElbUVazyQE0Cf4m2sfUOAAhy2g=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=lhzNZaAJZKdHmUmmMRo00Zd7iLjagmNdOurvsUajMB55/Vh2iSZiu9MC9U3+HdjI2
         sR5K310LLew1eTv5K9KfUBaKDB/P6j3khMb2gYJVh4a64dxv8tfnZn6SBRHkYTGwKa
         QiDHTH70xVH6A+6IFUeDfz1tDa9GIvR6J4rMAauU=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190321013945epcas1p1ff66bba871cba46874ac0cf69c1ed01f~N1a0Aa2LL2138021380epcas1p1n;
        Thu, 21 Mar 2019 01:39:45 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.ED.04108.B5BE29C5; Thu, 21 Mar 2019 10:39:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190321013938epcas1p4093e78aa4335f5b5b6a345ac242cd5ef~N1at6LZde2398423984epcas1p4U;
        Thu, 21 Mar 2019 01:39:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190321013938epsmtrp28e7432bc0793d95c671e2b090efdcfeb~N1at5kkBq0994309943epsmtrp2h;
        Thu, 21 Mar 2019 01:39:38 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-17-5c92eb5b6916
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.40.03662.A5BE29C5; Thu, 21 Mar 2019 10:39:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190321013938epsmtip12e38cdc14948e0f44bd958eb407d0011~N1atwYxrC2831028310epsmtip1M;
        Thu, 21 Mar 2019 01:39:38 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] extcon: Introduce support of Basin Cove PMIC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fd9b39b9-c589-0a61-5191-c91e63153f6c@samsung.com>
Date:   Thu, 21 Mar 2019 10:39:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319143042.66606-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmvm7060kxBgeniFv0Nk1nsnhzHEhc
        3jWHzeJ24wo2BxaPeScDPd7vu8rm0bdlFaPH501yASxR2TYZqYkpqUUKqXnJ+SmZeem2St7B
        8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QBuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQWWBXrFibnFpXnpesn5uVaGBgZGpkCFCdkZf9erFHzjqJi/4x5TA+Nnti5GTg4J
        AROJkwuaWLoYuTiEBHYwSlz5cArK+cQoseLgPDYI5xujxO7+w4wwLec+LmGFSOxllPi6dQUj
        hPOeUeLBjx9gVcICHhJT5nwAS4gILGeUeHpnCTtIgk1AS2L/ixtg2/kFFCWu/ngM1sArYCfR
        fnQjUxcjBweLgKrE3aUZIGFRgQiJ9093s0CUCEqcnPmEBaSEU8BdonuiHUiYWUBc4taT+UwQ
        trxE89bZzCBrJQQOsEkc2XGCGeJqF4njS79DfSAs8er4FnYIW0ri87u90MCollh58ggbRHMH
        o8SW/RdYIRLGEvuXTga7jVlAU2L9Ln2IZXwS7772sIKEJQR4JTrahCCqlSUuP7jLBGFLSixu
        74Qa7yHx6WYDNKxmMUr03f/JMoFRYRaS12Yh+WcWkn9mIWxewMiyilEstaA4Nz212LDAFDm2
        NzGCU6OW5Q7GY+d8DjEKcDAq8fB6GE2KEWJNLCuuzD3EKMHBrCTCG6EEFOJNSaysSi3Kjy8q
        zUktPsRoCgz4icxSosn5wLSdVxJvaGpkbGxsYWJoZmpoqCTOu97BOUZIID2xJDU7NbUgtQim
        j4mDU6qB0SfriUm7w81Xc46GfHvRXfGIMVL1b55rjjh7q8nplb+7ihhcogLMv9akyHmJHvx8
        ivENS/7b2xKHZO1r5eQFHZSfssqFhP/sejBRlrvr0mnpPCfhmGXaTPFLN+27bbzzoOCGDuat
        By9GvCqf3LGZqXdz89xY94u9p1fw73LiF1GRTdsRvX6VEktxRqKhFnNRcSIAqSPo56MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnG7U60kxBvf3m1n0Nk1nsnhzHEhc
        3jWHzeJ24wo2BxaPeScDPd7vu8rm0bdlFaPH501yASxRXDYpqTmZZalF+nYJXBl/16sUfOOo
        mL/jHlMD42e2LkZODgkBE4lzH5ewdjFycQgJ7GaUeNCwgBkiISkx7eJRIJsDyBaWOHy4GKLm
        LaPErum7wZqFBTwkpsz5wAiSEBFYzijx+NwidpCEkMAsRonbLe4gNpuAlsT+FzfAGvgFFCWu
        /njMCGLzCthJtB/dyASygEVAVeLu0gyQsKhAhMTdiy9YIEoEJU7OfMICUsIp4C7RPdEOJMws
        oC7xZ94lZghbXOLWk/lMELa8RPPW2cwTGIVmIemehaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYs
        MMpLLdcrTswtLs1L10vOz93ECI4DLa0djCdOxB9iFOBgVOLh7TadFCPEmlhWXJl7iFGCg1lJ
        hDdCCSjEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBMXmn
        mdFBqcsplzI1yt0D1psv8OO/lBYSxHivmtV1X5f5psmG3S/mHK7h2/dlk9d9R9klfzZXFj/U
        y/JTv/QxY+n+d5tKrspEfl52TI9rZe7R9v+H6/da7juY7JvTq/Qhfcbvj89mrfU+ItnsULi1
        +sUCoV1OHZ9EvSwaMtUCDs+3LrikHTzfVYmlOCPRUIu5qDgRAOOKjuV/AgAA
X-CMS-MailID: 20190321013938epcas1p4093e78aa4335f5b5b6a345ac242cd5ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190319143051epcas2p3d606ab8e344a2dc5c01e969d3cbfd024
References: <CGME20190319143051epcas2p3d606ab8e344a2dc5c01e969d3cbfd024@epcas2p3.samsung.com>
        <20190319143042.66606-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 19. 3. 19. 오후 11:30, Andy Shevchenko wrote:
> On Intel Merrifield platforms the Basin Cove PMIC responsible for USB DR
> detection among other things.
> 
> Here is the extcon driver to support USB DR and charger detection.
> 
> Since v2:
> - rebase on top of extcon-next
> - update copyright year
> - address most of Chanwoo's comments
>   (rest is left in similarity with other Intel extcon drivers)
> 
> Andy Shevchenko (2):
>   extcon: intel: Split out some definitions to a common header
>   extcon: mrfld: Introduce extcon driver for Basin Cove PMIC
> 
>  drivers/extcon/Kconfig               |   7 +
>  drivers/extcon/Makefile              |   1 +
>  drivers/extcon/extcon-intel-cht-wc.c |  21 +-
>  drivers/extcon/extcon-intel-mrfld.c  | 284 +++++++++++++++++++++++++++
>  drivers/extcon/extcon-intel.h        |  20 ++
>  5 files changed, 319 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/extcon/extcon-intel-mrfld.c
>  create mode 100644 drivers/extcon/extcon-intel.h
> 

Applied them to extcon-next branch. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
