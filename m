Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEXHASH_WORD,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D92C4646C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA866206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561127348;
	bh=pt8FQv7DPEJSU4vP1iF3ohoU5VbTxPVOBkxDJVNx2vE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Sp+1okgWtRLAk90wuS0EeLdmArZLfzpNhMG6wZ7DCGT7fQmnme3YnCLyfOy04rO0p
	 tyZy0kBSczmX1DisbyKpuxwdoYNcVdWnoYMooNRRECFFqY6vwqPpLmGfxLEAoY3OvQ
	 eXSi8illihAgG7UAFZTJot9kfR08EZfCP5Rp3hS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfFUO3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:29:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37347 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:29:06 -0400
Received: by mail-io1-f68.google.com with SMTP id e5so154802iok.4;
        Fri, 21 Jun 2019 07:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xu4kJhzJhrvstLOg2ov8ZfyYNtd4Cw2zWy/Us8B8Izk=;
        b=ZD+V6OcrCK77cB4293ufvgVXBBOvfbPvfXxBsxTdLW0w2bUtckm/AUcqDS98F9bzME
         l+9zbddGYwu3HTctMvwFs7AQvX45fg2avQh2FNVJUJ95Yh5+SkFS3o583x8EWsRp7AYj
         NSDtCSAsBc1ti988QGUNVGukXpFaJWs9zYavrOgOvK7zZAFs4wJWj0hA16OZmlhSVngC
         8FGw8x3qKF+7zQfj/IoEO2thATsiuarNYF7zzudonxkQSbkE2mExzyYvdsAhc3Xpc6/g
         JSDuey78avj0b1AZLzBroMCEffCT127TVYC9PA7kt2hVW4CcEEwAu6G9wpbrbVBtOrvd
         ffeg==
X-Gm-Message-State: APjAAAW25SrmFmczyhmkCMqQzwk5dmyZvlanpo97gOE7LCeKOaaQKAG7
        a9k04Ou1cP3VB77nNO6Sj9cIdNc=
X-Google-Smtp-Source: APXvYqznx8R9PgZ5In1WgjG912EwWNKVKenTMEOZc1kl5NngYIl/Wnt3FiuJmWZq1BCQ3PSyNHOLlA==
X-Received: by 2002:a02:cb96:: with SMTP id u22mr8302738jap.118.1561127342881;
        Fri, 21 Jun 2019 07:29:02 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.244])
        by smtp.googlemail.com with ESMTPSA id t22sm2596463ioc.75.2019.06.21.07.29.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 07:29:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] scripts/dtc: Update to upstream version v1.5.0-30-g702c1b6c0e73
Date:   Fri, 21 Jun 2019 08:29:00 -0600
Message-Id: <20190621142900.31988-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull in SPDX tag conversion from upstream dtc. This will replace the
conversion done in the kernel tree copy in v5.2-rc2.

This adds the following commits from upstream:

