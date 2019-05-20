Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_CSS,URIBL_CSS_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F76C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8300520675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=greatforyou.eu header.i=@greatforyou.eu header.b="YCiBuaAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfETJRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:17:14 -0400
Received: from mail.greatforyou.eu ([212.237.4.137]:40327 "EHLO
        mail.greatforyou.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfETJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:17:14 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 May 2019 05:17:12 EDT
Received: by mail.greatforyou.eu (Postfix, from userid 1001)
        id 3D64C8773A; Mon, 20 May 2019 11:05:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=greatforyou.eu;
        s=mail; t=1558343242;
        bh=Ose1Lf6xoZyXlmyNhvfZ0PnQ3bIpVImYbP9/NlfeECg=;
        h=Date:From:To:Subject:From;
        b=YCiBuaAuKHhUd89ezluna0l0isYMZaK3QeN9t8InRiMEa9tClU+ziHCPHtgulefHq
         Pt+yUl2eZZTpmGxbRUlNicPgVnWuTlizpBT+T9AQli+B4YSk5nHrH8i+gBrxLp49Em
         GlNYcWKXDeToiTTLS4qlU2RKZXRWmiinMrOFUrVQ=
Received: by mail.greatforyou.eu for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:05:18 GMT
Message-ID: <20190520110232-0.1.6.8qq.0.i1x2e6co9i@greatforyou.eu>
Date:   Mon, 20 May 2019 09:05:18 GMT
From:   "Radoslav Dobrev" <radoslav.dobrev@greatforyou.eu>
To:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?=D0=92=D0=B5=D0=BB=D0=B8=D0=BA=D0=B4=D0=B5=D0=BD=D1=81=D0=BA=D0=B8_=D0=B1=D0=BE=D0=BD=D1=83=D1=81=D0=B8?=
X-Mailer: mail.greatforyou.eu
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=97=D0=B4=D1=80=D0=B0=D0=B2=D0=B5=D0=B9=D1=82=D0=B5,

=D0=A1=D1=8A=D0=B2=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=D0=BD=D0=B0=D1=82=D0=B0 =
=D1=81=D0=BE=D1=86=D0=B8=D0=B0=D0=BB=D0=BD=D0=B0 =D0=BF=D1=80=D0=B8=D0=B4=
=D0=BE=D0=B1=D0=B8=D0=B2=D0=BA=D0=B0 =D0=B2=D0=B0=D1=83=D1=87=D0=B5=D1=80=
=D0=B8 =D0=B7=D0=B0 =D1=85=D1=80=D0=B0=D0=BD=D0=B0, =D0=BA=D0=BE=D0=B8=D1=
=82=D0=BE =D0=BC=D0=BE=D0=B3=D0=B0=D1=82 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=
=B0=D1=82 =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8 =D0=
=B2 =D1=88=D0=B8=D1=80=D0=BE=D0=BA=D0=B0 =D1=82=D1=8A=D1=80=D0=B3=D0=BE=D0=
=B2=D1=81=D0=BA=D0=B0 =D0=BC=D1=80=D0=B5=D0=B6=D0=B0 =D0=BE=D1=82 =D1=81=D1=
=83=D0=BF=D0=B5=D1=80=D0=BC=D0=B0=D1=80=D0=BA=D0=B5=D1=82=D0=B8 =D0=B8 =D0=
=B7=D0=B0=D0=B2=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8=D1=8F =D0=B7=D0=B0 =D1=85=D1=
=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B5 =D0=B2 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=
=B0=D1=82=D0=B0, =D0=B5 =D0=B8=D0=BD=D1=81=D1=82=D1=80=D1=83=D0=BC=D0=B5=D0=
=BD=D1=82, =D0=BA=D0=BE=D0=B9=D1=82=D0=BE =D0=B5=D1=84=D0=B5=D0=BA=D1=82=D0=
=B8=D0=B2=D0=BD=D0=BE =D0=BF=D0=BE=D0=B2=D0=B8=D1=88=D0=B0=D0=B2=D0=B0 =D0=
=B5=D1=84=D0=B8=D0=BA=D0=B0=D1=81=D0=BD=D0=BE=D1=81=D1=82=D1=82=D0=B0 =D0=
=BD=D0=B0 =D0=BF=D0=B5=D1=80=D1=81=D0=BE=D0=BD=D0=B0=D0=BB=D0=B0.

=D0=98=D0=B7=D0=B1=D0=BE=D1=80=D1=8A=D1=82 =D0=BD=D0=B0 =D0=BD=D0=B0=D1=88=
=D0=B8=D1=82=D0=B5 =D0=B2=D0=B0=D1=83=D1=87=D0=B5=D1=80=D0=B8 =D0=B7=D0=B0=
 =D1=85=D1=80=D0=B0=D0=BD=D0=B0 =D0=BA=D0=B0=D1=82=D0=BE =D1=84=D0=BE=D1=80=
=D0=BC=D0=B0 =D0=BD=D0=B0 =D1=81=D0=BE=D1=86=D0=B8=D0=B0=D0=BB=D0=BD=D0=B0=
 =D0=BF=D1=80=D0=B8=D0=B4=D0=BE=D0=B1=D0=B8=D0=B2=D0=BA=D0=B0 =D1=81=D0=B0=
 =D0=B7=D0=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BE=D0=B4=D0=B0=D1=82=D0=B5=
=D0=BB=D1=8F =D0=BD=D0=B5 =D1=81=D0=B0=D0=BC=D0=BE =D0=BF=D1=80=D0=B8=D0=B4=
=D0=BE=D0=B1=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=
=D0=B4=D1=83=D0=BA=D1=82=D0=B8=D0=B2=D0=B5=D0=BD =D0=B8 =D0=BC=D0=BE=D1=82=
=D0=B8=D0=B2=D0=B8=D1=80=D0=B0=D0=BD =D0=B5=D0=BA=D0=B8=D0=BF, =D0=BD=D0=BE=
 =D0=B8 =D0=BD=D0=BE=D1=81=D1=8F=D1=82 =D1=84=D0=B8=D0=BD=D0=B0=D0=BD=D1=81=
=D0=BE=D0=B2=D0=B8 =D0=BE=D0=B1=D0=BB=D0=B0=D0=B3=D0=B8 - =D1=81=D1=82=D0=
=BE=D0=B9=D0=BD=D0=BE=D1=81=D1=82=D1=82=D0=B0 =D0=BD=D0=B0 =D0=B8=D0=B7=D1=
=80=D0=B0=D0=B7=D1=85=D0=BE=D0=B4=D0=B2=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D1=
=81=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=BD=D0=B5 =D1=81=D0=B5 =D0=
=BE=D0=B1=D0=BB=D0=B0=D0=B3=D0=B0=D1=82 =D1=81 =D0=B4=D0=B0=D0=BD=D1=8A=D0=
=BA.

=D0=A0=D0=B0=D0=B4=D0=B2=D0=B0=D0=BC=D0=B5 =D1=81=D0=B5 =D0=B4=D0=B0 =D0=92=
=D0=B8 =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D0=BC =D0=BE=
=D1=89=D0=B5 =D0=BF=D0=BE=D0=B2=D0=B5=D1=87=D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=
=D0=B8=D0=BC=D1=81=D1=82=D0=B2=D0=B0, =D0=BA=D0=BE=D0=B8=D1=82=D0=BE =D0=B1=
=D0=B8=D1=85=D1=82=D0=B5 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D0=BB=D0=B8=
 =D1=81 =D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=
=D0=B0 =D0=BD=D0=B0=D1=88=D0=B8=D1=82=D0=B5 =D0=B2=D0=B0=D1=83=D1=87=D0=B5=
=D1=80=D0=B8, =D0=BA=D0=B0=D1=82=D0=BE =D0=BD=D0=B0=D0=BF=D1=80=D0=B8=D0=BC=
=D0=B5=D1=80 =D0=BF=D0=BE=D0=BB=D0=B7=D0=B8=D1=82=D0=B5 =D0=B7=D0=B0 =D1=81=
=D0=BB=D1=83=D0=B6=D0=B8=D1=82=D0=B5=D0=BB=D0=B8=D1=82=D0=B5 =D0=92=D0=B8=
 =D0=B8 =D1=89=D0=B5 =D0=92=D0=B8 =D1=80=D0=B0=D0=B7=D0=BA=D0=B0=D0=B6=D0=
=B0 =D0=B7=D0=B0 =D0=B2=D1=8A=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE=D1=81=D1=
=82=D0=B8=D1=82=D0=B5 =D0=BF=D1=80=D0=B8 =D1=82=D1=8F=D1=85=D0=BD=D0=BE=D1=
=82=D0=BE =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5 - =
=D0=BC=D0=BE=D0=BB=D1=8F, =D0=BE=D0=B1=D0=B0=D0=B4=D0=B5=D1=82=D0=B5 =D1=81=
=D0=B5.


=D0=A0=D0=B0=D0=B4=D0=BE=D1=81=D0=BB=D0=B0=D0=B2 =D0=94=D0=BE=D0=B1=D1=80=
=D0=B5=D0=B2
Head of HR Benefit Team
www.greatforyou.eu
