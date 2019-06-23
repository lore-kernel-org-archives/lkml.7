Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04120208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GOvz/2tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfFXCVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:21:32 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:46304 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfFXCVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:21:32 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190623235340epoutp040b6089afee5343ed78aae72ec7e5d614~q_QToS9f_0379103791epoutp04e
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:53:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190623235340epoutp040b6089afee5343ed78aae72ec7e5d614~q_QToS9f_0379103791epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561334020;
        bh=KFlrYEjo0jzFT6JMRF6jRvxqRSuR+ds4ksWexr+YB2o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GOvz/2ttBp4Eldyzsn53oFeHj4VXTa3etxCWoGOe1bQBIJNOo52vzY9yf8ydePLX4
         t2TTI7Qsd/AilM3/AUe1xlywVvg0fglc8Wrh610C6riMc4Akw/Qq6msZZEMpC7S4P4
         1oQViV0uUAF7cz/vdLsNFV1BrPkr2rlqYMqcsKYo=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190623235335epcas1p16165e77ecc55e20326e25c95a6d4191b~q_QPD9YCp0120301203epcas1p1W;
        Sun, 23 Jun 2019 23:53:35 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.AF.04257.FF0101D5; Mon, 24 Jun 2019 08:53:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190623235334epcas1p31f68310b57d9c565b60fa3672ba2e53c~q_QOKQRE32894228942epcas1p31;
        Sun, 23 Jun 2019 23:53:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190623235334epsmtrp1bd8b149a93eb5a840b6fee088fd64d1f~q_QOJbSWr2617626176epsmtrp1f;
        Sun, 23 Jun 2019 23:53:34 +0000 (GMT)
X-AuditID: b6c32a38-5cbff700000010a1-f0-5d1010ff61a6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.DF.03662.EF0101D5; Mon, 24 Jun 2019 08:53:34 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190623235334epsmtip268db8037d684736d45b287830296547e~q_QN8kWVF2077720777epsmtip25;
        Sun, 23 Jun 2019 23:53:34 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] extcon: Add fsa9480 extcon driver
To:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        myungjoo.ham@samsung.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <871519f4-b653-e247-0afd-f7b1f29af8ae@samsung.com>
Date:   Mon, 24 Jun 2019 08:56:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmnu5/AYFYg6f9Ihbzj5xjtbi8aw6b
        xdLrF5ksbjeuYLP4cbyP2aJ17xF2BzaPNfPWMHrsnHWX3WPTqk42j74tqxg9Pm+SC2CNyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCdcX//
        V9aChVwVh3oesjQwPmLvYuTkkBAwkdi9bjJTFyMXh5DADkaJ/k+7WCGcT4wSZ3f+YIdwvjFK
        /D8xhxGm5dXkecwQib2MEhvnX2UDSQgJvGeUaJye3MXIwSEsYCvxYDI/SFhEIE5iXttkFhCb
        WSBDYsWV92Cr2QS0JPa/uAHWyi+gKHH1x2Ow+bwCdhKXNz9nBbFZBFQl3p57zQRiiwpESFze
        sguqRlDi5MwnYDM5BVwkXm56xAoxX1zi1pP5TBC2vETz1tlgd0oIPGeTOH58HdQDLhLr38xg
        grCFJV4d3wINCymJl/1tUHa1xMqTR9ggmjsYJbbsv8AKkTCW2L8UFGAcQBs0Jdbv0ocIK0rs
        /D2XEWIxn8S7rz2sICUSArwSHW1CECXKEpcf3IVaKymxuL2TbQKj0iwk78xC8sIsJC/MQli2
        gJFlFaNYakFxbnpqsWGBCXJkb2IEJ04tix2Me875HGIU4GBU4uEV2MAfK8SaWFZcmXuIUYKD
        WUmElyeHJ1aINyWxsiq1KD++qDQntfgQoykwtCcyS4km5wOTel5JvKGpkbGxsYWJoZmpoaGS
        OG88980YIYH0xJLU7NTUgtQimD4mDk6pBsYZvUXJgTcvdPsaeHZ+c5T9d/DLDGentodcmTOl
        CkPOSH1wtvn8Tr3pboOWE3vwhBb7L68KPziVWM5Sz7U6/30O2/Pw8Hf2R7ZxMj/zcVjtXyfW
        qbg/f+aOH42fTKd9n6r2RvRto10r4yLhp4+XaoV+uFyx5v+2g7aXuN/U65z5psIQyvNK/IUS
        S3FGoqEWc1FxIgCpBcvisgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXvefgECswYdDQhbzj5xjtbi8aw6b
        xdLrF5ksbjeuYLP4cbyP2aJ17xF2BzaPNfPWMHrsnHWX3WPTqk42j74tqxg9Pm+SC2CN4rJJ
        Sc3JLEst0rdL4Mq4v/8ra8FCropDPQ9ZGhgfsXcxcnJICJhIvJo8j7mLkYtDSGA3o8Tpb1vZ
        IBKSEtMuHgVKcADZwhKHDxdD1LxllPi99wgjSFxYwFbiwWR+kHIRgTiJiVv2s4LYzAIZEju+
        LWGEqJ/OKNFz8i5Ygk1AS2L/ixtg8/kFFCWu/njMCGLzCthJXN78HKyGRUBV4u2510wgtqhA
        hERf22w2iBpBiZMzn7CA2JwCLhIvNz2CWqYu8WfeJWYIW1zi1pP5TBC2vETz1tnMExiFZyFp
        n4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOIS2tHYwnTsQf
        YhTgYFTi4RXYwB8rxJpYVlyZe4hRgoNZSYSXJ4cnVog3JbGyKrUoP76oNCe1+BCjNAeLkjiv
        fP6xSCGB9MSS1OzU1ILUIpgsEwenVANjbVtZ1Nsq43sm6tlbUrbpnXxbXrFxUmXf2iUOZ167
        6CeeM2De0OPRfbU/Nqkr/09tSf9HwboNmQFrmB+fvHR9faCm2PYUpqeT5ZmiGjR15JaU2MgW
        TsucNtXyw+vQdRnZNwR5i8z51Bwt/0v2fbt/rk1RVX/JBSl/vansfL7PLm43CzfZvV+JpTgj
        0VCLuag4EQDaHi34nQIAAA==
X-CMS-MailID: 20190623235334epcas1p31f68310b57d9c565b60fa3672ba2e53c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190621111402epcas4p2f65fb1b6d3e83bd69bd129b27c90d295
References: <CGME20190621111402epcas4p2f65fb1b6d3e83bd69bd129b27c90d295@epcas4p2.samsung.com>
        <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 6. 21. 오후 8:13, Paweł Chmiel wrote:
> This small patchset adds support for Fairchild Semiconductor FSA9480
> microUSB switch.
> 
> It has been tested on Samsung Galaxy S and Samsung Fascinate 4G,
> but it can be found also on other Samsung Aries (s5pv210) based devices.
> 
> Tomasz Figa (2):
>   dt-bindings: extcon: Add support for fsa9480 switch
>   extcon: Add fsa9480 extcon driver
> 
> Changes from v1:
>   - Added newline at end of dt-bindings file
>   - Removed interrupt-parent from dt-bindings file
>   - Added Acked-by to dt-bindings patch
>   - Remove license sentences from driver
>   - Remove custom sysfs entries and manual switch code
>   - Switch to using regmap api
> 
>  .../bindings/extcon/extcon-fsa9480.txt        |  19 +
>  drivers/extcon/Kconfig                        |  12 +
>  drivers/extcon/Makefile                       |   1 +
>  drivers/extcon/extcon-fsa9480.c               | 395 ++++++++++++++++++
>  4 files changed, 427 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
>  create mode 100644 drivers/extcon/extcon-fsa9480.c
> 

Applied this series to extcon-next
after checked the build warning on extcon-testing branch.

Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
