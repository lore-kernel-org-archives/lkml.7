Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE88C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AFD2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfCVPsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:48:01 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfCVPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:48:00 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MEV7U-1hEZGU3J8M-00FzwG; Fri, 22 Mar 2019 16:47:28 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, Genki Sky <sky@genki.is>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Michal Marek <mmarek@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 14/25] kbuild: setlocalversion: print error to STDERR
Date:   Fri, 22 Mar 2019 16:44:05 +0100
Message-Id: <20190322154425.3852517-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8f/kvwj3Nxe00/rXmyCTb8V8PTLXRNRu2GUKDuTqRIqv4f1GfwR
 STVR7OwyYEBXKqtR5c0e5pVQhX4RLdkBaJouCnkFandHBpug8rhuvQH1Rmms7QbiWHAKX0o
 8box7D/Jl1D9QVrAYQf54jKJXvZD2v5PYjzxjTkS5b7NS3+r6LNFrRcA96ja1jegD+QKOri
 5lBoPoz930duwUOYETXhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8tvzb9R3BCI=:/kOyQLYDkp5XX6T5OIkDiN
 Nvay+FMZ0WMK1GHoYZajpvrKZGY0hSy+MC0bHsSdJHgErEAe+bT8AoMoiL68HxRsWV8Z5EHru
 VB4B/yW0VxPtdHKhAXPCGg1rH9ta7faZqDV0mqN08t6d1buzXz6/QYFnHrPkItGTVBhN6rqKL
 EGTloAgJeZLAHqAdLAcoWIgEiXB3Uxb7yok3UtfyfODPGb8BAMvmTuubaZjUPZ9/r46lhEuZ3
 pyGcWO2fUk2MBH1dbmHKNAxecFTLTVJBYPZXbdhnYLuEIdkqenwnr1JtVC6tCDmJJBYU3qFM2
 EyrUb+56tLaPCUm1LgcsFemAhnVDeedlZ/786rS6oWnBn6riV2zInjrAvokmRWPTt1NjsFRy/
 iw2TNLy+H/CHc3NWdCbfchno4W8kYtk7/z6QK50C0t6bEiu353PO5FyMMQd9XgjgQgnyEJfkK
 XSDMR/kvhfo5U0kvDYHVRtuG9PbAKzCOXo99Qfv9qbX9AkmQ3wWZeCm6Pba3kO3MUM+WLeROf
 o2vTXtr9jMMfsuq73mR8rT2zJTLsHcFtbYvUjVBE+/sI4dpH/FlRH3VtTX4hDQbNnyt+SRseV
 a0BPo2h4B8sPZayPWU0wLRoq/f+MB9LL1XXbWfqZQAIV3UZmi3G9Zxe8N7xSiFUoW5VUBV6Ix
 bsNTOrv4CS41ErlMqMGHmdpbvWPX0gc6/t6+fvqQhqR9DZ4Zs4xhVsNR1DcwUebUCY/+7x3Ma
 OFXOabFu9mA2CgkiJhRyphOy2KgKJDsa+AdDMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa@the-dreams.de>

I tried to use 'make O=...' from an unclean source tree. This triggered
the error path of setlocalversion. But by printing to STDOUT, it created
a broken localversion which then caused another (unrelated) error:

"4.7.0-rc2Error: kernelrelease not valid - run make prepare to update it" exceeds 64 characters

After printing to STDERR, the true build error gets displayed later:

  /home/wsa/Kernel/linux is not clean, please run 'make mrproper'
  in the '/home/wsa/Kernel/linux' directory.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Michal Marek <mmarek@suse.com>
(cherry picked from commit 78283edf2c01c38eb840a3de5ffd18fe2992ab64)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/setlocalversion | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 63d91e22ed7c..966dd3924ea9 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -143,7 +143,7 @@ fi
 if test -e include/config/auto.conf; then
 	. include/config/auto.conf
 else
-	echo "Error: kernelrelease not valid - run 'make prepare' to update it"
+	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
 	exit 1
 fi
 
-- 
2.20.0

