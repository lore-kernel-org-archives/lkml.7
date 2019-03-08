Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47CCC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1F420684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfCHMpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:45:23 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:34407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfCHMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:45:13 -0500
Received: from orion.localdomain ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MofPt-1giqIb492v-00p1Rj; Fri, 08 Mar 2019 13:44:57 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        info@metux.net, apw@canonical.com, joe@perches.com,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 4/5] scripts: checkpatch.pl: don't complain that debian/rules is executable
Date:   Fri,  8 Mar 2019 13:44:23 +0100
Message-Id: <1552049064-32044-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552049064-32044-1-git-send-email-info@metux.net>
References: <1552049064-32044-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:/aNiaUTcsj0E0j3M1ztgDLgje82UwrMzNDIplcsHJI2w0y1jPex
 lBc1jxG1uC7xJgvWhw4rouzoilkV7yqW/9Tq8XIPAMjWXnnOJKjBV6MGmCp3I2QraIInXUh
 4vxqwof7CSAWbwBwOipTJcnCKF8H/9aNOKVGUMsPcCPVGXGnGv50lmzXM9jlE8CvnejGkWL
 srQtQvyCr1NK64OdOIjIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iufGRRxJwrM=:VSD9inoEcc4w9+KSPmEqd8
 /TJ/kCl1rzv9d3REDWg5lmPecDKuK2Esy2ZFB8RfTGWhJ4i17n1RlqFsMSWwso8enWm0j7X6T
 FQJPb+Huhi021jTIdj9m7pM6XnCE28N534PAupd7Sb1B49K2vYlMSiIsOhBmjyA9uyuBOtmsC
 35tdCKppY+ZotBpj0IGEcwSS6CnD0+hMGBfgrd/ymeQaC7WEs/gSxYnJBHtfAHbcN+ctwpU/f
 m+YwhvlZEKR3iRybAKem8jao0LCtTHq+S5u4Mz1bfs9EECP9d5C7hlEGg34aI+txtrpLyxnzw
 ObxOtnyDJC1hFMDG/4k35mOa5PDeNl2j2lF28++FenM6cYNaPaYVk7H6dT2206Jg6dDQNQavF
 OGXys13EmSrpAf//kBhHaI962ksvsjS0G9zFkiZ1idtZXA5KhlxYGiDgochicAVeItl1/QtRu
 2OgdzAegfq9yb9RW5EmLlfmbpOP4LCN4lKcF77wdiHTv0Eiwbr21gULtYQhHZ+KhQn/L0TWOZ
 7Kv9behPo1vEareB/8MnUwYibjPlsT9HBuCC1qU8uxJAGv+aKJA39KyZSERJX7+PSCygGtCL7
 iRLz+GxL307pBF2Be1r7PdiV+xpUieX8YshQHXeMXFwmKoPxyeE5rh4XnSqcDU7b+klBS0J+t
 G1qg53Y5N+8dfJRizYf/If5irxMICIwh1eb2OIcBkf44rmPNfOKw9x0zTB8+fe2ZC+Jk4j+Sb
 G9dNYVoNwg8VB1DGrnx534zbkzf1ZT2edA9CoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl complains when adding executable "debian/rules",
obviously a false alarm. Therefore add an exception for that.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b737ca9..7bcc70a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2576,6 +2576,7 @@ sub process {
 		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
 			my $permhere = $here . "FILE: $realfile\n";
 			if ($realfile !~ m@scripts/@ &&
+			    $realfile !~ "debian/rules" &&
 			    $realfile !~ /\.(py|pl|awk|sh)$/) {
 				ERROR("EXECUTE_PERMISSIONS",
 				      "do not set execute permissions for source files\n" . $permhere);
-- 
1.9.1

