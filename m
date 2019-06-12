Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C517C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35FC20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364728;
	bh=aB0nY+c99dqXtnUDmL4YRPXa7WMw3p/ojX8SP0nUH08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j7T/FvI7oIoPvkVp8Qa158U8jI5MByj0l51hm2d+NafmE4QHfPNl0lHXSphmW1L6I
	 ucS+Ga3Wbqk5LGpHJRECEs17WWq4j5D6dwiwk8ulIg9jnr2tUJaGgWS0voSzgHTu5e
	 +H824igPaCju2cvHyCsSA+i6X3XgweiGvWbO/xuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfFLSiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:38:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfFLSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UD0e/rWQH1FDfqkDGh4F+mBTNbfEsEPXgPOEIL/lZpA=; b=pkxMOjCkVjDPkHU+JjjpR0tAO0
        2Mur5FPWtEF6Zs1/3yiRdDX7MnkUb+0roUjkJ32M68bI9/L1NhVKAc+u+HpycNZbIm0bApydacQEF
        1Ndg3yxTIjJSj6hZOft247vqS47QswUakN4YZfUGnNx/f1O7XsxkC/Jd4ZXrmbfRelsICOGqAahRg
        J41DzR56/z6ninwqfzcM35k1GO+rGbv7n3VozuAS0VeIDGCKs4WVyIEgYyR3TMmBRAO3wcvX0VCWN
        LgRkn6GxT+4xCQA3e76WsAIuYxxHM0FLeBuHZVarpk3t6U591eIN0hbm9AkPdNaxiwMngCcVVOmly
        +s1IKp3g==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YF-K2; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88p-0002AN-QU; Wed, 12 Jun 2019 15:38:35 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 02/31] docs: lcd-panel-cgram.txt: convert docs to ReST and rename to *.rst
Date:   Wed, 12 Jun 2019 15:38:05 -0300
Message-Id: <7020079dd54628f70b61f2529994da5ab558b123.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
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
index b0b674f5aaca..fa236f3f5979 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11932,7 +11932,7 @@ PARALLEL LCD/KEYPAD PANEL DRIVER
 M:	Willy Tarreau <willy@haproxy.com>
 M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
 S:	Odd Fixes
-F:	Documentation/auxdisplay/lcd-panel-cgram.txt
+F:	Documentation/auxdisplay/lcd-panel-cgram.rst
 F:	drivers/auxdisplay/panel.c
 
 PARALLEL PORT SUBSYSTEM
-- 
2.21.0

