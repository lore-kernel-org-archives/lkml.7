Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF404C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A0D21848
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfE2NH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:07:57 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41432 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbfE2NH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:07:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TSyCu0K_1559135272;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0TSyCu0K_1559135272)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 May 2019 21:07:52 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        laoar.shao@gmail.com, songliubraving@fb.com
Subject: [PATCH net-next 0/3] introduce two new tracepoints for udp
Date:   Wed, 29 May 2019 21:06:54 +0800
Message-Id: <20190529130656.23979-1-tonylu@linux.alibaba.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces two new tracepoints trace_udp_send and
trace_udp_queue_rcv, and removes redundant new line from
tcp_event_sk_skb.

Tony Lu (3):
  udp: introduce a new tracepoint for udp_send_skb
  udp: introduce a new tracepoint for udp_queue_rcv_skb
  tcp: remove redundant new line from tcp_event_sk_skb

 include/trace/events/tcp.h |  2 +-
 include/trace/events/udp.h | 88 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/udp.c             |  2 +
 net/ipv6/udp.c             |  3 ++
 4 files changed, 94 insertions(+), 1 deletion(-)

-- 
2.21.0

