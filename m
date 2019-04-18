Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4E2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4604E2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V8nqZKqD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V8nqZKqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbfDRKlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:41:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40122 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388529AbfDRKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:41:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF6AB60274; Thu, 18 Apr 2019 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555584068;
        bh=5kVaoP3ltoplJ8p0UrArWH0oQeDPJw0TtvXYozklMVI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V8nqZKqDD9wC+kbSFdFYqZsndUuCyjQhPoD2o0PRinz+LppVdFQQGx7n5/pMuvh9U
         Sv6SLKFlxwph5oOvmnIIlfdxUaH821yFaSszc4RAOBqBUrYvz1MQ0KqRJlxKzUJR5Y
         +5UY6lJurz2C+hkMgBsMBkBRpvCfijJWpfLL4k9Y=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4569D60112;
        Thu, 18 Apr 2019 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555584068;
        bh=5kVaoP3ltoplJ8p0UrArWH0oQeDPJw0TtvXYozklMVI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V8nqZKqDD9wC+kbSFdFYqZsndUuCyjQhPoD2o0PRinz+LppVdFQQGx7n5/pMuvh9U
         Sv6SLKFlxwph5oOvmnIIlfdxUaH821yFaSszc4RAOBqBUrYvz1MQ0KqRJlxKzUJR5Y
         +5UY6lJurz2C+hkMgBsMBkBRpvCfijJWpfLL4k9Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4569D60112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] scsi: aic7xxx: fix spelling mistake "recevied" ->
 "received"
To:     Colin King <colin.king@canonical.com>,
        Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190418102025.10021-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a8edb273-1350-3387-900c-4ce7d80bd5dd@codeaurora.org>
Date:   Thu, 18 Apr 2019 16:11:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418102025.10021-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2019 3:50 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a kernel message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/scsi/aic7xxx/aic7xxx_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
> index d4a7263e4b8f..a9d40d3b90ef 100644
> --- a/drivers/scsi/aic7xxx/aic7xxx_core.c
> +++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
> @@ -1666,7 +1666,7 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
>   					printk("\tCRC Value Mismatch\n");
>   				if ((sstat2 & CRCENDERR) != 0)
>   					printk("\tNo terminal CRC packet "
> -					       "recevied\n");
> +					       "received\n");
>   				if ((sstat2 & CRCREQERR) != 0)
>   					printk("\tIllegal CRC packet "
>   					       "request\n");
