Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F25BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C8320650
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbfIJJUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:20:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfIJJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:20:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MSKq6-1hjJ4T3Ojw-00SbPA; Tue, 10 Sep 2019 11:20:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] objdump: restore quiet build output
Date:   Tue, 10 Sep 2019 11:20:24 +0200
Message-Id: <20190910092031.2897823-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kvlPWdIu+LuyrXPRkKyMxErLVgDRXe6HknkxoxEedEF9LHNIXpD
 oiYvHe1/OXFbz/YmXmAWUeg6tfWGDw+1g0vTlktk9OAJ7tmiGeGQdP4wgVOs9gUd7msiLND
 7kjg9IfyXHDeWroUM2+Fb5zcgnDBq2iejsc6TE83e8jL21bXsmbYXz5Qq3o1pjSSGSjffOp
 gu/D5RxBF7r51M6R2kSHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uVq5xvgeT8I=:/NvUsnpWc8oKalgj04kIiB
 IcoUBrzU6REMSY+vCpyfM7ujPntsQe7IOPFtLE6pBzhmM7jr5xommhD/j4ewk/pjIC1enZXYd
 YqxMbSlO+Hv2YFXbsQxZwcA1hB/pMiQe8CiXwB/rKoDA19ieCupfGDDcNs8DkjDn3tscHIvHT
 /7j4/ckskcaP8CeYGwkAfr4xcmK6QY1JPXrb20t1F3JDi3ayFbytuyakxtn8fiqTEYuK6Aojl
 T91XPe0TsnkPY2t73gecb8zDlJMf0I+1mP1+PcEMElkHurC2t59RGlEzNZ+0rAIXoL1T7KBPd
 /DOY0UNshIBuByGMt1lp0rmeWs6qdQX4JlMJCk6ZeNR4x17oqJgnMK+laWXA0xaAZepZBv6I7
 rZR9SmNfciTkCdOxKaCmaTMspMRoSWdPjMDlUXuYq8arWcBLxF76u6EJ5oD7OD9jnQ3cicE+4
 iuiCKdxH3Z24o4+EfEZAD3LeT7ghi897C9XZZJSs3Ezlh95K78kPNpCiGhcLDSl5xyx4/Bv2d
 oa1p+6T7sOIQu8gZzisgRDhPvoz1qHvjteBGJ6WmwXCiYTnrQMspwLIFtB3gJ39XI5Khn9aH9
 Ab/uoyuj/C4LIKTu5R4mGsfMTEOspB+WFpf7bgEIKIVXIbKKuMVrszGej8YKIzj+ziRwqYXm9
 iRl4L49TF+zK83eKOEpiG7HHQr1gpi32E3qS7ZoUITOyCvvDTynDRExte+Kz1s5nTIirq76EC
 yaKFgpCrwhJhNWUTt7HPGOP+uxbDR2yinBztTjVx47a0z3/Bxjhx/4i+kSwOLdzNeQV3kZ9Wh
 prSutG0lDQdT/soNPfhQ2asbdAP/BnROyURBZDsVWps0n8N9g0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a recent sync-check.sh update, a 'make -s' build prints a
single line of output from the 'cd -' command:

    /git/linux/tools/objtool

This is clearly unintended, so revert back to a completely quiet
build by redirecting the cd output to /dev/null.

Fixes: 2ffd84ae973b ("objtool: Update sync-check.sh from perf's check-headers.sh")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 tools/objtool/sync-check.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 0a832e265a50..94b8d76c2851 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -48,4 +48,4 @@ check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
 check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
 check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]"'
 
-cd -
+cd - > /dev/null
-- 
2.20.0

