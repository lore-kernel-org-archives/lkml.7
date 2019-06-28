Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A66C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9648E208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725083;
	bh=xmHCNjVoJevBrhW4x9IcFU/JFDWpNbudEbrzyF5jXXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J7NLt48XUtyDZNBqogMXntN6dYlaxeQ/6qddKux3DswVOyZw+qPRsh6jlJz+HyhNc
	 ys08+tgbatsbzi5fXPx6X/RBVWT2//AFl7j/wmDHdOf2SEIRzf5Es48yEHL+J6nicH
	 yf6YKf7UBOKd46mqOz+HEHPduL02KUALdmtWymdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfF1Mas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:30:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfF1Man (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e7PI9xcipbF07o8l7bOvfTR9teu/JtxbkDUbu2d3wzA=; b=ky2z+0udABzsP4et8Uaot7GiuW
        2Yotbf4DBoCpouCXHDKG2WipZYhqQD1MhrS/+Cbc4YL+VCbF8KDtldJXibnZHkvpIh3XyFkRUU7Ye
        HTt8ThFJN1QBmcZKGPVcqoy43iR09f2NNULlBM9I2jUksBA6rMvInjyftg/9Hhr8JhVRhAS48QQnI
        rYJD9KGmRNCMiyWW/t99iZ2SL7UXGwrU0wcpJzyRDqbBYpvmqfelcF5HHIrjkM8Tb7VM5whwMUT5R
        p+P9LeMW5MWg1kwJCl20kxZK2BDi+ZJ4FFF859YQl3rPxx5rvK3YUbDtfU8PPeKSBfWPiFtsKf10i
        hYclQnZw==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055a-Lt; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Sz-KA; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Justin Sanders <justin@coraid.com>
Subject: [PATCH 26/39] docs: aoe: add it to the driver-api book
Date:   Fri, 28 Jun 2019 09:30:19 -0300
Message-Id: <654ed60bf8a921e162b46c487c6c77cf76419918.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those files belong to the admin guide, so add them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/{ => admin-guide}/aoe/aoe.rst         | 4 ++--
 Documentation/{ => admin-guide}/aoe/autoload.sh     | 0
 Documentation/{ => admin-guide}/aoe/examples.rst    | 0
 Documentation/{ => admin-guide}/aoe/index.rst       | 2 --
 Documentation/{ => admin-guide}/aoe/status.sh       | 0
 Documentation/{ => admin-guide}/aoe/todo.rst        | 0
 Documentation/{ => admin-guide}/aoe/udev-install.sh | 0
 Documentation/{ => admin-guide}/aoe/udev.txt        | 2 +-
 Documentation/admin-guide/index.rst                 | 1 +
 MAINTAINERS                                         | 2 +-
 10 files changed, 5 insertions(+), 6 deletions(-)
 rename Documentation/{ => admin-guide}/aoe/aoe.rst (97%)
 rename Documentation/{ => admin-guide}/aoe/autoload.sh (100%)
 rename Documentation/{ => admin-guide}/aoe/examples.rst (100%)
 rename Documentation/{ => admin-guide}/aoe/index.rst (95%)
 rename Documentation/{ => admin-guide}/aoe/status.sh (100%)
 rename Documentation/{ => admin-guide}/aoe/todo.rst (100%)
 rename Documentation/{ => admin-guide}/aoe/udev-install.sh (100%)
 rename Documentation/{ => admin-guide}/aoe/udev.txt (93%)

diff --git a/Documentation/aoe/aoe.rst b/Documentation/admin-guide/aoe/aoe.rst
similarity index 97%
rename from Documentation/aoe/aoe.rst
rename to Documentation/admin-guide/aoe/aoe.rst
index 58747ecec71d..a05e751363a0 100644
--- a/Documentation/aoe/aoe.rst
+++ b/Documentation/admin-guide/aoe/aoe.rst
@@ -20,7 +20,7 @@ driver.  The aoetools are on sourceforge.
 
   http://aoetools.sourceforge.net/
 
-The scripts in this Documentation/aoe directory are intended to
+The scripts in this Documentation/admin-guide/aoe directory are intended to
 document the use of the driver and are not necessary if you install
 the aoetools.
 
@@ -86,7 +86,7 @@ Using sysfs
   a convenient way.  Users with aoetools should use the aoe-stat
   command::
 
-    root@makki root# sh Documentation/aoe/status.sh
+    root@makki root# sh Documentation/admin-guide/aoe/status.sh
        e10.0            eth3              up
        e10.1            eth3              up
        e10.2            eth3              up
diff --git a/Documentation/aoe/autoload.sh b/Documentation/admin-guide/aoe/autoload.sh
similarity index 100%
rename from Documentation/aoe/autoload.sh
rename to Documentation/admin-guide/aoe/autoload.sh
diff --git a/Documentation/aoe/examples.rst b/Documentation/admin-guide/aoe/examples.rst
similarity index 100%
rename from Documentation/aoe/examples.rst
rename to Documentation/admin-guide/aoe/examples.rst
diff --git a/Documentation/aoe/index.rst b/Documentation/admin-guide/aoe/index.rst
similarity index 95%
rename from Documentation/aoe/index.rst
rename to Documentation/admin-guide/aoe/index.rst
index 4394b9b7913c..d71c5df15922 100644
--- a/Documentation/aoe/index.rst
+++ b/Documentation/admin-guide/aoe/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =======================
 ATA over Ethernet (AoE)
 =======================
diff --git a/Documentation/aoe/status.sh b/Documentation/admin-guide/aoe/status.sh
similarity index 100%
rename from Documentation/aoe/status.sh
rename to Documentation/admin-guide/aoe/status.sh
diff --git a/Documentation/aoe/todo.rst b/Documentation/admin-guide/aoe/todo.rst
similarity index 100%
rename from Documentation/aoe/todo.rst
rename to Documentation/admin-guide/aoe/todo.rst
diff --git a/Documentation/aoe/udev-install.sh b/Documentation/admin-guide/aoe/udev-install.sh
similarity index 100%
rename from Documentation/aoe/udev-install.sh
rename to Documentation/admin-guide/aoe/udev-install.sh
diff --git a/Documentation/aoe/udev.txt b/Documentation/admin-guide/aoe/udev.txt
similarity index 93%
rename from Documentation/aoe/udev.txt
rename to Documentation/admin-guide/aoe/udev.txt
index 54feda5a0772..5fb756466bc7 100644
--- a/Documentation/aoe/udev.txt
+++ b/Documentation/admin-guide/aoe/udev.txt
@@ -11,7 +11,7 @@
 #   udev_rules="/etc/udev/rules.d/"
 #   bash# ls /etc/udev/rules.d/
 #   10-wacom.rules  50-udev.rules
-#   bash# cp /path/to/linux/Documentation/aoe/udev.txt \
+#   bash# cp /path/to/linux/Documentation/admin-guide/aoe/udev.txt \
 #           /etc/udev/rules.d/60-aoe.rules
 #  
 
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index c073af461cdf..be3b86db8171 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -82,6 +82,7 @@ configure specific aspects of kernel behavior to your liking.
    namespaces/index
    perf-security
    acpi/index
+   aoe/index
    device-mapper/index
    laptops/index
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 664e2a827544..2791b443ab8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2650,7 +2650,7 @@ ATA OVER ETHERNET (AOE) DRIVER
 M:	"Justin Sanders" <justin@coraid.com>
 W:	http://www.openaoe.org/
 S:	Supported
-F:	Documentation/aoe/
+F:	Documentation/admin-guide/aoe/
 F:	drivers/block/aoe/
 
 ATHEROS 71XX/9XXX GPIO DRIVER
-- 
2.21.0

