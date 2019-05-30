Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048D0C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C82262D1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfE3XHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:07:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:24800 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfE3XHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:07:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 16:07:10 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 May 2019 16:07:08 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hWU8a-0008nu-3S; Fri, 31 May 2019 07:07:08 +0800
Date:   Fri, 31 May 2019 07:06:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Baron <jbaron@akamai.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Christoph Paasch <cpaasch@apple.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] tcp: tcp_fastopen_alloc_ctx() can be static
Message-ID: <20190530230620.GA3979@lkp-kbuild15>
References: <201905310755.SmE6F5XI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905310755.SmE6F5XI%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 9092a76d3cf8 ("tcp: add backup TFO key infrastructure")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 tcp_fastopen.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 8e15804..7d19fa4 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -72,9 +72,9 @@ void tcp_fastopen_ctx_destroy(struct net *net)
 		call_rcu(&ctxt->rcu, tcp_fastopen_ctx_free);
 }
 
-struct tcp_fastopen_context *tcp_fastopen_alloc_ctx(void *primary_key,
-						    void *backup_key,
-						    unsigned int len)
+static struct tcp_fastopen_context *tcp_fastopen_alloc_ctx(void *primary_key,
+							   void *backup_key,
+							   unsigned int len)
 {
 	struct tcp_fastopen_context *new_ctx;
 	void *key = primary_key;
