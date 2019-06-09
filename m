Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C87AC28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62E921851
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560047259;
	bh=CWYoaD127JcZzXbvw69YezS+qOt6XjXTcaqPRQgG5ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ux6Rsm1SKo32+HKB5jT0zm6H5yJD9sYYtaeDo6UJGpmaOwBDrLQRcaxX9FTAZrqj/
	 6DPfoQLPBd1PMEcu9KkFFwr3xVd2isk1xtYnFgcKqOcvqPoBFn1ZSlMYvy4CI1NCKw
	 eJIbkZ3AMtk12OjAVw2rfJ0HUyajBqB2b1cixKDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfFIC1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 22:27:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfFIC1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1i+/CwQvCFSSff2+OU8uan6/0iYzlORT2y09SfPy9RM=; b=GmdE597H7q53teUMVQ2HkbOqRc
        8dR49Qb4hVzwkzkB6n55GIcLVCaTk45+4uGAlTSFk/MabvPxqzi59sQSebYof9amo5vxVcr/e+zJi
        k+e1cXJTaagGWhXpksQXihWJXEN1OchYlnqZ2hWaiyDO6CooLqcKrzSoowTtzy3TCYPQDVsPuuKt0
        VHEeDpKAumDQmcYGzoo3bSMugoeGC4l4G6jg7n9jgd2k9mHlzZU12wwq2UXKXiy9a+GGTNQhp/T4R
        Y8FMzNo+Aa4vtmN3NzQ0Gk2316UjukLGAjuEQ86/pKWnTb2url+nhaUNcV7mXQhJ5z2G3uMAf+53y
        oa4Y5LHg==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYO-0001mz-2b; Sun, 09 Jun 2019 02:27:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYL-0000Jt-E0; Sat, 08 Jun 2019 23:27:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH v3 22/33] docs: pps.txt: convert to ReST and rename to pps.rst
Date:   Sat,  8 Jun 2019 23:27:12 -0300
Message-Id: <cb9274c1d5e94a74c5922c04d99b90554f2d804b.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
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
index 01d9120bb83b..b982622ea7ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12689,7 +12689,7 @@ M:	Rodolfo Giometti <giometti@enneenne.com>
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

