Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784E1C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473E020861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806770;
	bh=ZDmmVoPhIp1mq/TvKtY0HDmQNyoK47fziOfMSlrhMEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vxsOXY9fHa8cpatItpenWv/2xZUut8ufGAqanJQ/5iHIkuwUIVzE4ywmlk88dPOBt
	 oeXCnBuvyCi0S6cqJnrNQwz5Z9mCVxXFl5QmKiC6a76rM368l9GgAzT/kwm9XI6rB4
	 MY7Czrbq0McWHiRYgeNuF78vM2ZtDXgp0oktjR8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfFQV0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729615AbfFQV0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:26:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E8F320657;
        Mon, 17 Jun 2019 21:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806761;
        bh=ZDmmVoPhIp1mq/TvKtY0HDmQNyoK47fziOfMSlrhMEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHNFRsbrMK1XGLYMO5m9To5OYgTap2mlPmacXZTv6VKwGdSwN1kLHVbYGg4fiFF8V
         8Pa2/+uc7bXwcsmaqrw48wER+UjTDAG2iCIEm+IgOJh9Btm/eulsecXU8Ksh7r9hRO
         p1bzsDqpPCg5d4Ajc9BITgfJri5f9hzq3SyoTTyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 48/75] selftests: fib_rule_tests: fix local IPv4 address typo
Date:   Mon, 17 Jun 2019 23:09:59 +0200
Message-Id: <20190617210754.607470699@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210752.799453599@linuxfoundation.org>
References: <20190617210752.799453599@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fc82d93e57e3d41f79eff19031588b262fc3d0b6 ]

The IPv4 testing address are all in 192.51.100.0 subnet. It doesn't make
sense to set a 198.51.100.1 local address. Should be a typo.

Fixes: 65b2b4939a64 ("selftests: net: initial fib rule tests")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index d84193bdc307..dbd90ca73e44 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -55,7 +55,7 @@ setup()
 
 	$IP link add dummy0 type dummy
 	$IP link set dev dummy0 up
-	$IP address add 198.51.100.1/24 dev dummy0
+	$IP address add 192.51.100.1/24 dev dummy0
 	$IP -6 address add 2001:db8:1::1/64 dev dummy0
 
 	set +e
-- 
2.20.1



