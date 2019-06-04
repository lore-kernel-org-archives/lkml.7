Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5FEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A591A2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFDTcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 15:32:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37670 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFDTcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 15:32:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so1445476oih.4;
        Tue, 04 Jun 2019 12:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+foDqFARTHSWTyodVanz5MQ4oguv8cWe5Ge3BJ5pUps=;
        b=IKyTOOdx6AiEkq9QoYeUzziUBw/H3y3aLFqpdtD1EZ6xGS5BDYMgZ/bwIOSmz2RXJ0
         k77AtPtwsooitG2iKu6lKnYtK2rp5H660dNtYwIcub6GtNPFC4E7U0hLZI5ZsJE6vhfo
         +j+l9OVRZ4pWL2kp0UVgsuomDKcYNG1qFa2QMF1gylq+r/iBbNg//UBoRSqC0w9pRQsA
         Vvn0iwZldoknan/rC7aHk4fLvRAa8aOY5BRPj4bXSY1PsAU+rWUwQLjNdHHcfQ97zOlS
         SCc3VSmO5gvhrEo1VZVcK0qB+6cWjfSsGKiTMmGLyGRLGs/9pE9ld+uyyBaocvV57Zd0
         lgKg==
X-Gm-Message-State: APjAAAV44L1N7t79wWDA5dgK4KblTdBZfT0N2GqaayPro+p9ewaOV7EI
        uU9RDGomokQ1XLMmRvDEMK9GUgcu32H7lyx5GwN7iz3D
X-Google-Smtp-Source: APXvYqyCzxuBdnnN0GJKre76sfBrLX65clPn4InKFS4WmGhnfe8Fh4gjLbZCDE9PVdnG/NHS22bCsJxD8Ldfrmr/bW8=
X-Received: by 2002:aca:c4d5:: with SMTP id u204mr5175689oif.131.1559676739766;
 Tue, 04 Jun 2019 12:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190530135317.3c8d0d7b@lwn.net> <20190601154248.GA17800@mit.edu> <20190604130837.24ea1d7b@lwn.net>
In-Reply-To: <20190604130837.24ea1d7b@lwn.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 21:32:07 +0200
Message-ID: <CAMuHMdW3ChMmeFY2cK0R61sc90BBArytdzMP4nscqCOpf56f1Q@mail.gmail.com>
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Tue, Jun 4, 2019 at 9:09 PM Jonathan Corbet <corbet@lwn.net> wrote:
> On Sat, 1 Jun 2019 11:42:48 -0400
> "Theodore Ts'o" <tytso@mit.edu> wrote:
> > Finally, I'm bit concerned about anything which states absolutes,
> > because there are people who tend to be real stickler for the rules,
> > and if they see something stated in absolute terms, they fail to
> > understand that there are exceptions that are well understood, and in
> > use for years before the existence of the document which is trying to
> > codify best practices.
>
> Hence the "there are exceptions" text at the bottom of the document :)
>
> Anyway, I'll rework it to try to take your comments into account.  Maybe
> we should consistently say "rebasing" for changing the parent commit of a
> patch set, and "history modification" for the other tricks...?

Or just "reworking a branch" for the other tricks?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
