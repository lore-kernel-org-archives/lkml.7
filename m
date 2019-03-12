Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972E4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602062147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412873;
	bh=o/6WT9M50GYJxHJfH5hc/JsHOUMOjl+mzGFCSH/84zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LL0oQULm35LNRMh0FBR8TlTjlivATvXRMZoODcmWeWBaJndRtZ36ZmIg7tGCbri2m
	 K+KdkU/GaZHOtGn3F9RLzOY+1N8SZJIYIgdzbFK4xQC8LmqFfcmRpgbkG1Q5OVDV8H
	 rDhF4ncDpLyFICd7qTUl6t/eNxKN04TaAKzj2Bx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfCLRrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbfCLRPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:08 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90A121850;
        Tue, 12 Mar 2019 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410908;
        bh=o/6WT9M50GYJxHJfH5hc/JsHOUMOjl+mzGFCSH/84zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFV1mo0ZDX83hJgpvPazmm6J9wwP+wXRAsMQw5lP36dDIbYsNCZKol1Ukef5xHibQ
         6sqiPz8XNsM6H1GKyA/kXP817ITebGP6DQLlQ3W1c5271fP9oY/tXfvdBWnewYhvED
         BHkMJ4SzIoIeduHFFO6escZfQ6u7kpS7JjZyHOoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 102/149] selftests: netfilter: fix config fragment CONFIG_NF_TABLES_INET
Date:   Tue, 12 Mar 2019 10:08:40 -0700
Message-Id: <20190312170358.100320472@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



