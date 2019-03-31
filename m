Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB8BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 08:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B906E20882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 08:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfCaIg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 04:36:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbfCaIg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 04:36:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 057A4AC3B;
        Sun, 31 Mar 2019 08:36:25 +0000 (UTC)
Date:   Sun, 31 Mar 2019 10:36:24 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     helgaas@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
Message-ID: <20190331103624.4a13c5ee@endymion>
In-Reply-To: <20190325183652.252175-1-helgaas@kernel.org>
References: <20190325183652.252175-1-helgaas@kernel.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 13:36:52 -0500, helgaas@kernel.org wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> convert i2c-isch to platform_device") removed the use of
> acpi_check_region() but not the include.
> 
> Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/i2c/busses/i2c-isch.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> index 5c754bf659e2..f64c1d72f73f 100644
> --- a/drivers/i2c/busses/i2c-isch.c
> +++ b/drivers/i2c/busses/i2c-isch.c
> @@ -30,7 +30,6 @@
>  #include <linux/ioport.h>
>  #include <linux/i2c.h>
>  #include <linux/io.h>
> -#include <linux/acpi.h>
>  
>  /* SCH SMBus address offsets */
>  #define SMBHSTCNT	(0 + sch_smba)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

(I would add a Fixes tag but maybe that's just me.)

Thanks,
-- 
Jean Delvare
SUSE L3 Support
