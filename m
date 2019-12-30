Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC7C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 10:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58E6206E4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 10:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jR9I0GL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfL3KIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 05:08:24 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:57994 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfL3KIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 05:08:23 -0500
X-Greylist: delayed 930 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Dec 2019 05:08:22 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aF2Ah
        cAK31BkXnWnmspWm3f0462KhUNDoHYlAluuscM=; b=jR9I0GL79tj3zOYyeMTS1
        Rs/oM2VZfjGIcCCFZQKvSutaxCHigZFazJOFBLYPoqwbHrkbCaj4rFSMtC4MZaGg
        w4PBuMbJ1CMglelV6oRZ4/GBd8MpbFtju7MNXdOK4/gmfUjkC5r5wUabNcNV5mZY
        lR+u3HFqZOZ2/Ba5dQ3kAE=
Received: from xilei-TM1604.mioffice.cn (unknown [114.247.175.223])
        by smtp4 (Coremail) with SMTP id HNxpCgAH2uXYyAleR7gGBw--.32S4;
        Mon, 30 Dec 2019 17:52:28 +0800 (CST)
From:   Niu Xilei <niu_xilei@163.com>
To:     davem@davemloft.net
Cc:     petrm@mellanox.com, sbrivio@redhat.com, edumazet@google.com,
        roopa@cumulusnetworks.com, ap420073@gmail.com,
        jiaolitao@raisecom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niu Xilei <niu_xilei@163.com>
Subject: [PATCH] vxlan: Fix alignment and code style of vxlan.c
Date:   Mon, 30 Dec 2019 17:52:22 +0800
Message-Id: <20191230095222.21328-1-niu_xilei@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgAH2uXYyAleR7gGBw--.32S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw45XryDWr4rXw1Dtw4rAFb_yoW5Cr17pr
        4xGFs5CFWDJ3yUJr4kZr4kZFyktry7CasruayDKF1FqryYk348Ca47CF4SgrZYkFW8Ca4U
        GrnrWw1rCr1DAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j96pPUUUUU=
X-Originating-IP: [114.247.175.223]
X-CM-SenderInfo: pqlxs5plohxqqrwthudrp/1tbiYxybgFaD+kOn2gAAs1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Coding function and style issues

Signed-off-by: Niu Xilei <niu_xilei@163.com>
---
 drivers/net/vxlan.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 3ec6b506033d..e95e6585ab82 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1060,6 +1060,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 			return err;
 	} else {
 		union vxlan_addr *remote = &vxlan->default_dst.remote_ip;
+
 		if (remote->sa.sa_family == AF_INET) {
 			ip->sin.sin_addr.s_addr = htonl(INADDR_ANY);
 			ip->sa.sa_family = AF_INET;
@@ -1696,7 +1697,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
 				   !net_eq(vxlan->net, dev_net(vxlan->dev))))
-			goto drop;
+		goto drop;
 
 	if (vxlan_collect_metadata(vs)) {
 		struct metadata_dst *tun_dst;
@@ -4128,30 +4129,30 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
 	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
 	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
-			!!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
+		       !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_PROXY,
-			!!(vxlan->cfg.flags & VXLAN_F_PROXY)) ||
+		       !!(vxlan->cfg.flags & VXLAN_F_PROXY)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_RSC,
 		       !!(vxlan->cfg.flags & VXLAN_F_RSC)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_L2MISS,
-			!!(vxlan->cfg.flags & VXLAN_F_L2MISS)) ||
+		       !!(vxlan->cfg.flags & VXLAN_F_L2MISS)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_L3MISS,
-			!!(vxlan->cfg.flags & VXLAN_F_L3MISS)) ||
+		       !!(vxlan->cfg.flags & VXLAN_F_L3MISS)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_COLLECT_METADATA,
 		       !!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)) ||
 	    nla_put_u32(skb, IFLA_VXLAN_AGEING, vxlan->cfg.age_interval) ||
 	    nla_put_u32(skb, IFLA_VXLAN_LIMIT, vxlan->cfg.addrmax) ||
 	    nla_put_be16(skb, IFLA_VXLAN_PORT, vxlan->cfg.dst_port) ||
 	    nla_put_u8(skb, IFLA_VXLAN_UDP_CSUM,
-			!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM_TX)) ||
+		       !(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM_TX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
-			!!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_TX)) ||
+		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_TX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
-			!!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_RX)) ||
+		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_RX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_TX,
-			!!(vxlan->cfg.flags & VXLAN_F_REMCSUM_TX)) ||
+		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_TX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
-			!!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)))
+		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)))
 		goto nla_put_failure;
 
 	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))
-- 
2.20.1

