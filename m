Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C0DC43141
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12D520726
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKRHh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 02:37:26 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:38567 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRHhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:37:25 -0500
Received: from localhost ([185.35.208.129]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N9dg5-1hli4Z3cEH-015WVh; Mon, 18 Nov 2019 08:36:54 +0100
Date:   Mon, 18 Nov 2019 08:36:50 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org, mark.rutland@arm.com
Cc:     mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        tglx@linutronix.de, mchehab+samsung@kernel.org,
        davem@davemloft.net, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] MAINTAINERS: add maintainer for ping iio sensors
Message-ID: <20191118073648.tk4otab6alsiuzt7@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:ZISP8DP7LxxcjVaKcb0HRurcDIs/0YQTEspXlzOeNUD09UpU21I
 A8MfWMOlgmmvZwYxEVYwbPSQsxW7yxgfzqZdQCxtLfO/MgWG2IqPZMRQR+ZzfvL9TV8tknA
 gJpZuVuMirJ5Dk2t49/AmA/SKYp5VCeCRO1xCWcWn+i79CdlQOeLjKt/bQLFSW8nwsS4xKP
 EHfM7FqfJrwlgsCGPfjzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pzWtpX5zhZA=:uAPKewFawR4cgNWUdCnfrh
 TKb2ODE7kL5lG4bjmgtm/SMhHhx/6z7AWNU0kO0TTrbrtWe/mGBhHzw6v4VeztTj1wdC7+IJd
 zPXNvZ4S/5LK+u4dAflENtx6btQ41SHOEGxfOZKdkhbCtpOh5Pk4pwiYmuW/IuHHMK7MRynEB
 mCbyrd1q1B1pLmlTkhO0jMvFoWvjBCSJDejDP9B/rRGO9d4/UxOWDhyJAXzUQ1zKdeAoFmTUd
 6oQMPQXVMR/YG9ed9q9gGHN4uuYvCK5hRULjaSlMF6p0nSTUYXMOeFb3mc11wC54M84KSLJ7N
 03OVQygOfpdHXEwYLJmcPdjteyFBIvFbwGqyn7U3o3sEMCBeeQoXTaNWXK+Yzkx55P0hX7eMF
 pl/g+auPT/EPhh6WAbyl3CGPlkJ8UOhm8csfemYYdcKGQWci7KzvtIhMhS81f5adabVCIVrNQ
 yQGI9HvlQ0xlagOiRgCJwJoOlZJJiQV6kxDRbXccBFdf5eXG85Up9GAdabbjhCrCEe8mRUKdG
 iINAa9dIkQS36Ugm4xXsQFH0riCfkvLQhjMTms1HW3+0w+N9zZXqT2hWZJw3McmJr+g4PFGm3
 CrPB2jE4wd1kbIfyI1y3FiL1gp1a7qBtYNMHwhFwu9w+ocos8pn254b9Vr5Vg0aaGnbEgJFz5
 e7T1xwEAYbGk0albCkSO/QWAIMNX/8YUqka0KfylCv//nf5+DY7mlWgiPzA2ZbP3kAPXpE4ry
 MHbYBLBWCCJvBdIvdpxvOwDCta/quArlCp9CtIrivJXfZiWVKRtn6SHAm1/OR6S2/DRYU9gDM
 nmP4gUGy0BSXxWSHClGa+VJ5WfsFBdGiYizWTk5YBvT/cr+KtSXKuT/6qvdBkZNk+0QLJOmbE
 0N0MLkHejM1mychbQr5z9VBDKKf/oY5Ld4CKzAJ1Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a maintainer for the new parallax PING))) and LaserPING IIO sensors

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d04ce95..ad469adffb99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12264,6 +12264,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/panasonic-laptop.c
 
+PARALLAX PING IIO SENSOR DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
+F:	drivers/iio/proximity/ping.c
+
 PARALLEL LCD/KEYPAD PANEL DRIVER
 M:	Willy Tarreau <willy@haproxy.com>
 M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
-- 
2.11.0
