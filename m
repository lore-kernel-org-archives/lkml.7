Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F1C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18971214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742779;
	bh=wHyMRSFjDyBqV0ifAwpqlWE4g2Yaas9E9cdpqCa//og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tOwimwpOIU+5DaeK+UmOGsgdzWRNLX+g5s0S6Uhve2Ukd643eclZbxubjLj3/+LDn
	 dd0WSfgtdTyQwrBc+lvYDlS2wRVC1DhPpdD/rSUuSKEi0zYquP4RHgDXCxktH2j2tR
	 /7DAK7J6d/ZDV1hXyzdJH0jqPkRLkdeNZZSbyg/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfDHQ7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:59:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbfDHQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+/vCN7w/a3YnQuR/e0FP5otvIT6v5wA3Of7QaeCzNFU=; b=IdoZk4/sdR4D24H0/5tm3OgWcm
        qy3B7mj6J2idGSSpoA10DITR7UfnWVjIRtYLjO4QKUFCh+zNeqEJqA+GjESL/IT4VYwPqrkTOun8f
        RrQcosCqbhTl1pMH7dYNIGwqCQnUIrWuYesFMJI3vWTLMTWV2Gy+AAYDTBeHhK04gx86hNAnbcapj
        Mdp6tRpWztE9a9go9ZybDr9jJ0loG94FZc2XTsUif7LgINTZX+ZCTvRKgb63hRQXqgUyN0JOpGp3l
        BzNtS6DF+LvKUAbOjzvEMunoTX94SvP6igU3ksnDVgtFHqgWSwe/AcJXuzzaaYP8BdaZpy+BNqGEQ
        vMEDk8KA==;
Received: from [179.95.33.162] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXbO-0005Sq-5w; Mon, 08 Apr 2019 16:58:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hDXbI-0005nT-By; Mon, 08 Apr 2019 13:58:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 08/10] docs: ntb.rst: add blank lines to clean up some Sphinx warnings
Date:   Mon,  8 Apr 2019 13:58:24 -0300
Message-Id: <e2c2fafcce7fd5d631e5f187a3a05a7bfd73c98e.1554742526.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554742526.git.mchehab+samsung@kernel.org>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make it easier to parse and produce the right output,
add some extra blank lines.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/other/ntb.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/other/ntb.rst b/Documentation/other/ntb.rst
index 344a075f81f5..074a423c853c 100644
--- a/Documentation/other/ntb.rst
+++ b/Documentation/other/ntb.rst
@@ -77,11 +77,13 @@ outbound memory window so to have access to the shared memory region.
 
 As one can see the described scenarios can be combined in one portable
 algorithm.
+
  Local device:
   1) Allocate memory for a shared window
   2) Initialize memory window by translated address of the allocated region
      (it may fail if local memory window initialization is unsupported)
   3) Send the translated address and memory window index to a peer device
+
  Peer device:
   1) Initialize memory window with retrieved address of the allocated
      by another device memory region (it may fail if peer memory window
@@ -90,6 +92,7 @@ algorithm.
 
 In accordance with this scenario, the NTB Memory Window API can be used as
 follows:
+
  Local device:
   1) ntb_mw_count(pidx) - retrieve number of memory ranges, which can
      be allocated for memory windows between local device and peer device
@@ -105,6 +108,7 @@ follows:
   5) Send translated base address (usually together with memory window
      number) to the peer device using, for instance, scratchpad or message
      registers.
+
  Peer device:
   1) ntb_peer_mw_set_trans(pidx, midx) - try to set received from other
      device (related to pidx) translated address for specified memory
-- 
2.20.1

