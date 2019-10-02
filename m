Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583CDC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCE121A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E+ZgbF9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfJBPSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:18:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:59769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfJBPSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570029527;
        bh=Q+Tqcdu9N7Z5yZZRF6Mnkj+8SefS7EApumhjQV8PNRw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=E+ZgbF9dXkPh/j4RAiClbMGx/Av9WdTohUh1D8zhrBb7Qw+IdU6Ctwa3pYOblZ2Qv
         fZiLwcojsfU0l+DjD3byxaPoQgqjxxnbOnuJBPdoIjU1QXhKrtfS6Uf5savYVotHyx
         JNclS0B1+ndciPSoRi0UxreiuhzCh9QS78tuTFms=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMyZ-1iTCuE2N05-00MHxZ; Wed, 02
 Oct 2019 17:18:47 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: it_IT: maintainer-pgp-guide: Fix reference to "Nitrokey Pro 2"
Date:   Wed,  2 Oct 2019 17:18:39 +0200
Message-Id: <20191002151841.18476-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pbx6rcg2uyE/35W47UjXQlTJQ9kup/DIfSihVa/r9xT3mDqCq06
 nrkUAuKASfuNbNTlokm+wxRdmHqvYBIgKMTNm9+IfI1aq5Kv/ljfoXtp+cl8aFXYgWjcd7b
 l0tqmf03n5Sm3371wF7IBTYTD+qBLf0eYL7cJWXOD5fcQf8KFvRU0fc6QXv5OAod+AroQDx
 62+P8X+hZpokXUgntJGhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x5oklVP5wDs=:soA6vj6h+XpElIqb1DHz2Z
 06gG+DgzTBA74Q35ysz1IkB3U6KogSY1gzlY1xAnA4y8QsSGmiSwNXBw5hwvPmeXYDOkWmeeP
 7RQ0X/fZ8euFBXEVCozfv/gWlFjDCmChtbN5WueUw5yIPxvbHxb0pWXhHeP6ZEryD35Li3q/l
 Tlc9qwNWcVeOeZvDh0zTvw6hSi4a5lIuTOS7i4XiAPYXv7iqvukTcikg5a8Yb5n1cSYXMQ20H
 e9pGaDXFoXVRQKzTY5MErrcvgWEBckSfD3MklB++23Bq/xGP9MLG7EMCPNZfnbUY91UpOA+jU
 tWYn5rqzcr7l5ypHCHieTvsS7GmmojgY6L3LeZCIE/ORAtSlpyuziW0hY/sbMwTdThm7XuilA
 r7zTGp0EmjpFbFEgGpaTwAvppR2omjsy1O5mXj8lYtV3jWHPA47kVMWqKpD1E5n4o2GWPt+Fk
 OhIbBEU24Z6rWx96a29+Htp8oZdPiLmRUm1HqdVflKg5Ry7SLtOBpEgg5p4BQ5aRPxmAUydf6
 9jW7OGmaGHngh4sA+k6QaR9KgCOTx82TNIvaNFNPc3KuNdR/aog7OG+PqOEqPACTm5AZRrW1E
 JVx/4eModvqaY1dQLS7zCsf0xtQMJ0QywRduU2M/6/9SUCMoMC3AvCMq9PpF0v34wcnOkPcVt
 muONlPRm22vlXYsbAuxKYAp8wau5UfkYq1RcsIFGnfeO8IvEmpbFT0Pd2G0eKIaDBMyQNRhBA
 +rkmzoQcUUR5uDUNZIg+aMi1lo0SkYhtY1acH1gc3JNd/UCjEIWysfzH6IAQ+9iwQqsqoaUOy
 7hg04Nmt7EjXPrXKyOybEFdz7w+TLgZUs86N9y25N4ggFKWohsYAQBadJqDT7GTIU7+a2Wiv0
 5waPkkcBuXoVP98flDHbXCAvbf6XjJl0vIr4/GhbdDOBgdCxHZtY5wgdMI+Ygqo7vQrfEPGkQ
 FWqMS3Ei5eKStFfIFfu+NlIm62ELhMD0Wg7RO6+sbDwEvfG9OQysBpYh8Y11aBAnTc2cq0ao/
 gODJBkCzIPDskQbLB/INyTpgNZPYZRfQMaT0IUQDwKdAYHkwES79okiQDkvugVfXeZtWOTPaz
 PVcA7ZKnhrowU02j7QWStkqq8RxKc0vACHKmrNneHzKUhgiqPc5Dl5HJpYm+ooIXjsRPZ4HON
 lfSjNDpanuW0mziLyABM4WHYYWqARLMfX/agm/+PN1XH6kb1yO7p79M275qu3/KhvaZDpRp+p
 tTxijkkjPdW96+NaojBiICOdWUV0AUtQqmCOejgJHjB3XxZUxBZa/xYOkr5s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following Sphinx warning:

Documentation/translations/it_IT/process/maintainer-pgp-guide.rst:458:
  WARNING: Unknown target name: "nitrokey pro".

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../translations/it_IT/process/maintainer-pgp-guide.rst         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/it_IT/process/maintainer-pgp-guide=
.rst b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
index 118fb4153e8f..f3c8e8d377ee 100644
=2D-- a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
+++ b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
@@ -455,7 +455,7 @@ soluzioni disponibili:
   `GnuK`_ della FSIJ. Questo =C3=A8 uno dei pochi dispositivi a supportar=
e le chiavi
   ECC ED25519, ma offre meno funzionalit=C3=A0 di sicurezza (come la resi=
stenza
   alla manomissione o alcuni attacchi ad un canale laterale).
=2D- `Nitrokey Pro`_: =C3=A8 simile alla Nitrokey Start, ma =C3=A8 pi=C3=
=B9 resistente alla
+- `Nitrokey Pro 2`_: =C3=A8 simile alla Nitrokey Start, ma =C3=A8 pi=C3=
=B9 resistente alla
   manomissione e offre pi=C3=B9 funzionalit=C3=A0 di sicurezza. La Pro 2 =
supporta la
   crittografia ECC (NISTP).
 - `Yubikey 5`_: l'hardware e il software sono proprietari, ma =C3=A8 pi=
=C3=B9 economica
=2D-
2.20.1

