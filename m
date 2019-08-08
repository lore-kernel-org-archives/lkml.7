Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C582189E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dV8YQMdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404194AbfHHQtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:49:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:50869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404015AbfHHQtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565282955;
        bh=NyYRIlyJp1dNqY9bMLhKdZDQoswA/k6BxEUTuDZ+Zb8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dV8YQMdchQ5RKjdA20SaoSKPKuU8G05WvMvaPIUMySCtxCIdbqnX0XC2JC+XnLud3
         SYdo8NKzhO4ZzKKqlGhgHa08DhwP++1cPzSYiJORywewgfjql0t15WfFgsuhuJL2hm
         Sg1zZdehUfG/U+LeXuL1WcH4lM6G6N/31IVucbfs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmwpk-1iWCHf00Am-00h5Fs; Thu, 08
 Aug 2019 18:49:15 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/arm/samsung-s3c24xx: Remove stray U+FEFF character to fix title
Date:   Thu,  8 Aug 2019 18:48:09 +0200
Message-Id: <20190808164811.15645-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hh+MMVrp26ugQyFj+D/l4R8ydI3JFX9v5nK/15hlhDut2Eh6Y2L
 QLxShqdo8KDJwsAdSSddpgpiCyup3PqyrM2a5LBmFDQI9C+Eqi+YKFi+Oz36OVw6zwviSk9
 VZEs46WEyXKOnAuOd9KmrKd8yx2RrwCHZuwP7N+EipYj+eYmxcIcJkVU462lmplJ93HFeZg
 lR6aVBBmQ4LJvuakhnAFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c6pVNIDsHNg=:FGqIiO2jLGaVGa76F74RXp
 tcUbzZT7A2Oe2urH83/b48cZWUlWW9UKIqGfjTykNm+rilrnwAq88cBHOz6Hz8p5bhBYTtNh5
 UO7O110UrafNB0hAiOJ9VeqzTor8S3K2LQc+VwdYK4dGshKqeY+QAIrURC4BGU3nDeuNTLzu4
 BF3NBaOf30B6rNE6QtHsn6yS7InHaIMlKs65YSVmxAH2kE0+Hyn8ZJ11G7/evujkUInGb5IhL
 iRobXZKV0Jqz5qQPQurj8xEyUvzfQGxkhfWucnJKZVhoW/+TV8FnylKrQIK9TY3f8Ot7ldsH5
 JqPBo/uJuB/eKCUR1j1Nj5px5LHJ1z2bPEOT3qineeJFqqhFTGKfiVNEJHg9YUNsB9vSlqlA5
 bFAQbDE6hua+ZDfxBGjzaW7mSB2E0CipOwPjmBtdx30E8a9OV2LWV3Warrm6dn7L1YJYqEEYg
 hYJ2GeWkWDCXaTlJq0K0iyE8oFXiJcIEKdej/1opQOcsN1rl0sRhmXCa1UyerECVvKtKcivrK
 ZSihTme0UhUsZLQ2QdhCbT/9Mgb0vKrEtO/Gu+cjLwjshItORUAQA6oBZAk2kirQadpMEd0vn
 aVXXhsvc9VMHUbjyVugzV0Pm0ooikDnyqyWHQ7e045GdoFAxoz+zTJlQVrieITAXzBFFXHuTb
 T4Msh2CZV15pW46AUFXHS5u1Qqp980ESjqxMvfA0i5lgMp7KjdnAfTzArDDYOAwvMmH9iR6nV
 5my/YOSccGlfbI8hX/fAeXoUIYQBP4dJSLK1qqMi7OfEZmf6Vy+L1Z5AZpCCfiV1PG6T+z8c1
 QhWN8It4w7aVMchPtxACmU9y60yI2AN+xPlQFzVnmT5rtsLkw0D6AaJwL5aeg2ukpRsOh0S6H
 DghHEl1VFRBIOH+LHmBGNGJj3Gk7G+UHUiFRhAcu2LKpRXBYcfgV1pNjXPOFEjXZLsJyYR/vt
 azrmrmCHvhDw8pl8yOwCJacZLcf1HJW9PGIcJxi9pQVIx5pjRtOlmeHEoz+ZZbLrrae9Qiyb6
 sqGQmWfI27rt/VIpfV0nT9QpBFvcdb/Q5vnk6VnPKrmlAwHyhkc4zQ0lB5MO+RMlXq1A22VKb
 IjncQgDJuNvD2Rd9RFkUz1SHjExLLhFix5jMV0Cb0D7gezwDQlKjq0rn3CchNQ/rrhvFD9+Nr
 R47+8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems a UTF-8 byte order mark (the least useful kind of BOM...) snuck
into the file and broke Sphinx's detection of the title line.

Besides making arm/samsung-s3c24xx/index.html look a little better, this
patch also confines the non-index pages in arm/samsung-s3c24xx to their
own table of contents.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/arm/samsung-s3c24xx/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm/samsung-s3c24xx/index.rst b/Documentation/a=
rm/samsung-s3c24xx/index.rst
index 5b8a7f9398d8..ccb951a0bedb 100644
=2D-- a/Documentation/arm/samsung-s3c24xx/index.rst
+++ b/Documentation/arm/samsung-s3c24xx/index.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0

-=EF=BB=BF=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
 Samsung S3C24XX SoC Family
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=2D-
2.20.1

