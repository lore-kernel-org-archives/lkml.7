Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBCFC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEB320449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698814;
	bh=cmNAe10OMzs6JGNZcPGkXX8wwksmlkfKgRVjz5S6rdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IcFmanqRRfrPIXLK/SqoQjFQAXGIjA8703J/mD69vkKlynMmrKO9nvGvFOywEQhjE
	 D/9mpHB9CRsszm/5GUWFKt2WKimyaIoayk+aVfGelJi6dVBhEkdxFB7AqKS6zeQqbk
	 jKAMbnAziBWACTalaxM0W4YciGoEDVqLAauSyx5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfDSSdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727752AbfDSS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Received: from quaco.ghostprotocols.net (unknown [177.102.80.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510D62192D;
        Fri, 19 Apr 2019 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555677048;
        bh=cmNAe10OMzs6JGNZcPGkXX8wwksmlkfKgRVjz5S6rdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w91eJWs0envwGOr4oHcW4LfrFmqrBYZE5RsfI9SjjRfpwqrzgSpQGr4Vj7eFnGOms
         WqP7SIYjkNMxdIsv+q5wjtIb2hXZYPIRGz0xw9hpL5ujDl48iexFfX1XJg3OM+chNg
         dJyyHzzLXVVmh6oS2S0bhoRda3CtNKvTDyYEvLNg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Mentz <danielmentz@google.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] tools include uapi: Sync sound/asound.h copy
Date:   Fri, 19 Apr 2019 09:30:24 -0300
Message-Id: <20190419123029.11328-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Picking the changes from:

  Fixes: b5bdbb6ccd11 ("ALSA: uapi: #include <time.h> in asound.h")

Which entails no changes in the tooling side.

To silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
  diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Link: https://lkml.kernel.org/n/tip-15o4twfkbn6nny9aus90dyzx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/sound/asound.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index 404d4b9ffe76..df1153cea0b7 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -32,6 +32,7 @@
 
 #ifndef __KERNEL__
 #include <stdlib.h>
+#include <time.h>
 #endif
 
 /*
-- 
2.20.1

