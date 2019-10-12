Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DD3C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 10:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6432089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 10:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gB9RKGd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfJLK5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 06:57:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:49593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfJLK5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 06:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570877848;
        bh=vBB10BE9403hAvmcNQMwxU1XPTEAQgdMIr6WWEgfJo8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gB9RKGd6IosHf1HbMIDSdsqgcsTCZruKdaMJYk5GTqL9p5AehAstEXxcePwlurXmQ
         Y6eo7u6c839YRiCG8xuUWflMrcsRJgxSaB8kV64gdUTVRSyN+f5cgm1ZxjDL5OolyI
         8PsRBXpxcPNxfNrSxVvNlexMomY5eHIUuUPuNUFo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1iMYTM0MJQ-003Kf3; Sat, 12
 Oct 2019 12:57:28 +0200
Subject: Re: [PATCH] mailmap: Add Simon Arlott (replacement for expired email
 address)
To:     Simon Arlott <simon@octiron.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     trivial@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
References: <ab8c62db-b207-9aa1-e99c-16f9eb4152df@simon.arlott.org.uk>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <939abb19-e02c-bfe6-deb5-57c72569dbb3@gmx.net>
Date:   Sat, 12 Oct 2019 12:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ab8c62db-b207-9aa1-e99c-16f9eb4152df@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:2v73v2zjEvQWzL+Z5hlCtbfVOjDl80r57EaKRWYG79ekP3os+qq
 4o1mMiwOvtxNhOhRBND6oR0KenT83x5XNIIaBk9tkChjmIX5pZxiD4DG409cJ4ZFCCkFeIg
 TdGMMDYkaDvT4bcH6zCzPhi0yHMzX8QeOH4sa5wlXb49T8++xURnO2T05AeDwsRSbKq1EqX
 jq8fT42KdKSm+pWR1vXPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v7qs8VYykWo=:Odq16Fk0o+r+oLjNaJ8Wmo
 NnjxG2sp/VcDqC/KaAPHzEZ3E55/F+R2vLfPoBMZ+FfuwoyRgDGjIRbOidi+TCDmBovy8RB60
 3t8p5xmRUvv7KeJcyPBwwnm3qt5W7CCi9LUBjQxXiiTOpmhw7D6f8s6AXqbzsg2gh/YSX8Vkl
 0npOThOnMG3lEST3NyFfhMiXHvqfww2aVCSNhQNXUdRkI4gutI7Ao7Utr6NjygysI6eqUbW6s
 OMKcTsupb3oKfe4yisfJFJUFuGkoT1X08W1uVdmMqlVbBVzV0eeaOfqrkbh1J1oWr59U1PuFj
 9LvdYfR9ODFx6MvgzQv9N3uNxDCiNeVDQLNnmX0mwpuk7TeDbMUNHVzrEg/jaKZvf+LJ0NAKj
 wYalEPrb3NQbgVpogo0ATu+cLnK6YYQqheYyRVt5MOdEBu3FzKfqx2fGeRulAgBZDTT4CQzr1
 hjYl0c9ysNbcZ+YMUtUn0yD/oZUKaGo7ZKPtAL/lV4SbhWKsH4V2hIi9KNJ9ZxGzlobFQvORq
 iuYVbEPg9Aw1QAlv8OrfMxzTmL2xbO1OcG+A5h16BI0QVT2x0P9qJaUtE7RAHM7/PPClSK/4x
 amYvjiN693tzy9iKTAmHc8aaQrDs9dAGJinV000wU+re9dt+QVsG5wngUw4C8jlV+GCEz1zE4
 wuucHe68LZQ4aGP7ALC+2DGQuxUWvmdBZi+a7YZK+6EHemzrgik2EFlXSmHsAse7+qNFYVuDi
 BfTiERZcsUu5a9c+DIUYTnkqyTWb7KDJYy/d2uX5khLMx1IYSwcwRAxfhMUQmD2imoYsgF2Vs
 q9gHwaltgrS/c7cBGsfcjX28sir6ou0ZkatITE3Rar/xSq8WcHcdHuVncg45LAoxUedv0p03b
 YCqhHd7t3biYHBvqBelAuQV3AJKVSd4THnMFQP50Eon9EedVfLiLTn64o2TIETgeNoYWM6A6e
 0POYl9EALVC/oUuRXBv6APPAZEebYIAPUaZIfRLHYPb2gl/YI6izsRsfgH+3+nJOUsbNh7+6t
 Z5yucUIh36qfjhEO+SzGXULT7wXhDS0k6X65uOfXXx7GbMAKmsKg8x2ESM8KTaD8dTSNO3zGD
 01fPuZ15qz/+0mZ0vDvKSJllYA633SziIYhQHyhVmZI/y2v7O/VfgsfpuyOC2eFOBkgfK1LyT
 fCelG0hcovpQ6X06XZDhZBxiRjiKdwiGMGwTm/BXb9BtM5WhHclJWq4U5Oq8/4HBU+7T4h81f
 ++QdfYe9jOCNlMbLegN/6V0W1D7DRFgGhyjm7cSLd2upcxrm05OpiDvgo+2E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.08.19 um 21:01 schrieb Simon Arlott:
> Add replacement email address for the one on my expired domain.
>
> Signed-off-by: Simon Arlott <simon@octiron.net>
> ---
Applied to bcm2835-maintainers-next
