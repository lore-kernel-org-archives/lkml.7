Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8747C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FDB2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfCGOow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:44:52 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42646 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:44:51 -0500
Received: by mail-vs1-f67.google.com with SMTP id c189so4601070vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kP7kmuTcNICvPfv0gI8Uwu1XmBbtKnhB5CMdbpEhqnA=;
        b=qN0JSddORkIKWj3OOK7QyraqTqmxVOXVjqm32yftRWqZM2MI3JAHEfnggKD9B+kDT9
         xFnhRWB8Gaf/+PX+48UtC1RR9h2Ztk9V15m2VhxEtVyahFjiC9zCxSZgtdrEA3QvGOnw
         SsqVybC1LBmZ5y5W5+NCn18ZhbIg+1W/CDm8E8mVT5cFl13LU8tuOoDQTTp1ZfQESXx/
         IPO0pnV/gjg8bzGUDIH9YkBTc8t+e7aqZUMsqmHbfLytertKhhDw3o9cpbpRpgPeKRux
         JI2IqGdP1oM6Z4LcqZ0vsu4uBxMCVzwGkZVKN/l/H23rRUVAwvwLom3oI6UemZaIOP6/
         asoA==
X-Gm-Message-State: APjAAAU5I9r2Cu7DizZ+GGS0elXQtfJ6Ii8q9gbTL2e81A/3f9sXjRPe
        dglteyzbPqBlTV9bQsV9bXT7bcEXiTSFqrSXpG+Qq9AYYJM=
X-Google-Smtp-Source: APXvYqxIpxIVTK6l/qWqQimcWL08Z33xbKMuHpeMprzpz5l6jpobj6AsSUuEMwlTjcuVg+CqkpGXnJXmCW2q6i3sRto=
X-Received: by 2002:a67:fc13:: with SMTP id o19mr7316986vsq.123.1551969890375;
 Thu, 07 Mar 2019 06:44:50 -0800 (PST)
MIME-Version: 1.0
References: <1551921213-813-1-git-send-email-jsavitz@redhat.com>
In-Reply-To: <1551921213-813-1-git-send-email-jsavitz@redhat.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Thu, 7 Mar 2019 09:44:39 -0500
Message-ID: <CAL1p7m71U4pcbuBTqQ3qMoa4Y2tYJPQ52qQraSBHLu-SrzzYwA@mail.gmail.com>
Subject: Re: [PATCH] sched: fix spelling of active in comment on is_cpu_allowed()
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, trivial@kernel.org,
        Philip Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Best,
Joel Savitz


On Wed, Mar 6, 2019 at 8:13 PM Joel Savitz <jsavitz@redhat.com> wrote:
>
> trivial fix of documentation typo
>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ead464a..2e2e19b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -920,7 +920,7 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
>  }
>
>  /*
> - * Per-CPU kthreads are allowed to run on !actie && online CPUs, see
> + * Per-CPU kthreads are allowed to run on !active && online CPUs, see
>   * __set_cpus_allowed_ptr() and select_fallback_rq().
>   */
>  static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
> --
> 1.8.3.1
>
