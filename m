Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5488CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F25E2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hFHICOXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfFDRek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:34:40 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:43967 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDRek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:34:40 -0400
Received: by mail-pg1-f172.google.com with SMTP id f25so10752056pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4WbrwLtDUXe8HTAdFzSzCI6MmrDej8XdLtQH+1WkJxA=;
        b=hFHICOXg5ScO/YJHqqF2FT4bBiGpihOGIKHl5ID+Fs7tuhHLCoUimQ0j0R13OTcCQ2
         oGYLIiOMyPJnydwnG4SKSpMpOoOWyqjSupIMzF3lQonYeamho4X6Ke/doYsodwYO9Xhj
         PBZs1IPvalwX9HhiwmW3el7cCkMlcpYAta4yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4WbrwLtDUXe8HTAdFzSzCI6MmrDej8XdLtQH+1WkJxA=;
        b=aZTd/xWLM7cTHMi93goJKvxg+7VIuQpzdshc/okCCkIrmIw8sr39Is3Kl2ZcqUdhpJ
         Ue2clxMm3RpnM5dfN3mKRia4vJH64brFGSvuZQaql1JrrH9aey/N8HG/lFDHHgvzz/82
         BITd7cKb6EknfEX9eqUr3gLZ7VnhRtY53RrqLbc81ZkCvj1Y4PhOXSpP2VKGrVNOehzh
         x7O7z/0i7a4jrM6t7n0JVJooFVz6lAfZvKvbeZH916lJb7i11vE6QvG7UkV4Tm2G8PuU
         pduubfGYjwT9Gark0e61nDVo7YkEToQ31CyhBq5bI57D6NrjoEpBglKsoE/wy6p/TAuH
         DuRw==
X-Gm-Message-State: APjAAAVAU4DoSppsOA6sDflDAciYxAQyJr1xhseZPCoNc/MwVsPTvLY7
        sIpqPyUeFkVTu/x3SFIyBg4S4Q==
X-Google-Smtp-Source: APXvYqwHenvbeywYajmzkPeaxvyRPC5N7HRT3eOsx4Ooigcvtbetz+9AEtW/a6j/0W3/q8+gKqmgiA==
X-Received: by 2002:a17:90a:23ce:: with SMTP id g72mr32288861pje.77.1559669679303;
        Tue, 04 Jun 2019 10:34:39 -0700 (PDT)
Received: from [10.230.29.90] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n184sm19870059pfn.21.2019.06.04.10.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:34:38 -0700 (PDT)
Subject: Re: [PATCH -next] scsi: lpfc: Remove set but not used variables 'qp'
To:     YueHaibing <yuehaibing@huawei.com>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jsmart2021@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190531152745.7928-1-yuehaibing@huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <a9496faa-6dd3-47dc-b5ba-7716c2b21940@broadcom.com>
Date:   Tue, 4 Jun 2019 10:34:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531152745.7928-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2019 8:27 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/scsi/lpfc/lpfc_init.c: In function lpfc_setup_cq_lookup:
> drivers/scsi/lpfc/lpfc_init.c:9359:30: warning: variable qp set but not used [-Wunused-but-set-variable]
>
> It's not used since commit e70596a60f88 ("scsi: lpfc: Fix
> poor use of hardware queues if fewer irq vectors")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>

Looks good - thank You

Reviewed-by: James Smart  <james.smart@broadcom.com>

