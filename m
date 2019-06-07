Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D55BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5092F212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gw2/Rgyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfFGMcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:32:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41082 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfFGMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:32:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607123202euoutp01627935d08c334386829626730b12a5cb~l6ol8_3jH0173801738euoutp01N
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 12:32:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607123202euoutp01627935d08c334386829626730b12a5cb~l6ol8_3jH0173801738euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559910722;
        bh=vqbGOMy12XkJS45GPFssVA29gnSK7Mg2h0V+4KbPPpY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Gw2/Rgyq7EJ18b79hzBEuSTkHdNvrA3RhL+SHw4q/dLRByN9bIwNniBPAW652JR9W
         MA0CJvvswTfTCp8p5CQ1aAVnb/BOY1GgXWoG1zKor6GMnG80ADKE6xcuTmw9lmz+iz
         aYpV6ya7afGmfJRrnguCAOdEx3AwqbMEA3t87d/o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607123201eucas1p1b5dccf24841b045e5b2290e240c48b98~l6olY_evB1805518055eucas1p1M;
        Fri,  7 Jun 2019 12:32:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 66.92.04325.1495AFC5; Fri,  7
        Jun 2019 13:32:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607123200eucas1p18998abac85d88ff568264e037ab3d8cb~l6okls4-C0627106271eucas1p1o;
        Fri,  7 Jun 2019 12:32:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607123200eusmtrp2d7d98c291cf1704ee4dcd8b952a8e8c5~l6okWPl0s0938109381eusmtrp29;
        Fri,  7 Jun 2019 12:32:00 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-69-5cfa59410ad5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.88.04146.0495AFC5; Fri,  7
        Jun 2019 13:32:00 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190607123200eusmtip2dac82c9117639c6dfeee028971a3d57c~l6okJOITR2451924519eusmtip2f;
        Fri,  7 Jun 2019 12:32:00 +0000 (GMT)
Subject: Re: [PATCH v2] video: fbdev: da8xx-fb: add COMPILE_TEST support
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <56fcd283-07b9-f198-b2cd-0f4afe565622@samsung.com>
Date:   Fri, 7 Jun 2019 14:32:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fe534641-82b7-c3f7-4296-db4ba4ff30e6@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzneV3HyF8xBj0nhCyufH3PZnGi7wOr
        xeVdc9gcmD3udx9n8vi8SS6AKYrLJiU1J7MstUjfLoEr4+PsD2wFd5gqFr9Yx9jAuJCpi5GT
        Q0LARGJt+1FWEFtIYAWjxPmbBV2MXED2F0aJ2ZNfsUM4nxklLvSeZYTpuHLuKAtEYjmjxIRd
        ncwQzltGiVsfzzODVAkLeEjsOL8PrINNwEpiYvsqMFtEIEFixfQZYDavgJ1EY8NysHoWARWJ
        hf/fsoDYogIREvePbWCFqBGUODnzCVCcg4NTwF7iwi8bkDCzgLjErSfzmSBseYntb+eA3SAh
        8JlN4uGaB+wQl7pI7JtwhRXCFpZ4dXwLVFxG4v9OkGaQhnWMEn87XkB1b2eUWD75HxtElbXE
        4eMXWUE2MwtoSqzfpQ8RdpS43T2NGSQsIcAnceOtIMQRfBKTtk2HCvNKdLQJQVSrSWxYtoEN
        Zm3XzpVQJR4SRxtCJjAqzkLy5Cwkn81C8tkshBMWMLKsYhRPLS3OTU8tNs5LLdcrTswtLs1L
        10vOz93ECEwdp/8d/7qDcd+fpEOMAhyMSjy8Huw/Y4RYE8uKK3MPMUpwMCuJ8JZd+BEjxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnLea4UG0kEB6YklqdmpqQWoRTJaJg1OqgTFVzYjf2uv0qjd9
        a2foHJ5hfmOHrFm08KQpTOlHGaL6I1r1yry6pjq2N9RO0jR691rxdRaTKtM25QPTt19aM2Ur
        53LFVPNfJ5s6ipym8vO9nj/zP+dnzfl6n0RMr7FG8q1m2fIk10nBVeOWSdyUkojYK6Jqt9P8
        WVL3zrcs0OdzP7Rg1f2+UiWW4oxEQy3mouJEAPy9s1sZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4PV2HyF8xBuceSlpc+fqezeJE3wdW
        i8u75rA5MHvc7z7O5PF5k1wAU5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGp
        kr6dTUpqTmZZapG+XYJexsfZH9gK7jBVLH6xjrGBcSFTFyMnh4SAicSVc0dZQGwhgaWMEl0z
        aroYOYDiMhLH15dBlAhL/LnWxdbFyAVU8ppRYuaNj4wgCWEBD4kd5/eB2WwCVhIT21eB2SIC
        CRJPX89ng5hpJ9HVshnM5gWyGxuWM4PYLAIqEgv/vwXbKyoQIXHm/QoWiBpBiZMzn7CA3MAp
        YC9x4ZcNSJhZQF3iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSchaR7FpKWWUhaZiFpWcDIsopR
        JLW0ODc9t9hQrzgxt7g0L10vOT93EyMwIrYd+7l5B+OljcGHGAU4GJV4eB0YfsYIsSaWFVfm
        HmKU4GBWEuEtu/AjRog3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgdGaVxJvaGpobmFpaG5s
        bmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB0clhnvRWv8u6+7uuP+nPefijY9dejbWi
        7FsT7nGFuk/kn3DvwsG5yyszzntEdpletN6vN1941Y+4E/K3Vko2VL/1vvhA992q6V/2rZrP
        3e+65ue5xVtby+P7oq6+m847ff+U+Tp6r/Y8f32z7YHBJK/pO3rKzGZq8JgmHogtOrPixOZz
        hSJs1c5KLMUZiYZazEXFiQCSuioPngIAAA==
X-CMS-MailID: 20190607123200eucas1p18998abac85d88ff568264e037ab3d8cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607123200eucas1p18998abac85d88ff568264e037ab3d8cb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607123200eucas1p18998abac85d88ff568264e037ab3d8cb
References: <fe534641-82b7-c3f7-4296-db4ba4ff30e6@samsung.com>
        <CGME20190607123200eucas1p18998abac85d88ff568264e037ab3d8cb@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/21/19 12:53 PM, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to da8xx-fb driver for better compile
> testing coverage.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
