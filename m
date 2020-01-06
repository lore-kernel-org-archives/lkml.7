Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A627C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F573215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578296200;
	bh=+er8ZnCgPIcoYGEpVdmEN4hu4QeFiPIftsS21Y50ZlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lCgCd0snX5MLgyPWfrTsLdzkaeMIcaEj5d4wL/EwsgSIvXnB3KA4zZMkCdoty8+Z1
	 YIXZnbc1CF34hURpetpALvd8BNUJkj2ew23gy92IHj423scXrsis/MoX+YaBoGCECU
	 kdN3vuV326guFAabWj5vvYnANAnXMvFO7xPRpIkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgAFHgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:36:39 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:48152 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgAFHgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:36:39 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 0067Zx8d016413;
        Mon, 6 Jan 2020 16:36:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 0067Zx8d016413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578296160;
        bh=x+bqJGvJ9dfQ92n9qPLb8ZtMbNjVzUFYBwr7W/KMlXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRqt5TT1t+oGlK+04WQOfVpyyrVY/PXqi0G6EToUrBdh+slDNFA0UXQLflc3+aR3T
         Plv3IVUmxVXx6JGot6DwbP+AniCg98wxTb9W4sfB1AoVhiaMTwbuzMD34vLjBLMgbD
         EJMGOw7pTL7gu1CWAjW4IKyCS+2drgD8hNMcHKhmv+7o6Fg65pUTNA3VF4nm4/GKKg
         xf1xOVtnBPHlFwOUu3QFI0YT9Trac3OXsM2rLUUAMH/KpSoasGHThgwyYzI6rnKCwp
         FA7evSA5yDC6kLuGYBpnwl7Lvaj7CCMa8n4s+Y3B9LjPfx4wMxDZwR4+MpNRNqFDJG
         +34I2ivR8STVw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        "David S . Miller" <davem@davemloft.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tipc: remove meaningless assignment in Makefile
Date:   Mon,  6 Jan 2020 16:35:27 +0900
Message-Id: <20200106073527.18697-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106073527.18697-1-masahiroy@kernel.org>
References: <20200106073527.18697-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no module named tipc_diag.

The assignment to tipc_diag-y has no effect.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 net/tipc/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/tipc/Makefile b/net/tipc/Makefile
index 1603f5b49e73..ee49a9f1dd4f 100644
--- a/net/tipc/Makefile
+++ b/net/tipc/Makefile
@@ -20,5 +20,3 @@ tipc-$(CONFIG_TIPC_CRYPTO)	+= crypto.o
 
 
 obj-$(CONFIG_TIPC_DIAG)	+= diag.o
-
-tipc_diag-y	:= diag.o
-- 
2.17.1

