Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C37C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2916D208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558955278;
	bh=7l2rsi0cMU3FHzhTcOF6vtMJCeAfJrK0JdiHqTonA3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z7tL0gi5+n9hhL2o/0F2IZsVgDPssNrGSbOAPVTxKCWEe/ECskL2eHlbwSWLec0tw
	 gaFqUVYFZUkJ6aubZ5EEnTKC4h0T566JXUhwASDwxK8B5qXcffnVc4oSKt13533rqv
	 eBKN2vZlN4Zn5e3fVWNTucLdqhR3oFb0dDRo35Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfE0LHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:07:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfE0LHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tS6RAB6sVg+kJ3U+MKfWQpKGE8UFNU5HfgzkbdPGAmk=; b=G3MGG0KGi1GEDMk45x5Cqe45DL
        i0C3iJCVGoqUnvkxkTg7LuUsAHIlhf/q6tnzqV7OQk6yQzEucjIkE7ebtEduJ3hfkN8ANGDgpEng/
        tgGvJkxZigUcLf0dxqgruti/mlKNiQCSiVCVbERcp5JIIzCUibSd+YVBkJ4LCdniaM+TCd/OTKIzY
        TQpV8LO9hP1s9q+/vVg+pKKCT1Ijm/5C1QDMv4q0hAt4y2cCgkIMyiD1YEgNziBpQWkzHe4tUGlb3
        IYWljMTTkycEty5eFrlGN8vTqajO19PD+3P66TtSUxgj1Wi7OX4ayOm6LM3wHqC7RiPDxMbG0CLdT
        0dWtbTfw==;
Received: from [177.159.249.4] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVDTn-00061x-OS; Mon, 27 May 2019 11:07:47 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hVDTi-0002cu-RM; Mon, 27 May 2019 08:07:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Nider <joeln@il.ibm.com>
Subject: [PATCH 5/5] docs: requirements.txt: recommend Sphinx 1.7.9
Date:   Mon, 27 May 2019 08:07:41 -0300
Message-Id: <2020d45c8f7ed71d5f66ba5d925ecdd81e044a9d.1558955082.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558955082.git.mchehab+samsung@kernel.org>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
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

