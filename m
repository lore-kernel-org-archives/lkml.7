Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD698C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05702173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfIBHyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:54:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37017 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbfIBHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:54:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id 97so9939389otr.4;
        Mon, 02 Sep 2019 00:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+o00h+tPTTN/5vvYLtJ9XPEgY829Ij3W3jZH5PLN+0=;
        b=KCDnoE+jvjgvsQyWT78BTYH6NkR6IYExO12i0ZVByoaXUYL3EjXcqyBSryLfWCuSbJ
         HnIMjuGAWnqyetr4M/g9qvXTUF0XXqFGf0pOmRmzs+gHkdz8Y+2AU9jQnO9COhBXRKtk
         WZHZfiKCO9nHxee+p+V1iK38ezDjDRpR884htvdf+cRvZ0FRdZEBNQIFDGO/7o/52Xrr
         O2mXE3ote6n6ghCbe3R0zyHKrIFKZ/k23rcM6uGFcq7IQv11LYENnL8XO/IkeKu5+w0i
         S0OD1Z48tO+SbURvs2j3yinaMrFtO/DG+wcyGwEdhpFKATmkvekW2lGWS7/9f7ghQkk1
         acXA==
X-Gm-Message-State: APjAAAWNbep2al/qM1/DoHUMRmA3Cu5XNpgoO9rCJpS1ixGIn+PGuwKW
        2oaBmaYYbihtF+LyWzPZeM82t3QuIqDSPnxSY3o=
X-Google-Smtp-Source: APXvYqzITRmai4wNLfTbqeWbF7TloFU0S/9e6nsv2cEMTTvzeRl2BQMfLDQxK1mpX6NNYT+2KqEwcF0umTtySwWIZPI=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr6390698oto.250.1567410841744;
 Mon, 02 Sep 2019 00:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190830161237.23033-1-hch@lst.de>
In-Reply-To: <20190830161237.23033-1-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Sep 2019 09:53:50 +0200
Message-ID: <CAMuHMdXUnkUABF8nA4TKPj8eLTh9GpRoF5e3s7WU=dxuQEQGBw@mail.gmail.com>
Subject: Re: ioremap cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Aug 30, 2019 at 6:12 PM Christoph Hellwig <hch@lst.de> wrote:
> these are three cleanups from my generic ioremap series that needed
> a few edits, and which I'd like you to pick up through your respective
> arch trees for 5.4 if possible.

Thanks, [1/3] applied and queued for v5.4 in the m68k tree.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
