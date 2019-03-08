Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DC6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A012085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfCHMpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:45:21 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59563 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCHMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:45:13 -0500
Received: from orion.localdomain ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPXta-1hNdLH19gA-00Mer2; Fri, 08 Mar 2019 13:44:57 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        info@metux.net, apw@canonical.com, joe@perches.com,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 5/5] debian: add generic rule file
Date:   Fri,  8 Mar 2019 13:44:24 +0100
Message-Id: <1552049064-32044-6-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552049064-32044-1-git-send-email-info@metux.net>
References: <1552049064-32044-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:R3JLL8sBMmKhfDQMbrg5EzF+7Ba57fKqfYnxGB+ha38n1r8aQuP
 mjTGpYJcbAnimrTFaSV9++tGRGm311DfVX9fpqDugRcdW+l9s4xKlt8TGgQn/3HyOOTCxVM
 DgvKhPQYM5Z27npVTAO5VInoD39RGEi3MG9bf6aa8THMG+9g1wbn77xO4aj/hej4E4SAI+1
 Sy4XpTQ7IQTEiBjGwDwAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I+ktiGOYKKo=:gjhIqya2r76CM/Wg5q9h6f
 AMuvikgwzHUnQjscoUhPA4Xc0WNAzDX0N+8QfXf5l5SApFeTS1osB0KYqQUEJ0cP9nd7CEeTe
 xr14jebppnTBNGXVr6nmiXAHVZ/FsG5kXdpdgInl8ssgUwn1Wsyqm7/OMqjWo02kgvgZusPpg
 hebaX40g0uxRpmj5DTKBJmV/VS1ubFFcXGe/zB8BP1W3hQF61sx02pAu4FLnnmfWuZd4KSP4f
 vbYl9w0u/mS7H/i8aJT0t1Bw1zx9i3WDfDqTcIn1FlhCgpYDXJYJ37bbtmBtNPTBHgm3Pszre
 ISa3kvQ3QuczDjzoFiKqsvtcSl31A5uzsYS3nMZjkAaKdazua401uKq5+uM63GnKKNhqokuJ8
 X0maH/NxDxcMs7vWL2MGeZ1Fd+z7iyjr0R7lrJHN+M0/He3RLvV+Ka9QX/RIt4CRaZq5JMq/I
 8ZTZ+E7L0kmLbew9j4MR0B9GkzS+tshF/4hpk2kmQP2o9qsetKHkskOel9/k2kcyjQeDTAlVa
 BP1bHnUEW61q+SVWa0b7U9tt+GZGEpp+LjRXChcWLfzJPMaZuimpq0Q+jFPiJDSonTua5JhLf
 LKOqvJEDWlEjbDVVNvvV0jF8QpDE9QQbrOe5crqrsDeDJkifqKuN7meByPwx0ZJ9Oe+gqqi/9
 0HCbeZGO7v2iM/Lb2Yzdaa1c/Iav4Ay8+3dSfCPYqBRna3LS8rCe1rEVvi8KCqxGt1+GnZrAu
 O8+MqJDSH9GtXQVAIP5Xfrhd/K3wON+NmvRL1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a generic debian rule file, so we can build the directly
via usual Debian package build tools (eg. git-buildpackage,
dck-buildpackage, etc). It expects the .config file already
placed in the source tree.

The rule file contains a rule for creating debian/control and
other metadata - this is done similar to the 'deb-pkg' make rule,
scripts/packaging/mkdebian.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 .gitignore   |  1 +
 MAINTAINERS  |  6 ++++++
 debian/rules | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100755 debian/rules

diff --git a/.gitignore b/.gitignore
index a20ac26..2d8081f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -68,6 +68,7 @@ modules.builtin
 # Debian directory (make deb-pkg)
 #
 /debian/
+!/debian/rules
 
 #
 # Snap directory (make snap-pkg)
diff --git a/MAINTAINERS b/MAINTAINERS
index 09d47cd..1edc169 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4363,6 +4363,12 @@ F:	include/uapi/linux/dccp.h
 F:	include/linux/tfrc.h
 F:	net/dccp/
 
+DEBIAN PACKAGING FILES
+M:	Enrico Weigelt <info@metux.net>
+L:	linux-kbuild@vger.kernel.org
+S:	Maintained
+F:	debian/
+
 DECnet NETWORK LAYER
 W:	http://linux-decnet.sourceforge.net
 L:	linux-decnet-user@lists.sourceforge.net
diff --git a/debian/rules b/debian/rules
new file mode 100755
index 0000000..c2f0319
--- /dev/null
+++ b/debian/rules
@@ -0,0 +1,27 @@
+#!/usr/bin/make -f
+# SPDX-License-Identifier: GPL-2.0
+
+export MAKE
+export KERNELARCH           = $(shell $(MAKE) kernelarch)
+export KERNELRELEASE        = $(shell $(MAKE) kernelrelease)
+export KBUILD_DEBARCH       = $(shell dpkg-architecture -qDEB_HOST_ARCH)
+export KBUILD_BUILD_VERSION = $(shell $(MAKE) kernellocalversion)
+export KDEB_RULES           = debian/rules.auto
+export KDEB_SOURCENAME      = linux-source
+export ARCH                 = $(KERNELARCH)
+
+debian/control debian/changelong debian/arch debian/copyright:
+debian/control:
+	./scripts/package/mkdebian
+
+build:	debian/control
+	$(MAKE) KERNELRELEASE=$(KERNELRELEASE) ARCH=$(KERNELARCH) KBUILD_BUILD_VERSION=$(KBUILD_BUILD_VERSION) KBUILD_SRC=
+
+binary-arch:	debian/control
+	$(MAKE) KERNELRELEASE=$(KERNELRELEASE) ARCH=$(KERNELARCH) KBUILD_BUILD_VERSION=$(KBUILD_BUILD_VERSION) KBUILD_SRC= intdeb-pkg
+
+clean:
+	rm -rf debian/*tmp debian/files debian/changelog debian/control debian/copyright debian/rules.auto debian/arch
+	$(MAKE) clean
+
+binary: binary-arch
-- 
1.9.1

