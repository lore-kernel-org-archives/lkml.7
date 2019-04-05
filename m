Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5593C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B4521738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gWrSIU4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfDEKEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:04:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50705 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfDEKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:04:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190405100420euoutp026ac28eb7b399116e3acea306c3f324e1~Si_qQkczR3265932659euoutp02p
        for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2019 10:04:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190405100420euoutp026ac28eb7b399116e3acea306c3f324e1~Si_qQkczR3265932659euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554458661;
        bh=wJxu88QKAoJYLl+pjjEVp3qcRsEpmjOxn6M3JKU4xkY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gWrSIU4drh3Ji9tJ7KhxBXD99iiqaHo0JgWliqeBPhSZC7kpektWPsodjrs+U0vr1
         pNM8lDFx4lN7eLpb26wdSAkYdk2+BuoNzYyDdSHk7lRZklNDJ36S/dPzU6jEK4lAY8
         aysAfotdZyXVMMU2nvsd1ZHhTVMUkNoHgqA4IB3s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190405100420eucas1p13833313cae3cdd0efbf6231d9db86dac~Si_pgspxp0410404104eucas1p13;
        Fri,  5 Apr 2019 10:04:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D8.F0.04325.32827AC5; Fri,  5
        Apr 2019 11:04:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190405100419eucas1p29fc3a14c724915ff7d613be655ab7d53~Si_oklw4E0766007660eucas1p2U;
        Fri,  5 Apr 2019 10:04:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190405100418eusmtrp17b0eb94ad411189d0db9f60bb008ea08~Si_oWe7mb2985229852eusmtrp1M;
        Fri,  5 Apr 2019 10:04:18 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-2e-5ca728234c20
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8F.FD.04146.22827AC5; Fri,  5
        Apr 2019 11:04:18 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190405100418eusmtip2f27d7cbd686c5c03000ac14d371248d5~Si_nzX85l2755127551eusmtip2u;
        Fri,  5 Apr 2019 10:04:18 +0000 (GMT)
Subject: Re: [PATCH RFC 2/8] soc: samsung: Exynos chipid driver update
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <5d80718b-57ad-33cd-80ff-03c01266a143@samsung.com>
Date:   Fri, 5 Apr 2019 12:04:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcJrctz5E8GX2ke804FBifpfYm5D_=H4MguTg_Cq2CPng@mail.gmail.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7rKGstjDKZ3mFpsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26x9PpFJovbjSvYLBZt/cJu
        0br3CLsDr8eaeWsYPTat6mTz2Lyk3qNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgytm/dzFZw
        UbRi6cmvbA2MTYJdjJwcEgImElP6d7N1MXJxCAmsYJS4924HI4TzhVFi2eUVzCBVQgKfGSUu
        bLOF6ej83s4CUbScUeLb5w9QzltGic7GZUwgVcICbhJHVl5jBbFFBDQlrv/9zgpSxCxwmlli
        +8wOFpAEm4ChRO/RPqB9HBy8AnYSR+6HgoRZBFQk1t5eAFYiKhAhcf/YBrA5vAKCEidnPgGL
        cwoESvRMmwYWZxYQl2j6shLKlpfY/nYOM8guCYF77BI/Oz6yQ5ztItF35ReULSzx6vgWKFtG
        4vTkHhaIhmZGiZ7dt9khnAmMEvePL2CEqLKWOHz8IivIpcxA76zfpQ8RdpTounmcGSQsIcAn
        ceOtIMQRfBKTtk2HCvNKdLQJQVSrSPxeNZ0JwpaS6H7yn2UCo9IsJK/NQvLOLCTvzELYu4CR
        ZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZg+jr97/jXHYz7/iQdYhTgYFTi4dVgWhYj
        xJpYVlyZe4hRgoNZSYRXbiVQiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTU
        gtQimCwTB6dUA2P5YZ1HKW6hcSYpRnXtzbz2jPFpstvk/wvtvvOAX0T80kKrpOY+Xh3mxVyV
        GuYiy+ziTqyXnyn/s2Z97691yatXv1nOFXy6YtVmY1kRzcZDEg//HNbk4HP857xuTvuNmWz9
        2z33l0af3+q8P6Dchf9Kr/H/N5tse0zrZ5z8XW5odf2JX4NDlxJLcUaioRZzUXEiAOTCbFBb
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7pKGstjDE5sNbXYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl91i6fWLTBa3G1ewWSza+oXd
        onXvEXYHXo8189Ywemxa1cnmsXlJvUffllWMHp83yQWwRunZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlbN+6ma3gomjF0pNf2RoYmwS7GDk5JARM
        JDq/t7N0MXJxCAksZZSY1fmGtYuRAyghJTG/RQmiRljiz7UuNoia14wSL87+YgVJCAu4SRxZ
        eQ3MFhHQlLj+9zsrSBGzwGlmidVvtkFN7WCSmHblBxtIFZuAoUTv0T5GkA28AnYSR+6HgoRZ
        BFQk1t5ewAJiiwpESJx5vwLM5hUQlDg58wmYzSkQKNEzbRrYMmYBdYk/8y4xQ9jiEk1fVkLF
        5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwHjd
        duzn5h2MlzYGH2IU4GBU4uFtYFkWI8SaWFZcmXuIUYKDWUmEV24lUIg3JbGyKrUoP76oNCe1
        +BCjKdBzE5mlRJPzgakkryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMH
        p1QDo5U8s9bMKe2aer5zT+ifUFGuf3j8b8iTKeJ2dhs4Ftiw2UlsTvvw3Lj8iKVd0a/2J36b
        tX/yXMrZP9GqQ5ihZ/FbkbKUgCTDx1Nnxgc98Dd9zcgc63xkX+lpnh+rZ36Sqim+yLc881fU
        RCWW7MP6vx609kgd5VvLO//0QsEDNyI0vd1f3n7trsRSnJFoqMVcVJwIAD0T6bTtAgAA
