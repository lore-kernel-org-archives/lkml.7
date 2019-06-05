Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B1CC28CC3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D25206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFEAA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 20:00:56 -0400
Received: from anholt.net ([50.246.234.109]:50568 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfFEAA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 20:00:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3FE4110A2DB7;
        Tue,  4 Jun 2019 17:00:55 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id J5PPjNu5RML4; Tue,  4 Jun 2019 17:00:54 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0254810A1128;
        Tue,  4 Jun 2019 17:00:53 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 728A22FE3AAE; Tue,  4 Jun 2019 17:00:53 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] clk: bcm2835: register Raspberry Pi's firmware clk device
In-Reply-To: <20190604173223.4229-4-nsaenzjulienne@suse.de>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de> <20190604173223.4229-4-nsaenzjulienne@suse.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Tue, 04 Jun 2019 17:00:51 -0700
Message-ID: <87muiwzyrw.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:

> Registers clk-raspberrypi as a platform device as part of the driver's
> probe sequence.

Similar to how we have VCHI register platform devices for the services
VCHI provides, shouldn't we have the firmware driver register the device
for clk_raspberrypi?  Or put the clk provider in the fw driver instead
of a separate driver (no opinion on my part).

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlz3BjMACgkQtdYpNtH8
nugXZxAApCxDEcQNUZSA82dd4rtrlp/1uMz/j6cXVe9KKGi7a52dfc8MEIvoZDbq
PAN/yjpvQVJosHh+JOUmXzKOEd9seFx9/gZwzdb3/8VKNnkYAy0ugfAzAN6K1XFW
eAV1rSbBAkAtrvL/FUK1WxMN+4yf/yMcY9ZVmKSML2A9KcwkQHpNISOidbfdMy5c
NkqMl9lTD3XoE+VZgUUsLg440KidEOO5kKix7VhP5zQiQ9OG2RInZvhUthTz0qRS
9j+4XCyC7IPe8QpejvK9eocR0CW7sVbEaujUsScR1xSFLWGI11fPgCjnGDzBxzkN
jzofDEUVgfM8hzX+sIJ/DXI7WNNf01H51c8h0H7fxII2U3nNw5WgsQvU8BdoyRS5
WZdWPUAwFMkdlZNqRL7WdJL15in11f5lfiSZjT+Hxp95y77Jf/esA5Wfg3N5KD5I
MWfTvdku3c6IBNi7Iy+l1knz+FjyoV1wYgYtYrzjrZtrGsIssySU+ZrzIrECo/8s
k8B5kM2CHq5GM1d82sqj1haF0IsfChjQQVfIzkKja/FHmpC1IJBAnYjGUas7L+Z8
LVbsHuYZX+yH6k5cMe6f7cljlmeyjaHLDerVVnqlKO7ByYFgbGZUMP8acuBIIrzd
LyNFmfuctdyaiwCnR/0wEmMAWlzn+HvxM7G31vBGo4ihTnlPaS0=
=dVrD
-----END PGP SIGNATURE-----
--=-=-=--
