Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCCCC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795FF2073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKOHqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:46:00 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:33415 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfKOHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:46:00 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MgNxZ-1hxGfZ3Nkt-00ht6M; Fri, 15 Nov 2019 08:45:27 +0100
Date:   Fri, 15 Nov 2019 08:45:24 +0100
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
Subject: [PATCH v2 4/4] MAINTAINERS: add maintainer for ping iio sensors
Message-ID: <20191115074522.o237qv2hivdawn45@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:R3YeHRSDgxZM/qfBF5BAAc6W1GiIOvqg9saqoNCLjAxLOpbM8xM
 +9Alvx4ZVShXDqkTrssJagSSVf1w/DbIXR6e6icWOF8Yrd5t1VyxYAV4MtZfJ6RdDUe/6bA
 hr/HIVU6T4F3GLnvtasBeeL4usPUf3DH8VOxRXcXfrXYXHvaWkFIWqZY450LjUE6dkX9mu5
 nws5fQtq9nVbOu3ujsYQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jtiVqWsSXIQ=:quQlDAO92j49Xs7ucDVLyd
 Tv6x9xha7xQNE7Y+wtyjZuJjrkO/IdRgnZJlpgF0QFw1A5CRNCHzShiZTsA7AveaH1tgNDBh/
 hik/E3azwHgEnljxXheJDbY4HyqAWpUrLnOhNZGICyIl265kl7u8iPA9kIfMfNAKJYH0ALZjD
 0Tc79P6Hvqb+SxBfE6VxM8rMf6cZhMZKw2MgLaGq+OU88ncQgF9Ip4eYMcHnu1w4C5LSXMf9d
 Qr12Y4lPWBjZrVcASch4sz8kR8yQ0aCGVwd0PCqbgj0Ba0FVqH69kFaZ/7RxGvn2neMhAS7kw
 YPw0lwOqNJ8zFUJMOPqUUx6SKzI9DVjXrDTKsYyh37Ni45DLSihYKulvwGSWGkv/MFTVUycrK
 ZUOHgnR1VagXU42aXUPuqbGUTdf4V2M42qpleVIQXvLlXpo0UWrmys5PvCKub6IFfL/oQWlWN
 +fLo1XT732ou2VHxmeiF9CO3RvN5vYuqXyguSkc/3M30z99AcWWXw569fCL/MdsMRpiLWKCHY
 bJ15mcH2vmPht2wFwG4DWH6tyTs6A94Tf4fUNM3LogddRzCdVGAsfMaJZw5cUNajWenmsPbXG
 OnQYB3xJATZ30iW2wpNdcnAMeHzvadIcVBxmGVB+i0z87Xg0UrNeE3eQa0c+jYlpLuvqYMKLQ
 +DsTvl9+rnXeIJq+usBtt0w/0j6BPo9V/Fv7DCSg+7oWz83MAQ5cc1b3eOtr/ch6Zn60On/Qs
 Rkw8ts31GfWZ9e78OKAroOn1MsKYdam2h+QxWRcpNYjat+H7TxAXxHh03UMf4zM3RVQ0CNwgp
 54+7pgquR1SOGg1HbhhcRIUqiEYsPMoM7py33hFVaCGrmsMDBtjO/pq69n2z8tyd4GYmC/M3D
 lucPrQnUQCnf37h2QcoQ==
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
