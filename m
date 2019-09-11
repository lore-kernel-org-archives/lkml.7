Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50B4C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8733D20838
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfIKVK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 17:10:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:47069 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbfIKVK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 17:10:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id v11so27027726qto.13;
        Wed, 11 Sep 2019 14:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23NrFChKykdY1EKYDK/1t31I0Xos3EvXXWZvJnu/Dj8=;
        b=ZerXNUtjhMC/jKxjyPbE4KXrRRdLJqU99yhbzGTpNw4RYk7InKTWzu82H6sYkKlive
         k+IQTxnuDZblRlDrejCBh3PdgMtOgLDRxoj73j//NKOvq/z/xr6Fura7IR/RMR5VSf4H
         5eePrhKU19KNZPC7eew50pC6D3/eW11LMgDC8pFKhSzfwNryzN8yaBhM0VErVLX1vd45
         qMel1E6ckZDbQiHMYahM3PG1k1vC3ebv0ysrss3wmtzksF7N/T77k1H8/AuTpcEoFsa/
         ZYGaRNDJXQKtrbIaUP7lrjw6+NUAq3rb57Z1MSYOv4Y4gaUS/CvMUoWz1FVlHiniva76
         WJjQ==
X-Gm-Message-State: APjAAAWSZDasTYESDMxahRYbmIvknzj6okWCLy4IRfgBEJJV/wempiFv
        J8dP/k38HW9KP0RR2+jrfqfkkS3mjg5VqChSb4k=
X-Google-Smtp-Source: APXvYqzlhYH1AZxPoUWhLlKAi/3cz5wBak0YHxRnRpq/UZvZhmQwxva9MvOWocpwez0hO+aGpdkH/w0NIKo5Lc5rV+I=
X-Received: by 2002:ad4:4529:: with SMTP id l9mr19566057qvu.45.1568236226485;
 Wed, 11 Sep 2019 14:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190911183632.4317-1-krzk@kernel.org> <20190911183632.4317-2-krzk@kernel.org>
In-Reply-To: <20190911183632.4317-2-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Sep 2019 23:10:10 +0200
Message-ID: <CAK8P3a0OBOrYKnwY8pCMiPQneXyrg3-O-LfrBF4=qy+HasU17g@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] ARM: samsung: mach/soc for v5.4, second pull
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 8:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> ----------------------------------------------------------------
> Samsung mach/soc changes for v5.4, part 2
>
> 1. Fix system restart on S3C6410 due to missing match of watchdog,
> 2. Enable suppor for ARM architected timers on Exynos.
>

Pulled into arm/late, thanks!

     Arnd
