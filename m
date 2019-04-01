Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655FA20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TZkl/vHm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yxuw4Pur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfDAI3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:29:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDAI3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:29:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4FB856086B; Mon,  1 Apr 2019 08:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554107391;
        bh=j3ubdfca/muWHCAPL/bJN3HLJlnlDPi6lDSgbcnrF3Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TZkl/vHmfHEBIw02++Mq1AZvymE0EFL4u43t88WtQlIvoq/Us7waoXqBAyMPf0A+j
         CrBnWkLzXG5vVpvZCR2XDh+zQZV7X2VlawAE19nlWKLoR6wq8hM3iY0U9QSO309jd/
         uo6mQ6PkKqCJM2DbrpDqYCGKTJiUAjx04U2wmxZE=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 745BC608FF;
        Mon,  1 Apr 2019 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554107389;
        bh=j3ubdfca/muWHCAPL/bJN3HLJlnlDPi6lDSgbcnrF3Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Yxuw4Purg3zJqBn2s11aaBB4ja3GUcrycxbLq+hqwXMkepQZ1gDvf1xkjIFLmQePz
         8xa3Gjf1QOpyNqZbWyJp14L12lzGk7H7ploirR+vrfNm22MUDHnLTVaVJGfgeq6iPN
         UIuBkbp6K0cnzgwMGcZqsvRBG6BrUyuNfp8qskfA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 745BC608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] docs: core-api: Drop reference to flexible-arrays
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190331214159.13987-1-j.neuschaefer@gmx.net>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2c0c0001-0d7e-8dbc-2f38-c469ff57d508@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:59:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331214159.13987-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 3:11 AM, Jonathan Neuschäfer wrote:
> This file doesn't exist anymore.
>
> Fixes: 586187d7de71 ("Drop flex_arrays")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   Documentation/core-api/index.rst | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 6870baffef82..ee1bb8983a88 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -22,7 +22,6 @@ Core utilities
>      workqueue
>      genericirq
>      xarray
> -   flexible-arrays
>      librs
>      genalloc
>      errseq
> --
> 2.20.1
>
