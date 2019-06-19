Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0751C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C457E2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfFSHET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:04:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34063 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSHER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:04:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id p10so9128022pgn.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 00:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7/8RVwwpSyiRMCTGZS64tnDjssYAeJ0LgQZ9r//r+qE=;
        b=ejowrUoaDpO+7iO8TarHS6mW+JqurABzR7zR3mPSN7kwMqFsZUYViUuUDKESUJH6BM
         JaCOL0pz2GydG05zqvQvXRrg8rCz2r+DDkrnJHdXuEuVXIPCAJPbKhi7oOVaj68AqqA7
         LqqxfnYM+8+DX1o4rl2DwuSZAK5RxHvJ4DRM0swpOD+KcnTsRoWvCkynSwgyf5AmcXIi
         Pvkkqzf/PVCBbYSIMgj1X6yc/W5GpqAThBYJ5GWpAWsm4Aqkm9clur4zB2ZmS8fx/W07
         4DjczMpgaAdI3wTRPUmWe7G1t9zUYxLnXJs61hmN+26WR53i4Y0SGKfK6Cts1ntg1iBD
         4DfQ==
X-Gm-Message-State: APjAAAWx6hSFlBfO1YAX78cstA6zhBl9h6O09//peku60R6HLgwiFwUy
        f3Ry5oqWn7bgbs7rFPvbWpv75w==
X-Google-Smtp-Source: APXvYqyU93GnXfOMPxiWzkmGi33H3j+hQkODkg0SsE+Md9DOd3Z+gKFS7f34Ev/hIAuIXkD2oWnH+Q==
X-Received: by 2002:a17:90a:3590:: with SMTP id r16mr9702251pjb.44.1560927856852;
        Wed, 19 Jun 2019 00:04:16 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id l7sm20331564pfl.9.2019.06.19.00.04.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 00:04:16 -0700 (PDT)
Date:   Wed, 19 Jun 2019 00:04:16 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 00:03:19 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: defconfig: enable SOC_SIFIVE
In-Reply-To: <1560799790-20287-4-git-send-email-lollivier@baylibre.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, lollivier@baylibre.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     lollivier@baylibre.com
Message-ID: <mhng-81fd3887-519a-4a3b-8486-22d4d5441c9b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 12:29:50 PDT (-0700), lollivier@baylibre.com wrote:
> Enable SOC_SIFIVE so the default upstream config is bootable on the SiFive
> Unleashed Board.
> And have basic support for future boards based on the same SoC.
>
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
>  arch/riscv/configs/defconfig | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 4f02967e55de..6e3e37aa8fd1 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -12,6 +12,7 @@ CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  CONFIG_BPF_SYSCALL=y
> +CONFIG_SOC_SIFIVE=y
>  CONFIG_SMP=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> @@ -49,8 +50,6 @@ CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> -CONFIG_SERIAL_SIFIVE=y
> -CONFIG_SERIAL_SIFIVE_CONSOLE=y
>  CONFIG_HVC_RISCV_SBI=y
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_DRM=y
> @@ -66,9 +65,6 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
>  CONFIG_VIRTIO_MMIO=y
> -CONFIG_CLK_SIFIVE=y
> -CONFIG_CLK_SIFIVE_FU540_PRCI=y
> -CONFIG_SIFIVE_PLIC=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
>  CONFIG_AUTOFS4_FS=y

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
