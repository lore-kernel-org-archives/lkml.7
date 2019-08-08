Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B11C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D0C2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565256314;
	bh=b1/XEb2Q708aFr6cmaQm262dAEP3TeBoP1EeklqSEFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kufXOTVMzSkh5x++yFcUNwkQQA9juqfcu6NHUCm2yoGsF1b4Rqx0BqnnOscy2ojwH
	 +vTwCPCkt1sQ9zW9ADbqM8vj5px8sDC/eTdzzoMFW3UP8tpydgqwDhfW/fcUQ53nbb
	 eXiGeqze77KH+vvFLi81eVn9P8wYGtaOF2vG+vlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbfHHJZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbfHHJZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:25:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4352B2173C;
        Thu,  8 Aug 2019 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565256311;
        bh=b1/XEb2Q708aFr6cmaQm262dAEP3TeBoP1EeklqSEFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKTQ+16T9fQpQx4DX/KDUlHi5MJl/Ko+FJcT4OCEhngsFj5sUftKDb+895SyJfFVK
         J0zr148nxRyknJpf/vhyiVcZ94E8XYOhM2UUJH5X/7G8hO6YdUwyC4Z6eOdcrEAsiW
         /+3kQf/4EN3q5y3DxG/eZWHabI2k1oYsFHZLm1pA=
Date:   Thu, 8 Aug 2019 11:25:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH] MAINTAINERS: mark wusbcore and UWB as obsolete
Message-ID: <20190808092509.GA20173@kroah.com>
References: <20190806101509.GA11280@kroah.com>
 <b73f09c944625a40b2589e9bac7f8bd22a711ed3.camel@perches.com>
 <20190806113501.GA18443@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806113501.GA18443@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe rightly points out that we should be using the "Obsolete" status for
these two subsystems.

Also I got the path name wrong for the wusbcore tree.

Reported-by: Joe Perches <joe@perches.com>
Fixes: 71ed79b0e4be ("USB: Move wusbcore and UWB to staging as it is obsolete")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index f4463fb48249..6f2d988fe7b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3801,8 +3801,8 @@ F:	scripts/extract-cert.c
 
 CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
 L:	devel@driverdev.osuosl.org
-S:	Orphan
-F:	drivers/staging/wbusbcore/
+S:	Obsolete
+F:	drivers/staging/wusbcore/
 
 CFAG12864B LCD DRIVER
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
@@ -16443,7 +16443,7 @@ F:	include/linux/ulpi/
 
 ULTRA-WIDEBAND (UWB) SUBSYSTEM:
 L:	devel@driverdev.osuosl.org
-S:	Orphan
+S:	Obsolete
 F:	drivers/staging/uwb/
 
 UNICODE SUBSYSTEM:
