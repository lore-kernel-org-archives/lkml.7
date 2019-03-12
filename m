Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B623C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DC5206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCLMGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:06:14 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:52932 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbfCLMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:06:13 -0400
X-IronPort-AV: E=Sophos;i="5.58,471,1544482800"; 
   d="scan'208";a="373037623"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 13:06:11 +0100
Date:   Tue, 12 Mar 2019 13:06:09 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     "Milan P. Gandhi" <mgandhi@redhat.com>
cc:     kernel-janitors@vger.kernel.org, qla2xxx-upstream@qlogic.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Fix a small typo in qla_bsg.c
In-Reply-To: <20190312115313.GA12695@machine1>
Message-ID: <alpine.DEB.2.20.1903121305220.4097@hadrien>
References: <20190312115313.GA12695@machine1>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Mar 2019, Milan P. Gandhi wrote:

> This patch fixes a minor formatting issue with comment section and a
> typo for 'iiDMA' cmd in drivers/scsi/qla2xxx/qla_bsg.c

This seems to be two completely unrelated changes.  The subject line
promises only one change, and indeed only one change per patch would have
been better.  You should make a series.

julia

>
> Signed-off-by: Milan P. Gandhi <mgandhi@redhat.com>
> ---
> diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
> index 17d42658ad9a..2353be988907 100644
> --- a/drivers/scsi/qla2xxx/qla_bsg.c
> +++ b/drivers/scsi/qla2xxx/qla_bsg.c
> @@ -1,4 +1,4 @@
> -	/*
> +/*
>   * QLogic Fibre Channel HBA Driver
>   * Copyright (c)  2003-2014 QLogic Corporation
>   *
> @@ -1354,7 +1354,7 @@ qla24xx_iidma(struct bsg_job *bsg_job)
>
>  	if (rval) {
>  		ql_log(ql_log_warn, vha, 0x704c,
> -		    "iIDMA cmd failed for %8phN -- "
> +		    "iiDMA cmd failed for %8phN -- "
>  		    "%04x %x %04x %04x.\n", fcport->port_name,
>  		    rval, fcport->fp_speed, mb[0], mb[1]);
>  		rval = (DID_ERROR << 16);
>
