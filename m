Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3305C47409
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C595D24653
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578150191;
	bh=OImT5951usVoEzBTTXk40cdtKNYhMGaPcyc+mblWNvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/TSL/GgxzPKV7X6d1wNbryCzuS8Vx3+USEe0iWPbfMVArb1ak0wk4TGmrByOsIAV
	 G3N30UeNtQuFQelKmMTVFrBvRJ3y1K1vnS9jA4IC/tEOdOMLW3KqDmdxOoIKo7utKD
	 AkrpeGru5vHVvnmt9wBL96iQsncO+jBxiSwcR0iA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgADPDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:03:08 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53557 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgADPDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:03:01 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 004F2gcS018492;
        Sun, 5 Jan 2020 00:02:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 004F2gcS018492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578150164;
        bh=SKiPM0FBFgdXfstujev5RqYQ1TcIrVxmqymcoyNEglI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/YeNqRwEpLsxuSW+1yl8DiFvcgQkDWkeOi9OhPlHBinKjerZnRrY3dk9S629dwyZ
         sgSRPYhG/51Ij2BHa7Zgl9JWi96c5L+/B15z4P9W5j2czJCQNBvtTnyVCFkBPDMjOh
         OnEaR3XOd49j7rkP103PrKPyA41XyJZRrXgk6/DHqL2rdqGvdhpr3mh4LTVkH6jAf/
         tLdwM3Gv6FZlivlJQZoR0Oyrki/e3LWt5P1p4/B1XUAcwPZtesiH1UzVfrdu/l2FtL
         C7xa/TRX2/StXg1d3yg0Yx+OzzsVGsKTHMrDSwd/ipT13n/MARhhWRltPwFSiRe3nA
         3uj40gll2iudg==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] gen_initramfs_list.sh: remove unused variable 'default_list'
Date:   Sun,  5 Jan 2020 00:02:27 +0900
Message-Id: <20200104150238.19834-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104150238.19834-1-masahiroy@kernel.org>
References: <20200104150238.19834-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is assigned, but not referenced.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 usr/gen_initramfs_list.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/usr/gen_initramfs_list.sh b/usr/gen_initramfs_list.sh
index 2bbac73e6477..909a7b865aa7 100755
--- a/usr/gen_initramfs_list.sh
+++ b/usr/gen_initramfs_list.sh
@@ -280,7 +280,6 @@ while [ $# -gt 0 ]; do
 			shift
 			;;
 		"-d")	# display default initramfs list
-			default_list="$arg"
 			${dep_list}default_initramfs
 			;;
 		"-h")
-- 
2.17.1

