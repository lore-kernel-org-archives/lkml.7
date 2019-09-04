Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99863C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7419F208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfIDUi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:38:58 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:33826 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfIDUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:38:58 -0400
Received: by mail-qt1-f174.google.com with SMTP id a13so98420qtj.1;
        Wed, 04 Sep 2019 13:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MvZy1FbaNESC5hiYskF8A5TsTUh4jxrhX3nVcTTYmc=;
        b=UYtFp7jGmImUToI5TzzyGHIbWFJqk53mN1X1dzVEMWvd1qMf3VOyAPNsGeAIv6h7HP
         7BfNDSSvBli8/of0tDzKXJucymBpzVJcrGQZGp/eGoB6pgEQxrBGSiWdmNDcKssaOtlP
         QDgexfw2GSODdf8j0l5y4X0/bS1m7DWdakfCastmqRhK4Bxh9W+f+aSDYvEFB6YH9eeX
         I3+Rhv9qtvmJ+5ZvDLpWANY5jKqBPRgZ1VMEKE3/epr9AYwfPoh1n2TPbMjk18TQKCqn
         O3a6DhTI75i6HYT6zJ8KkKrVai5WcgSzo8M7S3ivxtnpR/wGdyqXuqLuLZg4l8A9CsSM
         EtnA==
X-Gm-Message-State: APjAAAX4xa/+Mn9yFJw3Z8drW4FVCSWsfEitYvpDYl81jQHqiurxQlZp
        BuYqpfXa+krDg4lfjTYZzoAlbJH8esvjGguG500=
X-Google-Smtp-Source: APXvYqy7XTIfEdC7D9TnqQEhUpBTB+scHJcwLQbjJkCRBHFsN5ejgGauPka+3ex40mC9hoqrTRolPDdEBvgm1bRJH74=
X-Received: by 2002:ac8:6b1a:: with SMTP id w26mr17522357qts.304.1567629537029;
 Wed, 04 Sep 2019 13:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190904175002.10487-1-krzk@kernel.org> <20190904175002.10487-3-krzk@kernel.org>
In-Reply-To: <20190904175002.10487-3-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Sep 2019 22:38:41 +0200
Message-ID: <CAK8P3a2oOD+9qGtAzotZKVNeGSW4x9KQkg_jaCd+g47dD_O4SQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/5] soc: samsung: Second pull for v5.4
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

On Wed, Sep 4, 2019 at 7:50 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Samsung soc drivers changes for v5.4, part 2
>
> Fixes and cleanups for recently introduced Exynos chipid driver.

Pulled into arm/drivers, thanks!

      Arnd
