Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564CF2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AOPLZ71J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RBVVf9TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfC2HKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:10:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbfC2HKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:10:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 079CA6087D; Fri, 29 Mar 2019 07:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553843417;
        bh=fTmRJ0Ikgi+Z+X2xIKdBVKDGhs0L7AcQwgQVjfgpKa0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AOPLZ71J5A25IMWyC7C9iiLNnnzdKgx1VJ8Uu3Yp4+3Lwh7oz8V+/4oKCqphfElub
         26VjWUSKEMZIVOibQcBw9S9nXKmhPchByCQ9Ok70W2kg7VpFaSJmnTwu+95U+qRqC5
         glWOHyefq5M8D2GocXiE7/pVC5Ld2wbtesEnJbh8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECB3B606AC;
        Fri, 29 Mar 2019 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553843415;
        bh=fTmRJ0Ikgi+Z+X2xIKdBVKDGhs0L7AcQwgQVjfgpKa0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RBVVf9TN7B5S8z4+2cdWi38s6EfM2/6+FK6XNNtVW9N29q1Dd8VUzGyleeSy0ADU7
         SgP9Xj5v7jQpe63sSoS4xQnBDSddD5Uo3hE6mQaGVfILdQyCdAQ7TO6+BSLayB2njw
         qBHNlQ1zQBeyMXmyQDRDsscSoaXllIxzm8ueDiqw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECB3B606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] scsi: bnx2fc: remove unneeded variable
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        QLogic-Storage-Upstream@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553829852-16525-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <bde8b876-eda6-b23b-5401-cd07015fd767@codeaurora.org>
Date:   Fri, 29 Mar 2019 12:40:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553829852-16525-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 8:54 AM, Ding Xiang wrote:
> "rc" is unneeded,just return SUCCESS

"rc variable is  not needed in `bnx2fc_abts_cleanup`. Fix this by 
removing it ."


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

>
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>   drivers/scsi/bnx2fc/bnx2fc_io.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
> index bc9f2a2..8def63c 100644
> --- a/drivers/scsi/bnx2fc/bnx2fc_io.c
> +++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
> @@ -1083,7 +1083,6 @@ int bnx2fc_eh_device_reset(struct scsi_cmnd *sc_cmd)
>   static int bnx2fc_abts_cleanup(struct bnx2fc_cmd *io_req)
>   {
>   	struct bnx2fc_rport *tgt = io_req->tgt;
> -	int rc = SUCCESS;
>   	unsigned int time_left;
>   
>   	io_req->wait_for_comp = 1;
> @@ -1110,7 +1109,7 @@ static int bnx2fc_abts_cleanup(struct bnx2fc_cmd *io_req)
>   	kref_put(&io_req->refcount, bnx2fc_cmd_release);
>   
>   	spin_lock_bh(&tgt->tgt_lock);
> -	return rc;
> +	return SUCCESS;
>   }
>   
>   /**
