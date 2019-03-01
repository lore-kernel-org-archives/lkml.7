Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ADDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C020120675
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Opr5/aCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbfCAOp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:45:57 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56517 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388299AbfCAOp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:45:56 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190301144555euoutp01d4f6e079975c286b3c23e788ffa86376~H3Pg61tls2769327693euoutp01i
        for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2019 14:45:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190301144555euoutp01d4f6e079975c286b3c23e788ffa86376~H3Pg61tls2769327693euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551451555;
        bh=xUKGahBStRpVDvuKCNi90H4mrzoc2f5GUFxLNjnLP3I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Opr5/aCosuni2pTDOIIsoWoylyN8DMSo286V2omkLfN4VB4PFI6zY3pKakCAo3WII
         Phzio9CHg6sd9w1MoDA2XzhYynKInfKMJ7eefkr5Oplr4Qt21TZT0uHj+1VFBheq1+
         nmHu3yJ4bjL/qtQK8GW0NrBOnAOzgMLP26tRMti4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190301144554eucas1p29d5bfe928ec7e48c7483e73b505067bd~H3PgjZg2n0954409544eucas1p2T;
        Fri,  1 Mar 2019 14:45:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 31.A1.04441.2A5497C5; Fri,  1
        Mar 2019 14:45:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190301144553eucas1p18099a26127761a8c1d13bb5ec7a0390b~H3Pfh03mv1598015980eucas1p1m;
        Fri,  1 Mar 2019 14:45:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190301144553eusmtrp1ce9a6d1bd686d1fe578e3b68a0011e74~H3PfTqq6-2538925389eusmtrp1o;
        Fri,  1 Mar 2019 14:45:53 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-87-5c7945a2a272
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 92.45.04284.1A5497C5; Fri,  1
        Mar 2019 14:45:53 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190301144553eusmtip2dd1fb1ee6fd88fa7704d1c8a32bf24df~H3PfCmSIh2127821278eusmtip2N;
        Fri,  1 Mar 2019 14:45:53 +0000 (GMT)
Subject: Re: [PATCH] fbdev: omap2: fix warnings in dss core
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <5ceb8653-055d-e4eb-a705-0bfd243e132c@samsung.com>
Date:   Fri, 1 Mar 2019 15:45:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190213084721.29624-1-anders.roxell@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOd1FrpUxBjMmq1vcmvKbyeLK1/ds
        Fif6PrBaXN41h81i9pJ+FgdWjzvX9rB53O8+zuTxeZNcAHMUl01Kak5mWWqRvl0CV8bb7Y1s
        BSc4Kl4+aWJuYOxn72Lk5JAQMJHYuG0faxcjF4eQwApGif/TtjNCOF8YJbbsWMwO4XxmlJg0
        eQorTMuKU5egEssZJR7928oG4bxnlLj6+ypTFyMHh7CAtcSqHzUgDSICOhJzX59nBrGZBWok
        jr7eBbabTcBKYmL7KkaQcl4BO4m2R+YgYRYBFYm1Hy+zgoRFBSIk+s+og4R5BQQlTs58wgJi
        cwJVb9+xiw1iorxE89bZzCAXSAg0s0vM+3SVBaRXQsBFYluLK8TJwhKvjm+B+lhG4vTkHhaI
        +umMEm9+LYVy1jNKrDlzjAmiylri8PGLYEcwC2hKrN+lDxF2lHg36xITxHw+iRtvBSFu4JOY
        tG06M0SYV6KjTQiiWk1iw7INbDBru3auhCrxkNj/K3ACo+IsJI/NQvLMLIS1CxiZVzGKp5YW
        56anFhvmpZbrFSfmFpfmpesl5+duYgQmj9P/jn/awfj1UtIhRgEORiUe3gqtyhgh1sSy4src
        Q4wSHMxKIrwzLIFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4
        OKUaGIUnz9T9e/OP6o1lBg8+rl957YTil5irQX2zZgZutvKPeRkVdanp/TE172YT5VvVJUbR
        TPY29+Y6bdovOXXuA60UQVnTtTY8Ih3t388f3jvb74qjVuGT/S31kdN2SvgnVuc8nvrGtI8l
        s+rnXvWZa0xci/+v8F6sw7dvp91D3zVb1996/L8oco8SS3FGoqEWc1FxIgCijBi+GgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Pd2FrpUxBmfvqVjcmvKbyeLK1/ds
        Fif6PrBaXN41h81i9pJ+FgdWjzvX9rB53O8+zuTxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWR
        nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbb7Y1sBSc4Kl4+aWJuYOxn72Lk5JAQ
        MJFYceoSkM3FISSwlFFi0cnXbF2MHEAJGYnj68sgaoQl/lzrYoOoecsoMeH2EhaQGmEBa4lV
        P2pAakQEdCTmvj7PDFEzkVHiyeUPYAuYBWokmlqvgNlsAlYSE9tXMYL08grYSbQ9MgcJswio
        SKz9eJkVxBYViJC49bCDBcTmFRCUODnzCZjNCVS+fccuNoiR6hJ/5l1ihrDlJZq3zmaewCg4
        C0nLLCRls5CULWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREYGduO/dy8g/HSxuBDjAIc
        jEo8vBValTFCrIllxZW5hxglOJiVRHhnWAKFeFMSK6tSi/Lji0pzUosPMZoCPTGRWUo0OR8Y
        tXkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhjlfigqdy2/FHqP
        JcUoQk5HRPl/IHvkjIhL728I2RuZnYhK8L0R1muVLvYggp3fUqlW7eoPo0+7zBiu32pc/415
        heqWn0GfNQ78/Z//qe/RhkUyy4RfbNn6YeHRk/rM+d/+HJzTvU2Ca7pSk3mUTfefErm3LY3P
        +HMv75/EdvzGdPH8LeY8/ueVWIozEg21mIuKEwHVBOuRogIAAA==
X-CMS-MailID: 20190301144553eucas1p18099a26127761a8c1d13bb5ec7a0390b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190213084828epcas3p2d7f70d63c5e267197de5513ae96b4fc2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190213084828epcas3p2d7f70d63c5e267197de5513ae96b4fc2
References: <CGME20190213084828epcas3p2d7f70d63c5e267197de5513ae96b4fc2@epcas3p2.samsung.com>
        <20190213084721.29624-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/13/2019 09:47 AM, Anders Roxell wrote:
> Commit 60d2fa0dad06 ("fbdev: omap2: no need to check return value of
> debugfs_create functions") changed the declaration of the return value
> of function dss_debugfs_create_file() and the following two warnings
> appeared:
> 
> drivers/video/fbdev/omap2/omapfb/dss/core.c: In function ‘dss_debugfs_create_file’:
> drivers/video/fbdev/omap2/omapfb/dss/core.c:139:9: warning: ‘return’ with a value,
>  in function returning void
>   return 0;
>          ^
> drivers/video/fbdev/omap2/omapfb/dss/core.c: In function ‘omap_dss_probe’:
> drivers/video/fbdev/omap2/omapfb/dss/core.c:172:6: warning: unused variable ‘r’
>  [-Wunused-variable]
>   int r;
>       ^
> 
> Rework so function dss_debugfs_create_file() that is declared to return
> void don't 'return 0' and remove the declaration of the unused variable
> 'r'.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
