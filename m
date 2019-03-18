Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1820CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0B02085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KJ4n1fsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfCRAQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:16:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51524 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCRAQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PNC+yOc9qLOR+abq/u69TbFgVOPDMoWfP8uSYfFe5f4=; b=KJ4n1fsCdjTUR/uoQWKyabs8Qa
        phJbX/V/Emq7X6qBpclFx5gSE1lpIYY3TVVeyOdN5xC/qvEjxexpveFXqbPg7bZ3psI+01XFVjZa1
        Wh03Y7EW/3BzM3I6uOD/2gmyDS3YccPDGK0qdMcg6SSv4s6IxUeJuS4dxukanp1TFfXHc32QCsQNR
        ainDgqos5S+ekUe6Bx5IKbJsmxtud/bBoyhoKjxbgbuhjHLU7rtsLoM3kasC688EYbYsJ5wYfnkdK
        b60QmcZL0/RjKUcI7Tr4eAYY8aV69dlYd4m21WZyW92gMka0oOF3mv2VpAwqJotBNLkGElatye5DN
        n29vj33w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5fx7-00061D-BU; Mon, 18 Mar 2019 00:16:29 +0000
To:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] list.h: fix list_is_first() kernel-doc
Message-ID: <ddce8b80-9a8a-d52d-3546-87b2211c089a@infradead.org>
Date:   Sun, 17 Mar 2019 17:16:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typo of kernel-doc parameter notation (there should be
no space between '@' and the parameter name).

Also fixes bogus kernel-doc notation output formatting.

Fixes: 70b44595eafe9 ("mm, compaction: use free lists to quickly locate a migration source")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/list.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-51-rc1.orig/include/linux/list.h
+++ lnx-51-rc1/include/linux/list.h
@@ -207,7 +207,7 @@ static inline void list_bulk_move_tail(s
 }
 
 /**
- * list_is_first -- tests whether @ list is the first entry in list @head
+ * list_is_first -- tests whether @list is the first entry in list @head
  * @list: the entry to test
  * @head: the head of the list
  */


