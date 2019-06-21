Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1887C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F812083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561120353;
	bh=fMZVBXbHv1Ong3WvlNIJiGvb+5Z9Cew+pxEE4axadwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XpQhsjKo/kmc+GlBKIgu7/AapC/I2nKFyCfenV92pHFNMmbHaGpBxPdQCN7LZ+fG/
	 zkKSFCodzgjuvAdqHpFqN/DDUOH2sq1QbEZz9D9SgT802krTCwxrwxnknktiWPNKLe
	 AFlHss6rFY99C/E5y4M6T3iXuSaK8acmfx9IOero=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfFUMcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:32:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfFUMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ra0xbYPSU+4H3pFb2eOnhM3NB1hvssFTkUjTKCV0aRM=; b=VQ0VBJhUL8WG6w1hqN+mJ6TG/W
        sa/aBvMrpftPNDYUOt3tTQjiMzvZa3R6QE3iNcIaNvf569s3QuIykZSqbzRNqfjzsUhZ/9dVjAAPk
        VWgaA4QMdsjIdxsGUctULHeAMrGas4/fsrtrn8H7trEVrgu3w7yElX786NCXQ6BdROj/LgaP2mQQf
        zSIstg/91rUxRcThwzuZWEzdxuuaf7F2DXkoHnqe3UGSluGCRY89xjFip4iIW5XIKFouOGBrFDPJt
        kYeWXcz0pSqLMEO3Z16/tbDf4MnYoB1add/roDdEqGaAr27It/tdmu+GpYTLPhof8MnShBjlP4bm5
        dofro21w==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heIiA-0003xO-Fs; Fri, 21 Jun 2019 12:32:10 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1heIi7-0001FF-Ut; Fri, 21 Jun 2019 09:32:07 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RFC 6/6] docs: abi: create a 2-depth index for ABI
Date:   Fri, 21 Jun 2019 09:32:06 -0300
Message-Id: <29a97004133729cc86e4586d2750e15460e44b48.1561118631.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561118631.git.mchehab+samsung@kernel.org>
References: <cover.1561118631.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That helps to identify what ABI files are adding titles.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/abi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/abi.rst b/Documentation/admin-guide/abi.rst
index 3b9645c77469..bcab3ef2597c 100644
--- a/Documentation/admin-guide/abi.rst
+++ b/Documentation/admin-guide/abi.rst
@@ -3,7 +3,7 @@ Linux ABI description
 =====================
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 2
 
    abi-stable
    abi-testing
-- 
2.21.0

