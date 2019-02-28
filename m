Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB2EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5314218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366607;
	bh=Ui/7h9JFlbrLYPlec1qdhESNoTusVvdaz6Pj1c9Z9Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qKPC5bPF+UEFYAKg/ZTppsCmHbB2UiPx5HMqcgVte81N7wxUhrOLMdKQmjACZ7hl1
	 6CGEv/dnjC3RoYwMetLcvxfBTZvpjWw7rAmm2szaNKRwI5zEEszmC5q/99/rvIDWEF
	 m2cK5pikCryDSdiNSsM+vUrNeShf6n3zUIE1ayCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfB1PKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387641AbfB1PKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99256218AE;
        Thu, 28 Feb 2019 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366602;
        bh=Ui/7h9JFlbrLYPlec1qdhESNoTusVvdaz6Pj1c9Z9Wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5Vk9FzbqoHrWvjnWcwCuII8v6hWHX9d8ufrHAvVspdtSHTwUUYJrfMZTga7y76Fr
         oHTdq/aXUkUAUi2HPXSiqoVMsrJuSGkFsgsaFTueKTxUNbVOCEIdzKn6iQZpvJofPU
         lAqYVe3LgccaZcGZxatfHtaiR73WBtZ37onvguOg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 57/81] selftests: netfilter: fix config fragment CONFIG_NF_TABLES_INET
Date:   Thu, 28 Feb 2019 10:07:49 -0500
Message-Id: <20190228150813.10256-57-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naresh Kamboju <naresh.kamboju@linaro.org>

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
index 1017313e41a85..59caa8f71cd80 100644
--- a/tools/testing/selftests/netfilter/config
+++ b/tools/testing/selftests/netfilter/config
@@ -1,2 +1,2 @@
 CONFIG_NET_NS=y
-NF_TABLES_INET=y
+CONFIG_NF_TABLES_INET=y
-- 
2.19.1

