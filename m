Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DDAC742CA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F01E20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGLPoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:44:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44387 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfGLPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:44:54 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so21206245iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 08:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Flz2lLRzUd8jYEWKtYpt6MQ7g5ki02yJxXMItOlTOZg=;
        b=pbPlFejq7MTKPuDW0ogOnbBzGH2jXDG5LC6kb260dojCS+6rZGCVtGA2IH1kL6RznB
         SJhzvuQG7loYFZAVmTdkdk1rejdBTozWt2pts8ngpES6w5L98c+Y/VQQQR1uvpzaGUYL
         84j5tR/zzIFinJNYKrNFtBQoTLKU2r2KSXnzPDJcwEscR+qEtSta4Cw7XzMHiWpyHd3Z
         MygntlFCZiZDeQmGvz9hirLEZ0q6RAbnv1McHly0lCVDjLsWlQWqi3q45RowsBDAjuwP
         47Kvmg0xLi2Y7troXaiWupgkLT+Q45VB2Yp1A5D+NtQVaeZnAiZaVMr+WJHp/2NtBFdT
         cyGg==
X-Gm-Message-State: APjAAAWMuaJrWnxSURD3XvqAZeiFIYfl7FBK8lMj+tLBeQtOn4Hrsdwe
        UScJOTl8N4tZWMsjEC7qiZmfkLDD5oi2fP58ojE=
X-Google-Smtp-Source: APXvYqxN8RQNuZM9vdEm/CAl+zuh4AN5lTPTDyHWochsrNu0wOHqh5l7I2dOMKuVQTeQcmrFPVSCkwj2CtRyhmmnvW8=
X-Received: by 2002:a6b:e60b:: with SMTP id g11mr11691332ioh.9.1562946293139;
 Fri, 12 Jul 2019 08:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <59042b09-7651-be1d-347f-0dc4aa02a91b@gmx.co.uk>
In-Reply-To: <59042b09-7651-be1d-347f-0dc4aa02a91b@gmx.co.uk>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Fri, 12 Jul 2019 17:44:40 +0200
Message-ID: <CANBLGcyO5wAHgSVjYFB+hcp+SzaKY9d0QJm-hxqnSYbZ4Yv97g@mail.gmail.com>
Subject: Re: Asus C101P Chromeboot fails to boot with Linux 5.2
To:     Alex Dewar <alex.dewar@gmx.co.uk>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, 12 Jul 2019 at 17:02, Alex Dewar <alex.dewar@gmx.co.uk> wrote:
> When I try to boot the screen just gets flooded with messages like this:
> http://users.sussex.ac.uk/~ad374/boot_fail.jpg

Those seem to be only audit messages. You can try booting with audit=0
on the kernel command line to get rid of those messages, so you have a
better chance of catching the real issue. (Or conclude that audit is
what is broken.)

/Emil