X-CMS-MailID: 20190405100419eucas1p29fc3a14c724915ff7d613be655ab7d53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190404172229epcas2p25a819e37035b26ccf53613e880bdcacf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190404172229epcas2p25a819e37035b26ccf53613e880bdcacf
References: <CGME20190404172229epcas2p25a819e37035b26ccf53613e880bdcacf@epcas2p2.samsung.com>
        <20190404171735.12815-1-s.nawrocki@samsung.com>
        <20190404171735.12815-3-s.nawrocki@samsung.com>
        <CAJKOXPcJrctz5E8GX2ke804FBifpfYm5D_=H4MguTg_Cq2CPng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 11:22, Krzysztof Kozlowski wrote:
> On Thu, 4 Apr 2019 at 19:22, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>>
>> This patch adds definition of selected CHIP ID register offsets
>> and register bit field definitions for Exynos5422 SoC.
>>
>> exynos_chipid_read() helper function is added to allow reading
>> the CHIP ID block registers.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  drivers/soc/samsung/exynos-chipid.c | 16 +++++-----
>>  drivers/soc/samsung/exynos-chipid.h | 48 +++++++++++++++++++++++++++++
>>  2 files changed, 57 insertions(+), 7 deletions(-)
>>  create mode 100644 drivers/soc/samsung/exynos-chipid.h
>>
>> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
>> index 5cb018807817..4920f0ef2c55 100644
>> --- a/drivers/soc/samsung/exynos-chipid.c
>> +++ b/drivers/soc/samsung/exynos-chipid.c
>> @@ -16,10 +16,7 @@

>> -#define EXYNOS_SUBREV_MASK     (0xF << 4)
>> -#define EXYNOS_MAINREV_MASK    (0xF << 0)
>> -#define EXYNOS_REV_MASK                (EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
>> -#define EXYNOS_MASK            0xFFFFF000
> 
> Create hex-addresses in first commit in lower case.

>> +static void __iomem *exynos_chipid_base;
> 
> No, this was removed in Pankaj's version v6 -> v7 and I do not want it
> to be file-scope. Having it file-scope is error prone and prevents
> having multiple instances (I do not expect having more than one but
> still code should be rather nicely generic).

I'm going to switch to using regmap so that will not be needed any 
more, together with exynos_chipid_read() helper. Then the header
file would be moved to include/linux/soc/samsung.
 
>> +unsigned int exynos_chipid_read(unsigned int offset)
>> +{
>> +       return readl_relaxed(exynos_chipid_base + offset);
>> +}

>> diff --git a/drivers/soc/samsung/exynos-chipid.h b/drivers/soc/samsung/exynos-chipid.h
>> new file mode 100644
>> index 000000000000..826a12c25fa2
>> --- /dev/null
>> +++ b/drivers/soc/samsung/exynos-chipid.h
>> @@ -0,0 +1,48 @@

>> +#define EXYNOS_CHIPID_REG_PRO_ID       0x00
>> + #define EXYNOS_SUBREV_MASK            (0xf << 4)
>> + #define EXYNOS_MAINREV_MASK           (0xf << 0)
>> + #define EXYNOS_REV_MASK               (EXYNOS_SUBREV_MASK | \
>> +                                        EXYNOS_MAINREV_MASK)
>> + #define EXYNOS_MASK                   0xfffff000
>> +
>> +#define EXYNOS_CHIPID_REG_PKG_ID       0x04
> 
> Can you comment that these are fields from this register?
> The same in second one.

OK, I will add some comment here.
 
>> + #define EXYNOS5422_IDS_OFFSET         24
>> + #define EXYNOS5422_IDS_MASK           0xff
-- 
Regards,
Sylwester
