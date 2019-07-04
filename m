Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F60C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A437218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FO4I7i7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfGDJ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:26:25 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33987 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfGDJ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:26:24 -0400
Received: by mail-vs1-f67.google.com with SMTP id m23so1577331vso.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hyh+/KgfYoPmkb5oXW5TFTjDUdeJWMjqBJydbIwAvyU=;
        b=FO4I7i7BpQtxsmEcVH7rbJ5NUSzstdOIcpD5adeyGlSfR2BfnQZLEh15vmvaq2yn7Q
         A4i+cWlyysVUI5vI/GySsapidnWxeomqKzmytMz5MLvNku3eq7rl66wocYb3cAxTwyZP
         F8hXW4V7CIl9mRbm+tlz5UCu/TZYtjav5P8JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hyh+/KgfYoPmkb5oXW5TFTjDUdeJWMjqBJydbIwAvyU=;
        b=DRPgHXYfQluFJLCsp203m9K8NSWHVTdg9q3GSVx0jt+5eZ3CFQfnCtVFVqCJfY5td9
         woOfIuepO/+90jBibqq50xTtKM3Ut3zJFKG6Yk2HCKFzSn5N+N5ExNDv/lD1632WDTdc
         Cv6Fq8JJkCODK1BoF6EreUAuoa1vguauO+tDgehy7S6YsMrxxpmkcMgWpFuobPZE1pWf
         xiuR/EppUck+r4+KW0nHvw4oJGJMRMq53zDcbl/VKOypfbSUJ5mzTIu5oA0GagmJB3lO
         HDi+AnpJYb+olZetFmhtQCt3eJvIBSOGArSGfkbyLxbTKNWn3wYUz5dYBI2ehrkXx4CY
         Fnsg==
X-Gm-Message-State: APjAAAVzKl6YeBlubn4QXK9MxOZAZjwVo4vfs45mA3lBJR0DMfzI6RP5
        HJ358FrUdwAEZEreF1qBwwkcr7j+/RX1LWh5Erihnw==
X-Google-Smtp-Source: APXvYqzpBTOsuIo2jM1AJboCaE+3XQ7ZOcfbe7eldnBtROk/zMLG+m+Hyt4D7iMxx0o3rNOwPctugNdaSOOs109XC3Y=
X-Received: by 2002:a67:8c84:: with SMTP id o126mr21371282vsd.122.1562232383326;
 Thu, 04 Jul 2019 02:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190702130114.29356-1-yuehaibing@huawei.com>
In-Reply-To: <20190702130114.29356-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Thu, 4 Jul 2019 14:56:12 +0530
Message-ID: <CAL2rwxoLJ-1onwPPJKcQv5L=eGGi6+zUW3vtx0Cwx9peg+NAqA@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: Make some symbols static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 6:34 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/scsi/megaraid/megaraid_sas_base.c:271:1: warning: symbol 'megasas_issue_dcmd' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_base.c:2227:6: warning: symbol 'megasas_do_ocr' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_base.c:3194:25: warning: symbol 'megaraid_host_attrs' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 80ab970..49e0f3d 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -280,7 +280,7 @@ void megasas_set_dma_settings(struct megasas_instance *instance,
>         }
>  }
>
> -void
> +static void
>  megasas_issue_dcmd(struct megasas_instance *instance, struct megasas_cmd *cmd)
>  {
>         instance->instancet->fire_cmd(instance,
> @@ -2237,7 +2237,7 @@ megasas_internal_reset_defer_cmds(struct megasas_instance *instance);
>  static void
>  process_fw_state_change_wq(struct work_struct *work);
>
> -void megasas_do_ocr(struct megasas_instance *instance)
> +static void megasas_do_ocr(struct megasas_instance *instance)
>  {
>         if ((instance->pdev->device == PCI_DEVICE_ID_LSI_SAS1064R) ||
>         (instance->pdev->device == PCI_DEVICE_ID_DELL_PERC5) ||
> @@ -3303,7 +3303,7 @@ static DEVICE_ATTR_RO(fw_cmds_outstanding);
>  static DEVICE_ATTR_RO(dump_system_regs);
>  static DEVICE_ATTR_RO(raid_map_id);
>
> -struct device_attribute *megaraid_host_attrs[] = {
> +static struct device_attribute *megaraid_host_attrs[] = {
>         &dev_attr_fw_crash_buffer_size,
>         &dev_attr_fw_crash_buffer,
>         &dev_attr_fw_crash_state,
> --
> 2.7.4
>
>
