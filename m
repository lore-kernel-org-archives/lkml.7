Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2DFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E522077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563354508;
	bh=4vu4Okxb5WZcflRFF6tQdhHwvtvePiCyc0cLWLfo7E0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=il4hP4eLTrGmJu7JgqSdJV960dOA/x4z+tlPsuqGWJBz9HOkG9KAgAPyh5jNB79oK
	 MbbNfku9yz1RD8JoCdKuwkFg9kuB5IIF6RbAGsoGWPoG057Nwx63atvpXczI63wYV+
	 WAm/ACssNMLu00hxnsjT4iAokxP1jtIhw53WOvQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfGQJI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfGQJIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:08:25 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F502077C;
        Wed, 17 Jul 2019 09:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563354504;
        bh=4vu4Okxb5WZcflRFF6tQdhHwvtvePiCyc0cLWLfo7E0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RALEPS5CHWpeiDfu+HsvmOaOtvbO5k1yXwr0S9XTymblJwDF6sHvV4gEFnM2bVK9j
         yKQMewHedSijshe748912a1/XBQpOFpER3JlkGbAUAI0kxVSMiGP7AzuAWb+5Y5IyL
         Qh+O+M84QxD+z/qPh2CYiANXO29KI04JSGWeFggE=
Received: by mail-lf1-f54.google.com with SMTP id q26so15878610lfc.3;
        Wed, 17 Jul 2019 02:08:24 -0700 (PDT)
X-Gm-Message-State: APjAAAU0XUJ6xSvg4HhNSZVVu2G/t6K8+Up57poQKMjmikFKEf3A5q59
        WHqBCXQ5ji9eJG/Rlpbv/ftQTuB+I+k6hS+pGNc=
X-Google-Smtp-Source: APXvYqzPzGPDBYSh581qW48n1T0W9q70m0vdtu/7IVr2GTIxxD6DYirb0vG3PGSnLIb3eXrPmw69lCfnIFHh/iYbG8w=
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr16685179lfi.159.1563354502661;
 Wed, 17 Jul 2019 02:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124452eucas1p294d89255359b2036b19213427f558dbf@eucas1p2.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-24-l.luba@partner.samsung.com>
In-Reply-To: <20190715124417.4787-24-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 11:08:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeTsS_4MGfgT6ZnP8PzeaaP7Du71TxD3cQZXougGgvKXw@mail.gmail.com>
Message-ID: <CAJKOXPeTsS_4MGfgT6ZnP8PzeaaP7Du71TxD3cQZXougGgvKXw@mail.gmail.com>
Subject: Re: [PATCH v1 23/50] ARM: dts: exynos: change lowest OPP in
 bus_disp1_fimd in Exynos5420
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com, Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 at 14:44, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> The lowest OPP must be aligned to possible value after division of parent
> clock rate. Thus, change it to the value which is true for clock 1200MHz.

I think this is getting slightly too granular. It seems you are
solving the same problem (or very small subset of the same problem) as
in patch 22:
https://patchwork.kernel.org/patch/11043849/

Please combine such changes per IP block, unless you have really
reproducible different issues (e.g. reproducible different performance
problem or OOPS, but not just what clk_summary prints). I imagine that
you align entire subsystem (DISP) buses to real clock frequencies (or
to match real frequencies, or to achieve more granular scaling, or to
get slightly better performance).

Best regards,
Krzysztof
