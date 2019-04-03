Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D23C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64B32075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wngj67Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDCN6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:58:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54028 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:58:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE3085A606;
        Wed,  3 Apr 2019 09:58:15 -0400 (EDT)
        (envelope-from nicolas.pitre@linaro.org)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=3jyHG9U6T9W2bkF6HS56FEP+arw=; b=wngj67
        Q/7oYsYvktcTP53qK0Ej/xH6tbVV+xZEWCpVr4dB7tygPJ0LKSMFYFwRj3OkHw55
        bc9W+AFVBHMBkvdnRR0OUIyuS7kZ7ee8c81bB5RbpLIN8AGelXBqM+iyTYd31j0Z
        0fhDuyc1pdN82SAhH8nzbi2KDF26T+QvojH5g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6CFF5A605;
        Wed,  3 Apr 2019 09:58:15 -0400 (EDT)
        (envelope-from nicolas.pitre@linaro.org)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC8CE5A602;
        Wed,  3 Apr 2019 09:58:11 -0400 (EDT)
        (envelope-from nicolas.pitre@linaro.org)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 8407F2DA017B;
        Wed,  3 Apr 2019 09:58:09 -0400 (EDT)
Date:   Wed, 3 Apr 2019 09:58:03 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] update my email address
In-Reply-To: <CAHk-=wiQq8UsV0cOTASUmsZyfm8E1BdfZFduxD0TZgOxXqXqqQ@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1904030954490.20244@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1904021315560.20244@knanqh.ubzr> <CAHk-=wiQq8UsV0cOTASUmsZyfm8E1BdfZFduxD0TZgOxXqXqqQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 84B5A88C-5618-11E9-BE81-D01F9763A999-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 2 Apr 2019, Linus Torvalds wrote:

> On Tue, Apr 2, 2019 at 7:18 AM Nicolas Pitre <nico@fluxnic.net> wrote:
> >
> > The @linaro version won't be valid much longer.
> 
> Generally I like seeing these come in from the old address just to verify.
> 
> But at least the old address is cc'd..

Fair enough. Here's a confirmation.

Nicolas

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpLvrAAoJEH9KYoIL9GO3NlwH/iSnLw3VgKBJBTCbiOmgZTMu
+X5Pebwe9TlVJxqnFBMnszJT4GJTrg5oA4m1hAh8vxoQnwQ/HIYJs1ioAlGLl9wi
KQ2AsMiokO5LXLz2L0YjD5/5YY5G5c6o8qP9cVt6e3ep6jOJej0QSY1rc0FYu2sf
QOTal+HswoaEb8Nu/nir3aNaKJhBK7rf+t7KpvbfHXjH72C5VHe9ECCgsPOSgm3Z
d/jalyarPk237xDQ0la/hiXunnen/3yQrZ12ILQs5g426CAhykK5L9gIPoSnFT90
uIP1Wpe0pCy3v3UoF9etZmQD3uavLm5lEC0RzSESSaUAprV2pK/3uMebyQnrN3M=
=xJL1
-----END PGP SIGNATURE-----
