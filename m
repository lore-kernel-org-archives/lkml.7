Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B19C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D60720665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hXReIxZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391283AbfGWSRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:17:24 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38441 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbfGWSRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:17:24 -0400
Received: by mail-ua1-f68.google.com with SMTP id j2so17334427uaq.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82d9c75d2N5edHNgI510WWQsvw//3O8L7Akked9Pdus=;
        b=hXReIxZrRnD1TqXU0vlEWk6jzlmDLpgM0IMU0/QsxPFfyftBuYsmhFuHJxqiuTFAUi
         prSYvMNSOyATO9LAspoPhPCRFVKo79B9UfqDzaVh3FsOYxirUViCGTJE9C7FnzyyNnAp
         kqXyFHIHz04iGyjQBM79sfXLnwPTIghYjsud4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82d9c75d2N5edHNgI510WWQsvw//3O8L7Akked9Pdus=;
        b=o7kevoVBZIYqqk4SPzU0/7vWjPoGVjetAWZsvaJXMCfL6N3rrhdzK81szDP8LBitnR
         VDvOimrwMI0Ay6jfo9J7T+v044TEBggpP9WqKWQS4YqqtkhH6jTdXxB2kA3H1k/cq2BU
         dKOOVRl6YJhwpHWMKrM8HusI6UMoTz2bxLT/diXM6r5O5uiyiLED7Fjp+MOMs4InZ3iV
         uUwkfV9TJuA/7SYjVWBeAzfzW8dxmwn/vrEdtThIR5vNIydPWN8du9fFqSDCub2S+Yd9
         lRIiZlbgAy+F5GEWp72qqV+L1P2I7DqVNBJbqt/5MUsEiNcgB3JDbpciBF9PJWpUpN+b
         Y7fw==
X-Gm-Message-State: APjAAAVlPEuuzCPD2VnsBMwiL9kqDm5h1Xr1ES4imlTJ9WsGHxdna/qv
        BoOKvW5f6f9+tR/mPOCrWc35/vc9KXWlRcaqaZOaHA==
X-Google-Smtp-Source: APXvYqyYqdC0VtXJ1fmDprfj3PHJhgNn1E+lUKXbEwOkrnpKi3XLMDgYKQw8xVEM+dv1QiaoM9bLy9iF/y4lCSZphUY=
X-Received: by 2002:ab0:4993:: with SMTP id e19mr49852000uad.2.1563905843320;
 Tue, 23 Jul 2019 11:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190720215840.23831-1-colin.king@canonical.com>
In-Reply-To: <20190720215840.23831-1-colin.king@canonical.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Tue, 23 Jul 2019 23:47:11 +0530
Message-ID: <CAL2rwxp_MNBiouBmAEXidEVxoLmb74dZWbGTPyTazH+MRe_sFg@mail.gmail.com>
Subject: Re: [PATCH][next] scsi: megaraid_sas: fix spelling mistake
 "megarid_sas" -> "megaraid_sas"
To:     Colin King <colin.king@canonical.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 3:28 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Fix spelling mistake in kernel warning message and replace
> printk with with pr_warn.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index b2339d04a700..2590746c81e3 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -8763,7 +8763,7 @@ static int __init megasas_init(void)
>
>         if ((event_log_level < MFI_EVT_CLASS_DEBUG) ||
>             (event_log_level > MFI_EVT_CLASS_DEAD)) {
> -               printk(KERN_WARNING "megarid_sas: provided event log level is out of range, setting it to default 2(CLASS_CRITICAL), permissible range is: -2 to 4\n");
> +               pr_warn("megaraid_sas: provided event log level is out of range, setting it to default 2(CLASS_CRITICAL), permissible range is: -2 to 4\n");
>                 event_log_level = MFI_EVT_CLASS_CRITICAL;
>         }
>
> --
> 2.20.1
>
