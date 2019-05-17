Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55479C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FED20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunchkarty.eu header.i=@lunchkarty.eu header.b="EYvsjSfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfEQHkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:40:42 -0400
Received: from mail.lunchkarty.eu ([80.211.141.150]:54707 "EHLO lunchkarty.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbfEQHkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:40:42 -0400
Received: by lunchkarty.eu (Postfix, from userid 1001)
        id DFB5A8777A; Fri, 17 May 2019 09:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lunchkarty.eu;
        s=mail; t=1558078256;
        bh=DRu0vjHfbY7ipkVfR5IVkS8rC2tRt9/vG06AzL2xOt4=;
        h=Date:From:To:Subject:From;
        b=EYvsjSfPHrT8S0MNWKUqjaUO/apxwQlQdyqetcE0C4b3yeIPoUO2SOYg2JDUVqOaO
         2tOx6iyUtcqp+9j5ziiBULu0sAKHzogQw3lT9l3Lw6tOWAi4zzsNJH4+Ec0OYNVOdX
         ICKhrqmfl4ahk4FjhlXGWTD5l8CdQyr5fLOlY1Xw=
Received: by mail.lunchkarty.eu for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 07:30:35 GMT
Message-ID: <20190517084500-0.1.11.2np0.0.9gg70k968m@lunchkarty.eu>
Date:   Fri, 17 May 2019 07:30:35 GMT
From:   "Radoslav Dobrev" <radoslav.dobrev@lunchkarty.eu>
To:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?=D0=92=D0=B5=D0=BB=D0=B8=D0=BA=D0=B4=D0=B5=D0=BD=D1=81=D0=BA=D0=B8_=D0=B1=D0=BE=D0=BD=D1=83=D1=81=D0=B8?=
X-Mailer: mail.lunchkarty.eu
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=97=D0=B4=D1=80=D0=B0=D0=B2=D0=B5=D0=B9=D1=82=D0=B5!

=D0=9D=D1=83=D0=B6=D0=B4=D0=B0=D0=B5=D1=82=D0=B5 =D0=BB=D0=B8 =D1=81=D0=B5=
 =D0=BE=D1=82 =D0=BC=D0=BE=D1=82=D0=B8=D0=B2=D0=B0=D1=86=D0=B8=D0=BE=D0=BD=
=D0=B5=D0=BD =D0=BF=D0=B0=D0=BA=D0=B5=D1=82 =D0=B7=D0=B0 =D0=BF=D0=B5=D1=80=
=D1=81=D0=BE=D0=BD=D0=B0=D0=BB=D0=B0, =D0=BA=D0=BE=D0=B9=D1=82=D0=BE =D0=B5=
 =D1=83=D0=B4=D0=BE=D0=B1=D0=B5=D0=BD =D0=B8 =D0=BF=D1=80=D0=B8=D0=B2=D0=BB=
=D0=B5=D0=BA=D0=B0=D1=82=D0=B5=D0=BB=D0=B5=D0=BD, =D0=BA=D0=B0=D0=BA=D1=82=
=D0=BE =D0=B7=D0=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BE=D0=B4=D0=B0=D1=82=
=D0=B5=D0=BB=D1=8F, =D1=82=D0=B0=D0=BA=D0=B0 =D0=B8 =D0=B7=D0=B0 =D1=81=D0=
=BB=D1=83=D0=B6=D0=B8=D1=82=D0=B5=D0=BB=D0=B8=D1=82=D0=B5?

=D0=92 =D1=82=D0=B0=D0=BA=D1=8A=D0=B2 =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=B9=
 =D0=92=D0=B8 =D0=BF=D1=80=D0=B5=D0=BF=D0=BE=D1=80=D1=8A=D1=87=D0=B2=D0=B0=
=D0=BC=D0=B5 =D0=B4=D0=B0 =D0=BE=D0=B1=D0=BC=D0=B8=D1=81=D0=BB=D0=B8=D1=82=
=D0=B5 =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=
=D0=BE =D0=BD=D0=B0 =D0=B2=D1=81=D0=B5 =D0=BF=D0=BE-=D0=BF=D0=BE=D0=BF=D1=
=83=D0=BB=D1=8F=D1=80=D0=BD=D0=B8=D1=82=D0=B5 =D0=B2=D0=B0=D1=83=D1=87=D0=
=B5=D1=80=D0=B8 =D0=B7=D0=B0 =D1=85=D1=80=D0=B0=D0=BD=D0=B0 - =D1=80=D0=B0=
=D0=B1=D0=BE=D1=82=D0=BE=D0=B4=D0=B0=D1=82=D0=B5=D0=BB=D1=8F=D1=82 =D0=BE=
=D1=81=D0=B8=D0=B3=D1=83=D1=80=D1=8F=D0=B2=D0=B0 =D0=B2=D0=B0=D1=83=D1=87=
=D0=B5=D1=80=D0=B8 =D0=B7=D0=B0 =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=BB=
=D0=B5=D0=BD=D0=B0 =D1=81=D1=83=D0=BC=D0=B0, =D0=B0 =D1=81=D0=BB=D1=83=D0=
=B6=D0=B8=D1=82=D0=B5=D0=BB=D1=8F=D1=82 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=
=B0 =D1=8F =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0 =D0=B2 =D1=80=
=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=BD=D0=B8 =D0=B2=D0=B5=D1=80=D0=B8=D0=B3=
=D0=B8 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=B8 =D0=BC=
=D0=B0=D0=B3=D0=B0=D0=B7=D0=B8=D0=BD=D0=B8 =D0=B8=D0=BB=D0=B8 =D0=B7=D0=B0=
=D0=B2=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8=D1=8F =D0=B7=D0=B0 =D1=85=D1=80=D0=B0=
=D0=BD=D0=B5=D0=BD=D0=B5 =D1=81=D0=BF=D0=BE=D1=80=D0=B5=D0=B4 =D1=81=D0=B2=
=D0=BE=D0=B8=D1=82=D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D0=BF=D0=BE=D1=87=D0=B8=
=D1=82=D0=B0=D0=BD=D0=B8=D1=8F.

=D0=A9=D0=B5 =D1=81=D0=B5 =D1=80=D0=B0=D0=B4=D0=B2=D0=B0=D0=BC =D0=B4=D0=B0=
 =D0=92=D0=B8 =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D1=8F =D0=B2=
=D1=8A=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE=D1=81=D1=82=D0=B8=D1=82=D0=B5 =
=D0=BD=D0=B0 =D0=B2=D0=B0=D1=83=D1=87=D0=B5=D1=80=D0=B8=D1=82=D0=B5  =E2=80=
=93 =D0=BC=D0=BE=D0=B3=D0=B0 =D0=BB=D0=B8 =D0=B4=D0=B0 =D0=92=D0=B8 =D1=81=
=D0=B5 =D0=BE=D0=B1=D0=B0=D0=B4=D1=8F, =D0=B7=D0=B0 =D0=B4=D0=B0 =D0=BE=D0=
=B1=D1=81=D1=8A=D0=B4=D0=B8=D0=BC =D0=B2 =D0=B4=D0=B5=D1=82=D0=B0=D0=B9=D0=
=BB=D0=B8?


=D0=A0=D0=B0=D0=B4=D0=BE=D1=81=D0=BB=D0=B0=D0=B2 =D0=94=D0=BE=D0=B1=D1=80=
=D0=B5=D0=B2
Head of HR Benefit Team
www.lunchkarty.eu 
