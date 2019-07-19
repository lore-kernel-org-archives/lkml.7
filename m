Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1775BC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2AA20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfGSLif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:38:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41478 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGSLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:38:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so32417674ota.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 04:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=03l048ehGxbSZZvOhAbamfgP2eq6FIOyrVURBTlBhNs=;
        b=ToFcEYTtmavvIks8RcmyYaASfqPyN867JqO37meFlTpO9kpKeS7LqxInQu6jPVLVxs
         /pqGtDKSHsOXp7VUK7uyZ1Bxg/8N+3TM4cxHEFdKOVW/fM9UPQfU8q867c/MkwgKoZsZ
         i5n82uPtLeYR2j0VeZxps2HKP8UYgLtLrGB5mRpa2i6/cPcuyvpo5ABD8gWzwhmYfXY7
         Ykg4H1f238nUWVfqMwwx1oYNkYPyWAtIMc2tf4jbbyvAmRjd7xbPLnUoxMlUCGzhsuMT
         PpeBc8slCEK7yGXNJhI01LwKJyORDZgCD32kIbM5hDEeb4/CpWi3RYAwxhN52yujqSBy
         LXeg==
X-Gm-Message-State: APjAAAUAsDH4fZEF8k+0+PTDGiGtdem/nejjndIBj6x14EG1rYPSomPo
        9fV/GSt32jg3T4R0sf8I9VptJF8yGk7VVOplW8zptA==
X-Google-Smtp-Source: APXvYqzSDldk05B6ipsj8LXolcsxZ2gKRCSMuliXabwaUAp+PBKB7Y1ksewM7J8YmPmDj56HZ7dTgLS8Vj6SAeDLCSo=
X-Received: by 2002:a9d:4109:: with SMTP id o9mr15975223ote.353.1563536314574;
 Fri, 19 Jul 2019 04:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+7wUszbn05nieiVsGM=MXFtf9HVks8vqtuOKw7ejTYFZhq0iQ@mail.gmail.com>
In-Reply-To: <CA+7wUszbn05nieiVsGM=MXFtf9HVks8vqtuOKw7ejTYFZhq0iQ@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 19 Jul 2019 13:38:17 +0200
Message-ID: <CA+7wUsxtQ2BODXVth0TTmxCuU9iGcfqMNY3xh2pfbddcK-21vg@mail.gmail.com>
Subject: Re: Help: Regression in v4.19 : do_IRQ: 0.37 No irq handler for vector
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 1:32 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> [cc me please]
>
> Hi there,
>
> I recently upgraded my desktop to Debian/buster. Now when I start my
> xfce session I can hear the system bell, and my dmesg is filled with
> numerous:
>
> [  920.728347] do_IRQ: 0.37 No irq handler for vector
>
> The symptoms seems to be gone using git/master:
>
> 3a1d5384b7decbff6519daa9c65a35665e227323
>
> Could someone suggest a method/tool to track down which commit needs
> backport to v4.19 (other than a git bisect).
>
> For reference:
> * this is bug Debian #932304
> * I can boot in recovery mode without any issue. It seems to be
> related to an event in single mode

s/single mode/default mode/

In other word: it occurs when I 'ctrl+d' from the rescue mode into the
default mode.

> Thanks much,
