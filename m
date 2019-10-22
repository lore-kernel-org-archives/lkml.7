Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6DDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781DA214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571743805;
	bh=OiFWgdUQNJpZkfwZF5qhHHv2CYR6/jxdauiVbE1smEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OeChmQXIGC/X0B1/Q/hT1o+q+Fwhh47nxrxWHCb97RA8IHvnMIFyCphBTrE3HAez0
	 BihFl1iOOlos1p6wJtxPT4rCnRiucHEVKtXqU2hRJQGDbrIQ8J4Z8Gxeq+sktXH2EJ
	 QCgdC48QgL9FUsBlNvXwaKcvGGgOr/5hNc+5KM0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbfJVLaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730515AbfJVLaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:30:04 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65844214B2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571743803;
        bh=OiFWgdUQNJpZkfwZF5qhHHv2CYR6/jxdauiVbE1smEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L2DiMycVh3TeWYESXegNaC7btZFDZKlKXG4zx+npVxrvnnMRQ+kMNaP9aqqD3Edl8
         rfHjUETkz1ZzPEUBB2x63sGPymVgVvKwXEHep5Yv5l63qKPsCVuiR4QXZxlShL8B9a
         ZVIJrTg29YIqwQ+wsjYleAUlJAEO8qn4wOoohsIY=
Received: by mail-qk1-f170.google.com with SMTP id 4so15850272qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 04:30:03 -0700 (PDT)
X-Gm-Message-State: APjAAAUufzhpsMU5WNbPxR2uyE8pEdGS9+pr/nBf7panVSJFMKd2mvkw
        CneDLnu7jLS3VvE9vt17D+Xhtpg+nz7agqXmsSU=
X-Google-Smtp-Source: APXvYqySNBvnObWjJUAGsOE2qMQ9ipjhJl7wlvcmGa0Fi5HT7944OPc2g+xKPFWM7zlKbeIkOBRAqsu9ZLoVAi42aTs=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr2425395qkf.112.1571743802494;
 Tue, 22 Oct 2019 04:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191021125402.5043-1-john.allen@amd.com>
In-Reply-To: <20191021125402.5043-1-john.allen@amd.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Tue, 22 Oct 2019 07:29:51 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6qBY4fuzCU=tC1LhE1QknCv2DsbdQ8qxrBtAsaM1prNQ@mail.gmail.com>
Message-ID: <CA+5PVA6qBY4fuzCU=tC1LhE1QknCv2DsbdQ8qxrBtAsaM1prNQ@mail.gmail.com>
Subject: Re: [PATCH] linux-firmware: Update AMD cpu microcode
To:     "Allen, John" <John.Allen@amd.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 8:54 AM Allen, John <John.Allen@amd.com> wrote:
>
> * Update AMD cpu microcode for processor family 17h
>
> Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
> Key ID          = F328AE73
> Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73
>
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  WHENCE                                 |   2 +-
>  amd-ucode/microcode_amd_fam17h.bin     | Bin 6476 -> 9700 bytes
>  amd-ucode/microcode_amd_fam17h.bin.asc |  21 ++++++++-------------
>  3 files changed, 9 insertions(+), 14 deletions(-)

Applied and pushed out.

josh
