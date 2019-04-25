Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C65C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B32206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfDYOQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:16:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33213 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfDYOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:16:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id k189so13115563qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 07:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aPOuidiZH4qfH77QcuS7z29qmmRuPhlC00KMsUQYZ4=;
        b=Xm56ORFsET4kUjkejya/uLGZNfkav3LzcDLLo+cRHKtekbXKMso8vmkKWtYy6F2CfH
         ZYgPj9z9+5kfgFHCz0r4SaWa+51teyCG4BScAhGCQbeTOQgYFqAEw8K8ieUU0o9ittYj
         QGOWkib+4MrokqpD4UzjJFo5GFk/kXH2BONPvTTjxhjrBGr9hPVMkQDJXZ8LuKjWo1We
         +JbbUtU1sWhbMcr8pZvjta40tHStCcRBggCt/M80awRQd34UbRZnbNQHgDpVLtipnAEN
         HQzdrKk8cZmeC3aKPuXBXb6j8A5jYcKyO0pawT6VpNGXK9qP7zq1n5d8LEvhVMC2e58U
         tpoA==
X-Gm-Message-State: APjAAAV0GS+J8FIHvsmA0XRC9RWo1MBaVvmz0FB+je0wEbgcNoyyKwcm
        O+vVbwkxyZXyM2J6RxLmnxrUST2WnLmfbKqCYkIWGk55UPQ=
X-Google-Smtp-Source: APXvYqz8fz1gHC/4Kyfnk3ktBjGw1qzalfuoCKbp1s9HHUq9wLYSoi4OGikb1Ct3RYQKQSgjfQBYS3oXhJfcACCSkiI=
X-Received: by 2002:a05:620a:15cb:: with SMTP id o11mr29671781qkm.270.1556201788827;
 Thu, 25 Apr 2019 07:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190425233430.14bdb102@canb.auug.org.au>
In-Reply-To: <20190425233430.14bdb102@canb.auug.org.au>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 25 Apr 2019 16:16:17 +0200
Message-ID: <CAO-hwJ+DOfjoL+ZS0amusr7JEBv6uis5tn59gb7XFepXO8Lb0Q@mail.gmail.com>
Subject: Re: linux-next: Fixes tags need some work in the hid tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Apr 25, 2019 at 3:34 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   39b3c3a5fbc5 ("HID: input: fix assignment of .value")
>
> Fixes tag
>
>   Fixes: 2dc702c991e377 ("HID: input: use the Resolution Multiplier for
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> In commit
>
>   d43c17ead879 ("HID: input: make sure the wheel high resolution multiplier is set")
>
> Fixes tag
>
>   Fixes: 2dc702c991e377 ("HID: input: use the Resolution Multiplier for
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not aplit Fixes tags over more than one line.
>

Sorry for that, these are my commits.

I just re-read the doc, and indeed, we are not supposed to trim or
split the commit title. I'll be more careful next time.

Also, can't we add these requirements in checkpatch?

Cheers,
Benjamin
