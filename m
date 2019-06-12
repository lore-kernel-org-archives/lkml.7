Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866BBC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E245208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfvLpUOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438783AbfFLMSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:18:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44009 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438779AbfFLMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:18:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so11902490lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 05:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLgqFLgI1RD7txKsXHTcttpt8QJ2qspurJ8r4TaFBuo=;
        b=FfvLpUOfzN6wTBDG93ptVmlfJBX2N34h39prIp2th17F7l4y5WYEM1Easy5npKwdPR
         yrNaZYf2mW4ZJ++7lbZWkbYO5T/KdbeNQ8aIFYczQ2ylarmaXoYt/zdNMPONaKWImR4C
         qBuxaiOyay2r17jP/3shi+mEkf16wTWbWzu+5BH2RN/BUaaJsOljwQJPtKPbPljdFhSG
         FxbxZ8ijKX2RMJyFfxSH00IrZJF91EcroP5wgKVdynk9K09i03hnimr+LhD8uQyTaoE+
         3LWLKtl+zXMFXfnXQqS/4vSDK6OiYZDSuHafztRmKI5qpZOCks9/gdAoyUPDIn66y9VY
         7rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLgqFLgI1RD7txKsXHTcttpt8QJ2qspurJ8r4TaFBuo=;
        b=G4SVuto6GhzOWKewGf8E4PTjExL98jEAzLXsbYZVBcCq30haub8pD/Ba/VIJtEVSGV
         fqBrZnnrM+sEzag0CjN/d627+r33ElSHmN+GdSZSuURmar4ZxkmlYGhwUmzTTDRjH5Nh
         AJMrMOY+jrWNHap3/o0/efvklA2tgisgjpTim3tVZY3xki0EQ5C/o0cKx4K+IX9a3AEU
         xHjiSVlfUVrwXkb7VOvOPoB92ANwQts1gyFofxW/xdnjbVPR6aPN0jPgkw0IglXdtHlb
         /+ZBuF10YyafKx2baMO4wvsvLVf1Ce9H5/RmAelR8K2OhojZnOxCr0+cj1Ew1B1pIZ5F
         KzqQ==
X-Gm-Message-State: APjAAAVaFPoukMu4CtAIEasSGMZxfmLuCHM+RSgUCTxXhauGH/0LytyJ
        t1apOUcrhFr8zVEh0J6bHe6tb08eeWyY+d0GZxBVZKjR
X-Google-Smtp-Source: APXvYqzzhiF6iMG++OhR+MGtmOroCfV56gr3a2ZeGoM8umsfC45K9xFo43Z8yZlHV/8RUbSoa7Te3b3r4DhtKwjvqug=
X-Received: by 2002:a19:7616:: with SMTP id c22mr37373804lff.115.1560341887523;
 Wed, 12 Jun 2019 05:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190611072001.2978298-1-lkundrak@v3.sk>
In-Reply-To: <20190611072001.2978298-1-lkundrak@v3.sk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 14:17:56 +0200
Message-ID: <CACRpkdYeWMs30Q3zD1vQF-yC1_PKuOFDSDs5nVqhMSfrgFvu1Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: xway: Switch to SPDX header
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     John Crispin <john@phrozen.org>,
        Martin Schiller <mschiller@tdt.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 9:20 AM Lubomir Rintel <lkundrak@v3.sk> wrote:

> The original license text had a typo ("publishhed") which would be
> likely to confuse automated licensing auditing tools. Let's just switch
> to SPDX instead of fixing the wording.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Already fixed upstream by tglx pattern patches.

Yours,
Linus Walleij
