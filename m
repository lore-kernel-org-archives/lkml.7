Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2EDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949C923402
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfICORp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:17:45 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:42966 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfICORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:17:45 -0400
Received: by mail-qk1-f179.google.com with SMTP id f13so16023805qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBvHA58am235Kil4REO1DbmmyCPU05PPM7Vs0ryKTNo=;
        b=owjmXsy4sYDrqU1u2Nlwf3ErqlBJJ+Zqe8bJK+XXeo3xgO22z8/xj4ToLVaXXh63PD
         XfPxNQb1YCG95aDHDJHl7HBd7HK1iyRNg+iD89UOGbqEb6W/x9Wfcb/8ZDB9NuCeqN7E
         a44S5S5XvOj+pq+t7fg2sp342LkaZiJod9JbyUlNyyTcydkcCKcV6V/c/pczWCOOrAXK
         fxEuZ8GkkH9wpZZxobADiOqWQjdSpQj5r1oKxPBBPOqlrJplKTaQBSaOnmlaQ1u7q0kJ
         jvQeJ8dAWR8d65rJZ8YeRugsLsguRVhgB+jWdkxFJSrLFd3c3t3eWwLhDFkA8yYcymGH
         xWEg==
X-Gm-Message-State: APjAAAXwCBvNnpAqd+8EVKbZheNy4FUbr0b2+x7rOuYN7cIl+5hHfo1/
        3fhjAgPD2qDlN6pPixFxszT/0a5lV7dae1e2ZEaoaA==
X-Google-Smtp-Source: APXvYqwVhpns+/EW7fpsdQhggKdxH3/H/t+l4aj+6vVdTXMt4EPrOuqWUGnp7WY2QEGcRuvIcLyWQG01kiIpa+fcW6k=
X-Received: by 2002:a37:89c4:: with SMTP id l187mr6689014qkd.286.1567520264292;
 Tue, 03 Sep 2019 07:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <875zmhzjml.fsf@FE-laptop>
In-Reply-To: <875zmhzjml.fsf@FE-laptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Sep 2019 16:17:28 +0200
Message-ID: <CAK8P3a2whyE+GRg5Q-fDWHKRegnEybuGHY34B45WNkmx1pY9Mw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: mvebu: dt64 for v5.4 (#1)
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 12:09 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
> ----------------------------------------------------------------
> mvebu dt64 for 5.4 (part 1)
>
>  - Add mailbox support on Armada 37xx
>  - Add cpu clock node needed for CPU freq on Armada 7K/8K
>  - Enhance CP110 COMPHY support used by PCIe, USB3 and SATA

Pulled into arm/dt, thanks!

     Arnd
