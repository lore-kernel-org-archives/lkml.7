Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B5C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E46F2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLWKF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:05:59 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40194 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfLWKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:05:59 -0500
Received: by mail-oi1-f179.google.com with SMTP id c77so5913804oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 02:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8dvbUthjWg1rl1tdJ7OSIw8oxO2mgRKvSl1C+kWKzaQ=;
        b=m3NgT4NFHHD9/PrKMYEOxnf1E+JnzJQhtOhkllE3VzGJQ7e7NQSRRfOP0dfNt/Z47G
         BYmMSVUbntYekmiI8ziVLIng4BoZBguQAqXaZZgopMmtfliuC6lanekGML0F9VC70+lW
         V2GOBM5vBsGZ7X+pc3Y4TfvQG1HXwPmVR2e2JBBMUJ3CHoBYF6mWKRuCMHWxqBsaVk46
         rl9oP7Ld2C37I37dJssez62SQ7reLVz4wQEktI5gB3bXF1I2LcdNIAVQGPnz6eesp5uZ
         chrqkE7SMuRJoy9ipfxNFnlHPkfuPklKaPCSMC7hQZUE0EjZrAg+XFA3gbHWV0LFRnr/
         /+0g==
X-Gm-Message-State: APjAAAW5gTs9bXLFFq2Rpdr5F8SjGhTbw3mqSCPPFsPeNvjUnWzlAfAG
        Zku6Zge6euqqrjrCvXB69WbIbSfwjv25ewRMXsJGFgb2
X-Google-Smtp-Source: APXvYqypQOGlVIg71skLv8bEFPdiR5EguXwHRiC11uAMO+fbywrsS/F4t6f2GSG0x3UI4D0rEnu+0AbFEwIQ41vHYm4=
X-Received: by 2002:aca:eb83:: with SMTP id j125mr3627360oih.153.1577095558176;
 Mon, 23 Dec 2019 02:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20191223095547.4892-1-geert@linux-m68k.org>
In-Reply-To: <20191223095547.4892-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Dec 2019 11:05:47 +0100
Message-ID: <CAMuHMdUTQZVWQopnFyvebRqWv0pTxBxt-7+SFOZ_Crb0rpwjkg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.5-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 10:56 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.5-rc3[1] to v5.5-rc2[3], the summaries are:
>   - build errors: +1/-0

  + /kisskb/src/include/linux/of_mdio.h: error:
'of_mdiobus_child_is_phy' defined but not used
[-Werror=unused-function]:  => 58:13

Various CONFIG_OF_MDIO=n (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/46cf053efec6a3a5f343fead837777efe8252a46/ (all 232 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d1eef1c619749b2a57e514a3fa67d9a516ffa919/ (all 232 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
