Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFCBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DD2214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e2KLH1yY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfCLJRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:17:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40528 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfCLJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:17:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190312091740euoutp015c1ee2b61af370bd830e32ef84a97182~LK3DS2Ts42346723467euoutp01c
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:17:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190312091740euoutp015c1ee2b61af370bd830e32ef84a97182~LK3DS2Ts42346723467euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552382260;
        bh=DDfIJ9ZP3Ka479zRB9Ni6TdKaIs++FvotXU2HTHyosw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=e2KLH1yYYV8ArOYmEL0RnkM+Ll8gIDsZ+23Q0eErNg5R0S51/iarpd71y39bLUArW
         IADsUcW016Ey/lOxwQuXCgNmURBzOg20eQ56YKkFCGg7wedtWx0U9U1w+THzrDgz01
         abxjFAuUeLi8s7heO16WAJwE8BE55udDDebt1cp0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190312091739eucas1p1d04f72dad3bd456911b41b72d03bdd60~LK3CtEa_Y1851218512eucas1p1m;
        Tue, 12 Mar 2019 09:17:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 26.66.04441.339778C5; Tue, 12
        Mar 2019 09:17:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190312091738eucas1p1a373509eae14bbb683e630d87bcb632c~LK3CAQbO00833908339eucas1p1F;
        Tue, 12 Mar 2019 09:17:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190312091738eusmtrp17984f6bffefd94be7c0cfd604d7dd7c9~LK3Bx7hy30087300873eusmtrp1Y;
        Tue, 12 Mar 2019 09:17:38 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c9-5c877933c418
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 33.C8.04128.239778C5; Tue, 12
        Mar 2019 09:17:38 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190312091737eusmtip2744f6b73da5e1c1a2272c01dee6e0ffe~LK3BNRarC1851818518eusmtip2c;
        Tue, 12 Mar 2019 09:17:37 +0000 (GMT)
