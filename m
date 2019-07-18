Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59807C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BB52173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lGeQJ168"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbfGROCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:02:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42573 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGROCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:02:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190718140215euoutp022ee52c3a13f79844386d422ff1bc20dc~yhUEMhmro1503915039euoutp02j
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:02:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190718140215euoutp022ee52c3a13f79844386d422ff1bc20dc~yhUEMhmro1503915039euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563458535;
        bh=Z73bues8FHpZhyrw8DETK5H+SvUwyqneslorNXufFSA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lGeQJ168mF9cRylq7PPn861wlIbBWHfEi7RcWK4wxQdENSTvFNA8pF+Y/mDbLBP+8
         YnAO2Q4MfsZOt0uVdq6yUpC0GaJn4rPv/UuILJ6IcPMnX5dHCw2ajMmu4ZH24kia+n
         bngzQ+MjCHSaZxgLV3/J5aeoScEE63GSdwm+Qi90=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718140214eucas1p1e762aaadd89f2291eb9f8832e13a6ebc~yhUDpzs3f1953719537eucas1p1g;
        Thu, 18 Jul 2019 14:02:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E4.91.04377.6EB703D5; Thu, 18
        Jul 2019 15:02:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190718140213eucas1p2c57432f2d3b1a0ef3d00e999398e482e~yhUC4pbo43145531455eucas1p2V;
        Thu, 18 Jul 2019 14:02:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718140213eusmtrp17c783e7d0fbeafc43ecdfd3ddcaa3eab~yhUCqdvV70046800468eusmtrp1R;
        Thu, 18 Jul 2019 14:02:13 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-ce-5d307be6b25d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.03.04140.5EB703D5; Thu, 18
        Jul 2019 15:02:13 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190718140212eusmtip25c2c71a123cc20791e0f7de5d50e94d5~yhUCGsifr0049100491eusmtip2d;
        Thu, 18 Jul 2019 14:02:12 +0000 (GMT)
Subject: Re: [PATCH RFC 3/8] dt-bindings: exynos: Add ASV tables binding
 documentation
To:     Rob Herring <robh@kernel.org>
Cc:     krzk@kernel.org, kgene@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <4c0ad46b-6790-b154-9c55-587b87dc204e@samsung.com>
Date:   Thu, 18 Jul 2019 16:02:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190429172337.GA30032@bogus>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7rPqg1iDRZt57PYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl91i6fWLTBa3G1ewWSza+oXd
        4v+eHewOvB5r5q1h9Ni0qpPNY/OSeo++LasYPT5vkgtgjeKySUnNySxLLdK3S+DKOHn1HWPB
        Y+aKU6/2sDYw/mXqYuTkkBAwkVh0ZxeQzcUhJLCCUWLD7V+MEM4XRok7p0+xQjifGSXm3nwO
        lOEAa5n+UA8ivpxRYtLV2VBFbxkleqZ1soPMFRaIkGiaeYsFxBYRUJT43TYNrIhZ4CiTxIv3
        XWBFbAKGEr1H+xhBbF4BO4mGpu9gNouAqsSFUxvAbFGgQaeOzGOBqBGUODnzCZjNKaAtcbK7
        GWwOs4C4RNOXlawQtrzE9rdzmEGWSQg8Ypd4tvAFK8SnLhJXp3+C+lpY4tXxLewQtozE6ck9
        LBANzUAv7L7NDuFMYJS4f3wBI0SVtcTh4xdZQQHALKApsX6XPkTYUWLZiSvskHDhk7jxVhDi
        CD6JSdumM0OEeSU62oQgqlUkfq+aDnWClET3k/8sExiVZiF5bRaSd2YheWcWwt4FjCyrGMVT
        S4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPY6X/Hv+xg3PUn6RCjAAejEg9vQK5BrBBrYllx
        Ze4hRgkOZiUR3tsv9WOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2C
        yTJxcEo1MHoUFwkXCFnftwv69231ceVTGq6NQWejr34/vGL/2aPfo04Yn0mo8Ty7WGmKcn6R
        bw3bzp2RiUsXHmF6Ubb/Cnuf1j8Z49lH1//XEHuuFWK79q9zc3fjpbOaV0/s+z79sNSKpJwd
        i4+ceD+7YFoCg/NEtZZzatbPslutvq9uXGpseXg17wejv6+VWIozEg21mIuKEwF+qOfaXAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7pPqw1iDc5eF7PYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl91i6fWLTBa3G1ewWSza+oXd
        4v+eHewOvB5r5q1h9Ni0qpPNY/OSeo++LasYPT5vkgtgjdKzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOHn1HWPBY+aKU6/2sDYw/mXqYuTgkBAw
        kZj+UK+LkZNDSGApo8ShJ7YQYSmJ+S1KIGEJAWGJP9e62LoYuYBKXjNK3Dz5jxkkISwQIdE0
        8xYLiC0ioCjxu20aK0gRs8BRJol9iz8wQXQ8YpRY/e4vO0gVm4ChRO/RPkYQm1fATqKh6TuY
        zSKgKnHh1AYwWxRo6qRrO1kgagQlTs58AmZzCmhLnOxuBpvDLKAu8WfeJWYIW1yi6ctKVghb
        XmL72znMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNZt
        x35u2cHY9S74EKMAB6MSD29ArkGsEGtiWXFl7iFGCQ5mJRHe2y/1Y4V4UxIrq1KL8uOLSnNS
        iw8xmgI9N5FZSjQ5H5hI8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFx
        cEo1MC5yd+c5cYlTcwbHmVvNk6cfNZ3v3/V2qlXZgdjFezb+y5k3V4B1xeewfY48P6JrUpMm
        rlL/WrTMZ+9WvodFUrc6TS5WT50zzWXB0s37Y+NWHrY6ZDblvFpZYl7exLO7OiZ4fvp23mVe
        8eyJ5dbVJbUCG5+t2+yZtSx1XfEtIeGwO3EVTN8fWj9VYinOSDTUYi4qTgQAL/pWSuwCAAA=
X-CMS-MailID: 20190718140213eucas1p2c57432f2d3b1a0ef3d00e999398e482e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190404172234epcas1p37667ec0996000aff9297f13639908dfc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190404172234epcas1p37667ec0996000aff9297f13639908dfc
References: <20190404171735.12815-1-s.nawrocki@samsung.com>
        <CGME20190404172234epcas1p37667ec0996000aff9297f13639908dfc@epcas1p3.samsung.com>
        <20190404171735.12815-4-s.nawrocki@samsung.com>
        <20190429172337.GA30032@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/19 19:23, Rob Herring wrote:
> We already have OPP tables defined for QCom CPUs to do speed bining, and 
> I just reviewed something from Allwinner for similar purposes. We can't 
> have each vendor doing their own thing here.

I tried that opp-supported-hw bitmask approach but number of OPP DT nodes
was rather high, around 200 per CPU cluster.  So I moved OPP tables to
the driver. I'm going to post next version of the patch set soon.

-- 
Regards,
Sylwester
