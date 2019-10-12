Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC0C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185C420700
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b6jV/Cq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfJLRMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 13:12:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:36039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJLRMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 13:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570900311;
        bh=Zp5EojyV8iA7Me1YyTg4L4oVopF5r4vzZiU3EOEBo8A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b6jV/Cq2C2JNtNduHvcMqL5P1f6L6dfPuf7JI39x2NNbTRmwkX6ZwN8XNDL6emQv2
         Xtfp1dVolu6ivIslXL6DhEJ5HAgGKDmpx842cE+0m5LpCp4CFwC9SIlaNX4sWa1gz9
         94GYls+ZWmwGPv1FXNm4oNXrEq/zNIzkQCBDtwpE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([213.196.244.109]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1iQV8D0zHC-008KZv; Sat, 12
 Oct 2019 19:11:51 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Cornelia Huck <cohuck@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] docs: admin-guide: dell_rbu: Improve formatting and spelling
Date:   Sat, 12 Oct 2019 19:11:12 +0200
Message-Id: <20191012171114.6589-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191012171114.6589-1-j.neuschaefer@gmx.net>
References: <20191012171114.6589-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QjuWJOX8YISUQdG76zE7qW+b+u0EOV+IIZpfy+y44NWXkBk4hiR
 C3pAkD3Njfy35mCy7n0SukqO+vWA3jLQbMdbX+HIxr1GqWOrTwVvonzx1ZC0wWOd6fwVvjZ
 ynqI40kgn96a5E/S7snFjydh+R3HLZVHt9yoBzhsmBb4XmZmlAm5UU2dSJ33+d4HD3Podpq
 WLtZRVH2nS25OU0mUC3Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k9yi6jqpTaE=:K5dRhzfAs6p5vbuN2Pn43v
 +Fmbg7XcxICEsoazNLOwn10eihLy9NkOEpU5Qyp+7jDG0ivtRQYHVesl1jdVI0iNKMPAag1Mo
 dXfxC9TlYyqgLktqcGtQrvwrN8js94zq5uRQSrWFTBCMK5e2GKYrpeqWf4HTi8rKjQuaGDzT/
 CnHCSLzhhp1+R7z2LbOq4vimUICLqc3QTVtyqMqi9yuE3rWxefFrMiEss5Mss0yvBCYl/kQXX
 tsfDxd8pzo/dIvdo4a71KmFdXj3Vo+jFNRCGLom7+S4MTeA91nk50l2ZidqIELASmp570y9bp
 cHuzp8JUWR+m3J8NSwy662++Az/WnYtzXuP57HsXGY7obAZkcw3Ol18IaWf6rQds1vm84cgbm
 AxUqGMUZ9YHObD1JTCOirfXC30Qn/sXUO+6EZyeFrz5Upufzyi84sm+HDBxsSARCuBsEcRx6G
 OtME0sW2tFgmy+Oe7p3v6uJ/W3ryhMUvfHqgPUzSfb8MHWmk0VRTNnaOszwl3rGmmhDmpXUUi
 h7y4XuOliVuT3ZsdM3AtSzg6KZ+jwuO5leq1Gl2GfSTZyNZZQNkEs5RnPE46rIY3E1H2NSWPL
 HYDigpgRs0mGHPb5kMthHl88/+PgT/PqPtLV9T4czd857Tp26F9jDVkICXCdil8DoONhBhFkS
 XobRr4YOWJTyqfc60mm4+D7MYFWkTARKQbFE5Ol71eqjRAQuDi7jtbgv45Un3kolo5pSmonOf
 5zLFwWL5DzE0L6Y1HtC2X+wHAKxpxV/W9+r/pr1t9SUuPGLBHLDGL+7nQHNbu9dOlpzQ6y+mD
 tQFB+1WrSgJW0ub11toH9rOAwQNI4dhVgppzY9wFNFqzILkXzFOd0Db8aU8aZQiiKKAYLHIgX
 7bSyq/CikBsoM4hBTQaFZid4koenrmkBKe9ieIP9MhbDk9LimXFiQl6UNYcbjrgtmS8BemgZS
 a7WVh+UlTyfRB6OYgU/tEcBFcfNDhqM8dkpZOYGmmdCL9Ym8ybHRDvSDx3W9AUavaMHatYPu9
 WnWK43hoKmhJArxMc21WQUK9Ju0/vcbzJgw9AU0EF9jbnZm75MelbpDWO0I64WAfDs0A5MhSt
 04bxdowCeuOEpBE0r7LWI/y8lNie8MQY4ewXlOmkG9iUKLh9MTLRcGdxLKj/dImr4q5+/IY9K
 0E13BOPJwpRVfAlBchFdu1CtFlA0t1X1ZuxhgrZXyYIh7PvTEm3See7BBMtD6+JiWJ8BqQ1G4
 Zm42TGkUdU1WnML4Fco5Wc6ym3/5YR9kXnYzNppOHYf2Nd5DlZZ46LGdMPZw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This improves readability a bit.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/admin-guide/dell_rbu.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dell_rbu.rst b/Documentation/admin-=
guide/dell_rbu.rst
index 10830db9e616..8d70e1fc9f9d 100644
=2D-- a/Documentation/admin-guide/dell_rbu.rst
+++ b/Documentation/admin-guide/dell_rbu.rst
@@ -5,7 +5,7 @@ Dell Remote BIOS Update driver (dell_rbu)
 Purpose
 =3D=3D=3D=3D=3D=3D=3D

-Document demonstrating the use of the Dell Remote BIOS Update driver.
+Document demonstrating the use of the Dell Remote BIOS Update driver
 for updating BIOS images on Dell servers and desktops.

 Scope
@@ -37,7 +37,7 @@ maintains a link list of packets for reading them back.

 If the dell_rbu driver is unloaded all the allocated memory is freed.

-The rbu driver needs to have an application (as mentioned above)which wil=
l
+The rbu driver needs to have an application (as mentioned above) which wi=
ll
 inform the BIOS to enable the update in the next system reboot.

 The user should not unload the rbu driver after downloading the BIOS imag=
e
@@ -71,7 +71,7 @@ be downloaded. It is done as below::
 	echo XXXX > /sys/devices/platform/dell_rbu/packet_size

 In the packet update mechanism, the user needs to create a new file havin=
g
-packets of data arranged back to back. It can be done as follows
+packets of data arranged back to back. It can be done as follows:
 The user creates packets header, gets the chunk of the BIOS image and
 places it next to the packetheader; now, the packetheader + BIOS image ch=
unk
 added together should match the specified packet_size. This makes one
@@ -114,7 +114,7 @@ The entries can be recreated by doing the following::

 	echo init > /sys/devices/platform/dell_rbu/image_type

-.. note:: echoing init in image_type does not change it original value.
+.. note:: echoing init in image_type does not change its original value.

 Also the driver provides /sys/devices/platform/dell_rbu/data readonly fil=
e to
 read back the image downloaded.
=2D-
2.20.1

