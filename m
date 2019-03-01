Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D61C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFD02087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfCAKxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:53:20 -0500
Received: from smtp.asem.it ([151.1.184.197]:57076 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCAKxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:53:19 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003725273.MSG 
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:53:15 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Fri, 1
 Mar 2019 11:53:13 +0100
Received: from flavio-x.asem.intra (172.16.17.161) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Fri, 1 Mar 2019 11:53:13 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] doc: acpi: fix path for acpidbg tool
Date:   Fri, 1 Mar 2019 11:53:11 +0100
Message-ID: <1551437591-11022-1-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: hardfail smtp.helo=webmail.asem.it (does not match 172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0214.5C790F1A.0057,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file:

Documentation/acpi/aml-debugger.txt

reports an obsolete path for the acpidbg tool.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 Documentation/acpi/aml-debugger.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/acpi/aml-debugger.txt b/Documentation/acpi/aml-debugger.txt
index e851cc5..75ebeb6 100644
--- a/Documentation/acpi/aml-debugger.txt
+++ b/Documentation/acpi/aml-debugger.txt
@@ -23,7 +23,7 @@ kernel.
 
    The resultant userspace tool binary is then located at:
 
-     tools/acpi/power/acpi/acpidbg/acpidbg
+     tools/power/acpi/acpidbg
 
    It can be installed to system directories by running "make install" (as a
    sufficiently privileged user).
@@ -35,7 +35,7 @@ kernel.
 
    # mount -t debugfs none /sys/kernel/debug
    # modprobe acpi_dbg
-   # tools/acpi/power/acpi/acpidbg/acpidbg
+   # tools/power/acpi/acpidbg
 
    That spawns the interactive AML debugger environment where you can execute
    debugger commands.
-- 
2.7.4

