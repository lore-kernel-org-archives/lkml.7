Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40327C468BE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 21:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0998320840
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 21:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560116329;
	bh=t3QeBrzdU5Dl22idppOvDRuJ7Ru4IAwbC3pGmanHj+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r1nzNie9UgU7OLzwnl0mgsYGK+U7WviGNSfuuB3znQw2wR990gyOqgytHpc6DyQy5
	 kCcl7yKa4YiJfkg38+USgj0QcyVEN3M40e/yN7VWTOqISefUDmeF3iQCJI0Bsaorik
	 voojsfKvquVy8UldbE+WOMj7IUceCPM712QDounw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfFIVis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 17:38:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44469 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfFIVir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 17:38:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id e189so4901022oib.11;
        Sun, 09 Jun 2019 14:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bw/EkCR2TlK1nmZVU4ZTbtb5+JKQzKPuQmhGULnT2cA=;
        b=rr/eCpp4JEJXkIuwsyCnRKAN8qv6Wx3DYem62ealK3a+7kNNowuuCd95xeTmqCUQHL
         nB55cFCLiIGBttVtF4TW1FcKgF1Oum1BGY3dudscT7xzjJxJOkSkUOd2z1UO1boWzeUn
         HxQ1mGq+vKEepMUaryP081C+hpqUv6H6Vfr9+pxAY1JSROPNtpFFMS75WWAE1r0pRIZi
         +T99h/Fxyf1gQpeAOqg6RI4kWNyMGQ1TcTCg0zXv5xVKNIqp5WwEFuOFPPY+V21nh5Nc
         vrsYGH7Lltgkff2k1EbDQPtraT9QM64N8YOpPVCuRuShfO6UMwDO1V+fNYkGBYN+FevC
         RPHw==
X-Gm-Message-State: APjAAAU/RQxAc09GQa2u02z/FH4lVFhej8KY21XjGdXK2tUNag8wWQ5a
        +jBQD1KyNI14Eponrr9b51EnJFRov+QbFvPHHY0=
X-Google-Smtp-Source: APXvYqzc2Phm++Xv8yAEz1KCFci7W+jSRKe9ikWJXGEb7NExTarbKD0WJKEuH7H0h5ldcCINcZmdYzM94pBmvhQ/2DE=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr9811626oib.68.1560116326825;
 Sun, 09 Jun 2019 14:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560045490.git.mchehab+samsung@kernel.org> <e8cb6d826e691a34996b6812851461b6000442e8.1560045490.git.mchehab+samsung@kernel.org>
In-Reply-To: <e8cb6d826e691a34996b6812851461b6000442e8.1560045490.git.mchehab+samsung@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 9 Jun 2019 23:38:32 +0200
Message-ID: <CAJZ5v0jfObx72ZSKP+rrErkNTHH6Q1L5_gkHq1SRnHiAtYT1Og@mail.gmail.com>
Subject: Re: [PATCH v3 07/33] docs: cpu-freq: convert docs to ReST and rename
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

On Sun, Jun 9, 2019 at 4:30 AM Mauro Carvalho Chehab
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
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

I have said "no" to this already twice.

How many times do I still need to repeat that?

There already is some cpufreq documentation under admin-guide in the
.rst format and the rest is obsolete.  It is going to be replaced with
something new and more up to date.

The API docs need to go under driver-api and conversions like this
don't help.  Indeed, they are counter-prodictive in my view.

DIsappointed,
Rafael
