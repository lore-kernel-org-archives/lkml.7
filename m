Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB552CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83578208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZCcCfym9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfKAEZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 00:25:46 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:24318 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfKAEZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 00:25:45 -0400
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id xA14PeNG021249;
        Fri, 1 Nov 2019 13:25:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com xA14PeNG021249
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572582341;
        bh=pCtXAaE0virYIG118S1JYIBI2/pqRmNhONsF5S2WZqs=;
        h=From:Date:Subject:To:Cc:From;
        b=ZCcCfym9eAsD3td9tDiu6VehIzGHAu97sEWo30pbuWDjtXT3BQDWXho7UW6YTkYXg
         cRCvg5UdO2fD5wOKhqUJ7z/uVghxeQ1F0GkwRVygNQZ+VSPupN6Y+v7Fu3TTQJAuyA
         sJiiWE1h72faE4oLBo/Xjxcfj3L9tWB+atJZU/MtoG79i4ZLL7DmsTGioW501js3rz
         1Rbc3247+FaYtjGAAwSZYZXPdH421Hb1yf1tlDewUpTzfkVHBpVo7KxrHsVQkdCN5L
         WAQjWVKbDGwy7n7S/9KpClxbgVsbetxP896rsWUZsCowrZb9JfQ27zgaW3aVAngdo9
         77sGlSAPpwpTw==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id j84so1922156vkj.6;
        Thu, 31 Oct 2019 21:25:41 -0700 (PDT)
X-Gm-Message-State: APjAAAX84pQeMHwxOydsMbz44MUoMQfvCnz0fexkIqhWn7ePJG/bwGu4
        dXSXGKc4O4dF7NQihSAVXH3zXEEld2pkAdcaKj4=
X-Google-Smtp-Source: APXvYqzANr9eUZIJO9faypzXg/yr/mvCN/OsFXT+HNZt++PanWn3/RSlTqAhDwathiFnRb6y64Tg/SWVaCQb8nvJ8/s=
X-Received: by 2002:a1f:6a43:: with SMTP id f64mr4452196vkc.96.1572582340027;
 Thu, 31 Oct 2019 21:25:40 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Nov 2019 13:25:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
Message-ID: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
Subject: spdxcheck.py complains about the second OR?
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

scripts/spdxcheck.py warns the following two files.

$ ./scripts/spdxcheck.py
drivers/net/ethernet/pensando/ionic/ionic_if.h: 1:52 Syntax error: OR
drivers/net/ethernet/pensando/ionic/ionic_regs.h: 1:52 Syntax error: OR


I do not understand what is wrong with them.

I think "A OR B OR C" is sane.


-- 
Best Regards
Masahiro Yamada
