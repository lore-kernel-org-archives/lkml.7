Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22784FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32A02178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GFG8Bngh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKHOGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:06:16 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58928 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKHOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:06:16 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191108140613euoutp011d45072668c04633294c85a38fe6552c~VNQyslpKp0324403244euoutp01J
        for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2019 14:06:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191108140613euoutp011d45072668c04633294c85a38fe6552c~VNQyslpKp0324403244euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573221973;
        bh=N+JCkz4JeDOFadjc5rrFs2UE9NippHyLnoYIO9LMYBg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GFG8Bngh77npG5R41S8Ms7pbUOUb1LtJk00qFUfdrXwATH68iySYo8AFmnD3Rd5ke
         Sl3Sd2ddIGaPwfuWYkGPd8+bIFuwqPzSd635rHs8kGJpgLQin33Ndzuf2n4+g2nFaw
         6KPQdYQoYve1lUpvTyAFxYZCxk9tWu8NmeBd7fEM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191108140613eucas1p2fff573cac0dd5366361e9a6cc2d58071~VNQylDFbo0666806668eucas1p2u;
        Fri,  8 Nov 2019 14:06:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A9.18.04309.55675CD5; Fri,  8
        Nov 2019 14:06:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191108140612eucas1p152704f9fb95a6187f536beacd66097d7~VNQyLxode0694406944eucas1p1M;
        Fri,  8 Nov 2019 14:06:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191108140612eusmtrp12ef22e7307c356a0ee608d70bfb9d664~VNQyLM8d22316223162eusmtrp1c;
        Fri,  8 Nov 2019 14:06:12 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-dc-5dc576555138
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8B.24.04166.45675CD5; Fri,  8
        Nov 2019 14:06:12 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191108140612eusmtip2177259d5802e85fc4f9be980128fced7~VNQx0F0MB2151621516eusmtip2X;
        Fri,  8 Nov 2019 14:06:12 +0000 (GMT)
Subject: Re: [PATCH][V2] ata: pata_artop: make arrays static const, makes
 object smaller
To:     Colin King <colin.king@canonical.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <50c64370-067a-a15e-29d6-dff3fc25cc77@samsung.com>
Date:   Fri, 8 Nov 2019 15:06:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191006142956.23360-1-colin.king@canonical.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87qhZUdjDWY94bJYfbefzeL36l42
        i623pC2O7XjEZHF51xw2B1aPWQ29bB6Xz5Z6fN4kF8AcxWWTkpqTWZZapG+XwJVx/uZb9oKF
        fBV3Dp9haWD8xtXFyMkhIWAicevDAvYuRi4OIYEVjBKnrn1ihnC+MEpM+L0TyvnMKNH5aj0b
        TEvnoUtMEInljBILNr9khXDeMkpsOXAArEpYIEri4NTN7CC2iIC7xIxds5hAbGaBOIlX5z8x
        gthsAlYSE9tXgdm8AnYSk07+A+tlEVCReLJ3HyuILSoQIfHpwWFWiBpBiZMzn7CA2JxA9fu3
        trBAzBSXuPVkPtR8eYntb+eAnS0h0M8usfPwC6izXSS63uxjhrCFJV4d38IOYctInJ7cwwLR
        sI5R4m/HC6ju7YwSyyf/g+q2ljh8/CLQGRxAKzQl1u/Shwg7Siyfc4wRJCwhwCdx460gxBF8
        EpO2TWeGCPNKdLQJQVSrSWxYtoENZm3XzpXMExiVZiF5bRaSd2YheWcWwt4FjCyrGMVTS4tz
        01OLjfJSy/WKE3OLS/PS9ZLzczcxAlPL6X/Hv+xg3PUn6RCjAAejEg9vhMyRWCHWxLLiytxD
        jBIczEoivJwtQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTByc
        Ug2MwlUJ/FYS/S4ftx53uv94IWdEXGNwX2zebhN2vUM7DnvYiT1d+S39xv0LUre84qTdnn1x
        dl9rtMZivn/WopKYpX6bmUQDT1wPi5BMYFLbruG7/UddjN4n/6zLCb9aTxVN+LPxUJNH8PVf
        v5XfaNUGt8oeePXpwoNzsW+v3dM/eFA4P0No8/4TSizFGYmGWsxFxYkAZdbd5ikDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7ohZUdjDZpmGFisvtvPZvF7dS+b
        xdZb0hbHdjxisri8aw6bA6vHrIZeNo/LZ0s9Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0
        tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Ms4f/Mte8FCvoo7h8+wNDB+4+pi5OSQEDCR
        6Dx0iamLkYtDSGApo8SDe20sXYwcQAkZiePryyBqhCX+XOtiA7GFBF4zSlzYnARiCwtESRyc
        upkdxBYRcJeYsWsWE4jNLBAncebYD0aImRMZJTbsngLWzCZgJTGxfRUjiM0rYCcx6eQ/sDiL
        gIrEk737WEFsUYEIicM7ZkHVCEqcnPmEBcTmBKrfv7WFBWKBusSfeZeYIWxxiVtP5kMtlpfY
        /nYO8wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAuNo27Gf
        m3cwXtoYfIhRgINRiYd3g9yRWCHWxLLiytxDjBIczEoivJwtQCHelMTKqtSi/Pii0pzU4kOM
        pkDPTWSWEk3OB8Z4Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkG
        RsHsZpaAZPWNXe/Vr79vnXa8WujmXkapxZcThZ3OFAv0SvBVhXDP3RPRrC7GNqNe2rHU4cCd
        iL0HW9706Gy8UWEwu+KAbmm17Ld9Ydm3T374kvXZ3ynm+tJp6Sc6rLL9dPnruR44sDnc3Nz4
        V3xZk+WkEhafW9u7lTaFG33NeTzp2L11ydkmSizFGYmGWsxFxYkAXMMIpbkCAAA=
X-CMS-MailID: 20191108140612eucas1p152704f9fb95a6187f536beacd66097d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191006143000epcas2p168872c0c7b1e1879e31931d3244dfd4d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191006143000epcas2p168872c0c7b1e1879e31931d3244dfd4d
References: <CGME20191006143000epcas2p168872c0c7b1e1879e31931d3244dfd4d@epcas2p1.samsung.com>
        <20191006142956.23360-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/6/19 4:29 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const arrays on the stack but instead make them
> static. Makes the object code smaller by 292 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    6988	   3132	    128	  10248	   2808	drivers/ata/pata_artop.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    6536	   3292	    128	   9956	   26e4	drivers/ata/pata_artop.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> 
> V2: fix up commit message
> 
> ---
>  drivers/ata/pata_artop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index 3aa006c5ed0c..6bd2228bb6ff 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -100,7 +100,7 @@ static void artop6210_load_piomode(struct ata_port *ap, struct ata_device *adev,
>  {
>  	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
>  	int dn = adev->devno + 2 * ap->port_no;
> -	const u16 timing[2][5] = {
> +	static const u16 timing[2][5] = {
>  		{ 0x0000, 0x000A, 0x0008, 0x0303, 0x0301 },
>  		{ 0x0700, 0x070A, 0x0708, 0x0403, 0x0401 }
>  
> @@ -154,7 +154,7 @@ static void artop6260_load_piomode (struct ata_port *ap, struct ata_device *adev
>  {
>  	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
>  	int dn = adev->devno + 2 * ap->port_no;
> -	const u8 timing[2][5] = {
> +	static const u8 timing[2][5] = {
>  		{ 0x00, 0x0A, 0x08, 0x33, 0x31 },
>  		{ 0x70, 0x7A, 0x78, 0x43, 0x41 }
>  
