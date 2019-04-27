Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D2C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B842087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfD0M4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:56:50 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfD0MxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:09 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M7JvQ-1hPrWb2KvE-007on1; Sat, 27 Apr 2019 14:52:45 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 14/41] drivers: tty: serial: uartlite: remove unnecessary braces
Date:   Sat, 27 Apr 2019 14:51:55 +0200
Message-Id: <1556369542-13247-15-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:HNae7PjeMCnI/fvVc5Vcn1UOQeHvus2cVjs+T9ya7m11++AcCzd
 Uql6NzhkB+oflvXltCOBqXEgUK5TSZ1hR8ffTPAYNbY/DvgKZZPbUn10MDN7ED70JOmLeJq
 1lKUaLw3MrCqMLhiaWDxWKIAGg5En0Qog7emS9vPAAPWKLAw46CPLHZiyXdcej2Fh8Ze+9P
 mQVxOOn3Z+MSiWhjBR3rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3t+Nw4JPEJE=:S64AQuvF2U7F25wvtc5XCm
 nSGvWcPttt+54CgkTz8WBMvqDdTZV1KbKhC11oN+8c/mvl2xjunvnZND4PK83mMayEeOKveGL
 Rd93v52I09dnYOeNp45XUqp/QksQLz9BPG1DLrjEYZz+ZHPu+6Pe0Rw0dPQ1h1bZtuLIyI8JZ
 WKqry4ildM4OTi6jM5nTBC+ZbuVxxi0Ov25WThAFtVMLRA+VFSGJ9FwUj5E18pRLO4JnVzA1A
 /At2a2dq0VbZWlVppOKC3+Wri1v58c0QMeOGg/TTlUbU51qerw8V3YktudCxe4coHD947lYRX
 hVMg9GHS0eWGn0Zi0jczAgtOciNOv6laK9FPaHZCa/UocjUZFekiZ8I6192ltw0IapPP69sBO
 ooWqzCwPdibwHdZEY1wGSmtnUFvvz1hDSiMogIa4x22PefBAr9KyHtc++v1P3qbPTaEGS+Eun
 tEzlO3f6xNCtXADxjqVYUZ3hDlrNQHHJsQI/I9gXDEaMMqxbQKYBUlU4mr+fc9XQ3jwDyNPdP
 GrbJW24PeowT2zhfXHQ51QUSwk/DyHpQtZxRjBLtbkqXILbsge0ytPII9Peb1wX53WnHrZ1EL
 uclEJEwocjxNPOvn1Qup74SBDKN2AM7ANqcGrVzZHb8TqKJw8Ksp/NvRXV6WwdAsJOh3ncIrl
 e2WYHXjOEtHoUrV3DEnBtI+k5GjpjNJViBLGkrTBGEWwCDP/t4KuiepcU5sAE3gMuV0ryxAFc
 7LjvLNQI4W2HVfnMPR699cwLCgmbn4KrVtdc/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch complains:

    WARNING: braces {} are not necessary for any arm of this statement
    #489: FILE: drivers/tty/serial/uartlite.c:489:
    +	if (oops_in_progress) {
    [...]
    +	} else
    [...]

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index c322ab6..4c28600 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -486,9 +486,9 @@ static void ulite_console_write(struct console *co, const char *s,
 	unsigned int ier;
 	int locked = 1;
 
-	if (oops_in_progress) {
+	if (oops_in_progress)
 		locked = spin_trylock_irqsave(&port->lock, flags);
-	} else
+	else
 		spin_lock_irqsave(&port->lock, flags);
 
 	/* save and disable interrupt */
-- 
1.9.1

