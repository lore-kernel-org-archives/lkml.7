Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2498CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0452D21744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfIBQmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:42:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34466 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfIBQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:42:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id a13so16217651qtj.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 09:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESVPzvoDmyhr0qPHPc2dAllaJ5z0kVzBcRcJ6MBqm24=;
        b=WHdmlM3GpfrjzX+dDRj/V6R4GpJM+IMtl6RZPWJYq8hn1ow1beM1oLpXSPrCHMoxjL
         RXB7djOu9PwE3mXNWG6p3a3GrQAS5Eb9D3kMiDLrmbF3Xv/5FXAaprFQzRRjbzV+2JgK
         wNjW/9n+rbN8bbtCkVREqajwokBMpHCyDMcL2STgTrRSWsaFaIxfpNGq7mmtnlVUb8ON
         zhI7pz+SYzsSFMf/hnd5Ws0DGxdFxn0AfftPvT8FLhjYglry40CrhBSOaKzPIvsjAo9c
         72iHX/HrlW8WE12a8aY70LZUuETlLiL+vSVE2UkP5G8EYPVWXMifhH6TKqHUd3WIYFQ8
         dWVA==
X-Gm-Message-State: APjAAAX+rnYWHQzUC6fEhfGPFequifovXQyTsgMDOh9cmXM2W99Pjmyj
        8Ira9omFYHLY8Cd8ZXweWzY37hg4uYBF+zO5feaOOQ==
X-Google-Smtp-Source: APXvYqyBIip2MdBOWy21R2bhPQrCc7eiTrHZFC+NOHCN4Z9fnQKXYsfcYC6/YlQc/qHGnz8aoQ0TFDMFoEZIE2D91R0=
X-Received: by 2002:a0c:e74b:: with SMTP id g11mr18622746qvn.62.1567442558193;
 Mon, 02 Sep 2019 09:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <1567440041-19220-1-git-send-email-olivier.moysan@st.com>
In-Reply-To: <1567440041-19220-1-git-send-email-olivier.moysan@st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 2 Sep 2019 18:42:21 +0200
Message-ID: <CAK8P3a3WvXmMys3mamCZef1-ychtdg+XbV=H-WTs2ZN6Jsrcbg@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: multi_v7_defconfig: add audio support for stm32mp157a-dk1
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Tony Lindgren <tony@atomide.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 6:01 PM Olivier Moysan <olivier.moysan@st.com> wrote:
>
> This patchset adds audio support for stm32mp157a-dk1 board.
>
> Olivier Moysan (4):
>   ARM: multi_v7_defconfig: enable stm32 sai support
>   ARM: multi_v7_defconfig: enable stm32 i2s support
>   ARM: multi_v7_defconfig: enable cs42l51 codec support
>   ARM: multi_v7_defconfig: enable audio graph card support

The changes are ok, and I expect Alexandre will pick them up and forward
to the soc tree.

However, I would prefer these to just be a single patch, as there is little
use in splitting the intended change up into one line per patch.

       Arnd
