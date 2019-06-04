Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338F0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D75220848
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G8k+cLgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFDRg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:36:59 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:41235 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfFDRg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:36:58 -0400
Received: by mail-pf1-f178.google.com with SMTP id q17so13113571pfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PWMUIeKcA67ntqsV3am8FfBRihyiBy43QFk2ZFto7CM=;
        b=G8k+cLgghyl2S4FplSud+2bVMT5NKiA95E/EsvA3Id8eyBSWWQO+H1Qn36aGOI74od
         iyuS0NrPRJ64HY+TAVrnfwZ9nBi4eeJf96ZEoFmdgl7xys/3aTbklO7/n2BscPxhsCvr
         p4ccpj/UwN1PK+qd/SHqYHgWtvkcRccwSSGLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PWMUIeKcA67ntqsV3am8FfBRihyiBy43QFk2ZFto7CM=;
        b=p4qMWSAzAuqVioVdma6qd3v5EKFto3Rr3sWMUg9b+q3BIHhXDP6IG5YBJz3qeFtXAA
         wViEtIMdhSIpSz/9KplZut/Tl1NPbXeidfH0RTzyaZdbnYrr/QT5DRVkJmqjnE2ddVBI
         iVfYVEgiKAB87OnB7k6znRWPrB7ZK6Oj0HsUlGoJKB2s2u8kF6YuBWYd4nE+n8B+xztN
         y23QWE+qN7M2N3Hu3zN06vIdyMkwOlJUguE1DvsKPKHk/VRjiGrGe2XopJm2ezlqbEDu
         UiPsjUZr0mALBrm/givJrxR/c6zooEahTEak4tWRa+tbaTAuEFPUbZdmxMnAsoh0YJb1
         ttuQ==
X-Gm-Message-State: APjAAAU8qfGJMetwNqefrdJQKPqw3BgRVMo2yWPBFHP+nFAyFwWiPzKa
        u5BPAN2yNUdYS2Rvbigj7aK1bA==
X-Google-Smtp-Source: APXvYqylI88kRmDNZ/oxDJWq9xsvDeuPxiCKRSLjyFzOzvV23vcUCd1kB3ZvXq0BVCsVf3c10ysEFw==
X-Received: by 2002:a17:90a:17cb:: with SMTP id q69mr10670208pja.8.1559669817477;
        Tue, 04 Jun 2019 10:36:57 -0700 (PDT)
Received: from [10.230.29.90] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k13sm11247632pgq.45.2019.06.04.10.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:36:56 -0700 (PDT)
Subject: Re: [PATCH -next] scsi: lpfc: Make some symbols static
To:     YueHaibing <yuehaibing@huawei.com>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jsmart2021@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190531152841.13684-1-yuehaibing@huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <e9a78d2a-a756-c42e-0c8d-af8ebf262615@broadcom.com>
Date:   Tue, 4 Jun 2019 10:36:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531152841.13684-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2019 8:28 AM, YueHaibing wrote:
> Fix sparse warnings:
>
> drivers/scsi/lpfc/lpfc_sli.c:115:1: warning: symbol 'lpfc_sli4_pcimem_bcopy' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_sli.c:7854:1: warning: symbol 'lpfc_sli4_process_missed_mbox_completions' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvmet.c:223:27: warning: symbol 'lpfc_nvmet_get_ctx_for_xri' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvmet.c:245:27: warning: symbol 'lpfc_nvmet_get_ctx_for_oxid' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_init.c:75:10: warning: symbol 'lpfc_present_cpu' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c  | 2 +-
>   drivers/scsi/lpfc/lpfc_nvmet.c | 4 ++--
>   drivers/scsi/lpfc/lpfc_sli.c   | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)
>
>

Looks good - thank You

Reviewed-by: James Smart  <james.smart@broadcom.com>


