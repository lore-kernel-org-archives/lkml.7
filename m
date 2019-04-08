Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2A9C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0778F20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742783;
	bh=4rofTVYaXEjIDo2mbeSYR8L8f4geJknLDvdv++F/m7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r3l03XKQaV0XiSn48sl6ZWFdRgey9yMIJQYOvevqhD9EoLce4gWnPY/j06w7jOYy1
	 QokqfOwAOXveC+eTadsnFJ+7QfMYLyUjncR4wldVfXEuNz4IuV9F4lS2ILFSC3ce7V
	 qBWyW2ZDnME26jcYIcZpw21BFQ8VL6GeXRuzNUsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfDHQ7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:59:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbfDHQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=81/KmEkB+/pugen2d+cVnJhqjOy8JESn90tSCrSP5OA=; b=QOgC7zlTzAw4y2Y7TFowxGsZRc
        PJcn58cDLE10cX1vxRR3bQGOktmaB3OU9PLTrcOzoJY4U5kncmN8BkWN1NyByCg4dt8z+0bFnH8lh
        SRab/Aul08EsF4Kg9MiX9SE1d/w3/QQ4rnrq5N+OltPyzFGcsyLjJRlwKViZBBao4cguS2SGvjXkb
        d7mj/APLonbcDZAQrdGgAROzp4g1JJsfb9F2W/t/6i08Yfk9Q+7I5t2hVoJwEhfuCW9R6Iuu8FUAq
        KQKj5i/9IJa1q2d4mr5JHrjTgW2psBtgBMPMF1xPDxoXZJYU7VSomzlKviva5NiXeAYeVy68LmrLE
        tkNxJNVw==;
Received: from [179.95.33.162] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXbO-0005Ss-67; Mon, 08 Apr 2019 16:58:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hDXbI-0005nX-D4; Mon, 08 Apr 2019 13:58:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 09/10] docs: speculation.rst: mark example blocks as such
Date:   Mon,  8 Apr 2019 13:58:25 -0300
Message-Id: <0aa821b9a14f61755e97007562e84c66a3c13f3d.1554742526.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554742526.git.mchehab+samsung@kernel.org>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
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
 Documentation/other/speculation.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/other/speculation.rst b/Documentation/other/speculation.rst
index e9e6cbae2841..50d7ea857cff 100644
--- a/Documentation/other/speculation.rst
+++ b/Documentation/other/speculation.rst
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

