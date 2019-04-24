Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE78CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76F620652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfDXNSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:18:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34094 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfDXNSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:18:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id j6so925724qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAb14S80i3UULMoZ7wIIm2M3Rh/7L83iDqB9hmOUh9o=;
        b=KzL9k61pe/eO4tNbkJNX0drjNJeT2lpwBBgMsBwxGSuxSTBueoFqFkjIAaj1Eh8Sjw
         3Fb4GAphwJaX/iKZRz/WHtDvGh7WCfYet+pPHm6NualCMucbnFbpyzQ8ZOcWT+xSGGr8
         JVvKS8p+lUD5KmmaJUcc62Titkd5p7CE9FvPvT7ojIbfJvGwQPRv6UjMq2cnGFdPe0CG
         Eb3Ozz02Dsiohb/QdNnI6keYxvpMqyVikfY7K4qw0Uz3Lw3u8OtZcM/YH7qIesoNPs67
         MpfNXBjLL51fEQwVHz/k8RCCPzp0UgY3A06XU8a9LpfxOvTFollVSNusl4TWhZRdQq7P
         4UyA==
X-Gm-Message-State: APjAAAWqtkiIGRQqmp1CsTGJ7WYgk5hl4HHj8tADUB6ue6lYnFa5rG7b
        by7r0qVXb2tG7zEM+vz6TIz7lCR+MAsg4wyN0JHdgQ==
X-Google-Smtp-Source: APXvYqwa9hKQjgB92HN+IfC2AVctdNlnQWRhV1wn9KD/LksbrmnorlRjfLd0P3djERA0YsZ6diN0+lJR5ZkezRUywOE=
X-Received: by 2002:ac8:25bc:: with SMTP id e57mr25605726qte.167.1556111928728;
 Wed, 24 Apr 2019 06:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190424131636.8320-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20190424131636.8320-1-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 24 Apr 2019 15:18:37 +0200
Message-ID: <CAO-hwJLVrC0i5dn+opLTm9haZ6HP5-g+ncUd-3VPrhNSf=siuQ@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-dj: add usbhid dependency in Kconfig
To:     Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 3:16 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> An oversight from me.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I went ahead and pushed it already to for-5.2/logitech

Cheers,
Benjamin

> ---
>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 76d82063d8d2..c3c390ca3690 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -521,6 +521,7 @@ config HID_LOGITECH
>
>  config HID_LOGITECH_DJ
>         tristate "Logitech Unifying receivers full support"
> +       depends on USB_HID
>         depends on HIDRAW
>         depends on HID_LOGITECH
>         select HID_LOGITECH_HIDPP
> --
> 2.19.2
>
