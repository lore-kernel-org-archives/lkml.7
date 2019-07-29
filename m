Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149CCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB65D206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbfG2L1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:27:16 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:42744 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387638AbfG2L1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:27:16 -0400
Received: by mail-lj1-f175.google.com with SMTP id t28so58209736lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 04:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhSMztl9vtcPHrtCcvMgqxG7WnfxjbwUrZSM++0kKfk=;
        b=OJl29BZHKS0WhGpPMg3wEVXl+sAlwDF0jrgBoeQaujlWxk0BNfDWAku1xJ48eVmy7O
         HrkbmtvWj/nlJPTbi//+iqVO8kGbmMccnGo4zwwsMSDJci54kWV6O7fGVNea5DQu97py
         ezAtqthVXt0Iz0G5dPgDdyyOu4o7CV2/TliXevZp6+TDzU6QIDirigfWQxfHxnFyp8l9
         9RXC97C+y0u0Ahvoy+Lmivn4rjmvCbuSVDXrQIGx05XdOE1x/yfQTcoR+7I26a9F+nuS
         dKj7T+Q9oeetkXvVJqK6SOFPK6LWP3SpeLenARb9WasC+hCQEGa3qHY86oE9WHp16SFE
         Ro/w==
X-Gm-Message-State: APjAAAVIVjkFzB+8ZChL8lsiEspBeE4G4Hfiga/CcO/BqA9IswVBzXyM
        hY3qZKla0R5sBLj8cUvSG+paJ/SZn2GDsjPLs7Uptw==
X-Google-Smtp-Source: APXvYqwmGzre91C1xV6WEc9bvK8y6PD3NAo1Y9stcZDW0EJEmZA86HhxhvVEUcD8QyRTdmFfYCdQ0561v6Et3EZw+5Y=
X-Received: by 2002:a2e:9643:: with SMTP id z3mr58628311ljh.43.1564399634664;
 Mon, 29 Jul 2019 04:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
 <20190729095047.k45isr7etq3xkyvr@willie-the-truck> <1cfad84e-5a98-99bd-07c2-9db0cf37292b@arm.com>
 <CAGnkfhxXHPfMZVMy4Wjmy39E3Oh2U8FjVU8p8PprCnj5QFLMEg@mail.gmail.com>
 <cc6f9c8f-a4a1-7c71-1f89-72e1e8dd0cc8@arm.com> <CAGnkfhx6St+MYQuR_Duguk4Q9ieuL7sLCTL=G76-eqUcCAbpoA@mail.gmail.com>
 <c8581164-168d-a4a0-46de-4bdd7f7dedbf@arm.com>
In-Reply-To: <c8581164-168d-a4a0-46de-4bdd7f7dedbf@arm.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 29 Jul 2019 13:26:38 +0200
Message-ID: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
Subject: Re: build error
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 1:18 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> Last but not least, are you on any irc channel? Might help speeding up the
> debugging if we talk there.
>

Sure, I'm matteo on FreeNode, #armlinux

-- 
Matteo Croce
per aspera ad upstream
