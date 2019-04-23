Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9762C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7934A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556007735;
	bh=F5bhvNKnwY8XiNKvCtKPn1M5V3lg2qUO5KUutmLrkY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PdKHeJCFYHCHuA2c5U+uQaFWwJmD+YP2+YcJ5JsNVM3+JgULzjUm5vmvL+X6YE7OQ
	 bJWdpZu9YaWqpMxfTKg8f5+aGz1fPRDu+CqTL8aDlVxvnt3N1MoIxUubkyr5IJ/9xR
	 +aaMhlGTYagCfkvKALvsyWIR9ix+O9McKDYYqC+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfDWIWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:22:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42460 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWIWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:22:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id f23so2894057otl.9;
        Tue, 23 Apr 2019 01:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZN3K22+KCH5eguILL1VGvwfyXMHOhQ1rRvqt9oWkJA=;
        b=iWgxm4qB36/GSDNYu5AEl1z4uAmus3bu+TzkPY4wnT3GoXTejlx9sRBMsSjc9MById
         E5dX3J/RPMP+R77gpXdGmGsJ2gJY5uFS9qlKe3vvnenhpJeCp2p1F5IhQVlPm1k5AJP+
         HynYF5kmRU7PQq9SDbcI5b04GVof+1UoV9fW7MBaOa8XZTUg7Grh+q8H13hHP5O1Efha
         ThvTAyzOCSRaxunfWL/yAjGrzyPHojPDw9JriXDJQWrdR5jpWOMRzlr/uZ3UVz/4lIGi
         5ShZjLfLQBqSTMrbJSnAptovDVydLUoifZrHnBBV73cgioK+l+ihF+GR65HaQy/ktZYy
         PcGw==
X-Gm-Message-State: APjAAAWY0+suFlD9ZdIZZ9YRYjJZODGETPkrNneTflFKV8HkCcfbtHVK
        0Fg619WA5ayzD255UOioBok+X+FIaB22cs1kS2w=
X-Google-Smtp-Source: APXvYqy3RBGDzq9UdYEtqJdqqVXwr8vL9We+kp9vM0Vu61Wl0geMa46n/aaexSFfBxUwiFVF/RVMbgkuIUYtDIYnrSM=
X-Received: by 2002:a9d:6209:: with SMTP id g9mr1778471otj.186.1556007733123;
 Tue, 23 Apr 2019 01:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555938375.git.mchehab+samsung@kernel.org> <90ab7c100b7fb0120689ebeda5d13447b2cb2af8.1555938375.git.mchehab+samsung@kernel.org>
In-Reply-To: <90ab7c100b7fb0120689ebeda5d13447b2cb2af8.1555938375.git.mchehab+samsung@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Apr 2019 10:21:59 +0200
Message-ID: <CAJZ5v0it3JfAZu8=4_m996JGjSRC6DLfRNYd6KrszB10-U2Fig@mail.gmail.com>
Subject: Re: [PATCH v2 10/79] docs: cpu-freq: convert docs to ReST and rename
 to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 3:36 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.

Well, as stated before, please drop this one too.

There is a plan to convert the remaining cpufreq documentation into
.rst (and which has already been done for the admin-guide part) and
the resulting files should go into driver-api.

Thanks,
Rafael
