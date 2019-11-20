Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06EAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE00F208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfKTHqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:46:45 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43343 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfKTHqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:46:44 -0500
Received: by mail-il1-f194.google.com with SMTP id r9so964927ilq.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 23:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbWVc4AqJ1bLXkcPG87UFSnTXbwjXcZVdpKuRo5pyt4=;
        b=j5LmEoCMCgAwGA117mS4VhnqPbzAP02Go/k+/Hjj6ndZFfMJP1MpEfxS48zaeQLe22
         LSTP+Rwkrb8Hsz9B6we3dXF6V1bWNtBW4CQtJWP1Kov5KQ142spviQ5DYM8zo4WuJHUq
         ovNQyQJ34+IMZKC7AWPzYZtx6Rn6xKioJU+L0fmusc7jCOcT2mvLHSjhocH83/B/CMyJ
         980J8QYEVpKhJR7ANF6rY/3uD194h6DrvQgHV0hh2pjPglpTsRtX8eajKT1plClme2ZV
         fv1Qa3GYhbjJksM+dsmd1c8Wcnxarq54ZtZ3vztAhVk+Jmou/qdccfKiCPEfY0rX183L
         C9wA==
X-Gm-Message-State: APjAAAU5jJStV+Vr9/1xXiByBfPsTgZMKYKRrOcq5NPntpLeVh+G/dOp
        7u+l8uKMN2/s97ADxDji0KkJ5sVxrquPqOw1V8Q=
X-Google-Smtp-Source: APXvYqy4MyfH90MlQYTS9KQlJoPrapbCH3oB2MfAInofcjqD945aKYDjuz9NFTPQamHMS10q51VAXnF+2uqBKhcemTQ=
X-Received: by 2002:a92:ca8d:: with SMTP id t13mr1992082ilo.58.1574236003406;
 Tue, 19 Nov 2019 23:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20191113182643.23885-1-andreas@kemnade.info>
In-Reply-To: <20191113182643.23885-1-andreas@kemnade.info>
From:   Pierre-Hugues Husson <phh@phh.me>
Date:   Wed, 20 Nov 2019 08:46:32 +0100
Message-ID: <CAJ-oXjTyj_MWw=e17magu2Z04Y12sSiYq2N_to+JpWZQh6NCnA@mail.gmail.com>
Subject: Re: [PATCH] regulator: rn5t618: fix rc5t619 ldo10 enable
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, b.galvani@gmail.com,
        stefan@agner.ch
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for the long time to answer, this thread went to spam...
So, to answer your questions:
- I don't have the datasheet of that chip
- My reference was rockchip vendor tree:
https://github.com/rockchip-linux/kernel/blob/release-3.10/drivers/regulator/ricoh619-regulator.c#L492
- That tree agrees with your fix. Sorry for the error!

I'll try finding the schematics of my board to know what's on LDO10,
and understand. But so far it looks like I've lost it...

Thanks for your series, all of those features are also needed on that
board, though I never got the courage to finish it.
