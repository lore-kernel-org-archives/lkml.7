Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D19C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5102421670
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eatforyou.eu header.i=@eatforyou.eu header.b="WjhpjINA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfE2JHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:07:41 -0400
Received: from mail.eatforyou.eu ([80.211.90.82]:46276 "EHLO mail.eatforyou.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfE2JHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:07:39 -0400
Received: by mail.eatforyou.eu (Postfix, from userid 1001)
        id E3CDD87620; Wed, 29 May 2019 11:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eatforyou.eu; s=mail;
        t=1559120854; bh=vyeMfvM9p5OpBZcpaixj7OR3/HmtYFl6oOgS3h1qK0U=;
        h=Date:From:To:Subject:From;
        b=WjhpjINApSeNGd/OWo8BPgfr+rfMmD+BBSd4+8J9oC9lDcC2qTXSn4PhnBfRduElk
         N7dPq3X9TX/5rKugl7+Dh/qgdbwNyApzDhRcP/1TgdqvuhWo/VvpMoTyWoQBck4dK/
         c5RjZMNaFfYx6ex08S+CU5Kw5/NPGxdRBsWtdSaQ=
Received: by mail.eatforyou.eu for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 09:07:16 GMT
Message-ID: <20190529105212-0.1.c.mvd.0.0jfof6v2e5@eatforyou.eu>
Date:   Wed, 29 May 2019 09:07:16 GMT
From:   "Radoslav Dobrev" <radoslav.dobrev@eatforyou.eu>
To:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?=D0=92=D0=B5=D0=BB=D0=B8=D0=BA=D0=B4=D0=B5=D0=BD=D1=81=D0=BA=D0=B8_=D0=B1=D0=BE=D0=BD=D1=83=D1=81=D0=B8?=
X-Mailer: mail.eatforyou.eu
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=97=D0=B4=D1=80=D0=B0=D0=B2=D0=B5=D0=B9=D1=82=D0=B5,

=D1=81=D1=8A=D0=B2=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=D0=BD=D0=BE=D1=82=D0=BE =
=D0=B4=D0=BE=D0=BF=D0=BB=D0=B0=D1=89=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=85=
=D1=80=D0=B0=D0=BD=D0=B0 =D0=BF=D0=BE=D0=B4 =D1=84=D0=BE=D1=80=D0=BC=D0=B0=
=D1=82=D0=B0 =D0=BD=D0=B0 =D0=B2=D0=B0=D1=83=D1=87=D0=B5=D1=80=D0=B8 =D0=B7=
=D0=B0 =D1=85=D1=80=D0=B0=D0=BD=D0=B0, =D0=BA=D0=BE=D0=B8=D1=82=D0=BE =D0=
=BC=D0=BE=D0=B3=D0=B0=D1=82 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B0=D1=82 =D0=
=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8 =D0=B2 =D0=BD=D0=
=B0=D0=B9-=D0=B3=D0=BE=D0=BB=D1=8F=D0=BC=D0=B0=D1=82=D0=B0 =D0=BC=D1=80=D0=
=B5=D0=B6=D0=B0 =D0=BE=D1=82 =D0=B7=D0=B0=D0=B2=D0=B5=D0=B4=D0=B5=D0=BD=D0=
=B8=D1=8F =D0=B7=D0=B0 =D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B5 =D0=B2 =
=D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B0=D1=82=D0=B0, =D0=B5 =D0=B8=D0=BD=D1=81=
=D1=82=D1=80=D1=83=D0=BC=D0=B5=D0=BD=D1=82, =D0=BA=D0=BE=D0=B9=D1=82=D0=BE=
 =D0=B5=D1=84=D0=B5=D0=BA=D1=82=D0=B8=D0=B2=D0=BD=D0=BE =D0=BF=D0=BE=D0=B2=
=D0=B8=D1=88=D0=B0=D0=B2=D0=B0 =D0=B5=D1=84=D0=B5=D0=BA=D1=82=D0=B8=D0=B2=
=D0=BD=D0=BE=D1=81=D1=82=D1=82=D0=B0 =D0=BD=D0=B0 =D0=BF=D0=B5=D1=80=D1=81=
=D0=BE=D0=BD=D0=B0=D0=BB=D0=B0.

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
www.eatforyou.eu
