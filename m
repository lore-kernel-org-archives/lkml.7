Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33421C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1446D207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437621AbfFLJj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:39:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35105 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437412AbfFLJj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:39:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so17847569qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJ5uEcQdLGxPj4sgIEL2qy1S+Og+9M7F0hxXgED9kTI=;
        b=tkLFTLvbcNuppneAEvt+uPb+ap05G02rEGi1Wmo8GzEwQ0kPXWxejd5iDYhD4wtI8b
         q+qcVh/Q1JvUIwvNArGpoRx6xU3l81Jh1hW7tPBx8I90KTdQaP11AmM+fO9oFS6Mc8dg
         VgCcXJUZz/iq2Kf+1hsfFVHldM4gpv7cO1eo3H4yTXY16cbfuFDLTiTRNf1kEm6i362b
         XRy7zMn/QpQh2GVKCcye4Vn/CTHea1nDu8HDo7BVfaC8BkSo2WuBwIG6iYlETceZRjBW
         PAmzu6nTJ0yNuk/ti18r/BFKKpxwmkhMrtiJ+EYG2YkM+Hzt5klPrtiXSzdR71MHTeyH
         y4RA==
X-Gm-Message-State: APjAAAW7FQLhWtpNzWaxYCImiVCm1qqGx+2NgTC1hR/glhXcLJy0j8By
        HLS1dhdtKCo8/Nr57RPd+AQLxm5qLkUwYqUPsO2H2/v8Yd8=
X-Google-Smtp-Source: APXvYqzElkDKd2kzLm7SbVsppgYiLj1v0Cdg14m0I4m//egnblE/rwsl4lv34rLBpVvjWnt03LJkvFn7Lq6HE34uroI=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr35388568qtd.18.1560332396827;
 Wed, 12 Jun 2019 02:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190611184107.GA1873@kroah.com>
In-Reply-To: <20190611184107.GA1873@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Jun 2019 11:39:40 +0200
Message-ID: <CAK8P3a3eQWeqVu_2VJ9=4Z3Fzp+B_zW1Zgcw_YFzC3qD05ygGw@mail.gmail.com>
Subject: Re: [PATCH] genwq: no need to check return value of debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Haverkamp <haver@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 8:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Frank Haverkamp <haver@linux.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
