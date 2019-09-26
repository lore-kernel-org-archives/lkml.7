Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51F8C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB8321D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBNIEO0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfIZP07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:26:59 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:36765 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfIZP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:26:59 -0400
Received: by mail-lf1-f53.google.com with SMTP id x80so2035447lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=s+9lOd9twZ++9lVM8x7eTHgsEZRoyEnG24gVWpP/yDQ=;
        b=GBNIEO0enx4yByEHHUOb+9DyJwd6a9M3U98jKwV3yi5VNB5AEDlweL9FpWSpxdttyC
         WpjbPackduphy2sbqMMb3dHi3C0rSJgLTVB002Ru3iElSAUECtck9zrpLji+lJjLFE88
         qdpM3mEAYDFjiWP7Kg213RCF1drx+jgUtk6RYQohgEx9Sn4IyjkWpsUmN7BA2lP60Yep
         fTRnYd18NEjcyNFNvJ944CUT5mjnXMOMp3J8EBFn66rDmFS2+vY3oiPpOkd2jUf4zvIU
         Lix95o0wVTC6IlbjcCeHv00zpUmZEIJVMwWHrvd7Lmgmt+u49m0qnuwzSE28vQhKnmoN
         F4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s+9lOd9twZ++9lVM8x7eTHgsEZRoyEnG24gVWpP/yDQ=;
        b=sthaoXODEMI+1cjlC8pRV2I+Zj1UqznuKBKg73W021+SPFQbBG4frF/J2IH7dr6zS5
         k87AeGApjtRFdfBDQGTw/4Sxfjmzk9t3qJT3c39d4nIFS9NO2l6cfF2zCJt4Rurdpo3S
         WlBHbqTmA8PQcMfKNyYyodSYekJ0O7VtJyg3b+f16DBIZhehivC94aG4mYs/BiU43v9I
         lg1OvITNZ3BtfDWqE6Pp44AstK0io1MIHYYQKuCNERWv7Z6zWkaDiyHkwNhD7701z0GF
         7xwQi2MrMC2timVLUQ0n8IC91qa7DHOiIQ0otVT2scv2WPH1t9Xs1y4iEA17iCxzlMD1
         edpg==
X-Gm-Message-State: APjAAAWPdPeBN/ZBktYhN5ymv8dFp9YAvmCGKkVEdTj9GS7WPHVpOubJ
        x9JiKT4WFkn115cEiUzr9qxjcHlT1fiyKa/nYsYaYZpf
X-Google-Smtp-Source: APXvYqx9KOsCzeRm5K8Du9emxpnNYYsYFechCA8Ys0Wwu4kB+Yf+FNghunoPHy7acNAKBAcTcZx/FSgEjx5+Xa7uTy4=
X-Received: by 2002:ac2:4c8f:: with SMTP id d15mr2797292lfl.74.1569511616809;
 Thu, 26 Sep 2019 08:26:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac2:46ca:0:0:0:0:0 with HTTP; Thu, 26 Sep 2019 08:26:55
 -0700 (PDT)
From:   "\\0xDynamite" <dreamingforward@gmail.com>
Date:   Thu, 26 Sep 2019 10:26:55 -0500
Message-ID: <CAMjeLr-RBsJaU7366wLLkO-pP8h_4E1yOVx0KtjmuxdJ8m-w4w@mail.gmail.com>
Subject: [OFFTOPIC] New OS
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the bloatware that all modern OSs have become. I've been
developing new computer science to make a new OS.  This OS may be
provably optimal.  How?

* New CS reveals that architected code reduces code size to 100 log2
non-architected_LOC.  What is architected code?  Architecture is the
complementary opposite of software engineering, the focus of most OSs.
Like properly-architected buildings, a well-engineered building isn't
necessarily efficient AT ALL for its overall usage.  This puts the
capstone on the field of software development and creates a new eon of
computer and data science.
* Language expressivity is measurable.  Termed Kolmogorov Quotient,
there is now an equation to measure the utility of languages -- an end
to the language wars.
* There is now a unified object architecture (called the GOOP: gospel
of object-oriented programming), so that OOP can realize it`s goals.
Along with proper architecture, this allows giants like Office
applications to be built in 20K instead of 20M.  All objects are apps
and all apps are objects.  All objects have the same API, creating a
data ecosystem of reuseable objects throughout the whole OS.
* Since the internet is now the norm, P2P is built into its design.
Objects are shared across the network, and each object hold metadata
that includes their paypal account, allowing them to be paid each time
the object is instantiated.  Now F/OSS programmers can get paid!
*  There is no need for a compiler; to be explained later.  The OS
does it for you using an optimized language design.

The millions of lines of driver code shows that architecture is faulty
or lacking, probably in hardware.  Processor geometries should be
figured out, such that tetrahedral GPU cores, for example, can handle
3d modeling properly.

Full disclaimer, I don't have one line of code yet.  I'm waiting for
assembly to and my development platform to stabilize.  But once a
basic prompt is available, objects can be created easily and a whole
system can emerge with very little effort, much like UNIX did back in
the day.

Sorry for the post, but I know there's someone out there who can use it.

Marxos
