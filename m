Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A9C20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366945;
	bh=Ui/7h9JFlbrLYPlec1qdhESNoTusVvdaz6Pj1c9Z9Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uaNKduda+npNeqtheL7ljm4YNAVeghOBELPXN7GZQ61hvCjF8XbihKdRsW0GtND52
	 z9POUsIfpJhaIJu9KPWebcM+WNbXz7VkKOt5ZQ83ZFgq1EAhBLbADj4uSAsGHlulT+
	 pTWO2g8IzDe4RkmtvTBLd2hvCaEznjYzVLtJLc2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbfB1PPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:15:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388899AbfB1PPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:15:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D1E20C01;
        Thu, 28 Feb 2019 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366937;
        bh=Ui/7h9JFlbrLYPlec1qdhESNoTusVvdaz6Pj1c9Z9Wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18n0SU0fnt4PBcz1if01TV97S6X8LWbPqx1vOl4pym+uj2TirSVrUy/nIBbmx8Z9y
         3aTA0bfpAPNqjPPx4M4fWZicPVoQWsc+oLNtssyMRR47VNGt8YC86cxWScw3pSt5nA
         Gx2UxTsyqvqbRJMjkF0ebDBop3i81R2TW4YBOiGk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 11/19] selftests: netfilter: fix config fragment CONFIG_NF_TABLES_INET
Date:   Thu, 28 Feb 2019 10:15:07 -0500
Message-Id: <20190228151517.12705-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151517.12705-1-sashal@kernel.org>
References: <20190228151517.12705-1-sashal@kernel.org>
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

