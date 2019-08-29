Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9565EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7152341C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567075830;
	bh=N1h7TtJ875q5awe/vvwWXc4y4CcTeulGLtMQqFmYWl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1T6HnNNW4B69TSyJ8YSxyy3sJKyd4ysiOKh7wDCe+inbDjFmgaJbeF7gzBYUREglC
	 OFrLZNulazL6HYZzEOu+xMGHOdF4V2KCxUyfDhPEE/fr80DR0XakuaM6pMhwOerH5T
	 HL3x7jRGHCr3VUa7ru0ztcSYbvELArlShOqdxrBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfH2Ku3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbfH2KuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:50:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8FF23405;
        Thu, 29 Aug 2019 10:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567075820;
        bh=N1h7TtJ875q5awe/vvwWXc4y4CcTeulGLtMQqFmYWl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9uQNTPvcS/M5o1/b8FBvx4g52JtUU0AQ2mJfUDY26lfhczk45+sqqdPqWv7CwP9a
         QgsZtnQ7Cimb3fcUlqmURbrv1t+r1RySAUIVdAW+Dkwj0wvKorugaseOUnwrXCx8sO
         ukNvGBiMhnv+0BMVvChtWWbujNnefWwuu85m/1ok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hangbin Liu <liuhangbin@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/29] selftests: fib_rule_tests: use pre-defined DEV_ADDR
Date:   Thu, 29 Aug 2019 06:49:49 -0400
Message-Id: <20190829105009.2265-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829105009.2265-1-sashal@kernel.org>
References: <20190829105009.2265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 34632975cafdd07ce80e85c2eda4e9c16b5f2faa ]

DEV_ADDR is defined but not used. Use it in address setting.
Do the same with IPv6 for consistency.

Reported-by: David Ahern <dsahern@gmail.com>
Fixes: fc82d93e57e3 ("selftests: fib_rule_tests: fix local IPv4 address typo")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 1ba069967fa2b..ba2d9fab28d0f 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -15,6 +15,7 @@ GW_IP6=2001:db8:1::2
 SRC_IP6=2001:db8:1::3
 
 DEV_ADDR=192.51.100.1
+DEV_ADDR6=2001:db8:1::1
 DEV=dummy0
 
 log_test()
@@ -55,8 +56,8 @@ setup()
 
 	$IP link add dummy0 type dummy
 	$IP link set dev dummy0 up
-	$IP address add 192.51.100.1/24 dev dummy0
-	$IP -6 address add 2001:db8:1::1/64 dev dummy0
+	$IP address add $DEV_ADDR/24 dev dummy0
+	$IP -6 address add $DEV_ADDR6/64 dev dummy0
 
 	set +e
 }
-- 
2.20.1

