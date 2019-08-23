Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2FAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E2022CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390803AbfHWIZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbfHWIZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:25:58 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A76580F7C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 08:25:58 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id f28so9196903qtg.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjFqKkU/rr1wSVqQW2FjKWVFmd3zU0NlYrJ5LLeu7CA=;
        b=dsL3TSzVovLBxcgt4fHVpQ8V+17DO7Mdx7geX0kb0tTZs/QQaLFpNIJ2kgaWI4hreM
         tB7444G7Y0/1JdtvA0O+a9al7AuMClpuLoGVO5gk7DJnTL1XmyROgezcgHlU9l7eBIq9
         HQchW/56xaOH6ka4GwnYpVCHuFVNyGd73PKF5bKdrTsAjIdWV0Z9UKswZU35O6w5d1Tv
         kztt7fE25OnLOkyEQiGeHj/Z6QF+lwx15WKN7m3vF6wuZp1lU4HoAvf9T4VJTM096HTU
         mGEnWUCe6qnTeANcQ/F2u+93RxGUzs60y0FauhlgPw7BGhGXdOSdiyXKDplzZ8UkgrsP
         8zpA==
X-Gm-Message-State: APjAAAUVAR9cgi0XdQF4DuuNT4noFBDV+mEkJqm347uc7uQfaMySlv1O
        zkmfuvj/M7GSiQKAIHu4UsvLHzCFAucVVGL3FBNNwFSv6HFLDeQ2EQUyKEYz1BoBErlegHeI/OO
        TYGruJNWgIHpyH49gbXxoBh3j4Ko6aJhicP62ci+u
X-Received: by 2002:a37:7cc3:: with SMTP id x186mr2952751qkc.169.1566548757932;
        Fri, 23 Aug 2019 01:25:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNX4lU3xyrEi8AXJCSV1OukASjVTtdoDCQ51j+nsk2GbCz5NAdQVvXyjy2qAxcjjN6hawR5X8aynRxBKBw8WM=
X-Received: by 2002:a37:7cc3:: with SMTP id x186mr2952739qkc.169.1566548757737;
 Fri, 23 Aug 2019 01:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190822201849.28924-1-pedro@pedrovanzella.com>
In-Reply-To: <20190822201849.28924-1-pedro@pedrovanzella.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 23 Aug 2019 10:25:46 +0200
Message-ID: <CAO-hwJKQcTpmk8cVf-YmKu2awXv_53=qfpy2yfmy2rgMu_DEug@mail.gmail.com>
Subject: Re: [Resubmit] Read battery voltage from Logitech Gaming mice
To:     Pedro Vanzella <pedro@pedrovanzella.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pedro,

On Thu, Aug 22, 2019 at 10:19 PM Pedro Vanzella <pedro@pedrovanzella.com> wrote:
>
> Resumitting this after having rebased it against the latest changes.

thanks for resubmitting. Sorry I wasn't able to provide feedback on
the last revision

>
> The gaming line of Logitech devices doesn't use the old hidpp20
> feature for battery level reporting. Instead, they report the
> current voltage of the battery, in millivolts.
>
> This patch set handles this case by adding a quirk to the
> devices we know to have this new feature, in both wired
> and wireless mode.

So the quirk is in the end a bad idea after all. I had some chats with
Filipe that made me realize this.
Re-reading our previous exchanges also made me understood why I wasn't
happy with the initial submission: for every request the code was
checking both features 0x1000 and 0x1001 when we can remember this
once and for all during hidpp_initialize_battery().

So I think we should remove the useless quirk in the end (bad idea
from me, I concede), and instead during hidpp_initialize_battery() set
the correct HIDPP_CAPABILITY_*.
Not entirely sure if we should try to call 0x1000, or 0x1001 or if we
should rely on the 0x0001 feature to know which feature is available,
but this should be implementation detail.

>
> This version of the patch set is better split, as well as adding the
> quirk to make sure we don't needlessly probe every device connected.

It is for sure easy to review, but doesn't make much sense in the end.
I think we should squash all the patches together as you are just
adding one feature in the driver, and it is a little bit disturbing to
first add the quirk that has no use, then set up the structs when they
are not used, and so on, so forth.

Cheers,
Benjamin

>
>
