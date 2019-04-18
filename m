Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2CCC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CC0204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hHS69al3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BMG2PFXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbfDRF7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:59:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:59:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63568601B4; Thu, 18 Apr 2019 05:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555567180;
        bh=jG9oarzwAH68Z2H+DhCc64yxzHV5Npqd56dQpVPYMMw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hHS69al3e0+GpT1bcHqWyGMizQCA+4eAnJIfrINj3nQ/5FU3gW7B8LRw0ZK2ITw/6
         4kIVANXs9nEpG8RDPcs7qkmdX8KjLqU0w5u/B0pD2SBH33/K5Gu9UOihqq2uYX6qao
         h90YOPJf5LT7VHNeegyJKdF9SYuXxDhEawi6Ou7E=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41C80601B4;
        Thu, 18 Apr 2019 05:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555567179;
        bh=jG9oarzwAH68Z2H+DhCc64yxzHV5Npqd56dQpVPYMMw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BMG2PFXzZZjrB/Z2iRvxo62T9+zOz+Uoc5blzmWwaDlDfpQc/tp2X/kVPazIpjOXM
         t0WQikWTJBFtQC6MP7eh9wR/fXQli/+08jmQB+S0KFa4bXhP/hq8jnVgQGyR/iEyQ6
         zYpIvjSZ+ayF70Sq0WbEnBmYotDhqjuSrnUtGR58=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41C80601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] scsi: qedi: fix spelling mistake "oflload" -> "offload"
To:     Colin King <colin.king@canonical.com>,
        QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190417134304.10979-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <071b73b2-424d-0bb0-a663-c63ee0a94425@codeaurora.org>
Date:   Thu, 18 Apr 2019 11:29:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417134304.10979-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2019 7:13 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are a couple of spelling mistakes in some kernel alert messages.
> Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/scsi/qedi/qedi_iscsi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
> index 6d6d6013e35b..e4391ee2c27a 100644
> --- a/drivers/scsi/qedi/qedi_iscsi.c
> +++ b/drivers/scsi/qedi/qedi_iscsi.c
> @@ -579,7 +579,7 @@ static int qedi_conn_start(struct iscsi_cls_conn *cls_conn)
>   	rval = qedi_iscsi_update_conn(qedi, qedi_conn);
>   	if (rval) {
>   		iscsi_conn_printk(KERN_ALERT, conn,
> -				  "conn_start: FW oflload conn failed.\n");
> +				  "conn_start: FW offload conn failed.\n");
>   		rval = -EINVAL;
>   		goto start_err;
>   	}
> @@ -590,7 +590,7 @@ static int qedi_conn_start(struct iscsi_cls_conn *cls_conn)
>   	rval = iscsi_conn_start(cls_conn);
>   	if (rval) {
>   		iscsi_conn_printk(KERN_ALERT, conn,
> -				  "iscsi_conn_start: FW oflload conn failed!!\n");
> +				  "iscsi_conn_start: FW offload conn failed!!\n");
>   	}
>   
>   start_err:
