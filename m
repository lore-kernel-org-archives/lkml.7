Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F67C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67562084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QM+RNgrz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FYIVf/4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDIR5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:57:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDIR5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:57:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2B1F160E75; Tue,  9 Apr 2019 17:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554832644;
        bh=ixONivm/dFo0+y48/K5Fxq7AJVSB3x3X0PFWookC5Ew=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QM+RNgrzMvy3Ja6WOvW2HTrKoluOSU9JWUJbNzkbLHABu9TS0CJnzzryV6ApwpIBp
         uiuzATMnuIEIsc3Sy0mpJ7r7DBkGGEDPZebWR3ygQYF+9lOC4aU7lVsMrlHITzmMsj
         0r7vAGs1rPPQ783fPYWMfreHgPPI9a9Rs8cD5kIk=
Received: from [10.79.161.180] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6776460746;
        Tue,  9 Apr 2019 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554832643;
        bh=ixONivm/dFo0+y48/K5Fxq7AJVSB3x3X0PFWookC5Ew=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FYIVf/4zDHaCYTfTTjBKDYflDCU6Rl6uV53J9JmW7OUnyRf23poWDutxwCzckSHjv
         bXbt300EVgfCIek0dcumN7MsD77St3dAgIIAS6v7IC5TFuqUhY6Atvhy3WBbXQOxfy
         0csHwaenyLHb/MmMVjwrIfkhzNwRk1sWvyshkL1U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6776460746
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH][next] scsi: qla2xxx: fix spelling mistake "alredy" ->
 "already"
To:     Colin King <colin.king@canonical.com>, qla2xxx-upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190408082014.1354-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <f03ae123-abef-9e3d-95df-fec1cb81b6c0@codeaurora.org>
Date:   Tue, 9 Apr 2019 23:26:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408082014.1354-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/2019 1:50 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a ql_log message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
> index 1ca63e80a7fe..3a6160ca9b4a 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.c
> +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> @@ -205,7 +205,7 @@ static void qla_nvme_abort_work(struct work_struct *work)
>   	if (atomic_read(&sp->ref_count) == 0) {
>   		WARN_ON(1);
>   		ql_log(ql_log_info, fcport->vha, 0xffff,
> -			"%s: command alredy aborted on sp: %p\n",
> +			"%s: command already aborted on sp: %p\n",
>   			__func__, sp);
>   		return;
>   	}
