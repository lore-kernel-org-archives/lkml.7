Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D814C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45107215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560362220;
	bh=T4MFrING43ge7ktyoj9q7KpqmGm9mqNqwt/MeprmNCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EgPQNK4p0Yd/QD+mSDjnpuP1Y37Uh9zRuCO4XtPszM+455lXDktB7WF09doLxnN/V
	 5+Sn++jQDGrRtw74x8FSkHhOKhKfBFalmmDjTZF+JMgkLe+L8roFJ52etox3GZvQ3o
	 XD88baMIVwqKWSntLGd/gD7iEVWE0He/rZKWO79g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404273AbfFLR47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:56:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388151AbfFLRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/ZZUTqS7pPsucm3eiqOvCLTIQSRmjVrFHqOoPzJmW2M=; b=WSSzJJjY+6oXa8zy+IkvkvfSPP
        DbiDPEiN/8YS0nBCfFaqJQePXlnkz5YsKnU1IuEBuTnFeQi9LpGECjHAWunErP3poi1azc2wXsQoE
        4znYFmmbaXmbS1/LrRf4xz3lmFTgSJhWmshgdNcepJ0EqWKZxwfNcO54rbFRTNDhzswfSb2RtqdJv
        mQbWCC7PjvS9zUgRRjV3Epz0ohDIoDPZFQ0lXtY+mvJtttV/IjxVTKamLes/aOcIpN7+MvocTeCxB
        aAhQ3wQ1yA3xdoSAMrzoTXFKYIDYSmecujONCAzQ5jVrZZFfQAzL19nrtNTPwhR6iinLgHf6uyUlP
        tPbyKJiA==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Qt-0002Dl-1U; Wed, 12 Jun 2019 17:53:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb7Qq-0001hB-Ik; Wed, 12 Jun 2019 14:53:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH v4 20/28] docs: pps.txt: convert to ReST and rename to pps.rst
Date:   Wed, 12 Jun 2019 14:52:56 -0300
Message-Id: <844bdcf3720d4b2e43ff6c16429583d1c0d61316.1560361364.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is already in a good shape: just its title and
adding some literal block markups is needed for it to be
part of the document.

While it has a small chapter with sysfs stuff, most of
the document is focused on driver development.

As it describes a kernel API, move it to the driver-api
directory.

In order to avoid conflicts, let's add an :orphan: tag
to it, to be removed when added to the driver-api book.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---
 .../{pps/pps.txt => driver-api/pps.rst}       | 67 ++++++++++---------
 MAINTAINERS                                   |  2 +-
 2 files changed, 36 insertions(+), 33 deletions(-)
 rename Documentation/{pps/pps.txt => driver-api/pps.rst} (89%)

diff --git a/Documentation/pps/pps.txt b/Documentation/driver-api/pps.rst
similarity index 89%
rename from Documentation/pps/pps.txt
rename to Documentation/driver-api/pps.rst
index 99f5d8c4c652..1456d2c32ebd 100644
--- a/Documentation/pps/pps.txt
+++ b/Documentation/driver-api/pps.rst
@@ -1,8 +1,10 @@
+:orphan:
 
-			PPS - Pulse Per Second
-			----------------------
+======================
+PPS - Pulse Per Second
+======================
 
-(C) Copyright 2007 Rodolfo Giometti <giometti@enneenne.com>
+Copyright (C) 2007 Rodolfo Giometti <giometti@enneenne.com>
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
@@ -88,7 +90,7 @@ Coding example
 --------------
 
 To register a PPS source into the kernel you should define a struct
-pps_source_info as follows:
+pps_source_info as follows::
 
     static struct pps_source_info pps_ktimer_info = {
 	    .name         = "ktimer",
@@ -101,12 +103,12 @@ pps_source_info as follows:
     };
 
 and then calling the function pps_register_source() in your
-initialization routine as follows:
+initialization routine as follows::
 
     source = pps_register_source(&pps_ktimer_info,
 			PPS_CAPTUREASSERT | PPS_OFFSETASSERT);
 
