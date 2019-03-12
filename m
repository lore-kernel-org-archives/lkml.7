Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA043C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725E521734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413477;
	bh=LSrNUnl7tvD8p3jC1rSuHoR9OyFbw2KRR7wqIPJ+kNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H5lE5aihWw64reZ79kns5LxoQXfWBQZ8tMG+LQ5cbA8CQdVDWVvir2aY/JKQ2aWvm
	 OAsO7121LCsjLTLhvSNudtYMBLTBLJDWCnPPUM9HvOPcBKg7J1LvLBu4EMVnulDGBS
	 zVUHOkJM5sBf8sod5DaFrQQfGayJbtis7bLvlffU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfCLRNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfCLRNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:02 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5507E2087C;
        Tue, 12 Mar 2019 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410782;
        bh=LSrNUnl7tvD8p3jC1rSuHoR9OyFbw2KRR7wqIPJ+kNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kDSEq4ZNDYzT+TNgwwqWlEoe14PCB04IBhh1Ezhwf9HQ8RauokB8ic9cWQyK23IZW
         C9RRs7+xKPiYjHokqRrvNXrTkb33XUKJ/lsUC5G+xG7TxNmwIrumggOF/xivMnpJSF
         TyNmNNYLKP27aEfOoIHI295jsnWKcYB7aBSCq9UE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 122/171] selftests: netfilter: fix config fragment CONFIG_NF_TABLES_INET
Date:   Tue, 12 Mar 2019 10:08:22 -0700
Message-Id: <20190312170358.314214813@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 952b72f89ae23b316da8c1021b18d0c388ad6cc4 ]

In selftests the config fragment for netfilter was added as
NF_TABLES_INET=y and this patch correct it as CONFIG_NF_TABLES_INET=y

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/netfilter/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/netfilter/config b/tools/testing/selftests/netfilter/config
index 1017313e41a8..59caa8f71cd8 100644
--- a/tools/testing/selftests/netfilter/config
+++ b/tools/testing/selftests/netfilter/config
@@ -1,2 +1,2 @@
 CONFIG_NET_NS=y
-NF_TABLES_INET=y
+CONFIG_NF_TABLES_INET=y
-- 
2.19.1



