Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0960EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23742088F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUJF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:05:29 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:38977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKUJF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:05:29 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N5UoU-1hn3q1383u-016zQ7; Thu, 21 Nov 2019 10:05:27 +0100
Received: by mail-qk1-f176.google.com with SMTP id i19so2421090qki.2;
        Thu, 21 Nov 2019 01:05:27 -0800 (PST)
X-Gm-Message-State: APjAAAU0bkXovOvsue0t6dKL0RblfZySFbsNASSdJ3+ye3M9viOM5dDy
        CbhyrKBNnFbEd75QZlpGkTsSWpf89WH5QJlQVrE=
X-Google-Smtp-Source: APXvYqxPau0CX4F09LDtOmesj5Cd1TIi8AUcjqmj4PrzO97ZFhgjrYRZu9sWl6NpnLAieV7VsBLNzitahZrLPdgO8Pg=
X-Received: by 2002:a37:44d:: with SMTP id 74mr6687555qke.3.1574327126576;
 Thu, 21 Nov 2019 01:05:26 -0800 (PST)
MIME-Version: 1.0
References: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Nov 2019 10:05:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2a6PWRUsxNWfXWaeiU-JMA=wCZ9tZLkj8EpTijQ4eR0w@mail.gmail.com>
Message-ID: <CAK8P3a2a6PWRUsxNWfXWaeiU-JMA=wCZ9tZLkj8EpTijQ4eR0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] agp: minor fixes
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Fenghua Yu <fenghua.yu@intel.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VTV/KpKjZo2VrtXBuOfeRR8CDFabdqXdNLHf6RYcZl5ZWctNafs
 ge0v7J5T2ZswmU58jF9y3fslMfxdHHKTo6qrzPhMxcev1f3RI/rbC8sVxkMcteNl6JvX2RS
 vgkpICNDWBF4pEKw6LPZaTASS6sXOPkGsDBG/qE+WoKEXV2fLJiw9B7q+a28Gqik97/6i4D
 /eySsnDwxT9vBh9f0F2EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lPCBiYB0Gjw=:s+t44hQTYuW7+s9tuNYdLY
 rOHPv7O42gKMmMo5d0ujsYaTTzZ31yMtnI7c35Lkci7J9w6OhHGeMvqeWGVmS/XqTbJqBVETK
 PvddKHKH7XaGJGpPc84uI2Pw5jpJ2oVByc/nKfE+KvllFn85lrbSX0FqUybraQfy/4GowMtNw
 TkrIlo9Zct3BTfX8D88mrOBqadOUzzoXElYqQqqxvF0OasRDqGg8HlMwCfnPWfwCd3Taq2PGi
 t3jzDL97Rz81ZLmVNlBCqr02ZGddYyuyIQ74Mqe/DhJwI+5epk3W2GKmJF0R8KGADDzxOoCbF
 8mv98TGE7fb2NsdWLjBuhqD077K6Z2a46PW6EeGvpdhZQNS+MALvLDrCAOenHoxHlStECVHfG
 iPlXFPblSZ6xGG+FgusoBsDDdaoIhG/yhsRipT188KQFU9i5lOXBz3GDqLQux2DEYdCewhlKx
 SVPYxdqMxkB8BpziRGrGzVd5A9kXQCAZs8Fyb1m2Gvy+jiu+5CIMueij7Fuli+qy3ZZNSyb3e
 KVEZXxzcwT/X6pfA9WzBL73zH6v8ceTYfak+FQ0h8uU5ALXAE7LVD0Ra860c9keDPx8q9lhVU
 0UPBwYq6vBTzHY4sSq/YAyVX1fjPIqlzDBR3MRgXYyArNP/2AFlvmhKHKw4pVUHVWe1Nd1ecc
 JtcE13jkEZynuBLjcZUpPOjX7kSrtCCzxdEpOdBaJR67+pNqah0O5IcrKWdu8Ug5x1bh9QapJ
 CDYFZcay1f6zFj708v37qmiaVWKNynOMZl5LVbGBW7cvrlzWc1fqjTWYYnP3U0MHTWBOUoFeY
 4RuvTb65wUY0jkDz7nBe3Flt1Uw/8keNOvNzv+TiZ9eky4f7Rh2/rvkLnlkw+OZXG/GF8V6ay
 2HugApcyAbAgIktgVbVg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 9:15 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> Hello
>
> This patch serie fixes some minor problem found in the agp subsystem
> There are no change since v1 (posted two years ago)
> This is simply a repost for trying to get an answer (gentle ping 6 month
> ago got no answer also).

Looks all good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