-The pps_register_source() prototype is:
+The pps_register_source() prototype is::
 
   int pps_register_source(struct pps_source_info *info, int default_params)
 
@@ -118,7 +120,7 @@ pps_source_info which describe the capabilities of the driver).
 
 Once you have registered a new PPS source into the system you can
 signal an assert event (for example in the interrupt handler routine)
-just using:
+just using::
 
     pps_event(source, &ts, PPS_CAPTUREASSERT, ptr)
 
@@ -134,13 +136,13 @@ Please see the file drivers/pps/clients/pps-ktimer.c for example code.
 SYSFS support
 -------------
 
-If the SYSFS filesystem is enabled in the kernel it provides a new class:
+If the SYSFS filesystem is enabled in the kernel it provides a new class::
 
    $ ls /sys/class/pps/
    pps0/  pps1/  pps2/
 
 Every directory is the ID of a PPS sources defined in the system and
-inside you find several files:
+inside you find several files::
 
    $ ls -F /sys/class/pps/pps0/
    assert     dev        mode       path       subsystem@
@@ -148,7 +150,7 @@ inside you find several files:
 
 
 Inside each "assert" and "clear" file you can find the timestamp and a
-sequence number:
+sequence number::
 
    $ cat /sys/class/pps/pps0/assert
    1170026870.983207967#8
@@ -175,11 +177,11 @@ and the userland tools available in your distribution's pps-tools package,
 http://linuxpps.org , or https://github.com/redlab-i/pps-tools.
 
 Once you have enabled the compilation of pps-ktimer just modprobe it (if
-not statically compiled):
+not statically compiled)::
 
    # modprobe pps-ktimer
 
-and the run ppstest as follow:
+and the run ppstest as follow::
 
    $ ./ppstest /dev/pps1
    trying PPS source "/dev/pps1"
@@ -204,26 +206,27 @@ nor affordable. The cheap way is to load a PPS generator on one of the
 computers (master) and PPS clients on others (slaves), and use very simple
 cables to deliver signals using parallel ports, for example.
 
-Parallel port cable pinout:
-pin	name	master      slave
-1	STROBE	  *------     *
-2	D0	  *     |     *
-3	D1	  *     |     *
-4	D2	  *     |     *
-5	D3	  *     |     *
-6	D4	  *     |     *
-7	D5	  *     |     *
-8	D6	  *     |     *
-9	D7	  *     |     *
-10	ACK	  *     ------*
-11	BUSY	  *           *
-12	PE	  *           *
-13	SEL	  *           *
-14	AUTOFD	  *           *
-15	ERROR	  *           *
-16	INIT	  *           *
-17	SELIN	  *           *
-18-25	GND	  *-----------*
+Parallel port cable pinout::
+
+	pin	name	master      slave
+	1	STROBE	  *------     *
+	2	D0	  *     |     *
+	3	D1	  *     |     *
+	4	D2	  *     |     *
+	5	D3	  *     |     *
+	6	D4	  *     |     *
+	7	D5	  *     |     *
+	8	D6	  *     |     *
+	9	D7	  *     |     *
+	10	ACK	  *     ------*
+	11	BUSY	  *           *
+	12	PE	  *           *
+	13	SEL	  *           *
+	14	AUTOFD	  *           *
+	15	ERROR	  *           *
+	16	INIT	  *           *
+	17	SELIN	  *           *
+	18-25	GND	  *-----------*
 
 Please note that parallel port interrupt occurs only on high->low transition,
 so it is used for PPS assert edge. PPS clear edge can be determined only
diff --git a/MAINTAINERS b/MAINTAINERS
index b3746e7b5652..5c5714eddde4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12709,7 +12709,7 @@ M:	Rodolfo Giometti <giometti@enneenne.com>
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
 L:	linuxpps@ml.enneenne.com (subscribers-only)
 S:	Maintained
-F:	Documentation/pps/
+F:	Documentation/driver-api/pps.rst
 F:	Documentation/devicetree/bindings/pps/pps-gpio.txt
 F:	Documentation/ABI/testing/sysfs-pps
 F:	drivers/pps/
-- 
2.21.0

