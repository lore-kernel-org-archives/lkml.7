Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA6FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515F520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfCDUlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:41:08 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:53797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCDUlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:41:07 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MGQWr-1gkAkD0R3N-00GmYZ; Mon, 04 Mar 2019 21:40:52 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vlad Buslov <vladbu@mellanox.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Simon Horman <simon.horman@netronome.com>,
        Adi Nissim <adin@mellanox.com>, wenxu <wenxu@ucloud.cn>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/sched: avoid unused-label warning
Date:   Mon,  4 Mar 2019 21:40:32 +0100
Message-Id: <20190304204049.2150878-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TmlPpxdDUF2mU4VYOam276FDHamkTtbq9FgbDJ70+3oAXHtU1oE
 mbTzcuj2OiZbE13vRAaMF9EboBjorTOsVy5l+1+vvK6IOkm9q+Hz/hMZtnAEdoPHn9cFujy
 Ae2XkzIZAWwBJdHkWdXHqSflPs/t+n5U3kdpTtJvbu+92WVF88DeAmSUePinUA9v056GYkt
 9r8ZiUZdbnkfiGsD9hWbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GQxPCzYySJo=:q6CITUG3lTzjN9T/GwaIOi
 r/PA32LQxTeWZe7oBBSiGKzOBedxJLQFtnuRITrqpFcMzUwwUNnAMviLSyreGzx1ZhZ2qIURD
 51oFk/zmqvTrPYFlv6MMMQtt5naF9iKhj9sti8Xh6jQUXbq5TPUIRVxLISH167N/n0WubBStI
 4hJ05KX8BLt5pVcesjdAusrvzjyi8UUOeOy0QaoryT12d6tpAOfw9SOfp60urjlcL9Yd8gOT2
 KLyBVRUbACjeEYAGXzPENboG/ROM6Qkd6TQ7/8k8Vk6XLEdarxxM5UdoClT6fbZwXsGtdYXal
 mwF92t3nB7BZGP+NJt2ZAiDb0G00nseFoL7egg93i78Z+2W1yWvOYj3FJQMRnS2+1hmjb9iLD
 2O2Nq5yYoeleAYKL8WbK5lQtLX42Ppk9C+WFH/AFV0n/EJ1aO2ZZVJYEOW1fI282k/jcxsLSr
 sOLUw7Awgcxx2Hh88bMNYDTTp+3YJJl2VsIVPozhesWpBn5PhiWsNfCsCmxDn4uiNDLZ9+C6Z
 K6So8xG/SWVDiG4kQUKtsr+7s8tU4I4a7sgGznw+0Gps2OuXEnku1YM2m46c/YCRwUzSRnBSi
 v4vaM/uSZchvr6u7WanwBsSYakWQBr8/ldNjZTEJhm6s6le5h8ikGYbBdiGXiVDxCEK0C0HgD
 Xwse5NcBFGNqKmrWlaBsJuh1uUwpoPuUe1SibRSBjgqhDBsnlIM5Omggw+vamlDRONd4qCMNK
 aMEoc3zO61BVaBg05rups5Ua3wMb+1nI0lVvSA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The label is only used from inside the #ifdef and should be
hidden the same way, to avoid this warning:

net/sched/act_tunnel_key.c: In function 'tunnel_key_init':
net/sched/act_tunnel_key.c:389:1: error: label 'release_tun_meta' defined but not used [-Werror=unused-label]
 release_tun_meta:

Fixes: 41411e2fd6b8 ("net/sched: act_tunnel_key: Add dst_cache support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/sched/act_tunnel_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 2a5f215ae876..3beb4717d3b7 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -392,8 +392,8 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
 #ifdef CONFIG_DST_CACHE
 	if (metadata)
 		dst_cache_destroy(&metadata->u.tun_info.dst_cache);
-#endif
 release_tun_meta:
+#endif
 	if (metadata)
 		dst_release(&metadata->dst);
 
-- 
2.20.0

