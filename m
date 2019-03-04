Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9227B206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfCDX6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:58:34 -0500
Received: from anholt.net ([50.246.234.109]:56850 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCDX6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:58:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9F85010A2DEE;
        Mon,  4 Mar 2019 15:58:33 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zj-Pw2x8csgH; Mon,  4 Mar 2019 15:58:32 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 54D2F10A2DD8;
        Mon,  4 Mar 2019 15:58:32 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id BDF4C2FE464E; Mon,  4 Mar 2019 15:58:31 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Phil Elwell <phil@raspberrypi.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Elwell <phil@raspberrypi.org>, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
In-Reply-To: <1548755757-79270-1-git-send-email-phil@raspberrypi.org>
References: <1548755757-79270-1-git-send-email-phil@raspberrypi.org>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 04 Mar 2019 15:58:31 -0800
Message-ID: <8736o2qjiw.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Phil Elwell <phil@raspberrypi.org> writes:

> "cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
> dereference in bcm2835_thermal_debugfs. The driver makes use of the
> implementation details of the thermal framework to retrieve a pointer
> to its private data from a struct thermal_zone_device, and gets it
> wrong - leading to the crash. Instead, store its private data as the
> drvdata and retrieve the thermal_zone_device pointer from it.
>
> Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 So=
C")
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Acked-by: Eric Anholt <eric@anholt.net>

From=20the thread that missed Ccing the maintainers there was also:

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlx9u6cACgkQtdYpNtH8
nuhpSQ//feRJqNfXmXK1TTSvE4FlARA8oPQVS+whGt9s9uTUiFn9jKwfstx2krTr
vEeod0LslKwR6bzPDkdti93SOf7WtGCIYl6olQtfkSMW7JxFPCwpTsZMqWxxde4L
29iiTJiKWsraGTiSQeudfJfARCi69+s0PdVIIQxeoENwOCOXoARcotFvIJNMp+i/
JH5iJLgch5lADC1naf4mz21WQnY6OsfiIgt+tLe0xHzfdLINhSLaQFHQneSvjZE/
EW0zwZ6ZNMa93IUN3lGXDFx5c/9q9CCdC+Gv4bY9oUxu06rOydPwrC5ZXF9VQtap
4uAO9OzQaDitWZNZKhEBlr2fJsFrg1xIRDam/0sTosGiX+V65ZiO6KLCcXR8qbng
UuQQnsFCuudL4BioiGNWB+dUZ1UuWOw6SYTfbVwc+bmYZ2E5G+BuObBkQM3nYcVX
aY6SKJabbIVZGJQ+0s+zIYm+3qG00u1WFWJcvTUTTaBn3q0DN3O873QZHWMNzKQE
VOmCiRobHCq/SQ0oMWBkqHG5isdsrsXJ1X7vIxS3u80ttM7Qupah2x6raneE+A8M
GES7uBtz67L4m6juya5GCdglR75vch9J0XwAVgbmh5Uf/KiINy56RYRn1pzgWHw+
Rb3nB02b4u5NUIxBfmS5Qo50Hu644kQXKX/x3Dl8QMUf3XoWJ20=
=BorT
-----END PGP SIGNATURE-----
--=-=-=--
