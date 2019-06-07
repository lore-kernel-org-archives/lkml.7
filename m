Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062E8C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E4120868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559933792;
	bh=dgQ7Sdw3+Qs/ODnlw6jkJOny1VOVt1lbwTQ60dXG9oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wSUpo6TxstJ5HoLe8FjGGtzttpKVsHooP3EOIK0TABnWr/hzGu+LxYY+YUnaOIakP
	 UOUkkSCt2LJoKOjshQMoSL0sBTxxuLXqV4r3vVaGlC/TxwbpidMWNi3iBnGBq0DZqH
	 I5fmNOJXpZ3qvCMDGNUvZ71muIWaEEXr1s5pRvj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfFGS4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:56:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbfFGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nmmmmE8IK45VX9V9j4/cO2pBiB9thUFj9++29NB31JM=; b=Y06nEFtTO7Y9tpHUkNKkdvuFUl
        tDxCKPIMotVcDSONsp1f5JxxBGArpwZn1Xine9jlhQUqN2yZs2Llfa4QJtVk3EBgLVKGN+3ZF3phh
        1xBFNqWhgzVvixgDvY6ZIXPNeJdP82HqL6WP3yJ3+fs4pgNaVD9GEsPqdRcbDlGcR8uo2NletgwWO
        83iGFHuQEHepH3mHKMer6lleQYtniZSKBY2Wmjvn1vfpqFIu1L2JVA8og/Ayq4vag1LKaakTvSaf0
        Y3LoObrR51VBYTmlSy6lALLrBVn8zwTV7ad0BvL+IYWOQg4O/AZFgasHzVOOdZhRKsjNHW5L3yPs6
        nkM2t0qg==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005si-M7; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007Ff-Lu; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 18/20] docs: isdn: remove hisax references from kernel-parameters.txt
Date:   Fri,  7 Jun 2019 15:54:34 -0300
Message-Id: <7681f328a4205bf1609521c2bf05a346d85e9566.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hisax driver got removed on 85993b8c9786 ("isdn: remove hisax driver"),
but a left-over was kept at kernel-parameters.txt.

Fixes: 85993b8c9786 ("isdn: remove hisax driver")

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1abd7e145357..9b16b640ce48 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1388,9 +1388,6 @@
 			Valid parameters: "on", "off"
 			Default: "on"
 
-	hisax=		[HW,ISDN]
-			See Documentation/isdn/README.HiSax.
-
 	hlt		[BUGS=ARM,SH]
 
 	hpet=		[X86-32,HPET] option to control HPET usage
-- 
2.21.0