Subject: Re: [PATCH v5 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <a8eafa27-1dc5-f4cf-9c1d-b4cbce80ec62@partner.samsung.com>
Date:   Tue, 12 Mar 2019 10:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190311220650.GB4082@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfXcuOzOPvU7LB0urSTehVdSH05UCM+lLRUGWQi07TGubtjMz
        M0KDNi+ZouBl2hVJW9pFvDEv1RRHhi0NsbLAyGqVGrgNqcByO0p++z3/5/+8z/OHlyHkHVQY
        k6wz8HqdSqOg/cnmnl+OdZsyTAkbpnMDucflDyluyP2V4m52v6S4wk8/CM7heCTl+i6PSbnX
        1iqacxV0I67c0Snh6rs/SLnh7Fqa+9veKuW6xkzULja2wZJLx15rtKBYV0PEAeKY//ZTvCb5
        HK9fv/OEf1JHk02aOrTwvM04RWYhR0AekjGAN0P+8H0qD/kzclyLILuvhBQLN4Ks0RyJWLgQ
        5LY1SOdG/loHabFRg8D07TMhFuMIujxuyusKxkeg4s0n5OUQvAL+GEt9SwjcLoGmwaKZpxiG
        xkpotZz1IotjoOzBfq+dxCvhntXmG12E46CrYMLHLA6C5xWjpJdlOAqy3D0+ncCh8G70pkTk
        ZdAyXuW7B/CAFIZ/1yPx6mio6fXMcjB8tzfOplkKL0qukiIL0JdjoUW+CKbnrbOebdBl76e8
        dxJ4LTy0rhfl3fCx20F7ZcCB8GY8SDwhEIqbywhRZiHHKBfda6Dx6iuJyIuhpq5UWoQU5nnB
        zPPCmOeFMf/fewuRFhTKpwlaNS9s1PHpSkGlFdJ0amViirYBzXyqF9P2yVbkGThpQ5hBigDW
        mWpMkFOqc0KG1oaAIRQhLKcxJcjZU6qMC7w+5bg+TcMLNrSEIRWhbKbfSLwcq1UG/gzPp/L6
        ua6EkYVlofjj9t7fttuJ0RPu4r0jh5MrURv7bnm4Z0vLgTsxQ9mF/S46xinLTZ46GLX/mdJ5
        /RB9x3m3wtnUmW9aIBj2PPFb/XHSsCqm+ui+TmWxBGND+BVtz9L3IxFfQjKV44Y4XWzlo9M9
        T6uDXp3Y0XYj8u3WSWukul+ZUvfzUvrZlql8BSkkqTZGEXpB9Q+qV/v2UAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7pGle0xBtOfSVtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVmsPXKX3eJ24wo2i/97drBb
        HH7TzurA67FpVSebR9+WVYwenzfJBTBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqb
        x1oZmSrp29mkpOZklqUW6dsl6GXs3XqIveA6f8Whtu8sDYzneboYOTkkBEwk/u+6ygZiCwks
        ZZS4c14HIi4mMWnfdnYIW1jiz7UuoBouoJrXjBJNO6+ANQgLhEvMvPGYEcQWEVCU+N02jRWk
        iFlgD5PEvLU3GSE6/jJKLH54h6WLkYODTUBPYseqQhCTV8BNYvo6f5BeFgFViZW7DoHNERWI
        kPj4dB8TiM0rIChxcuYTFhCbU0BLouHLMbAaZgEziXmbHzJD2OISt57MZ4Kw5SW2v53DPIFR
        aBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwNjcduznlh2MXe+C
        DzEKcDAq8fC+KGiLEWJNLCuuzD3EKMHBrCTCa5HTHiPEm5JYWZValB9fVJqTWnyI0RTouYnM
        UqLJ+cC0kVcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgdF1avdD
        L3btHIVla8uWMrk9qFj2YXX+NZYzfi0Tn88TOd8mvPjSh84qbU7NAssjJtIZDN2SDVXZjpfk
        VuzayaqVYVMjFWtU8KPW7cuElz6WhzXP6zHUvBcysIzlOe3I8eTZy10vTVatbLcRmXvCpWLj
        5Ax1E7cbfNHKcW7y70Wvnz+xJrjlghJLcUaioRZzUXEiAPqHOd3jAgAA
X-CMS-MailID: 20190312091738eucas1p1a373509eae14bbb683e630d87bcb632c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa@eucas1p1.samsung.com>
        <1551781151-5562-2-git-send-email-l.luba@partner.samsung.com>
        <20190311220650.GB4082@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/11/19 11:06 PM, Rob Herring wrote:
> On Tue,  5 Mar 2019 11:19:04 +0100, Lukasz Luba wrote:
>> Define new IDs for clocks used by Dynamic Memory Controller in
>> Exynos5422 SoC.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
I have skipped your ACK because of the hack which is implemented in v5
clocks. Chanwoo refused the driver code because it uses 2 registers from
the clock register set without Common Clock Framework API.
He said that he will not accept this code and I have to figure out new
approach using CCF.
Thus, I have modeled these two registers as 'gates', but these registers
are for Dynamic Memory Controller PAUSE feature (which stops
transactions) and the other is for switching between
two set of registers with timings for the LPDDR3 memory (normal
operation and alternative clock source operation aka 'bypass').
These registers should be (in my opinion) in the DMC registers and not
in the clocks.

Sylwester pointed out offline that it could be done using regmap.
These are the problematic clocks added in v5:
+#define CLK_CDREX_PAUSE		531
+#define CLK_CDREX_TIMING_SET	532

I have mentioned about it in the cover letter, but you are right I could
also add a comment for this particular patch that I have skipped your
ACK.
Thank you for sharing the information about the process.
I will keep it in mind next time and will add a comment below the commit
message for a particular patch and explicit information in cover letter
that I am not including an ACK.

Regards,
Lukasz
> 
> 
