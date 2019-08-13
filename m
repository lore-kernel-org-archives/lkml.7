Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8612EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2422067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfHMTgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:36:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32803 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfHMTgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:36:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so15195207qtb.0;
        Tue, 13 Aug 2019 12:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64QRb4GGMzoJ0fGBiaTwYwKZ4A1mAxuXZNxWhTksFhI=;
        b=njGlDUYua/w+G6ItLiV4fwRW1RJOwc5xC6leZ745GMik+4a3+Y3CfWhHQ5ZymyUooc
         MREksAOaJFZ0Ki5zapmD1k7G3WLIOOyX0hKawx/2Idpmeyy4mZGC+tTMS72674fNgq1B
         LvRGKUaF+KoYcR9OfDHfvzZMi0vHhSjvLo44VDL7KBbD1nR29ZR3swK6bWFcT9Ya1zH/
         l0l29QCu4I1E+NhGU1yA4etWkXrWWtT9fcBBEI47kPpZpJKjJyqirqyHxSEgF7gqfGD2
         0l839ZaV6Fiis4pY0PoC2juiKr6PNVf2zQsoAZmivE0Zqh4DGmGz4w+4kPfDzp96DhrZ
         8gYw==
X-Gm-Message-State: APjAAAXwLkpOm7Pc85ueqBbLTE2gp9U7U3yfq34c1gATHHppZCrLawBe
        ZYbawAdkxPbxHJ65B8SPpw/wjKUptXWIN6nbZeE=
X-Google-Smtp-Source: APXvYqxa2zhhLdy0RHZMdPoTiqVm6rEw5tVd7J8pF2Y0ifC2VEqmZZJFY7dK8ABlEKxMDhVftjOVqAAihB8+hQiFpGo=
X-Received: by 2002:a0c:d414:: with SMTP id t20mr76120qvh.45.1565724974318;
 Tue, 13 Aug 2019 12:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190814002836.4b6aa14b@canb.auug.org.au>
In-Reply-To: <20190814002836.4b6aa14b@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Aug 2019 21:35:58 +0200
Message-ID: <CAK8P3a2q1mShg-EQhiAFUOAET8UEMHfLJV-+HoLTaSQY+M7yBQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tags need some work in the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 4:28 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

>
> Please do not split Fixes tags over more than one line.  Also, please
> keep them with the rest of the other tags.

Thanks for the report. How bad is this? Should I undo the merge and
wait for an updated pull request?

      Arnd
