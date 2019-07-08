Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E29C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E4020665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGHHyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:54:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46523 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfGHHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:54:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so15215954ote.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 00:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnWDiPvhwU3RR2emtC/EVC/Ubm3es3odvaASBd4kQ/M=;
        b=iWuG3p2vO1udwtGB4Yq21hTiwcBfqoIq1Vqz7gU809bG4haEo20rIV4UlyhzuoAhxl
         ca3wyGaLn1Z185/jUohGuBQoOWKDV0CH6+ThJZMt5s0j6SA0dGwGmrddneICIBJ/9yBT
         v778LHcK+rLWevV0tijZr3/nOTbnUgUqzVhcAk1Z1Dev0CNVxpNNaYZPhTOzunSF/jhr
         hrX8PjbBtzEYL45Z3guNRCca0Xb/WScz1ao6hpJDfeD1/qWIjgdToZh1QxtWyXnWPr5a
         U9J7eZqb7mPMdzxzAeWwhVJ2oNVFuTS9G+0cLj2sH/0Q+WZpHmvRJax7C7N8KYJ6CGj4
         PkcQ==
X-Gm-Message-State: APjAAAVeyGTrLUd3VyrdYBYIZqQD0iAzzxZ4X1eurYtBBhHsQWpNs8DX
        iLNilwRymknd4MvBfdzYC/OqPA/Z8Fq1VBgsJcJrJQ==
X-Google-Smtp-Source: APXvYqzCmeUlPg1ZvUjRzDixJzUeoktPM2AVQcwWd/J9BTHPBZLm5/K4ET0DctJ3ExlDvKL11Zj4ilWRG3yEHDL/wZ4=
X-Received: by 2002:a05:6830:210f:: with SMTP id i15mr13375924otc.250.1562572447087;
 Mon, 08 Jul 2019 00:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190625090135.18872-1-hch@lst.de>
In-Reply-To: <20190625090135.18872-1-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jul 2019 09:53:55 +0200
Message-ID: <CAMuHMdX9QoEhyrAg_5WD03MB3bLoq6br-ZANEsLa=j9GPrs8hg@mail.gmail.com>
Subject: Re: switch m68k to use the generic remapping DMA allocator v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Jun 25, 2019 at 11:01 AM Christoph Hellwig <hch@lst.de> wrote:
> can you take a look at the (untested) patches below?  They convert m68k
> to use the generic remapping DMA allocator, which is also used by
> arm64 and csky.
>
> Changes since v2:
>  - fix kconfig dependencies to properly build on sun3
>  - updated a patch description to better explain why we are doing this

Thanks, both applied and queued for v5.3.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
