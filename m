Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CBCC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9A92053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613951;
	bh=6zIiEWN31skM5xergCOsL8g59AvndvwXjYmo6+sQC3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1bSQt0/7eEiUYQ3fB7LHQQi9gfaBf0Kp3j7332WqLkZwlRevGXBQX3VP9uCY2svlw
	 1hud+IqyIIYCN1/xIo6WemB7B/zK9XaY4Fs91rGR31mw85uUxt7a3jZotzWkqMURyX
	 3AZP2cDgm5B5ktbRRrXtTm2+doCy85m8VvtP3ut4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfIDQTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731920AbfIDP61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:58:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89AB2377B;
        Wed,  4 Sep 2019 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612706;
        bh=6zIiEWN31skM5xergCOsL8g59AvndvwXjYmo6+sQC3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1BiQUjmKf3Tv9p4UKUWni4yke/XKGDWvaCGqYS19NWQMG/RIgqTeIc6GVOKgqtOM
         19Fw4QbobOeRZnfrRXLzrPqFqJK2OlMF+PGy2LCF+9KUPWNAN8hNnjbMax7052NbAa
         Zq+toA6HUuj9iqB4Uqmz2/UTJUWjU3Y03PQU8irY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 33/94] selftests/bpf: install files test_xdp_vlan.sh
Date:   Wed,  4 Sep 2019 11:56:38 -0400
Message-Id: <20190904155739.2816-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit 3035bb72ee47d494c041465b4add9c6407c832ed ]

When ./test_xdp_vlan_mode_generic.sh runs it complains that it can't
find file test_xdp_vlan.sh.

 # selftests: bpf: test_xdp_vlan_mode_generic.sh
 # ./test_xdp_vlan_mode_generic.sh: line 9: ./test_xdp_vlan.sh: No such
 file or directory

Rework so that test_xdp_vlan.sh gets installed, added to the variable
TEST_PROGS_EXTENDED.

Fixes: d35661fcf95d ("selftests/bpf: add wrapper scripts for test_xdp_vlan.sh")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b9e88ccc289ba..adced69d026e5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -61,7 +61,8 @@ TEST_PROGS := test_kmod.sh \
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh \
 	tcp_client.py \
-	tcp_server.py
+	tcp_server.py \
+	test_xdp_vlan.sh
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = test_libbpf_open test_sock_addr test_skb_cgroup_id_user \
-- 
2.20.1

