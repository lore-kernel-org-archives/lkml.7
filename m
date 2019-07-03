Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4D6C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E801821881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGCSZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:25:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41579 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCSZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:25:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so3512286qtj.8;
        Wed, 03 Jul 2019 11:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYrr2XkrtgdorZ+tdABJeKy5zju0JjS/EkkrPZfhGno=;
        b=inS/DIPdSoPfTHLiDf1At1P3aXyuv1m9trP5THMKCNAhLlUNSsHOpUn/+WSOyjCYd0
         a9FYUNgoE9h5Q0HkBhk0nS2TuEd90Nw8VTmvzA4gfn0cPD4LFJPoeePLOOG2V9tdaZXF
         YuYJqrUtHZYCbBTzOOnxCuNNv76zSe7VYUenXn9m+GHR+sH0WqUyJFoqV+Gpcds6NDvc
         U8Kbay8bMpOwBKhEpUnHTvtwaeQVdiC2DxeudmdXWYKA9EGj2CFReOCeFmUTQU4+CCn4
         +yuKc3HOVRV/McKZTTVS5VOxjHSyZxdjaOaOiHQnxcxawpictsgUVv9MnBJ3SPOhf8W8
         5Q8Q==
X-Gm-Message-State: APjAAAUYhcJ9XJTjGJRLXhqCvRdAhdH6rKMbtfYpxgCHkUEsurHOdDHF
        JyqWLTM8I2GhKjVVaLy26R1RLFJNTteYXl9xMNs=
X-Google-Smtp-Source: APXvYqxNIjufeVEK1O1zdHGp08z8xlfUA3yLG9ntzbfi0UnYDfHY6JYgxc3gO/5VgfXlAEeC2twCgVEHAIWxpfJ/Wxo=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr31066092qtn.304.1562178317199;
 Wed, 03 Jul 2019 11:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190703133940.1493249-1-arnd@arndb.de> <7584cf05-e3f9-7027-a08c-87efbfb0f608@synopsys.com>
In-Reply-To: <7584cf05-e3f9-7027-a08c-87efbfb0f608@synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Jul 2019 20:24:56 +0200
Message-ID: <CAK8P3a2VS0TCNQa7r_C09fFD2uYiMn79V25B90Opx6SYC51idw@mail.gmail.com>
Subject: Re: [PATCH] ARC: hide unused function unw_hdr_alloc
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n Wed, Jul 3, 2019 at 6:13 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> On 7/3/19 6:39 AM, Arnd Bergmann wrote:
> > As kernelci.org reports,
>
> Curious, how are you getting these reports ? I want to see as well.

I'm subscribed to the mailing list at

https://lists.linaro.org/mailman/listinfo/kernel-build-reports

I think you can also ask the kernelci folks to get a different subset of
the build reports.

     Arnd
