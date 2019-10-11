Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00878C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B16206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l6CJwqg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfJKOPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:15:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44798 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfJKOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:15:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9BEFmYP096153;
        Fri, 11 Oct 2019 09:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570803348;
        bh=I7dmdvdBlPphNfATj/muSzDDbXFjLuTMgHnQzMfBLp8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=l6CJwqg679RNJl0FUVfo3oadknuvU8IJbRG0ebFSmgkqfMg5tr3YOMUUiYap2Pfsi
         9eK2uBb7YW+yQirefJRTxo1QzN/ze4nHN7bNJv8Gs4InfEpjHt1V15HfLJ6JcZofjd
         qaEnz7eugmgjmKcsWboGXirqYYS3Z97+qyQS4ztc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9BEFm9Y066706;
        Fri, 11 Oct 2019 09:15:48 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 11
 Oct 2019 09:15:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 11 Oct 2019 09:15:43 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id x9BEFlkk101141;
        Fri, 11 Oct 2019 09:15:47 -0500
Date:   Fri, 11 Oct 2019 09:18:23 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Colin King <colin.king@canonical.com>
CC:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        <linux-media@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] media: ti-vpe: vpe: use r2y instead of y2r,
 copy-paste error
Message-ID: <20191011141823.kyxz32c2p24rr3d3@ti.com>
References: <20191011132940.8995-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191011132940.8995-1-colin.king@canonical.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote on Fri [2019-Oct-11 14:29:40 +0100]:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There appears to be a copy-paste error on the access of
> csc_coeffs.y2r.r601.full.coeff, I believe csc_coeffs.2yr.r601.full.coeff
> should be used instead. This is a moot point as the code is never
> reached, but at least use the correct structure element.
> 
> Addresses-Coverity: ("Copy-paste error")
> Fixes: 3ff3a712a9ea ("media: ti-vpe: vpe: don't rely on colorspace member for conversion")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/media/platform/ti-vpe/csc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/ti-vpe/csc.c b/drivers/media/platform/ti-vpe/csc.c
> index bd923bee4a31..834114a4eebe 100644
> --- a/drivers/media/platform/ti-vpe/csc.c
> +++ b/drivers/media/platform/ti-vpe/csc.c
> @@ -238,7 +238,7 @@ void csc_set_coeff(struct csc_data *csc, u32 *csc_reg0,
>  				coeff = csc_coeffs.r2y.r709.limited.coeff;
>  		} else {
>  			/* Should never reach this, but it keeps gcc happy */
> -			coeff = csc_coeffs.y2r.r601.full.coeff;
> +			coeff = csc_coeffs.r2y.r601.full.coeff;
>  		}
>  	} else {
>  		*csc_reg5 |= CSC_BYPASS;

Reviewed-by: Benoit Parrot <bparrot.ti.com>

> -- 
> 2.20.1
> 
