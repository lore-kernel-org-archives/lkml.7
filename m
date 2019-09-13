Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF552C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B080E20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxVG/wU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbfIMO3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:29:49 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:35582 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387600AbfIMO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:29:49 -0400
Received: by mail-qk1-f173.google.com with SMTP id w2so5494471qkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iANRww2JCmc08FFA9EnPixWlYCXsamLrDl3yTEnQ1yY=;
        b=hxVG/wU/Ic2SNmYFQHiqr54NsD/mdG7WU4I+t0bAG+Kk74fQzvUtSe5JZnUKQw8Boo
         z1D62JPovN/yAmyJKm7L3E6rAVIQxUkHFavpQ3QuXce7qWOZwTGUqtsTkaPYd9hBkTcg
         T9iQWX8pQYNO3IH/j1vCu8aeEZrFt88SFpZaWUYntV4xYnrDsjzcJNRLyI8bmJTB5YTJ
         8+IZ0BasDXGNB4nNZY7TbVsSJVpiEF/6oPkaNPeepcCeRukLuAdSokHmAAXML5Oa1WY2
         CfleOddISBFBrEvAM4TkTbT/BNMfRvqBCIs55zK/PHigWING846E44gl+3P8d85PEJtN
         i9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iANRww2JCmc08FFA9EnPixWlYCXsamLrDl3yTEnQ1yY=;
        b=BVT4MHWcE/ZcYfd8ts9i04hhtKkqzv568sVdTdnF0cKK68hLEUYZoThQzItr/nheUg
         Yu9uCs7FpF3YgU9FRqIqD/sVhxdNpakR5ovhm7/0u31Fcnd/wSckuB9J4GRDAbRZ3zKG
         S15W7iBpEtVsebVHGP0wMWYjTEETwTeD0ik+XSiTVfIa56i5ruNf9F50N0JUHF3dIb61
         gIaM1YHEPpsyMJgHTg0pPR+Qw5kvzSCONEJcW/09AIiWelsQsVIiHqnwQBj5gjSNCNc/
         lbu1SgvBTrs/gnpdVkqhySQcMvBtxsinCDXIejm4+aKyG0aS1klJYUkctlMkig5p7UA7
         KpjQ==
X-Gm-Message-State: APjAAAUehqs4zJ96vjGcpcAa/YVRP4g6Jwb1gudrJRkGdFziGptdHOs+
        +ghg7Hc+GdRs6pThOBzmFazZNDoSdGgIgh85MT+29tXv0se6zQ==
X-Google-Smtp-Source: APXvYqzoHWRrlYAO3rxg6hpeijRniXW/G/J49LBKdigKZ2lIvBMmezciL+tR8kdzRHRknUD42QS5ovw9dwdVKBxw+ig=
X-Received: by 2002:a37:82c1:: with SMTP id e184mr20614285qkd.206.1568384988320;
 Fri, 13 Sep 2019 07:29:48 -0700 (PDT)
MIME-Version: 1.0
From:   John Doe <dovla091@gmail.com>
Date:   Fri, 13 Sep 2019 16:29:35 +0200
Message-ID: <CACxzxDkwXhHBpCRbJk50BZiE-RTrXoYoXK-aQBjjAzqqrFF7aA@mail.gmail.com>
Subject: hid-sensor-hub bug filling up logs...
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Sorry for bothering you, but I have one question to ask.
Recently I have installed Fedora 30 on my HP Spectre x360 Laptop and
found out that our logs are flooded by message:

hid-sensor-hub 001F:8087:0AC2.0003: hid_field_extract() called with n
(192) > 32!

I did also install 31 version to see if this was fixed, but still I
gave the same problem. Since I am not a developer but mere mortal, I
need to ask you a small favour.
Is it possible to fix this error as it is making lot of issues to all
of us that have Spectre laptop (not only Fedora but all using kernel
version higher the 4.19), as it is generating insane amount of data
into /var/log/message when I meant insane, I mean 10s of messages
within a second, so logs grow to couple of GB within a day.

By doing a research I have found that another developer had the same
issue as me and other "mortals", and he provided some sort of a bypass
by patching hid-core.c in the drivers/hid folder and hid.h in the
library/linux

Please refer to the link below:

https://patchwork.kernel.org/patch/11052949

and

https://patchwork.kernel.org/patch/11052951


If it is not a problem, can you put the patch in 5.3 kernel release,
as at this point, our machine is quite unusable. We will need to write
a script to delete logs every day as they are growing insanely high...

Thank you in advance and apologies for my English as it is not my
native language.

Have a great weekend.
