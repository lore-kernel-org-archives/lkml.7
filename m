Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5728C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88012215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jI2pwhg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfJDXYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:24:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:58381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDXYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570231410;
        bh=3s1K02Ujs66hvh7m223OoSF8WBIZ0s8zzY6Gf7EbaQc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jI2pwhg9xOSJg0JAK6pFONtC9FnaWxUS0Ga4392U/JMajmtIaHD7b67X9x7o69poc
         pcNWEauJfy734UAc9pyQcaAqE32gGRAYtAXYYijrkYK4FWzLJWNi57p7VT8OzUtK7Y
         UwLW56LC+i2NFKYfWXz9A94EjkatZI3eduQyvIwI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3se8-1i7Yhu0i4u-00zmkJ; Sat, 05
 Oct 2019 01:23:30 +0200
Date:   Sat, 5 Oct 2019 01:23:28 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Describe variadic macro argument in a
 Sphinx-compatible way
Message-ID: <20191004232328.GC19803@latitude>
References: <20191004215402.28008-1-j.neuschaefer@gmx.net>
 <20191004222439.GR2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <20191004222439.GR2689@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:xVulzbtSL9VmS9osTL6hIUJ/FH6lZvhKfNGtnR05iOw8io6Gu0g
 oxBpgf9E8iZ8aiHD/6A5E8ZxdTkq19ulfTYqGi47QN0gLFbUH7IxDfpsCO2lL6Ra6kcfUND
 p/PlIL0zOOZhUlxwTRmlMqkjGMN6JoER/VB/RmOB7C0tI/wFApdc6pyR8MXUmRHa1iSud4d
 apJRgQVrJfyeAEfMcJATg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gFJqLkUlquE=:RWuqhM7STd6mqdV+f4JeI7
 9UhLTgMq4eW5fZHuYg4uplhUl9FHswKUi/x86W7tqCEoHYSXIJCh6+i4vNLOmGqXjG3Fc9UEt
 fM5iIJAHQPnSVdhF2A6+AyRLdS+5/6W2GratNXR8DQC0TKiqUHteCLJIKg0jldMGDepHCQ09Y
 /yBb10/GLiRfK2zhStqWX+LoLTnk6FZ94TvrLwvq1lc3aNbAovy+y8ZAGeR6XBCtExlwupawR
 LCwcEDS7ypc3YwZMpp9gwazmI3vqtLWYOjBkHCrY0rBb4F2nKWBocEJK9srZ0J6T4dpXexrya
 7Z/c/0j+FGFwny8vTP0W5RroeCWhzMyaIJujco3ez0zU0c6g8wMQvcYuZZ4iB0nScv3cCIMpb
 MuLmZZNUsf8V1WZugqK/prr1J4C+r/G3TXzczioSrJfk19j84Jki9e40PoBYt+UhwCNNyz4Pf
 8WKLbee0Lb7cZJ/7HCQjiviKX3Wz9F9E56fNwWwvMnmmABhPCvGqM1tM0CcHYol/Ogmk1/UF0
 5b4O/ZHwOTOg21pjNyhMqPwUeRiV9naBT0Pjuh6Ugq77Kq1FialhaFJQqXHN/vWeFjcUVS67n
 C89u0c4zc87lDvtIsPwHbZgzAbHkO7vD5WE+w8qeW+rfVFmGb0mNjpsxGq6feSGBA0nKeyJGa
 kdx7N2aUqnE4v5ny3m9Wk2wU7zisfhUrpkoD6rbSYy9bHhsdCEehliSxSnwk5BMGWSNSPsQkv
 EYyM34VpgNv/3vEnD075IBR7QPmLrJ2vlc3X6NSjDSG9wP8/ohtNmpvzbhLk1YG1eVlIWD/Jo
 JhWvDooxh/o4g2Iw9jDQ0I6FYJqyxTNMf2pN3nyCLakn/XmvjxjAl80M5CU/YKhWFGHDmU6DB
 TkSIID8t2NA2lwpLCHZJAnpegC0Hm1V2iEgUxTaq/A5r6L/0y0a17lQ1hy9ZCGpabtlGM/Yig
 Kang6ThkwKPTq68IE5K3Y1sOCd1n2jWLXCXHXrj8y/4FYfY8F2DXauY7Cb3tT8N3PFghA1uD8
 tgyCt/JIrrLWUzOFQrTcmqLWtqGfydnAeKcDch84EAXvdUGdqkaLRShJcY3gQx88yihkNeVVG
 Te6sMcyjh8TmEy6ZaDtMoHsH3WDtjsdq5PSPnS4rPxF7kl659/GcglDNYqt+1ZDvC4akqv7BO
 qCBAdXPaH3iy/MWQbtRkt87S3nx0hPNB4AzK87aCFlWpxFGRumVgJ4ZG1CfBVJ4b2Szpkw368
 Zb/AVuOLR6+7MiiiK6wwozv9aEpfodiVJXK0BnnCtR/iJlcfoCYM0aw+PqfE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 03:24:39PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 04, 2019 at 11:54:02PM +0200, Jonathan Neusch=C3=A4fer wrote:
> > Without this patch, Sphinx shows "variable arguments" as the description
> > of the cond argument, rather than the intended description, and prints
> > the following warnings:
> >=20
> > ./include/linux/rculist.h:374: warning: Excess function parameter 'cond=
' description in 'list_for_each_entry_rcu'
> > ./include/linux/rculist.h:651: warning: Excess function parameter 'cond=
' description in 'hlist_for_each_entry_rcu'

Hmm, small detail that I didn't realize before: It's actually the
kernel-doc script, not Sphinx, that can't deal with variadic macro
arguments and thus requires this patch.

So it may also be possible to fix the script instead. (I have not
looked into how much work that would be.)


Thanks,
Jonathan Neusch=C3=A4fer

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl2X1GgACgkQCDBEmo7z
X9s0lxAAhbmET4fTZ9qZJYbUJMFK904D5myAIXWjznns59vjlShN+zO/T0h1q89U
UFTks5xYqACo5fCEDNTrNwrl4H67gW8Pi4qF8nx/tlxN06OIhidWjptnMEvgO0BS
c9eileN8Oi2Lz87Rqlc6WLFdEYQPDyG+opLxL/F3kVOpv71a8ynSiml2tnSPfwUD
QaFYeUC6bz2SE6piL1k0Bg3YY5GJznFLtWZWOLtgmn8LIxJj8UOjTCIZfiQq++0a
5Gi5gr+A82rTwhHRy7iquICJNmbpBA4K4a/hFDj7YfRahnSy+/18KQjSZYONs8ll
Urxgty8nfWili/6cRAdEQsyQGXfoqDMY0FEfPScx0GfHE9VTyNQHvCixYe81dXAf
q9naIP3VtuiZ06wZUDqgx4jyC+Rvlxo2kqTwzhz793JWLarQnlGfYibHpBse00F7
RahsWvN7AwCfpgEPuiC3bJzjTZYr81l/3Tnj2Qmk9xGKSVzA8oNHSfJ45CVUk51c
R3PAHir8H+lCAPOltkngj9ArRX6s9O9NAhYF5tsyOmwvXz0UsUB71DcdE7ZKJ6GZ
5hb95j1T92R0CVaTl4+h06ZxX+7+GP8lObsvWUlsG/1rrPjTAJ4FxbnPlNKx8a/G
Z/zI9PIKK8hlhEyWMq870PcZIIsyeX4uSbdkUFtaOFt7biPUn8w=
=LuOm
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
