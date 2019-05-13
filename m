Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB1C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDCA208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+++fRZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfEMMAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:00:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34235 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfEMMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:00:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so7109894pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=p3WkRupLQANIn+eKZSEzZINagFb+f491TtMUB8rusGg=;
        b=N+++fRZ20jobeOpyLHYLAVEpUKQjraWab8bLt6j5ZOHrH4gRwoiEzPEVePueOg4EkT
         9aVhRhMNDREwNEbaja9OpqLvsmrwBITjfZtuZXZfVsGrxiBI5qlSlGtA8bTvgYsX80KS
         B+Hy3tLCB6h6eCpC1xwUwRjx3yvZPN2lf3v3ZLVVBiv5sT7Ty37OChUzb50/4pDZrLMq
         IE7CVxIDLsxzQNwTAEJyhwTyRmVumeHP1uFD1yumIOTTox/hWWkAOvidJivPGFVECEok
         h/vm8VxlFnVl0yawuGVtUryQDBrwPXuS1oTAGBafBvVx/JAv2fvyytV/jVpmYh/Ndcd7
         xm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p3WkRupLQANIn+eKZSEzZINagFb+f491TtMUB8rusGg=;
        b=WIklum9mwtDa07fjGve1NbsQCSTYgM0YUAgA+6hADUNPTbHEbGNzDlUVHI5+GeqFmY
         FWTE6uqcPyKMm9NqqA/iclAa8cNodAz9N7P4DKW0QDMv+clQ4Ze2zB9QbZIcuMAGRDF1
         2m2NjkIQ8TZ+C/NSC0JORhTxFl7/11t62psAz8qxfxiUFUIsdoRwnSoXUU+HG6Pq6flB
         Q/k7AUxSayuNfoQgtYdli/v/8MRSgC86Ph5KsGo2NM83j7GBRAZFFf/SqFPMNGlBqo+p
         Op+LGGN2PL8ESu4A2JXHBQI2jrp5LmGlWPZF0QAwrHTNqJ8Xo5941b5uwvjieqEpkUnM
         Wkhg==
X-Gm-Message-State: APjAAAVbKA6ZnpuASJ3tf+BhBh0+lhcGe8LZUMv2TVXZYP6RvY/SSF2p
        dhtXMi+nkwAc3rYg9ViVX47s1Iy+LLg=
X-Google-Smtp-Source: APXvYqwVCYzieQmt6igQ6RiswHOPk0cOUDa7zoOiLFCwJCK65CcHTjofK0vKPbo01BznaQ8ITVMLqQ==
X-Received: by 2002:a63:318b:: with SMTP id x133mr30649337pgx.297.1557748830228;
        Mon, 13 May 2019 05:00:30 -0700 (PDT)
Received: from [192.168.1.7] ([117.248.72.152])
        by smtp.gmail.com with ESMTPSA id t25sm29707082pfq.91.2019.05.13.05.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 05:00:29 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] Staging: kpc2000: kpc_dma: Resolve trailing
 whitespace error reported by checkpatch
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190513102622.22398-1-bnvandana@gmail.com> <20190513104920.GI18105@kadam>
From:   Vandana BN <bnvandana@gmail.com>
Message-ID: <73832a6a-bc47-5882-91af-b23727f33b87@gmail.com>
Date:   Mon, 13 May 2019 17:30:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513104920.GI18105@kadam>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oh ok.. thanks i will correct it.

On 13/05/19 4:19 PM, Dan Carpenter wrote:
> The Signed off by has to be before the first --- cut off line.
> Everything after the cut off is removed from the commit message.
