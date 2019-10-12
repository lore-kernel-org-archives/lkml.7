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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3201CC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A87320700
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TrHzkcD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfJLRRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 13:17:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:52487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJLRRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 13:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570900304;
        bh=e3clNQm4ZApZXbVyy9UxDQAm7LQllONhhohiXcd0Ths=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TrHzkcD4erXW1naB1U30dr/sFOjzk8wWtig3neo9mkrsPNi/aGxMNBRswoNj6j0j/
         67bnrZ62bKAEKwhu/sqzrSJZXTJC8zXp1S6zxXdbL7rNMLypDAgroci6UVdUzsY5Bp
         /zcdUUwSoVdNvHZ0VqOpj1eHED3EK6VT0pox/bt8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([213.196.244.109]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1iZP5C1BQE-00Ylo3; Sat, 12
 Oct 2019 19:11:44 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/4] docs: admin-guide: Move Dell RBU document from driver-api
Date:   Sat, 12 Oct 2019 19:11:10 +0200
Message-Id: <20191012171114.6589-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191012171114.6589-1-j.neuschaefer@gmx.net>
References: <20191012171114.6589-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fm39Z6FB7YORX6RwhW9apc74hTkQlLRNNeSCCmUs+5m61yB9A7R
 PF2/4mDs8VpT4Q9zpngqHyWtfYnYQjOUh1njbVcQu+SQ7MKwVN2GjVySo44zjEFCZeRLXeV
 L7F/l2QcymwnpkHhz/NYzMz9z1WDVADqA0qmyxir16CxzO81vx9JM73fVTktuGusxPGTkWS
 jFw7XrE2Sh63MyZEkzNnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NUvq5Dkwz0k=:8NbpyClq5gdZLaxOZiQbZ0
 Pm7ksBZpbvZ/17ieQWQjytpMdWZ3ZR9ZwGvG3WfzdBpHzQnIM3uANB5J6NDD0YT30jJUMtub8
 JWIn+SZkSllf49TfIcjNEOlglOAPTVvO0TzIEZNI3Ip7sad4+JCiJFROEg7KKpDIfPEnhOt/t
 uP/YUfeJIcphUSDCUTGv7gEXnOkiCS0D4BRy6pPbwV+RQ0VYDPMbKHpyGAlSxtCgJSdLKvbFa
 iMMc3b9+duARDXbPqmSij+C9xIeqoAYHoTCzAZZGd18pdx3gB8bhDkJAU9nx5cjyYT/bnN+oB
 H+SvPWc9JljSRz60LTMLryNQm0vIcZZ5nRfqrXDaCppefEvSZ2Pf//AbMkZtGdY42oM7/FQ+B
 KyiA5lQqzj3dHcs1ssRNVg90XQR7HJI6NKlLOZzi15Sb666cxQEokAT8o8pomOEtrwTGJYg5g
 ioymUilSqY4wf1sYL8LvlHckcpRzfWbVjws9KafxkT2krrQDruEoXX6Upd/9S+ds5CscP9Wyt
 BR3niPhb0qmmedvgjSSFaIG4IUl91gay3ORJNAAczpL046f+W+fN/LxsJNAytQ6uOFCR3IJKQ
 yrgPRd5UYMZ/6foXWfgpMmaUyzMJBCoUKe0vrJmmTyWsbAULCvPfzS0r86PpB+e1b6b6afsaO
 QuLhwPAS6v3IUqtMgrzOlGwEzgQBJlK/O/a/uXOxdCgGM0jVlDAdoaS55l9Dxxw5USEdKTBvS
 RCAg8+ilNVP3FAIg+cjPN/oBR68Zwg/67Tow8E5FVyavjAtc/BvwpF18p7aoordsMBKQj55Q/
 U67IUaLr3BQJDuASopq/qkno80dTN77mt6hcIqLW6wi0duQTIIps05KgWr9B+kWDqFhTFhnhO
 VFouCbp3nKW/ndcsUExLgn8dQ4CYI3wIlGcTkONtDS9pyxcV8xweHhQHJZLAr1zM2HVS/UtwL
 qXv6j6dTUwV433Tn/UGWLPKg0BkSs9HoXqw6sZTGEJd2nAc3KdDptZHfCYtved+xfVv6I+GpT
 frBW3CwQ6imsLq50Cl4j60NqCVcR3MzanjQmZXdfIlo2GonP5L2l12rDtspP0HcyGh/IDE2Wu
 ZOQlwjmoS8xHBvbqWz3WBgYe8+K6wNnb3LrQSUZcAsQmUhHAQ01IS8KkahdSLPrVKbnTlQpEP
 EOIslqlBIejgGznXocDuE9xlWNeFlS7SHlEszKMnMYzSYG+//ir9KWnMpTHgDM8uOrjjdz3Dn
 LJFSzj2Yn+awq6C/h26JfQQHr27G90Xa4ECjCiuH7Z2ILoChpoK5arO3jlTc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document describes how an admin can use the dell_rbu driver, rather
than any in-kernel API details.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/{driver-api =3D> admin-guide}/dell_rbu.rst | 0
 Documentation/admin-guide/index.rst                    | 1 +
 Documentation/driver-api/index.rst                     | 1 -
 drivers/platform/x86/Kconfig                           | 2 +-
 drivers/platform/x86/dell_rbu.c                        | 2 +-
 5 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/{driver-api =3D> admin-guide}/dell_rbu.rst (100%)

diff --git a/Documentation/driver-api/dell_rbu.rst b/Documentation/admin-g=
uide/dell_rbu.rst
similarity index 100%
rename from Documentation/driver-api/dell_rbu.rst
rename to Documentation/admin-guide/dell_rbu.rst
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-gui=
de/index.rst
index 545ea26364b7..4405b7485312 100644
=2D-- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -72,6 +72,7 @@ configure specific aspects of kernel behavior to your li=
king.
    clearing-warn-once
    cpu-load
    cputopology
+   dell_rbu
    device-mapper/index
    efi-stub
    ext4
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api=
/index.rst
index 2b3b6949381e..6a3ac50f51f0 100644
=2D-- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -72,7 +72,6 @@ available subsections can be seen below.
    connector
    console
    dcdbas
-   dell_rbu
    edid
    eisa
    ipmb
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ae21d08c65e8..a890f47fbeec 100644
=2D-- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -259,7 +259,7 @@ config DELL_RBU
 	 DELL system. Note you need a Dell OpenManage or Dell Update package (DU=
P)
 	 supporting application to communicate with the BIOS regarding the new
 	 image for the image update to take effect.
-	 See <file:Documentation/driver-api/dell_rbu.rst> for more details on th=
e driver.
+	 See <file:Documentation/admin-guide/dell_rbu.rst> for more details on t=
he driver.


 config FUJITSU_LAPTOP
diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_r=
bu.c
index 3691391fea6b..7d5453326b43 100644
=2D-- a/drivers/platform/x86/dell_rbu.c
+++ b/drivers/platform/x86/dell_rbu.c
@@ -24,7 +24,7 @@
  * on every time the packet data is written. This driver requires an
  * application to break the BIOS image in to fixed sized packet chunks.
  *
- * See Documentation/driver-api/dell_rbu.rst for more info.
+ * See Documentation/admin-guide/dell_rbu.rst for more info.
  */
 #include <linux/init.h>
 #include <linux/module.h>
=2D-
2.20.1

