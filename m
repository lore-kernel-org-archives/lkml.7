Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FECCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52E921D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCUlJDAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfKDLVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:21:38 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:41752 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDLVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:21:38 -0500
Received: by mail-io1-f46.google.com with SMTP id r144so17954382iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 03:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iA3Ghh4jpvXSSERa2jOGmbp3jAalwStrBFig3xIOZ8Q=;
        b=LCUlJDAuatfSFAsRlhdxeWl3QtSamE4hc8n9dJ+nmgoW0PSGXgFbF/ydxGMNjphwMG
         hnroxzGM/qodPjlzPrWZr0CpSLhJxt+U19NQfdCeoEAkgaW9rsMUYgNDrUNJgxK5cnWl
         obnh7W52U9nm2LM+uNOVkNztSpM+y6JrmsjrEhNis5b6vlBQYyGCBcxo1ShHcEqHUuQQ
         HcW4LrRzMluXq9FgoxUCk+mtPsAKLyS4eqixwFJ1kt1eDNtxoiBv59i3niKXmmWLHwbs
         8cda3iJI5htoNV/OBh9UToSexj67czV59ljIsv0wUc+/LLEEqta7bnoerMqzHn14B7fc
         5awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iA3Ghh4jpvXSSERa2jOGmbp3jAalwStrBFig3xIOZ8Q=;
        b=rQICaS5mZk4L9oOjbOW9TRy9Bn1FwBO6vGFD3OBbzbLs5FqKHgyXregdgLBamuXGsS
         MACcZlHCWfEhM9nflTWH2clOD9oVeLEsQby2YXHgaAri8zIdsgyQAW78EICbF8Z5bEcH
         9PjaT3Pb23q0+zcNGsH3dbPj2DS9inSiLpywDnQ+Pdt6a9UWwHUtQ2IuKpqbOGtIu4zF
         a9dMxgNOWRC2vbF3jgH9RuZH/AQJl7w/cI91aw3QCnU3pxENAtXs5VCjgZWIIx8OevrM
         YTRLvQ+929CRiL4v9DDk+72FR8tP8N9tNXbqgbJx86LAtfdHyLNHERM2jJNl9PFVnXMZ
         fJAA==
X-Gm-Message-State: APjAAAXBS17S4G/Hg9LgTD0sh7l2GmLXN+kkjQXyK+8ygAP9/1BSqsA8
        7CDNXfWYBFxes3oIWDLS4xxSILfusLXNYEzS/keB8rwo
X-Google-Smtp-Source: APXvYqy/kRAKleYcs8DOOpqCxLbzM5UCoYYkc+UHZNcyNt4+LloxILm+f8QD3/pogXhcxsFwGYNTRpF9b2Hpn55SXbg=
X-Received: by 2002:a5e:9b13:: with SMTP id j19mr10487061iok.169.1572866495915;
 Mon, 04 Nov 2019 03:21:35 -0800 (PST)
MIME-Version: 1.0
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Mon, 4 Nov 2019 11:21:24 +0000
Message-ID: <CAFSh4UxSx7SYT=Ja6TbwFwCJm_yn6VtMapXGv3B=+g2rQcALSA@mail.gmail.com>
Subject: Power management - HP 15-ds0502na
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've recently purchased an HP 2-in-1 laptop, model 15-ds0502na.  This
is a Ryzen 7 3700U processor.  There seems to be some difficulty
between HP's firmware ACPI tables and the kernel.  It's not clear (to
me, at least) whether this is poor ACPI implementation from HP or poor
handling of valid ACPI tables by the kernel.  The most obvious
symptoms are:

* Pre-5.3 kernels don't boot at all.  This appears to be because the
FADT table declares the hardware_reduced flag and this was not very
well supported.  5.3 kernels boot okay (I'm using the one that comes
with Ubuntu 15.10).
* Power management doesn't work very well.  The most obvious symptom
of this is that /sys/power/mem_sleep contains only "[s2idle]" and so
there is no suspend-to-RAM available.  Setting
"mem_sleep_default=deep" on the command line doesn't change this.
* There are a few devices that appear to be on I2C buses and declared
in the ACPI tables (eg the fingerprint sensor) which don't show up
under Linux.  They did under Windows, until I blew the Windows
installation away to install Linux, and I'm assuming that Windows
found them through the ACPI DSDT.  Now thinking it may have been handy
to keep Windows around for debugging, but that's regrets for you.

Is this the right place to raise this?  If there's some other place
that Linux ACPI issues are dealt with, please point me there as I've
not had any luck googling.

What are my next steps debugging this?  I've decompiled the firmware
ACPi tables but I don't have much idea what I'm looking at.

Thanks,
Tom Cook
