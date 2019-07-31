Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F4AC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76023206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK35ux85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfGaUgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:36:50 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:33352 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfGaUgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:36:48 -0400
Received: by mail-lj1-f172.google.com with SMTP id h10so67008578ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=W5sXEYqP0ujTX/3QnJh9aARc9TQKIr+quqWDCsTrp4U=;
        b=nK35ux85iR+5iGNAAHcDjrGy41ccb9PKY2zg9w/t79t7Hr1vmfOt4jW+XEkBGUDY2E
         AZSg/PRLc0Fe7sV4p+e3bY0P34b8u2tymwXw47PlQBz0FijPak7118X1KnTMMJwOQoad
         oMtZimAoeb2b7tljD3lDN/ZQ/C/br/YGw70apikcs/HHl+SwSao/hey4dj6A3GcGm0W5
         A43EowiIQgcb9U+reFFUxiZLwi43UCUyBfNNs1Tir7blDUaY7dHYe+XUvTxMj4VpJLQI
         HqYjRf5zx9X32n39irmRECGNrqB4l/OCYpUaBeFUk0W2W6fqqvcMbPCvvzwrEJJRshZU
         8Bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W5sXEYqP0ujTX/3QnJh9aARc9TQKIr+quqWDCsTrp4U=;
        b=jAtAGuGPKgNrGsz9ewKV9FV/aODovrLEJ17sgbs8kHIKPzh07gyU1CNeLQYda2rV/F
         vPY3pYOd9rbYHeQtJxj9NO8a8BWQyMrfXYFQ2/vAoQPre3adaPWQRkxX3Qas15+BuDar
         wzqhiRqeHaz+zu308qkQYjfS2aHw54RmAAzELbi6E3LR6Lxsw0oGZhWZFEMIbec1e5/H
         3uCyUMITNcYXWn5EJjlXOYqL3q1nsDvPEgd2kEc+4dPt5D5h42MGDRoDTfxZ35i5UY18
         Q/J6XFLIR6Qj7xEwd7LTWxZD362R4pyD/7uV7BUcRqksxtOuiSQ+a0p5Ge+1kUrc3GSX
         ZGbw==
X-Gm-Message-State: APjAAAXicOmHc8RyK7E8YkhlJEuYgiY9pMIWJrRW8p4se4evMWDuw4gq
        LrGv/6hj5KZVRrnNxvSJTN2TgGRUy4jO/jWT36oJzn9y
X-Google-Smtp-Source: APXvYqxzvgiZyhdf/oxBzDg8ih4P5jyW7VSXiJL0vJJVaPVuVfm7Y5rGy7PPKdEQvacxwm2HyM0PekkgJgaTaTx/SmY=
X-Received: by 2002:a2e:124b:: with SMTP id t72mr66296974lje.143.1564605406218;
 Wed, 31 Jul 2019 13:36:46 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 31 Jul 2019 14:36:34 -0600
Message-ID: <CAMMLpeQMPJjSx-hqZ75LCV0wC-kQBmqEe7wjb2oU5iq-pc5bfw@mail.gmail.com>
Subject: Re: Merge branch 'floppy'
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Denis Efremov <efremov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Actual working physical floppy hardware is getting hard to find, and
> while Willy was able to test this, I think the driver can be considered
> pretty much dead from an actual hardware standpoint.

Just for the record: I have an Ubuntu machine, still in daily use,
that has a floppy disk connector on the motherboard. The motherboard
was made in 2006 if I remember correctly and has a quad-core Intel
CPU. It has both a 3.5" and a 5.25" drive installed and they get used
every time somebody finds another pile of floppy disks in Grandpa's
garage.

I'd be happy to test floppy driver changes on this hardware if anyone
needs me to.

-Alex