702c1b6c0e73 README.license: Update to reflect SPDX tag usage
4097bbffcf1d dtc: Add GPLv2 SPDX tags to files missing license text
94f87cd5b7c5 libfdt: Add dual GPL/BSD SPDX tags to files missing license text
c4ffc05574b1 tests: Replace license boilerplate with SPDX tags
a5ac29baacd2 pylibfdt: Replace dual GPLv2/BSD license boilerplate with SPDX tags
7fb0f4db2eb7 libfdt: Replace GPL/BSD boilerplate/reference with SPDX tags
acfe84f2c47e dtc: Replace GPLv2 boilerplate/reference with SPDX tags

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/Makefile.dtc             |  1 +
 scripts/dtc/checks.c                 | 17 +---------
 scripts/dtc/data.c                   | 17 +---------
 scripts/dtc/dtc-lexer.l              | 17 +---------
 scripts/dtc/dtc-parser.y             | 17 +---------
 scripts/dtc/dtc.c                    | 17 +---------
 scripts/dtc/dtc.h                    | 17 +---------
 scripts/dtc/flattree.c               | 17 +---------
 scripts/dtc/fstree.c                 | 17 +---------
 scripts/dtc/libfdt/Makefile.libfdt   |  1 +
 scripts/dtc/libfdt/fdt.c             | 47 +---------------------------
 scripts/dtc/libfdt/fdt.h             | 47 +---------------------------
 scripts/dtc/libfdt/fdt_addresses.c   | 47 +---------------------------
 scripts/dtc/libfdt/fdt_empty_tree.c  | 47 +---------------------------
 scripts/dtc/libfdt/fdt_overlay.c     | 47 +---------------------------
 scripts/dtc/libfdt/fdt_ro.c          | 47 +---------------------------
 scripts/dtc/libfdt/fdt_rw.c          | 47 +---------------------------
 scripts/dtc/libfdt/fdt_strerror.c    | 46 +--------------------------
 scripts/dtc/libfdt/fdt_sw.c          | 47 +---------------------------
 scripts/dtc/libfdt/fdt_wip.c         | 47 +---------------------------
 scripts/dtc/libfdt/libfdt.h          | 47 +---------------------------
 scripts/dtc/libfdt/libfdt_env.h      | 47 +---------------------------
 scripts/dtc/libfdt/libfdt_internal.h | 47 +---------------------------
 scripts/dtc/livetree.c               | 17 +---------
 scripts/dtc/srcpos.c                 | 16 +---------
 scripts/dtc/srcpos.h                 | 16 +---------
 scripts/dtc/treesource.c             | 17 +---------
 scripts/dtc/util.c                   | 16 +---------
 scripts/dtc/util.h                   | 16 +---------
 scripts/dtc/version_gen.h            |  2 +-
 scripts/dtc/yamltree.c               | 16 +---------
 31 files changed, 31 insertions(+), 833 deletions(-)

diff --git a/scripts/dtc/Makefile.dtc b/scripts/dtc/Makefile.dtc
index d4375630a7f7..9c467b096f03 100644
--- a/scripts/dtc/Makefile.dtc
+++ b/scripts/dtc/Makefile.dtc
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Makefile.dtc
 #
 # This is not a complete Makefile of itself.  Instead, it is designed to
diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 4719d658432b..d7986ee18012 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2007.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
diff --git a/scripts/dtc/data.c b/scripts/dtc/data.c
index 4a204145cc7b..0a43b6de3264 100644
--- a/scripts/dtc/data.c
+++ b/scripts/dtc/data.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
index 06c040902444..5c6c3fd557d7 100644
--- a/scripts/dtc/dtc-lexer.l
+++ b/scripts/dtc/dtc-lexer.l
@@ -1,21 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 %option noyywrap nounput noinput never-interactive
diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
index 2ec981e86111..2ed4dc1f07fd 100644
--- a/scripts/dtc/dtc-parser.y
+++ b/scripts/dtc/dtc-parser.y
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 %{
 #include <stdio.h>
diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
index 695e1f789fc7..bdb3f5945699 100644
--- a/scripts/dtc/dtc.c
+++ b/scripts/dtc/dtc.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include <sys/stat.h>
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 0d5fa215ac87..6e74ecea55a3 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -1,24 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef DTC_H
 #define DTC_H
 
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include <stdio.h>
diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
index f7f70769d73f..bd6977eedcb8 100644
--- a/scripts/dtc/flattree.c
+++ b/scripts/dtc/flattree.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
diff --git a/scripts/dtc/fstree.c b/scripts/dtc/fstree.c
index 1e7eeba47ff6..9871689b4afb 100644
--- a/scripts/dtc/fstree.c
+++ b/scripts/dtc/fstree.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
diff --git a/scripts/dtc/libfdt/Makefile.libfdt b/scripts/dtc/libfdt/Makefile.libfdt
index 193da8c99d83..e54639738c8e 100644
--- a/scripts/dtc/libfdt/Makefile.libfdt
+++ b/scripts/dtc/libfdt/Makefile.libfdt
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 # Makefile.libfdt
 #
 # This is not a complete Makefile of itself.  Instead, it is designed to
diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
index ae03b1112961..179168ec63e9 100644
--- a/scripts/dtc/libfdt/fdt.c
+++ b/scripts/dtc/libfdt/fdt.c
@@ -1,52 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "libfdt_env.h"
 
diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
index 74961f9026d1..f2e68807f277 100644
--- a/scripts/dtc/libfdt/fdt.h
+++ b/scripts/dtc/libfdt/fdt.h
@@ -1,55 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
 #ifndef FDT_H
 #define FDT_H
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
  * Copyright 2012 Kim Phillips, Freescale Semiconductor.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #ifndef __ASSEMBLY__
diff --git a/scripts/dtc/libfdt/fdt_addresses.c b/scripts/dtc/libfdt/fdt_addresses.c
index 2cc997ea5012..d8ba8ec60c6c 100644
--- a/scripts/dtc/libfdt/fdt_addresses.c
+++ b/scripts/dtc/libfdt/fdt_addresses.c
@@ -1,53 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2014 David Gibson <david@gibson.dropbear.id.au>
  * Copyright (C) 2018 embedded brains GmbH
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "libfdt_env.h"
 
diff --git a/scripts/dtc/libfdt/fdt_empty_tree.c b/scripts/dtc/libfdt/fdt_empty_tree.c
index f2ae9b77c285..49d54d44b8e7 100644
--- a/scripts/dtc/libfdt/fdt_empty_tree.c
+++ b/scripts/dtc/libfdt/fdt_empty_tree.c
@@ -1,52 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2012 David Gibson, IBM Corporation.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "libfdt_env.h"
 
diff --git a/scripts/dtc/libfdt/fdt_overlay.c b/scripts/dtc/libfdt/fdt_overlay.c
index d3e9ab2dbb7b..e97f12b1a780 100644
--- a/scripts/dtc/libfdt/fdt_overlay.c
+++ b/scripts/dtc/libfdt/fdt_overlay.c
@@ -1,53 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2016 Free Electrons
  * Copyright (C) 2016 NextThing Co.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "libfdt_env.h"
 
diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index 2c393a100bfc..6fd9ec170dbe 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -1,52 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "libfdt_env.h"
 
diff --git a/scripts/dtc/libfdt/fdt_rw.c b/scripts/dtc/libfdt/fdt_rw.c
index 9e7661509e9f..8795947c00dd 100644
--- a/scripts/dtc/libfdt/fdt_rw.c
+++ b/scripts/dtc/libfdt/fdt_rw.c
@@ -1,52 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "libfdt_env.h"
 
diff --git a/scripts/dtc/libfdt/fdt_strerror.c b/scripts/dtc/libfdt/fdt_strerror.c
index 0e6b4fd5e7ce..768db66eada5 100644
--- a/scripts/dtc/libfdt/fdt_strerror.c
+++ b/scripts/dtc/libfdt/fdt_strerror.c
@@ -1,51 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "libfdt_env.h"
diff --git a/scripts/dtc/libfdt/fdt_sw.c b/scripts/dtc/libfdt/fdt_sw.c
index e773157d0fc4..76bea22f734f 100644
--- a/scripts/dtc/libfdt/fdt_sw.c
+++ b/scripts/dtc/libfdt/fdt_sw.c
@@ -1,52 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "libfdt_env.h"
 
diff --git a/scripts/dtc/libfdt/fdt_wip.c b/scripts/dtc/libfdt/fdt_wip.c
index 534c1cbbb2f3..f64139e0b3dc 100644
--- a/scripts/dtc/libfdt/fdt_wip.c
+++ b/scripts/dtc/libfdt/fdt_wip.c
@@ -1,52 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "libfdt_env.h"
 
diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index be14bf63e577..7b5ffd13a887 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -1,54 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
 #ifndef LIBFDT_H
 #define LIBFDT_H
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #include "libfdt_env.h"
diff --git a/scripts/dtc/libfdt/libfdt_env.h b/scripts/dtc/libfdt/libfdt_env.h
index 4d1cdfa58547..73b6d40450ac 100644
--- a/scripts/dtc/libfdt/libfdt_env.h
+++ b/scripts/dtc/libfdt/libfdt_env.h
@@ -1,55 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
 #ifndef LIBFDT_ENV_H
 #define LIBFDT_ENV_H
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
  * Copyright 2012 Kim Phillips, Freescale Semiconductor.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #include <stdbool.h>
diff --git a/scripts/dtc/libfdt/libfdt_internal.h b/scripts/dtc/libfdt/libfdt_internal.h
index 4109f890ae60..7830e550c37a 100644
--- a/scripts/dtc/libfdt/libfdt_internal.h
+++ b/scripts/dtc/libfdt/libfdt_internal.h
@@ -1,54 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
 #ifndef LIBFDT_INTERNAL_H
 #define LIBFDT_INTERNAL_H
 /*
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
- *
- * libfdt is dual licensed: you can use it either under the terms of
- * the GPL, or the BSD license, at your option.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Alternatively,
- *
- *  b) Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *     1. Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *     2. Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include <fdt.h>
 
diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
index 21c274125c2c..0c039993953a 100644
--- a/scripts/dtc/livetree.c
+++ b/scripts/dtc/livetree.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
diff --git a/scripts/dtc/srcpos.c b/scripts/dtc/srcpos.c
index 41f83700ee91..f5205fb9c1ff 100644
--- a/scripts/dtc/srcpos.c
+++ b/scripts/dtc/srcpos.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #define _GNU_SOURCE
diff --git a/scripts/dtc/srcpos.h b/scripts/dtc/srcpos.h
index 6326a952c40e..4318d7ad34d9 100644
--- a/scripts/dtc/srcpos.h
+++ b/scripts/dtc/srcpos.h
@@ -1,20 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #ifndef SRCPOS_H
diff --git a/scripts/dtc/treesource.c b/scripts/dtc/treesource.c
index 1af36628b75f..c9d980c8abfc 100644
--- a/scripts/dtc/treesource.c
+++ b/scripts/dtc/treesource.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
diff --git a/scripts/dtc/util.c b/scripts/dtc/util.c
index 9c6fb5f286ae..48af961dcc8c 100644
--- a/scripts/dtc/util.c
+++ b/scripts/dtc/util.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2011 The Chromium Authors, All Rights Reserved.
  * Copyright 2008 Jon Loeliger, Freescale Semiconductor, Inc.
  *
  * util_is_printable_string contributed by
  *	Pantelis Antoniou <pantelis.antoniou AT gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include <ctype.h>
diff --git a/scripts/dtc/util.h b/scripts/dtc/util.h
index fc3c0d05ada3..ca5cb52928e3 100644
--- a/scripts/dtc/util.h
+++ b/scripts/dtc/util.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef UTIL_H
 #define UTIL_H
 
@@ -8,21 +9,6 @@
 /*
  * Copyright 2011 The Chromium Authors, All Rights Reserved.
  * Copyright 2008 Jon Loeliger, Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #ifdef __GNUC__
diff --git a/scripts/dtc/version_gen.h b/scripts/dtc/version_gen.h
index 2111a6e351f9..f2761e24cf40 100644
--- a/scripts/dtc/version_gen.h
+++ b/scripts/dtc/version_gen.h
@@ -1 +1 @@
-#define DTC_VERSION "DTC 1.5.0-g87963ee2"
+#define DTC_VERSION "DTC 1.5.0-g702c1b6c"
diff --git a/scripts/dtc/yamltree.c b/scripts/dtc/yamltree.c
index a00285a5a9ec..5b6ea8ea862f 100644
--- a/scripts/dtc/yamltree.c
+++ b/scripts/dtc/yamltree.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright Linaro, Ltd. 2018
  * (C) Copyright Arm Holdings.  2017
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include <stdlib.h>
-- 
2.20.1

