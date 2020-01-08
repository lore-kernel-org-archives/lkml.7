Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96256C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B9F20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OAm3VBt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgAHToF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:44:05 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33914 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgAHToE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:44:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008Ji3ed032667;
        Wed, 8 Jan 2020 13:44:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578512643;
        bh=qb7bCEHbxdLwaBILj37/9DfnWNTmboocW2uFVUEMG0g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OAm3VBt0HvYttynA2J1hESCjYvJIN7sABufG2GFUrmErrtAO1wBcG9kpnjBI+SMGm
         q9u6NyQ5pvWNjtm5lGvlSO9NyvKDIurIfNdp6U2Lgec4HvrNZPoYbAsINqjmMkVS3z
         vJX9edHmXcCmV/f79CIZWAAW/YzfII51sSqN4HuM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008Ji3FW101772
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 13:44:03 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 13:44:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 13:44:03 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008Ji2D6024389;
        Wed, 8 Jan 2020 13:44:02 -0600
Subject: Re: [PATCHv4 08/14] remoteproc/omap: remove the platform_data header
To:     Tero Kristo <t-kristo@ti.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>, <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <linux-omap@vger.kernel.org>
References: <20200102131845.12992-1-t-kristo@ti.com>
 <20200102131845.12992-9-t-kristo@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <4391856a-d956-751e-6d38-02f8306bb691@ti.com>
Date:   Wed, 8 Jan 2020 13:44:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200102131845.12992-9-t-kristo@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/20 7:18 AM, Tero Kristo wrote:
> The platform data header for OMAP remoteproc is no longer used for
> anything post ti-sysc conversion, so just remove it completely.

Thanks for removing the header now altogether,
%s/ti-sysc/ti-sysc and DT/ to be more accurate.

With that,
Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> v4:
>   - new patch, to remove the platform data file completely compared to
>     patches #8 / #9 in previous version of the series
> 
>  include/linux/platform_data/remoteproc-omap.h | 51 -------------------
>  1 file changed, 51 deletions(-)
>  delete mode 100644 include/linux/platform_data/remoteproc-omap.h
> 
> diff --git a/include/linux/platform_data/remoteproc-omap.h b/include/linux/platform_data/remoteproc-omap.h
> deleted file mode 100644
> index 7e3a16097672..000000000000
> --- a/include/linux/platform_data/remoteproc-omap.h
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Remote Processor - omap-specific bits
> - *
> - * Copyright (C) 2011 Texas Instruments, Inc.
> - * Copyright (C) 2011 Google, Inc.
> - */
> -
> -#ifndef _PLAT_REMOTEPROC_H
> -#define _PLAT_REMOTEPROC_H
> -
> -struct rproc_ops;
> -struct platform_device;
> -
> -/*
> - * struct omap_rproc_pdata - omap remoteproc's platform data
> - * @name: the remoteproc's name
> - * @oh_name: omap hwmod device
> - * @oh_name_opt: optional, secondary omap hwmod device
> - * @firmware: name of firmware file to load
> - * @mbox_name: name of omap mailbox device to use with this rproc
> - * @ops: start/stop rproc handlers
> - * @device_enable: omap-specific handler for enabling a device
> - * @device_shutdown: omap-specific handler for shutting down a device
> - * @set_bootaddr: omap-specific handler for setting the rproc boot address
> - */
> -struct omap_rproc_pdata {
> -	const char *name;
> -	const char *oh_name;
> -	const char *oh_name_opt;
> -	const char *firmware;
> -	const char *mbox_name;
> -	const struct rproc_ops *ops;
> -	int (*device_enable)(struct platform_device *pdev);
> -	int (*device_shutdown)(struct platform_device *pdev);
> -	void (*set_bootaddr)(u32);
> -};
> -
> -#if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
> -
> -void __init omap_rproc_reserve_cma(void);
> -
> -#else
> -
> -static inline void __init omap_rproc_reserve_cma(void)
> -{
> -}
> -
> -#endif
> -
> -#endif /* _PLAT_REMOTEPROC_H */
> 

