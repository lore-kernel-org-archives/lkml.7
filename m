Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E45EC606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B22A20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfGHNWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:22:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40408 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfGHNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:22:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so17923465qtn.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 06:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ianVmwRDAhEQ4C+PF75ZdEJW6kcwlJoy+bjTJQWLCOI=;
        b=EKwVDLY5QURv8XC2KBB+bpyycJI5HcODgu8bKhLEVC4bavltzFfiW0Zsfa/qVELpdb
         SaKVrqmhWJaJ8CFaC3RAxwTiVcu6F2f/6ym+fumuZVzHSAXwccTw76hTL1CaTkNv9Ol3
         24f2AGuZxqmhZqOzT+odtvfY+upiKqh4ULkvhuifPxSzk/TBlBkW999EBGAB3EfYOr63
         LQCBRZMJcothtj7qeT/xRI5mYVUBEB//GmsYdIptYbW43w9QLDZRVGI+AG5ahtVKK9G4
         drbpEZwRasYOoBXNzram2TUL1Ofy0P5pPEMH35b6KWZ9LIUneqyYCN1OK+3CmY47Erjk
         O5ow==
X-Gm-Message-State: APjAAAV23/Yc7JnpG3GKF4uubAeEr8Y7dgvUbRlimVuAmFmX/ElLJMiR
        fN2fI42Hte5yvLIVITYY+lP60PW+7+k0o/83tqwjIKwu
X-Google-Smtp-Source: APXvYqwGvlyqyuTOQcP4Ew9FgdI1S1EltFJFX5o0QUVXhfDjjabMoo+wnYAm0TtL8oYxpHT3TsbGlyIjjQLveuDBDjs=
X-Received: by 2002:ac8:4996:: with SMTP id f22mr13608655qtq.142.1562592152055;
 Mon, 08 Jul 2019 06:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190708124946.3679242-1-arnd@arndb.de> <20190708145426.62b4aabd@xps13>
In-Reply-To: <20190708145426.62b4aabd@xps13>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Jul 2019 15:22:15 +0200
Message-ID: <CAK8P3a3ajVPdhda-UdjnbnLYhM+XqedhZ2A5JY3mkQz0XxGv1A@mail.gmail.com>
Subject: Re: [PATCH] mtd: remove c++ comments from uapi header
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 2:54 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote on Mon,  8 Jul 2019 14:49:39 +0200:
>
> A similar patch has been sent a few weeks ago and has been applied
> yesterday night so it should have appeared this morning in linux-next :)
>

Ok, got it. I had rebased to the latest linux-next this morning and then created
the patch when I saw the bug for the first time, but it turns out that this was
still Friday's kernel and after rebasing again, it is indeed fixed.

       Arnd
