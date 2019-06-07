Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4532C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB4720868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559933748;
	bh=gUsSRIgwGG5++KN4cLUf8V8Gg0DEky5PXVRQkRULZqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eQ7zAtYVV85WDWCUpKeUkKcBbY6KqqzJle1s29eLmb/92bB7dHj1gTzHsLYprbPil
	 dZEJgZdsRvpXoFcosyS+jMSSsSXLfziG5NszlxlwM+H5K40ZtDdX0MN7AObGcnmdYs
	 3v2eEhfNiYsFCDwUErSds/jspWrxsOk3ThH8dFxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfFGSzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:55:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbfFGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e3C4ul1ER6PyCoizpBQg5C8nin/xYkn5bpb6N98bym8=; b=q/bqPLHcZic+BcN8nra57eHCqK
        aqgJXfRNnHQXl3Np3DnZCzyGe+0ZNxz5OA+bDaokK4/Bl5iU0FviZ1wVp87vFTBLYVo40UKIUf4QP
        uXy29Qe9zUL6buBMX1AkzSXONqIvGbtkX1NXd1+TtuyQdUxDSoOKtFrZO5sdT6NPnEay8AiWjRPBi
        ishF7rW4vHXnb6vxoKlOLH055ytS7n8siudayrH89hmvS1t3YOM1VGbiHNaz6TJoXtp89ZxM8sW+M
        Zh7xkzUy06WXNPJW3vi4x9U3IgX5XokSgjkku43slDxVNu7NlV+zn4AdftbZXMMAI/UUoRN4o3+TW
        IjSSBCRw==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sk-M2; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007Ei-AQ; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v3 05/20] docs: bpf: get rid of two warnings
Date:   Fri,  7 Jun 2019 15:54:21 -0300
Message-Id: <bb7b4935e20f456e25f4d44c49a93bcad8df95c4.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/bpf/btf.rst:154: WARNING: Unexpected indentation.
Documentation/bpf/btf.rst:163: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
---
 Documentation/bpf/btf.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 8820360d00da..4ae022d274ab 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -151,6 +151,7 @@ for the type. The maximum value of ``BTF_INT_BITS()`` is 128.
 
 The ``BTF_INT_OFFSET()`` specifies the starting bit offset to calculate values
 for this int. For example, a bitfield struct member has:
+
  * btf member bit offset 100 from the start of the structure,
  * btf member pointing to an int type,
  * the int type has ``BTF_INT_OFFSET() = 2`` and ``BTF_INT_BITS() = 4``
@@ -160,6 +161,7 @@ from bits ``100 + 2 = 102``.
 
 Alternatively, the bitfield struct member can be the following to access the
 same bits as the above:
+
  * btf member bit offset 102,
  * btf member pointing to an int type,
  * the int type has ``BTF_INT_OFFSET() = 0`` and ``BTF_INT_BITS() = 4``
-- 
2.21.0

