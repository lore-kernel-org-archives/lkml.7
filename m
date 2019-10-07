Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD48C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F92721721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfJGM0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:26:50 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51033 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfJGM0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:26:50 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46n08l3xQ0z1rq9f;
        Mon,  7 Oct 2019 14:26:46 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46n08k4GvNz1qqkD;
        Mon,  7 Oct 2019 14:26:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 47XwvLKpqE62; Mon,  7 Oct 2019 14:26:45 +0200 (CEST)
X-Auth-Info: cD3j9aIzZUlDBgxTvSwSbAIdVJOwsY+ug/pwuv90CS75160VaJxS4cJubNNwWIcj
Received: from igel.home (ppp-46-244-165-160.dynamic.mnet-online.de [46.244.165.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  7 Oct 2019 14:26:45 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 30F342C0181; Mon,  7 Oct 2019 14:26:45 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dmitry Goldin <dgoldin@protonmail.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel\@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v2] kheaders: making headers archive reproducible
References: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
        <874l0k3hd0.fsf@igel.home> <20191007115217.GA835482@kroah.com>
X-Yow:  FUN is never having to say you're SUSHI!!
Date:   Mon, 07 Oct 2019 14:26:45 +0200
In-Reply-To: <20191007115217.GA835482@kroah.com> (Greg KH's message of "Mon, 7
        Oct 2019 13:52:17 +0200")
Message-ID: <87zhic212y.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 07 2019, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Oct 07, 2019 at 01:49:47PM +0200, Andreas Schwab wrote:
>>   GEN     kernel/kheaders_data.tar.xz
>> tar: unrecognized option '--sort=name'
>> Try `tar --help' or `tar --usage' for more information.
>> make[2]: *** [kernel/kheaders_data.tar.xz] Error 64
>> make[1]: *** [kernel] Error 2
>> make: *** [sub-make] Error 2
>> $ tar --version
>> tar (GNU tar) 1.26
>> Copyright (C) 2011 Free Software Foundation, Inc.
>
> Wow that's an old version of tar.  2011?  What happens if you use a more
> modern one?

That's the most modern I have available on that machine.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
