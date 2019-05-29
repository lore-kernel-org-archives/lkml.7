Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B84C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355DE24303
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559171422;
	bh=7l2rsi0cMU3FHzhTcOF6vtMJCeAfJrK0JdiHqTonA3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vAO80MTPHoYZXLV/JJdp0uM9hIfGWTwtzquEwiFMzdbJd/gtDA/dpFlXnOZAxNkuL
	 0Fur5i6Nz68OldkLLyxFxdq2t0RwIpmGlkt2mbrfng04dfgjcv32s3Pd1YPsB5GKjc
	 jDe8eh2MBH4fkixbtYjdCmWXbkb7N22Nj6QA2USw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfE2XKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:10:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfE2XJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tS6RAB6sVg+kJ3U+MKfWQpKGE8UFNU5HfgzkbdPGAmk=; b=DY723L1SVURiF1RxxMu67JEPU8
        sOnmm/V2LW5VVq0b3tPMBaff70qGg4rmlldRv4Yhzgz+bkNtsgDlu4otE4AjugsLzGQ7PNCRYFJQK
        /IxM1+xa6Fy18mm2HJgW8BtjMqP/1TPoW7ohhXGifT1jVVa9GuXnzE/+2TXngwxWezlpNxf/rxGeg
        kEdS+T/15qp08ZAKpQN0gQ7lYyk5VU4GWj6KODkcI41Hftq/70Ki4sKgMWYtWCPCjCiH+q1Y3Y49Y
        3xaRkApKqMF4V5uWhEWWmhZ1+RtlEPTS3IfOByzkfGu6Wd7PyWGIcqDeUTlNeXWSu3A6Mlp54GN5w
        Uc2EbUaA==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7hQ-0000lL-FV; Wed, 29 May 2019 23:09:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7hN-0007Tt-Oy; Wed, 29 May 2019 20:09:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Nider <joeln@il.ibm.com>
Subject: [PATCH 10/10] docs: requirements.txt: recommend Sphinx 1.7.9
Date:   Wed, 29 May 2019 20:09:32 -0300
Message-Id: <08e7f5227b4e79d37e0e9afe7fba7cbc8476e4a2.1559170790.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559170790.git.mchehab+samsung@kernel.org>
References: <cover.1559170790.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed at the linux-doc ML, while we'll still support
version 1.3, it is time to recommend a more modern version.

So, let's switch the minimal requirements to Sphinx 1.7.9,
as it has the "-jauto" flag, with makes a lot faster when
building documentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/doc-guide/sphinx.rst    | 17 ++++++++---------
 Documentation/sphinx/requirements.txt |  4 ++--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index c039224b404e..4ba081f43e98 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -27,8 +27,7 @@ Sphinx Install
 ==============
 
 The ReST markups currently used by the Documentation/ files are meant to be
-built with ``Sphinx`` version 1.3 or higher. If you desire to build
-PDF output, it is recommended to use version 1.4.6 or higher.
+built with ``Sphinx`` version 1.3 or higher.
 
 There's a script that checks for the Sphinx requirements. Please see
 :ref:`sphinx-pre-install` for further details.
@@ -56,13 +55,13 @@ or ``virtualenv``, depending on how your distribution packaged Python 3.
       those expressions are written using LaTeX notation. It needs texlive
       installed with amdfonts and amsmath in order to evaluate them.
 
-In summary, if you want to install Sphinx version 1.4.9, you should do::
+In summary, if you want to install Sphinx version 1.7.9, you should do::
 
-       $ virtualenv sphinx_1.4
-       $ . sphinx_1.4/bin/activate
-       (sphinx_1.4) $ pip install -r Documentation/sphinx/requirements.txt
+       $ virtualenv sphinx_1.7.9
+       $ . sphinx_1.7.9/bin/activate
+       (sphinx_1.7.9) $ pip install -r Documentation/sphinx/requirements.txt
 
-After running ``. sphinx_1.4/bin/activate``, the prompt will change,
+After running ``. sphinx_1.7.9/bin/activate``, the prompt will change,
 in order to indicate that you're using the new environment. If you
 open a new shell, you need to rerun this command to enter again at
 the virtual environment before building the documentation.
@@ -105,8 +104,8 @@ command line options for your distro::
 	You should run:
 
 		sudo dnf install -y texlive-luatex85
-		/usr/bin/virtualenv sphinx_1.4
-		. sphinx_1.4/bin/activate
+		/usr/bin/virtualenv sphinx_1.7.9
+		. sphinx_1.7.9/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
 
 	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 742be3e12619..14e29a0ae480 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,3 @@
-docutils==0.12
-Sphinx==1.4.9
+docutils
+Sphinx==1.7.9
 sphinx_rtd_theme
-- 
2.21.0

