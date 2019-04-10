Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99889C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A841217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554890202;
	bh=njVBkfYOqks9z8aT/jedhq/3p2JD1dkdOrZHfnhaWN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oAo9jVjX3w3rUgCWAQ3KtndxpVPWSr8zeVeF/HAlOZLxVbIVakPNWCu2sJNoyfBIn
	 heRdKteWrcfV04MkMwIuZzdt3JccaJLtSNrcIvb/NzCvj4xj9rVEo88l3aE7nO65OI
	 OJZPH1ETchnx2w/13MX9FLYRT+EojrmD4cu6eaUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfDJJ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:56:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfDJJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YprWmfwhQF20Qys/UdJ3RBGreoWNm3/nxiInaksXJ+o=; b=tpadLzQl4noh+bArYx4m+wD4q0
        X67k5D/8/4dmaQkM1S9Ksd8N+8cHU/rkthXXoBXM+bpIj8SQ5QtulLSsIvZBaNb7nX1gqXg00haVa
        kADIDc2PDOyWhkUvWDZaBjEtwbHPMJHLoOyxpgazq4tiLYYTF6Mq8oirumB9vNxEfYQZqUeTtD6tV
        BDfwakks1AjXZXr3HzGl/eK5sRddaDgVduLYsE77JpS1Teol2jl/uur3NErk0EXKsvBdffMBWJ5ij
        SRnw54tyjsi23dAsghO2DiXYCq36/sFJmUxslUNIrvKTjtyAO5E8NvVcJmXzS3wftowQJxHTVsRFc
        O+3Sw9CA==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE9y9-0003Cn-6R; Wed, 10 Apr 2019 09:56:37 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hE9y3-0000oP-T8; Wed, 10 Apr 2019 06:56:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 8/8] docs: speculation.txt: mark example blocks as such
Date:   Wed, 10 Apr 2019 06:56:27 -0300
Message-Id: <793a3b0103b2d91e4bf850849f9de76cee3273a9.1554889999.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554889999.git.mchehab+samsung@kernel.org>
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identify the example blocks there, in order to avoid Sphinx
warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/speculation.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/speculation.txt b/Documentation/speculation.txt
index e9e6cbae2841..50d7ea857cff 100644
--- a/Documentation/speculation.txt
+++ b/Documentation/speculation.txt
@@ -17,7 +17,7 @@ observed to extract secret information.
 
 For example, in the presence of branch prediction, it is possible for bounds
 checks to be ignored by code which is speculatively executed. Consider the
-following code:
+following code::
 
 	int load_array(int *array, unsigned int index)
 	{
@@ -27,7 +27,7 @@ following code:
 			return array[index];
 	}
 
-Which, on arm64, may be compiled to an assembly sequence such as:
+Which, on arm64, may be compiled to an assembly sequence such as::
 
 	CMP	<index>, #MAX_ARRAY_ELEMS
 	B.LT	less
@@ -44,7 +44,7 @@ microarchitectural state which can be subsequently measured.
 
 More complex sequences involving multiple dependent memory accesses may
 result in sensitive information being leaked. Consider the following
-code, building on the prior example:
+code, building on the prior example::
 
 	int load_dependent_arrays(int *arr1, int *arr2, int index)
 	{
@@ -77,7 +77,7 @@ A call to array_index_nospec(index, size) returns a sanitized index
 value that is bounded to [0, size) even under cpu speculation
 conditions.
 
-This can be used to protect the earlier load_array() example:
+This can be used to protect the earlier load_array() example::
 
 	int load_array(int *array, unsigned int index)
 	{
-- 
2.20.1

