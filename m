Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_SCAM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38F0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C142082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPC3Wnsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfLQVrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:47:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38014 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfLQVrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:47:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so1291386ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jT/Clm9ZkR1esBu6GjzeLC8yOU74z+r51KBH33HeVXo=;
        b=gPC3WnsuXGzV8kQKP1JZ/TIz570HC2S2xop/0Ir7XATQH4Iaq+DObjndzLJavxx/8g
         ExPYJR9yG21IK+urQakNKWUVdxfgoHgJ6RvEeqk2f9OoOte6AR5eNBhgPQuK7RhuB4FN
         HpVEgsfmSK22WbBQWg01eEYtOmAAVLaJstIwA/AURB1032g0tVGezvTr7jnvt5Gd79KK
         0LN+mCWZ8q6UVYPDAeDOTh3H9rXAwpgJb+c1JyRGKLzG0kXotCnB2e9vvH7IjDOVrlL2
         3l7Ms8/1dNwezao5hr57lnmbHlhpNG0kbV2ouDn5dPdmTjbkVLcqePC8MRn9GLlZTQdV
         bQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jT/Clm9ZkR1esBu6GjzeLC8yOU74z+r51KBH33HeVXo=;
        b=iS/XDBz3tMNDLw25ml2Ex8ZTPxBhIAcZsp6eiB/TZbKx7vUJrbWwLdx9Dz5ShNOSdf
         LSWq5/SSi+LX8AtbiUCR3/35Zyi/KpZev6gOxs4k9/CCj9F9ItjGmxefXg+w1I5pnlRR
         sCIGLROOpKPrtCzNCmCCZZc2ROXMWfeS5EOuB60mZKXTWZFb2MPpT8etGKEJQI4Z1KQ0
         j1FB96rtXQTJAeLY/ubOrXwcBZ13R1fI7LMnwWoZIAYZ0PEbh6i4cAmNFEO0NIL7YguC
         k1vJxrzmd7xszEW3Zd22ouFvyuzKzzh3xCsJM6MJGqnyeqe/mjhT4d7uDDsbMWpzeEBX
         Eeaw==
X-Gm-Message-State: APjAAAUvZoZTBTV0RZG/s1A6NwcQBINswM0R2uYCXUBDXeyNAYfKrANg
        /TH9kwEqCNIobW1Z5UB2xbZygoYQhREH0SOYY0E=
X-Google-Smtp-Source: APXvYqyxBjeEC/wAnHkaMPwlkg6hogy/F5hrm/sJa1Hy2ru6Tvi+Eq8MdUzmXX+1b9ikpbW+yEkBQ2gkXCgehsYf2dA=
X-Received: by 2002:a2e:93d5:: with SMTP id p21mr15694ljh.50.1576619231574;
 Tue, 17 Dec 2019 13:47:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:9c95:0:0:0:0:0 with HTTP; Tue, 17 Dec 2019 13:47:11
 -0800 (PST)
From:   Sarah Adiel <sarahadiel3@gmail.com>
Date:   Tue, 17 Dec 2019 13:47:11 -0800
Message-ID: <CAMtWnUky-yJ5qK=QQGy9izVzSpbN7YYGR7vFbE5bTYrVqFuCdg@mail.gmail.com>
Subject: Greetings dear
To:     linkedin@2x.png, linkedin@matthewburgess.com,
        linux-kernel@vger.kernel.org, lizcarbone1@hotmail.com,
        lreystudios@gmail.com, lwrsds.crps@hotmail.com,
        m_namane@hotmail.com, mabdelghany@hotmail.com,
        mamisasaki@hotmail.com, marcelo.guima1000@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings

   How are you doing, i hope you are doing good?
My name is Sarah Adiel from Israel, i got your contact and i decided
to contact you here for something beneficial. Am looking for a serious
relationship and i also have a business proposal which i will like to
share with you. I will tell you everything about me when i see your
reply. Here is my email address ( srhadiel@gmail.com )

Am waiting for your reply to enable us know more about each other and
also share our photos and idea

Thank you
Sarah
