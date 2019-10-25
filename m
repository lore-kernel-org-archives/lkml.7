Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A24CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7163E205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfJYR4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:56:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:10973 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbfJYRz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:55:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 10:55:53 -0700
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="201881012"
Received: from dsp-dsk1.jf.intel.com ([10.54.70.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Oct 2019 10:55:53 -0700
From:   D Scott Phillips <d.scott.phillips@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        stuart hayes <stuart.w.hayes@gmail.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Date:   Fri, 25 Oct 2019 10:55:53 -0700
Message-Id: <20191025175553.63271-1-d.scott.phillips@intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow ndctl.h to be licensed with BSD-2-Clause so that other
operating systems can provide the same user level interface.
---

I've been working on nvdimm support in FreeBSD and would like to
offer the same ndctl API there to ease porting of application
code. Here I'm proposing to add the BSD-2-Clause license to this
header file, so that it can later be copied into FreeBSD.

I believe that all the authors of changes to this file (in the To:
list) would need to agree to this change before it could be
accepted, so any signed-off-by is intentionally ommited for now.
Thanks,

Scott

 include/uapi/linux/ndctl.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index de5d90212409..dd9718bc9401 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((LGPL-2.1 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
  * Copyright (c) 2014-2016, Intel Corporation.
  *
@@ -9,6 +10,32 @@
  * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
  * more details.
+ *
+ * This -- and only this -- header file may also be distributed under
+ * the terms of the BSD Licence as follows:
+ *
+ * Copyright (C) 2014-2016, Intel Corporation.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
  */
 #ifndef __NDCTL_H__
 #define __NDCTL_H__
-- 
2.23.0

