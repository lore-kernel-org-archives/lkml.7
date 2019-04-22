Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC9CC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAA921901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555939725;
	bh=KAc5ubX1O9poASCyTPw/gDBZKmkGE8x6iZ4bu8w0dog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w5bXHQeoU6aSFavMurPHzwmD/gT+KIsEFPy4LaZKxmlA1G5SFSSWqPbTeq7jchkdB
	 8Jg9CVcxsRTbwoYMBr9kKP/z1oFRXWKbgmcojLD3bOvdbDCp2ZSznZ5BmYzKGnGVRa
	 qnTPZN5MPPth4rr2zZAPfNds9wA9CS/z9VpVKDQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfDVN2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:28:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfDVN2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1dDWA920E0jHK8Xl4rWxMIjw2QMlLRUOZpuMfOc4ziA=; b=Xmn07UOAOBR84joMegImpWhxq1
        KbgLEktiWog1igY9hrnHSzd39dScvhFRVFzeaowOgzKapvVKE+IQ1PmWMg95QtHa0V7uveepiTt6R
        8uB/VYeMUW6BQd42j/6x7J3xCR3WtRM1s6FYGEfQhvy1ZMqdNsWd6y45eUAfgbuUiHcBQFPMXySmQ
        0itMbi4feK2/0dVLK6dJB5Juw6RXlkWG1T4GqWrbQO3Q9LrmAiOG79wfgg3jixF3eovVvdhi78Vdm
        AeDVckw25jWoiouHQ+Gcl+AiWGmyRMO/iIEbh6eRMKquqR9Tx/K2sX/BV5WIXmDut5x5+i3Yzw3fm
        MjN38wbw==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzc-0005HS-Te; Mon, 22 Apr 2019 13:28:20 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzT-0005mm-Fv; Mon, 22 Apr 2019 10:28:11 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 41/79] docs: lcd-panel-cgram.txt: convert docs to ReST and rename to *.rst
Date:   Mon, 22 Apr 2019 10:27:30 -0300
Message-Id: <673c4a648a98823080b13e4677bb9a6ddd5551d2.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small text file describes the usage of parallel port LCD
displays from userspace PoV. So, a good candidate for the
admin guide.

While this is not part of the admin-guide book, mark it as
:orphan:, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{lcd-panel-cgram.txt => lcd-panel-cgram.rst}         | 9 +++++++--
 MAINTAINERS                                              | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)
 rename Documentation/auxdisplay/{lcd-panel-cgram.txt => lcd-panel-cgram.rst} (88%)

diff --git a/Documentation/auxdisplay/lcd-panel-cgram.txt b/Documentation/auxdisplay/lcd-panel-cgram.rst
similarity index 88%
rename from Documentation/auxdisplay/lcd-panel-cgram.txt
rename to Documentation/auxdisplay/lcd-panel-cgram.rst
index 7f82c905763d..dfef50286018 100644
--- a/Documentation/auxdisplay/lcd-panel-cgram.txt
+++ b/Documentation/auxdisplay/lcd-panel-cgram.rst
@@ -1,3 +1,9 @@
+:orphan:
+
+======================================
+Parallel port LCD/Keypad Panel support
+======================================
+
 Some LCDs allow you to define up to 8 characters, mapped to ASCII
 characters 0 to 7. The escape code to define a new character is
 '\e[LG' followed by one digit from 0 to 7, representing the character
@@ -7,7 +13,7 @@ illuminated pixel with LSB on the right. Lines are numbered from the
 top of the character to the bottom. On a 5x7 matrix, only the 5 lower
 bits of the 7 first bytes are used for each character. If the string
 is incomplete, only complete lines will be redefined. Here are some
-examples :
+examples::
 
   printf "\e[LG0010101050D1F0C04;"  => 0 = [enter]
   printf "\e[LG1040E1F0000000000;"  => 1 = [up]
@@ -21,4 +27,3 @@ examples :
   printf "\e[LG00002061E1E060200;"  => small speaker
 
 Willy
-
diff --git a/MAINTAINERS b/MAINTAINERS
index 24c52307361f..c40b6a876f2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11773,7 +11773,7 @@ PARALLEL LCD/KEYPAD PANEL DRIVER
 M:	Willy Tarreau <willy@haproxy.com>
 M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
 S:	Odd Fixes
-F:	Documentation/auxdisplay/lcd-panel-cgram.txt
+F:	Documentation/auxdisplay/lcd-panel-cgram.rst
 F:	drivers/auxdisplay/panel.c
 
 PARALLEL PORT SUBSYSTEM
-- 
2.20.1

