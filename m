Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12853C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB22720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfCDU1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:27:14 -0500
Received: from anholt.net ([50.246.234.109]:55800 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfCDU1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:27:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 475FE10A2DE9;
        Mon,  4 Mar 2019 12:27:13 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id A90-3hZxxNtb; Mon,  4 Mar 2019 12:27:12 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1A67010A2A62;
        Mon,  4 Mar 2019 12:27:12 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id ACB862FE464E; Mon,  4 Mar 2019 12:27:11 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefan.wahren@i2se.com, linus.walleij@linaro.org, lkundrak@v3.sk,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: Re: rpi-b-rev2 can't detect hdmi display due to wrong hpd gpio pull in dts
In-Reply-To: <20190304185454.18043-1-helen.koike@collabora.com>
References: <20190304185454.18043-1-helen.koike@collabora.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 04 Mar 2019 12:27:11 -0800
Message-ID: <8736o2tmg0.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Helen Koike <helen.koike@collabora.com> writes:

> Hello,
>
> I have a rpi-b-rev2 (two holes, 512M) and when I was trying to test vc4
> driver, the HDMI wans't being detected.
>
> So I changed the hpd-gpios from ACTIVE_LOW to ACTIVE_HIGH and now it
> works correctly. I can see that modeprint from libdrm detects correctly
> when the display is plugged and when it is unpluggled.
>
> So I was wondering if this is just in my board or if there is an error
> in the dts (which I think it's unlikely).
>
> In any case I am dropping this email here in case anyone else see this
> problem, if you do, try appliying the patch below.

We even have the GPIO labeled as "HDMI_HPD_P" above, and dt-blob.dts
agrees.

Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks!  If Stefan doesn't pick this up shortly, I can.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlx9ih8ACgkQtdYpNtH8
nujmcQ/9FyjSFutNqSUwPu6FcG3JvOTwy5TN/k7iiobKCX+G8a3Hn8EHdu0gXLI2
oYQE3W166zJmGtjultlooZpxSe6ggPmpqNaaY+xQ3QkCZCBackFJIqLUy+7wNBzW
Mm1RhyO039pDhWJ25NLcq8aC9atryhjzzOpNMfKTSaTDCU85iq3Krm/5QimiOsKK
goTctyMjhjjkLA8DUFB0CjWsPq15OV2cTCb0kRDIiLfR1TZWKeAyATzHiqSofMc2
H5yUO6CsXLIgYGcwhhp+BnveCm2h9JFs6plwsEQ/fB3eHy/g/R+4B7oa415AwT50
Zqbv02fxBhZWsNhLzbLj684Ry45jHkJzlSQy0a1oxca9ZJowNAMhmAtQ2a0V2AcP
X2TJHgIWv+rnmBD5BYpYOZxIVY0D+WPtjaqfZmnjz7okoqeuIzeoL2u5AENQ05Uy
PPeVYGxTDUERPZbX81QNArt9P0dThKfNf568yi2q+TIpOy4yLgW9kTXwViWgt033
pGTtNtcO9uGKUZ8FZEblu0HxfLp6Cos0m3AmQho266y0UPgTK24ytSwAaQ5DzOUN
OWOTqdz/cu9KbP1rwRwu9zewL862TNPyOsVXhgugEKQ8knBTNE267QmaEK3OuXzu
rwO1edLLxfHQacNg2rc6qNPURt/emIybA67DLlZbIfp9POKxN5E=
=T86b
-----END PGP SIGNATURE-----
--=-=-=--
