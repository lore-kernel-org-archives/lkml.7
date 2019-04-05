Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BCBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BDE21871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OnAcZFp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfDEL2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:28:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:46553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfDEL2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554463716;
        bh=6fHvPidcPyBfB2ec8H5GPO/3TGnHjppQPxknaY/Obas=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OnAcZFp3hu62iK6UihzCMKP8bpXsumUQoQlHQUWqZk5HxMdw8tNHms1wStuWq0GVY
         jZv1mSYRbJjuPxzeUrGGTnKPU5PaWfZBeXDdkNV7Px/E75pwI38BRZ1B2O3uICdF78
         FGQ+o2G3OLm1JxCpfbyQTPEud04/qhUw++mK4lKQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MF4iR-1h9HYG2Rel-00GLXh; Fri, 05 Apr 2019 13:28:36 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v3 4/4] chardev: update comment based on the code
Date:   Fri,  5 Apr 2019 19:27:11 +0800
Message-Id: <20190405112711.25275-4-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405112711.25275-1-cgxu519@gmx.com>
References: <20190405112711.25275-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MQAtPIdquU8vizTMTxMqZfkfBrCseOhtvEPbYX5jluClV/SBNhW
 64goyVoxlTSbiJt67Nao/ASKpncHA/F/SlUSl0Oy3gW2kXZx79fXsLTMF+3Bf1W/WiAzkbi
 UUg7b5PeIRAWAP8QGXzzzO0xya6LXCjNKD26Sp6/yyo9BMB8Q2CwJqJ1JeSoHHB3mxUYKoc
 WIEGVQnqmi2BSzxNDnt0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3j62aQPKGJI=:BEXdWOzFINBZcgqY1MyNec
 8k6o6fXHu97i808zRBOm+yOfMSexf/ydKTdReva3b92WECV/EMqrk+OH/JczOV31+J7SFGfD8
 KI7MZMFY9FTkwa65cCjEVzs5merJ9hwBjcQi4PSxnZDY8DH1oeMNtxUSjTCU3USnK/RtTGobQ
 8ue8Jo/JHHgI7FekoOu74U9y/fT5KzK4brIrcusLmCYWPlOG0S871El2WAVIq3kSI5d8n2lN6
 sqdpnzUrZW5Ko5dx4iVj2YZ/hgBaBS011s9OUGEpNxke/CatmbYmxceXEWh3qF8urDOTFfHVY
 0pXvlgycpF/fN29f8liNPZmkaovd5Gb0boBZkNRiEsitpJe2s0+zUQu9sC676rYI0z7UctS6a
 bPRX9RSpcmRrFndovQPEku/nMAVizWalhT9Y8nIK/n7P0MoQCHj90O4PCyKPDotsByovd9FBr
 K/IFXYwOQtq9FjEjFKDAgBw+TEotEdUzQOjlqL8RCrhfndrOqkzKcMQhoZT9WuSZ3VaAEFnnb
 5ZtjC3zOC/zHsy1ILnXpxuZQ/HYPlHLCzTprThyJcxszFPIlinB9ANEtbwAWyYSN7mNLLkATR
 ehRkL0nu2G4naqdQuLJD0FQrw+DB5D+Jy0YotsJnPXwnSkgF7sgiZ2Jn4CHc6HqAQFeQ4xCX1
 ylZc/w8LBb9vaDz3U1smSn3sLjJJSq05G/gupS7Qsp5jQT3ofNzxv0ukXgrcBAlZvHQzszt4w
 nm82S/x3Q9ob36GCuLGQl3kISae4N+Pn5tPaI50l2k7ijgHx1IVWpl2+LEaki/a4Hp65okij1
 CEwKvfkUDwOnX97eqTD5K/a7+jHWKnnxolk9+mzvgYej91eIzsU9krWqgFHR5Gb+WHK3WYT/0
 8pzgSoZMPTopmY4YWSats8abMCeHlSr/CFGFfmTbpP5DO8ZQ+cZ18mMlP+EVZp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function comment of __register_chrdev_region()
is out of date, so update it based on the code.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
v1->v2:
- Split fix and cleanup patches.
- Remove printing minor range in chrdev_show().

 fs/char_dev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 47fd0561b03d..00dfe17871ac 100644
=2D-- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -88,13 +88,10 @@ static int find_dynamic_major(void)
 /*
  * Register a single major with a specified minor range.
  *
- * If major =3D=3D 0 this functions will dynamically allocate a major and=
 return
- * its number.
- *
- * If major > 0 this function will attempt to reserve the passed range of
- * minors and will return zero on success.
+ * If major =3D=3D 0 this function will dynamically allocate an unused ma=
jor.
+ * If major > 0 this function will attempt to reserve the range of minors
+ * with given major.
  *
- * Returns a -ve errno on failure.
  */
 static struct char_device_struct *
 __register_chrdev_region(unsigned int major, unsigned int baseminor,
=2D-
2.20.1

