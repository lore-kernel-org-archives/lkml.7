Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76898C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4D32173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=myocard.eu header.i=@myocard.eu header.b="POdBuySQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfEUKA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:00:58 -0400
Received: from mail.myocard.eu ([80.211.34.180]:38009 "EHLO mail.myocard.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfEUKA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:00:58 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 06:00:57 EDT
Received: by mail.myocard.eu (Postfix, from userid 1001)
        id DD812873EF; Tue, 21 May 2019 11:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=myocard.eu; s=mail;
        t=1558432544; bh=xqqTtMIwrdiA7dqnQhoAQdMueQWzOyOSooCPJrKxKOw=;
        h=Date:From:To:Subject:From;
        b=POdBuySQtYS/cJDIQaq4K7frGO9xDhTIITatjg5fm1CCv4tj3uItSQAGmSR38a7Hu
         PIWT9bfx42LpXleutq0N9Z0VITCvs4E5v+FMpj5ISg4Vo0567k/B0TyweHXR+pC8sE
         BaFaMGuu4Dc0aGBDTePOTrNpehjAx4kCSOppOgzs=
Received: by mail.myocard.eu for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:55:39 GMT
Message-ID: <20190521115508-0.1.7.aue.0.si2949og9p@myocard.eu>
Date:   Tue, 21 May 2019 09:55:39 GMT
From:   "Radoslav Dobrev" <radoslav.dobrev@myocard.eu>
To:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?=D0=92=D0=B5=D0=BB=D0=B8=D0=BA=D0=B4=D0=B5=D0=BD=D1=81=D0=BA=D0=B8_=D0=B1=D0=BE=D0=BD=D1=83=D1=81=D0=B8?=
X-Mailer: mail.myocard.eu
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=A3=D0=B2=D0=B0=D0=B6=D0=B0=D0=B5=D0=BC=D0=B8 =D0=93=D0=BE=D1=81=D0=BF=
=D0=BE=D0=B4=D0=B8=D0=BD=D0=B5/=D0=93=D0=BE=D1=81=D0=BF=D0=BE=D0=B6=D0=BE=
,

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

=D0=A2=D0=BE=D0=B2=D0=B0 =D1=81=D0=B5 =D0=BF=D0=BE=D1=82=D0=B2=D1=8A=D1=80=
=D0=B6=D0=B4=D0=B0=D0=B2=D0=B0 =D0=B8 =D0=BE=D1=82 =D0=BF=D1=80=D0=BE=D1=83=
=D1=87=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=A1=D0=B2=D0=B5=
=D1=82=D0=BE=D0=B2=D0=BD=D0=B0=D1=82=D0=B0 =D0=B7=D0=B4=D1=80=D0=B0=D0=B2=
=D0=BD=D0=B0 =D0=BE=D1=80=D0=B3=D0=B0=D0=BD=D0=B8=D0=B7=D0=B0=D1=86=D0=B8=
=D1=8F (=D0=A1=D0=97=D0=9E), =D0=BA=D0=BE=D0=B5=D1=82=D0=BE =D0=BF=D0=BE=D0=
=BA=D0=B0=D0=B7=D0=B2=D0=B0, =D1=87=D0=B5 =D1=81=D0=BB=D1=83=D0=B6=D0=B8=D1=
=82=D0=B5=D0=BB, =D0=BA=D0=BE=D0=B9=D1=82=D0=BE =D0=BF=D0=BE=D0=BB=D1=83=D1=
=87=D0=B0=D0=B2=D0=B0 =D0=B4=D0=BE=D0=BF=D0=BB=D0=B0=D1=89=D0=B0=D0=BD=D0=
=B5 =D0=B7=D0=B0 =D1=85=D1=80=D0=B0=D0=BD=D0=B0, =D0=B5 =D0=BF=D0=BE-=D0=B5=
=D1=84=D0=B5=D0=BA=D1=82=D0=B8=D0=B2=D0=B5=D0=BD =D1=81 20%, =D0=B0  =D0=BE=
=D1=82=D1=81=D1=8A=D1=81=D1=82=D0=B2=D0=B8=D1=8F=D1=82=D0=B0 =D0=BC=D1=83=
 =D0=BD=D0=B0=D0=BC=D0=B0=D0=BB=D1=8F=D0=B2=D0=B0=D1=82 =D1=81 27%.

=D0=98=D0=B7=D0=B1=D0=BE=D1=80=D1=8A=D1=82 =D0=BD=D0=B0 =D0=BD=D0=B0=D1=88=
=D0=B8=D1=82=D0=B5 =D0=B2=D0=B0=D1=83=D1=87=D0=B5=D1=80=D0=B8 =D0=B7=D0=B0=
 =D1=85=D1=80=D0=B0=D0=BD=D0=B0 =D0=BA=D0=B0=D1=82=D0=BE =D1=84=D0=BE=D1=80=
=D0=BC=D0=B0 =D0=BD=D0=B0 =D1=81=D0=BE=D1=86=D0=B8=D0=B0=D0=BB=D0=BD=D0=B0=
 =D0=BF=D1=80=D0=B8=D0=B4=D0=BE=D0=B1=D0=B8=D0=B2=D0=BA=D0=B0 =D0=B5 =D1=80=
=D0=B0=D0=B2=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=D1=87=D0=BD=D0=BE =D0=BD=D0=B5=
 =D1=81=D0=B0=D0=BC=D0=BE =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B4=D1=83=D0=BA=
=D1=82=D0=B8=D0=B2=D0=B5=D0=BD =D0=B8 =D0=BC=D0=BE=D1=82=D0=B8=D0=B2=D0=B8=
=D1=80=D0=B0=D0=BD =D0=B5=D0=BA=D0=B8=D0=BF =D0=B7=D0=B0 =D1=80=D0=B0=D0=B1=
=D0=BE=D1=82=D0=BE=D0=B4=D0=B0=D1=82=D0=B5=D0=BB=D1=8F, =D0=BD=D0=BE =D0=B8=
 =D1=84=D0=B8=D0=BD=D0=B0=D0=BD=D1=81=D0=BE=D0=B2=D0=BE =D0=BE=D0=B1=D0=BB=
=D0=B5=D0=BA=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 - =D1=81=D1=82=D0=BE=D0=B9=D0=BD=
=D0=BE=D1=81=D1=82=D1=82=D0=B0 =D0=BD=D0=B0 =D0=B8=D0=B7=D1=80=D0=B0=D0=B7=
=D1=85=D0=BE=D0=B4=D0=B2=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D1=81=D1=80=D0=B5=
=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=BD=D0=B5 =D1=81=D0=B5 =D0=BE=D0=B1=D0=BB=
=D0=B0=D0=B3=D0=B0 =D1=81 =D0=B4=D0=B0=D0=BD=D1=8A=D0=BA.

=D0=96=D0=B5=D0=BB=D0=B0=D0=B5=D1=82=D0=B5 =D0=BB=D0=B8 =D0=B4=D0=B0 =D0=92=
=D0=B8 =D0=BF=D1=80=D0=B5=D0=B4=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F =D0=BF=
=D0=BE=D0=B2=D0=B5=D1=87=D0=B5 =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=
=D1=86=D0=B8=D1=8F =D0=BE=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE =D0=B2=D0=B0=
=D1=83=D1=87=D0=B5=D1=80=D0=B8=D1=82=D0=B5 =D0=B7=D0=B0 =D1=85=D1=80=D0=B0=
=D0=BD=D0=B0 =D0=B7=D0=B0 =D1=81=D0=BB=D1=83=D0=B6=D0=B8=D1=82=D0=B5=D0=BB=
=D0=B8?


=D0=A0=D0=B0=D0=B4=D0=BE=D1=81=D0=BB=D0=B0=D0=B2 =D0=94=D0=BE=D0=B1=D1=80=
=D0=B5=D0=B2
Head of HR Benefit Team
www.myocard.eu
