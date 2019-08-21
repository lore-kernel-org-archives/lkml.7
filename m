Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABC8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2D22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566373963;
	bh=5nteA5+zrmgipnO474yy0n0FecWH31sdGUTtNAhVCSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0hstm7850blEJ3L+qGW0AWuHw9dSqyGNhoZfqhoDT/CM9q5wsDw8faBTJPT39yVVp
	 lHLeuEVwB+e3FeoajGZdS8H+Zq9albGjZiaHG6ihRztSWQVKI5s3P8ra0W1ShoPJWO
	 hno7uNyiydIDQP8O6cgz6+k8hMA3kvVoNP1Mc63s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfHUHwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfHUHwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:52:42 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A00233A1;
        Wed, 21 Aug 2019 07:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566373961;
        bh=5nteA5+zrmgipnO474yy0n0FecWH31sdGUTtNAhVCSk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wRvhpXgKSWITJklv09moe+PnqURa1UxxUJsPW/u0u3+nvywwPXpKcmNEDe9jKS2ro
         j1GHKu4zAcdFlYl0V55fHxrVytszz/tttZ4MvNOkLi49m4UX1l7mL7HFAcZTJDVryz
         4eOsmgr1/VUr5co1rhk8I9tpjNEtaUGN69Wk0UuI=
Received: by mail-lf1-f46.google.com with SMTP id b17so1080082lff.7;
        Wed, 21 Aug 2019 00:52:40 -0700 (PDT)
X-Gm-Message-State: APjAAAXN+XDstM6HMACTozx3eZ0Ndw9AFuVevL+rOc4wGDri6x8O7LUd
        D3rf6H12HiJDqNkbrbcrx4uwFoHhN71gt1Li7+s=
X-Google-Smtp-Source: APXvYqyAP1YOkm4D4f2V9WUC7znA2zZ/37GCGmDoDp9GcPyr7juX3RDYpPhUNtI6GfUQhYUiYVaD26GcNbEHnr5PNB4=
X-Received: by 2002:a19:c20b:: with SMTP id l11mr17713344lfc.106.1566373958980;
 Wed, 21 Aug 2019 00:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190816163042.6604-1-krzk@kernel.org> <20190816163042.6604-3-krzk@kernel.org>
In-Reply-To: <20190816163042.6604-3-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 21 Aug 2019 09:52:27 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfdvzvomUfmxhGf0qjEQH3K8TADCneo9SM6m50k4b=Gyw@mail.gmail.com>
Message-ID: <CAJKOXPfdvzvomUfmxhGf0qjEQH3K8TADCneo9SM6m50k4b=Gyw@mail.gmail.com>
Subject: Re: [GIT PULL 2/3] ARM: samsung: mach for v5.4
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 at 18:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
>
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.4
>
> for you to fetch changes up to 1fa70c7f49132513fb0da4afa7643395eedc7d35:
>
>   ARM: exynos: Enable exynos-chipid driver (2019-08-15 20:29:58 +0200)
>
> ----------------------------------------------------------------
> Samsung mach/soc changes for v5.4
>
> 1. Minor fixup in plat code (S3C platforms),
> 2. Enable exynos-chipid driver to provide SoC related information.
>
> ----------------------------------------------------------------
> Linus Walleij (1):
>       ARM: samsung: Include GPIO driver header
>
> Pankaj Dubey (1):
>       ARM: exynos: Enable exynos-chipid driver

This last patch should be dropped so I will rework the pull request
and send later v2. Please ignore it for now.

Best regards,
Krzysztof
