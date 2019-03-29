Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65977C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8D72173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfC2Pur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:50:47 -0400
Received: from gateway36.websitewelcome.com ([192.185.198.13]:45321 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728913AbfC2Puq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:50:46 -0400
X-Greylist: delayed 1466 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Mar 2019 11:50:45 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 4D183400CA258
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:43:08 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9tOchg1zb2PzO9tOchyA0x; Fri, 29 Mar 2019 10:26:18 -0500
X-Authority-Reason: nr=8
Received: from [189.250.126.17] (port=51964 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h9tOb-002gwy-OT; Fri, 29 Mar 2019 10:26:17 -0500
Date:   Fri, 29 Mar 2019 10:26:16 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vishal Kulkarni <vishal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Neil Horman <nhorman@tuxdriver.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 0/2 net-next] cxgb3/l2t: Fix undefined behaviour and use
 struct_size() helper
Message-ID: <cover.1553872521.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.126.17
X-Source-L: No
X-Exim-ID: 1h9tOb-002gwy-OT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.126.17]:51964
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset aims to fix an undefined behaviour when using a zero-sized
array and, add the use of the struct_size() helper in kvzalloc().

You might consider the first patch in this series for stable.

More details in the commit logs.

Thanks

Gustavo A. R. Silva (2):
  cxgb3/l2t: Fix undefined behaviour
  cxgb3/l2t: Use struct_size() in kvzalloc()

 drivers/net/ethernet/chelsio/cxgb3/l2t.c | 4 ++--
 drivers/net/ethernet/chelsio/cxgb3/l2t.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.21.0

