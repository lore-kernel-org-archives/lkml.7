Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95E3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902F42075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFDRRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:17:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52897 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFDRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:17:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so888539wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A/EDhzrByl8EmK23RXYavhkj6RV6VhNBEEWmOK2O4oc=;
        b=Ahz7Onwpb+e18nWvXZkXvYCSJwaGFtt/apo1Q87xxWOVcN6QKCExSxEYa+lkDojlut
         yJu4S8QC5LmVmE0w6uitEQlMFbA4jL/BEfWA4ZiM3ZbLINqcRVpGW3f6mJC7um44d/Tl
         7UZCv+HZuxJf/BNcBlaoPx+3Cewx0aRFxGXGiHsrcamICL8Ei5uiWylIjvlrj6BsMZGC
         zILokUrJ641Oltdok/0SVVI6Z5R+/6A14O8dElpZ8SDUwu5KWdpoT797S45WEkh9OXk7
         MGOBHviyohv20SqLy5FTXMA+oqJQdHoxhYhGmTXKA3TMgjTKiDl793fC6lOhlY569/7S
         epjA==
X-Gm-Message-State: APjAAAWciO9528zO7KMdclb1vf3mb9z+WYruVlgbYMwy3BdElUZQaX2R
        6l36/rTIOYevpYxbTaCZyFibCw==
X-Google-Smtp-Source: APXvYqx+np2IkHDkhaheW56dj7UzGI3V8HfcXIRPNsM16CncIwMSIOta7YXPQ2f8Kt7odr80mUAbNQ==
X-Received: by 2002:a1c:b782:: with SMTP id h124mr6812624wmf.20.1559668671392;
        Tue, 04 Jun 2019 10:17:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:657f:501:149f:5617? ([2001:b07:6468:f312:657f:501:149f:5617])
        by smtp.gmail.com with ESMTPSA id s11sm13805336wro.17.2019.06.04.10.17.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:17:50 -0700 (PDT)
Subject: Re: [PATCH] KVM: Remove obsolete address of the FSF
To:     Thomas Huth <thuth@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20190527165606.28295-1-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77810fca-3492-2170-c350-bad35cfdc5e6@redhat.com>
Date:   Tue, 4 Jun 2019 19:17:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527165606.28295-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/19 18:56, Thomas Huth wrote:
> The FSF moved from the "Temple Place" to "51 Franklin Street" quite
> a while ago already, so we should not refer to the old address in
> the source code anymore. Anyway, instead of replacing it with the
> new address, let's rather add proper SPDX identifiers here instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/x86/kvm/irq.c        | 10 +---------
>  arch/x86/kvm/irq.h        | 10 +---------
>  arch/x86/kvm/irq_comm.c   |  9 +--------
>  virt/kvm/arm/arch_timer.c | 10 +---------
>  virt/kvm/irqchip.c        | 10 +---------
>  5 files changed, 5 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
> index 007bc654f928..4b7b8e44df0f 100644
> --- a/arch/x86/kvm/irq.c
> +++ b/arch/x86/kvm/irq.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * irq.c: API for in kernel interrupt controller
>   * Copyright (c) 2007, Intel Corporation.
> @@ -7,17 +8,8 @@
>   * under the terms and conditions of the GNU General Public License,
>   * version 2, as published by the Free Software Foundation.
>   *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
> - * Place - Suite 330, Boston, MA 02111-1307 USA.
>   * Authors:
>   *   Yaozu (Eddie) Dong <Eddie.dong@intel.com>
> - *
>   */
>  
>  #include <linux/export.h>
> diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
> index fd210cdd4983..a904c9b3b76a 100644
> --- a/arch/x86/kvm/irq.h
> +++ b/arch/x86/kvm/irq.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * irq.h: in kernel interrupt controller related definitions
>   * Copyright (c) 2007, Intel Corporation.
> @@ -6,17 +7,8 @@
>   * under the terms and conditions of the GNU General Public License,
>   * version 2, as published by the Free Software Foundation.
>   *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
> - * Place - Suite 330, Boston, MA 02111-1307 USA.
>   * Authors:
>   *   Yaozu (Eddie) Dong <Eddie.dong@intel.com>
> - *
>   */
>  
>  #ifndef __IRQ_H
> diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> index 3cc3b2d130a0..ff95fd893e04 100644
> --- a/arch/x86/kvm/irq_comm.c
> +++ b/arch/x86/kvm/irq_comm.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * irq_comm.c: Common API for in kernel interrupt controller
>   * Copyright (c) 2007, Intel Corporation.
> @@ -6,14 +7,6 @@
>   * under the terms and conditions of the GNU General Public License,
>   * version 2, as published by the Free Software Foundation.
>   *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
> - * Place - Suite 330, Boston, MA 02111-1307 USA.
>   * Authors:
>   *   Yaozu (Eddie) Dong <Eddie.dong@intel.com>
>   *
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 7fc272ecae16..151495d7dec7 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (C) 2012 ARM Ltd.
>   * Author: Marc Zyngier <marc.zyngier@arm.com>
> @@ -5,15 +6,6 @@
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>   */
>  
>  #include <linux/cpu.h>
> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index 79e59e4fa3dc..bcc3fc5d018a 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * irqchip.c: Common API for in kernel interrupt controllers
>   * Copyright (c) 2007, Intel Corporation.
> @@ -8,15 +9,6 @@
>   * under the terms and conditions of the GNU General Public License,
>   * version 2, as published by the Free Software Foundation.
>   *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
> - * Place - Suite 330, Boston, MA 02111-1307 USA.
> - *
>   * This file is derived from virt/kvm/irq_comm.c.
>   *
>   * Authors:
> 

Queued, thanks.

Paolo
