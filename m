Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD156C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2892176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576679947;
	bh=+2yVV43hZqMwe5QE8OIFhA1tLlKcnaZh8XJcrsHp+vA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a59yFA2+W4g7VborAm7s30LGqPZ1cNXJVZgjE1wtIC8yt7lt8nfwtMzUEpnFBc8lE
	 sChVjj9VCZZf5MFrvzN5zIPk9q9wVfbsdFWqUiok7wAPOkIVEy9EBRzF7XhOqQruPm
	 wu4PI71byQDh4X/sqh7BF50Fvgm/KhGMb+8ZnM6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLROjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:39:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfLROjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:39:06 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7BF7227BF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576679945;
        bh=+2yVV43hZqMwe5QE8OIFhA1tLlKcnaZh8XJcrsHp+vA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ox/udGjVqq1T8L+/uQXafv67brOtVP6Lra13jCov3K1VF1oCSZuDJtEyCCGQxq7VH
         fglb/MUPGG09Rk5UD9IiUout9HLIgnTnFAQkHMWgQO8dmZZj8q/Mvea1yyoE0UhZ2z
         X44pdUOvWUgihEnHVgrVrskv5nLJoIwDN7fiBX/0=
Received: by mail-qt1-f173.google.com with SMTP id t3so2080545qtr.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 06:39:05 -0800 (PST)
X-Gm-Message-State: APjAAAW6UZ/u+PCASBJ/4FTLtx5vzChRjoHWQX33stpHUFZjIJokmG18
        QYAHDzvRW7v+7u3lD/uI1tYQhRrG7LRnK7xYkQ8=
X-Google-Smtp-Source: APXvYqzU+NbnxuUD39TqrMzI3oJRr80b3MwpxZUJO6WfeNiEUga4WQh79VMvOwH7C16Bg4A2aEB6czv2c9a+cCQrY5s=
X-Received: by 2002:ac8:30f7:: with SMTP id w52mr2469805qta.380.1576679944769;
 Wed, 18 Dec 2019 06:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20191218142740.20173-1-john.allen@amd.com>
In-Reply-To: <20191218142740.20173-1-john.allen@amd.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Wed, 18 Dec 2019 09:38:53 -0500
X-Gmail-Original-Message-ID: <CA+5PVA7w4gNOGaws6fO_QWCMwE0XWkvD6BKnX3TVE7of=qytEw@mail.gmail.com>
Message-ID: <CA+5PVA7w4gNOGaws6fO_QWCMwE0XWkvD6BKnX3TVE7of=qytEw@mail.gmail.com>
Subject: Re: [PATCH] linux-firmware: Update AMD cpu microcode
To:     John Allen <john.allen@amd.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 9:27 AM John Allen <john.allen@amd.com> wrote:
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
>  amd-ucode/microcode_amd_fam17h.bin     | Bin 9700 -> 6476 bytes
>  amd-ucode/microcode_amd_fam17h.bin.asc |  16 ++++++++--------
>  3 files changed, 9 insertions(+), 9 deletions(-)

Applied and pushed out.  Thanks.

josh
