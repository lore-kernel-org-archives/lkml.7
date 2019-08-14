Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97C7C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DDC20989
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfHNEoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 00:44:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39965 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725262AbfHNEoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 00:44:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id h8so20616930edv.7;
        Tue, 13 Aug 2019 21:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Z6D8IiynDoonRo+cCux5+ugmeKBsc4T5KOeVrjO/y0=;
        b=ohS3F0ckexhD0grG5/EApQQuSU8Hfrk8riSZ2PkJQzDDdiLJIzHkL5DG9DD/4QTsOk
         w9sSNGeah+IpPxPzOfgqZ7vql6b3dpSFmpjTIG5BiZk4iAa5IYOov69U0o8W098u+nAY
         NWUdZOvEL03XheMBzJpjg5mA1PK9IPjjw8inuGgM7jnyixuY66gziAIFqpJr6pYBZnu9
         H6LLzZNzQQzn9gjFYhhYtCfHorDafPfCh4RqW56vY5LHoljLVwlnLRlKTyEJJar4yNTz
         pXZHjkjG1EfOSUt+MoRHNEJm4s3qY7kVDbgsat86FI4uEhN6x7YuraXXdOtHR40vq6e0
         RXaQ==
X-Gm-Message-State: APjAAAVJtHc5iHi2tONF1DG0SOV7j3cs8PyM1A7uyVFkMKCVWksfRhZQ
        u7YtdCC/8INOo9qS2peLuhZhd/GhbpQ=
X-Google-Smtp-Source: APXvYqwCDlJlJQTBrjnpXRQJf4d8oHwRMFDgP4pWLMb04RmDK0zl6A+ZY82TSUXZLRT4qa4iv4Ciag==
X-Received: by 2002:a17:906:1dcb:: with SMTP id v11mr38833182ejh.218.1565757854556;
        Tue, 13 Aug 2019 21:44:14 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id b17sm1856923edy.43.2019.08.13.21.44.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 21:44:14 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id z11so7834876wrt.4;
        Tue, 13 Aug 2019 21:44:14 -0700 (PDT)
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr49717223wrn.324.1565757853951;
 Tue, 13 Aug 2019 21:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190813124744.32614-1-mripard@kernel.org> <20190813124744.32614-5-mripard@kernel.org>
In-Reply-To: <20190813124744.32614-5-mripard@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 14 Aug 2019 12:44:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v66C-Mqdo-xWm4RAw33sFk-gLy-L_YWQ__6BjYU9gcpYug@mail.gmail.com>
Message-ID: <CAGb2v66C-Mqdo-xWm4RAw33sFk-gLy-L_YWQ__6BjYU9gcpYug@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: sunxi: Add missing watchdog interrupts
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 8:48 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The watchdog has an interrupt on all our SoCs, but it wasn't always listed.
> Add it to the devicetree where it's missing.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

On a separate note, the A31 has four watchdogs in the timer block, and
one interrupt for each watchdog. Should we expand the node to encompass
all of them, or add separate nodes for each additional one?

Thanks
