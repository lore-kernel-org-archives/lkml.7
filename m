Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F57DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0688220674
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfKOPCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:02:23 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:35435 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfKOPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:02:22 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id CFC313C04C0;
        Fri, 15 Nov 2019 16:02:20 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5kG3EegiE-Xl; Fri, 15 Nov 2019 16:02:12 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 7D4F23C009C;
        Fri, 15 Nov 2019 16:02:12 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 15 Nov
 2019 16:02:12 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
CC:     <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] checkpatch: whitelist Originally-by: signature
Date:   Fri, 15 Nov 2019 16:02:02 +0100
Message-ID: <20191115150202.15208-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oftentimes [1], the contributor would like to honor or give credits [2]
to somebody's original ideas in the submission/reviewing process. While
"Co-developed-by:" and "Suggested-by:" (currently whitelisted) could be
employed for this purpose, they are not ideal.

Below matrix attempts portraying/quantifying the subtle differences
between these signatures (subjective/oversimplified):

Helper signature    Contribution "ownership"
None                100% Author
Suggested-by: X     80% Author / 20% "X"
Co-developed-by: X  50% Author / 50% "X"
Originally-by: X    20% Author / 80% "X"

[1] linux (v5.4-rc7) git log --oneline --grep Originally-by | wc -l
    88
[2] https://lore.kernel.org/lkml/alpine.DEB.2.21.1909261144250.5528@nanos.tec.linutronix.de/

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6fcc66afb088..e456aba12bd0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -486,6 +486,7 @@ our $signature_tags = qr{(?xi:
 	Reviewed-by:|
 	Reported-by:|
 	Suggested-by:|
+	Originally-by:|
 	To:|
 	Cc:
 )};
-- 
2.24.0

