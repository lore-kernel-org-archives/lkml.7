Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA158C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB0820717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dJzYZ3B+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfIMJz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:55:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38771 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387588AbfIMJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:55:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id h17so25053646otn.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMQYVHEWLYiHDyJ6nTZFM9bO2lcGE6JPb6li8qp7+Vk=;
        b=dJzYZ3B+/+gdgBIxCnf0X6itRvlfNcX7If2XgYPo5Ssp7hdAepbogmTZly9CF/3YaU
         lJE6KuYWAxZYeSG8Ti8SOEg0Bc0mrcXVMo7eNZuiUel54x/TFKXkg6Viw9w2U/J/BYCP
         hYscKPhgytjFQTDbt1ZajAMSP+ZI4tGFtwGUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMQYVHEWLYiHDyJ6nTZFM9bO2lcGE6JPb6li8qp7+Vk=;
        b=myZo4lSWb9BEQP8nmTpVT/ylcI57AaCNbiJp8mdUGbgzyCEtpk2yRp/Hxitjrf++a7
         kvQDJSDU18NpE/Hh/EEQmcDB5ksDE4TMwXtF2ONbVuDNyJjVpsthC1Wcr0F3wEefUlQK
         1b+pW9LRR+XFt4iG+Gw1MLsGQXx/DtNSmiN+GMbnGrVTSS/BFyYU82TDkOoaYnD+MilM
         bYnIUeHW8qsPXwDJnlVX8Ialc+fZw6d2B/wIKy749mAWfT2ql6lYYv3eLKhvO2USry8W
         /XH8y4XzlY9kijODLREpCba7sE+C/orPjP+u9LKW2eg0upTyRYoqKle6UoMg+os1wutp
         4TLQ==
X-Gm-Message-State: APjAAAXXwUZgU5xn7AH1CfrkPvsnXfPeitSMojdkJj6FPzuCg6aiaV1t
        CGXRpMLizODwBdqs2k06cCMMygw6KqbT84y9Zs/4jA==
X-Google-Smtp-Source: APXvYqw+1a84R4pBtZm3Y54xxn1FobvFYUznqgrUfd5/p6M55wi73uijrk14i87/KA7+sR2LmnCkMGF2HZR7ArTo1Co=
X-Received: by 2002:a9d:37c7:: with SMTP id x65mr37287063otb.47.1568368556464;
 Fri, 13 Sep 2019 02:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190911092856.11146-1-colin.king@canonical.com> <20190912150957.GA9160@mellanox.com>
In-Reply-To: <20190912150957.GA9160@mellanox.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Fri, 13 Sep 2019 15:25:45 +0530
Message-ID: <CA+sbYW1MWTBa-yG+Z2Z5KwZGfwRTOdLpzL64fE35OEeGrPbgeQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re: fix spelling mistake "missin_resp" -> "missing_resp"
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Colin King <colin.king@canonical.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 8:40 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Wed, Sep 11, 2019 at 10:28:56AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a spelling mistake in a literal string, fix it.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> > index 604b71875f5f..3421a0b15983 100644
> > --- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
> > +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> > @@ -74,7 +74,7 @@ static const char * const bnxt_re_stat_name[] = {
> >       [BNXT_RE_SEQ_ERR_NAKS_RCVD]     = "seq_err_naks_rcvd",
> >       [BNXT_RE_MAX_RETRY_EXCEEDED]    = "max_retry_exceeded",
> >       [BNXT_RE_RNR_NAKS_RCVD]         = "rnr_naks_rcvd",
> > -     [BNXT_RE_MISSING_RESP]          = "missin_resp",
> > +     [BNXT_RE_MISSING_RESP]          = "missing_resp",
>
> Broadcom folks, can you confirm if this is OK? Is the string ABI for
> this driver?
>

 bnxt_re doesn't have a string ABI.
This is a spelling mistake while posting the patch and it is okay to
merge this patch.

Thanks
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
