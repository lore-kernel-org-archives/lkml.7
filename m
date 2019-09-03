Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F42C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812B52377B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfICOaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:30:07 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:45513 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfICOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:30:07 -0400
Received: by mail-qk1-f175.google.com with SMTP id z67so3234423qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txdROfjUl9dM+2yPuRDkyhhvxXozqecsN8VhuY+SZ7M=;
        b=ULLfLJRUthwwQFUok6aLJJI3L7rutVQkHBR3ssAcfR9bKNBce8F3ZlwoOGVyfZ4cus
         ibChoEl7Y/q5ODSkTcgP078pg6570sweuswR7Yv2yl1RcCn/DifjZ2IH25UD7N/+mEK5
         dZCZJHiRk+pYhTy7bC6pXU8c7C8KhBIuVgKikPM6a7Wp3h4JsmJe6XL6Hn/ZOHzQETvU
         a4m5MWNgT1ZeeYrFELvhWWgBKJoMwQdhNudjyTxkycwAPJc7pKGIBgmwQ6MKRro6cg5E
         LmO8vu9lgqZBVyb21JQF5EGylqfiJp55wa6NBlt/HN2r4LCrokKX+KDMzZSOgZqdg040
         pY2Q==
X-Gm-Message-State: APjAAAUkpvk2buhnaDCRuT3mZ7yHpwI2/JgbqbTrbbdJqPyhPC77yqEa
        KPEfUZ71Ost9w9qOUQUhIoASkEqpusbLT++g6Is=
X-Google-Smtp-Source: APXvYqwLjTNx47Gj2QNqFyNsIzMwL+B4ROtxwyKeybUMtTA2U06E+WJnLtr/oIupoTE/Ww1krRjNLWQNdg1l/SO1/Tg=
X-Received: by 2002:a37:4b0d:: with SMTP id y13mr33577722qka.3.1567521006053;
 Tue, 03 Sep 2019 07:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <878srdzjpj.fsf@FE-laptop>
In-Reply-To: <878srdzjpj.fsf@FE-laptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Sep 2019 16:29:49 +0200
Message-ID: <CAK8P3a1+mZ43aKg5mEU+LsAtCr5paLseYdCPv5qJ=xH3Qaufjw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: mvebu: dt for v5.4 (#1)
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

On Wed, Aug 28, 2019 at 12:07 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> ----------------------------------------------------------------
> mvebu dt for 5.4 (part 1)
>
>  - Disable the kirkwood RTC that doesn't work on the ts219 board
>

Pulled into arm/dt, thanks!


    Arnd
