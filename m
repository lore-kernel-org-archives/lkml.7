Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B09CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E76020717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sqK+qum0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfKEBpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:45:11 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:48836 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfKEBpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:45:10 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id xA51io3R031758;
        Tue, 5 Nov 2019 10:44:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xA51io3R031758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572918291;
        bh=US7HnlfbUATMZewUXcHUmKQ8vx87uqsdcAQJeWxPmP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sqK+qum0s/ofCdio6VkD6ITJtwUT7fjxl1ZAhXzvq4PcS3Imp5mJO5moUHJ0njMw6
         2cDWiWKm5mQf6pO1Y5LyzrUIscWWiO+D5JbBITc3ApVvi37LdY4t8iUkt5mC8Z6upN
         31AmvCcO3U5b9uk7NIAtYSAtunMDnmGyM6AljC6eHyn5gCS3GESYovlu0syXuNAFHI
         lJVhMjZ2X/mnyO7Y9clvM8f+3iKNNrJirc0Z29vM34Sp/RbkWj1ww2YzY57byMe+Yi
         +SZFUaiqOaHHuHhtTzPXS8DVzWfDQSSMsq/0mMa5DP1/+TfoOfK9gEdqhCpMEsT1Eo
         gvqqH3NaN3V6A==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id s25so1259149uap.1;
        Mon, 04 Nov 2019 17:44:51 -0800 (PST)
X-Gm-Message-State: APjAAAWG2jJVZz6155TrG00fBQNZULcSgW2ZcsT1eptPmN9UXatM5URj
        VPjSPoYiYYLWOIjmpVJIiH3+4E2S52i64jpDlCg=
X-Google-Smtp-Source: APXvYqyAJwLfrsdrDuFC5DkDPl6kKaEgQE1dM2uxxz+hFwYzm6LlI63Y2XVEPHBoyeEM8Nncmazv6eanPEcWgTNMMWA=
X-Received: by 2002:a9f:3e81:: with SMTP id x1mr13534695uai.121.1572918290038;
 Mon, 04 Nov 2019 17:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20191101061411.16988-1-yamada.masahiro@socionext.com>
 <20191101061411.16988-2-yamada.masahiro@socionext.com> <CAL_JsqJbmFd5wZ0RCP2baqv-bjWwzaJ+hLqtGeYjK5LPJ54dXA@mail.gmail.com>
In-Reply-To: <CAL_JsqJbmFd5wZ0RCP2baqv-bjWwzaJ+hLqtGeYjK5LPJ54dXA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Nov 2019 10:44:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAThTaHpCWgGyx=qh6v7CsL6DAWfvE1g_jsNcGe-K5e_gA@mail.gmail.com>
Message-ID: <CAK7LNAThTaHpCWgGyx=qh6v7CsL6DAWfvE1g_jsNcGe-K5e_gA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libfdt: add SPDX-License-Identifier to libfdt wrappers
To:     Rob Herring <robh+dt@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
(+CC: David Daney)

On Mon, Nov 4, 2019 at 11:00 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Nov 1, 2019 at 1:19 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > These are kernel source code even though they are just two-line wrappers.
> >
> > Files without explicit license information fall back to GPL-2.0-only,
> > which is the project default.
>
> That is true and these are kernel only files, but given they are just
> a wrapper around the .c files, maybe they should have the same
> license?


I just thought it at first
but this wraps two files, with different license.

include/linux/libfdt_env.h:  GPLv2 only
scripts/dtc/libfdt/fdt*.c :  GPLv2+ or BSD-2-Clause


Looking at the include/linux/libfdt_env.h,
I thought GPLv2 only would be preferred for
the kernel-specific code.

If you prefer to align with scripts/dtc/libfdt/fdt*.c
I can change it, but I would also respect
the opinion from David Daney, the author of the
following commit:


commit ab25383983fb8d7786696f5371e75e79c3e9a405
Author: David Daney <david.daney@cavium.com>
Date:   Thu Jul 5 18:12:38 2012 +0200

    of/lib: Allow scripts/dtc/libfdt to be used from kernel code



-- 
Best Regards
Masahiro Yamada
