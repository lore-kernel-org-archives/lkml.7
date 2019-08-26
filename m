Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DE9C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D0720578
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfHZJJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:09:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50884 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfHZJJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:09:02 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 3eeff57f6b629e63; Mon, 26 Aug 2019 11:09:00 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ACPI: SBS: remove unused variable 'SMBUS_PEC'
Date:   Mon, 26 Aug 2019 11:08:59 +0200
Message-ID: <174115399.5Pdya9bJQt@kreacher>
In-Reply-To: <20190822144346.12028-1-yuehaibing@huawei.com>
References: <20190822144346.12028-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 22, 2019 4:43:46 PM CEST YueHaibing wrote:
> drivers/acpi/sbshc.h:18:17: warning:
>  SMBUS_PEC defined but not used [-Wunused-const-variable=]
> 
> SMBUS_PEC is never used since introduction in
> commit 91087dfa51a2 ("ACPI: SBS: Split host
> controller (ACPI0001) from SBS driver (ACPI0002)"),
> so just remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/acpi/sbshc.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/sbshc.h b/drivers/acpi/sbshc.h
> index 06372a3..c3522bb 100644
> --- a/drivers/acpi/sbshc.h
> +++ b/drivers/acpi/sbshc.h
> @@ -15,8 +15,6 @@ enum acpi_smb_protocol {
>  	SMBUS_BLOCK_PROCESS_CALL = 0xd,
>  };
>  
> -static const u8 SMBUS_PEC = 0x80;
> -
>  enum acpi_sbs_device_addr {
>  	ACPI_SBS_CHARGER = 0x9,
>  	ACPI_SBS_MANAGER = 0xa,
> 

Applied, thanks!



