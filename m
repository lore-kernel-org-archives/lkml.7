Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37231C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B33224307
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559171390;
	bh=ISQIgqAcf9s5x8hI7Y8uSHhbETm9nvTqQUKDTDEFxJE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LrYrXXDK87rBW9FUmWxCEs4nmIB5aNmBhA7wRoznweQumbx9WN1uqThaEXC3+WRcD
	 W8DQaCKaa3xQ3rXguQGPwjEb1mkt++w8HzX2l5hZbiFCVk/DJ6S7dbUUNNYzeoD2U9
	 iixkElJp+JwY8iNEUE/iO/lLfGWQE8gu/ZKmoSdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfE2XJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:09:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfE2XJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UKpsrDHnFfj+bCPyxEExWGka1JPVhaziYLtRF8hHMTk=; b=VZJV35UqsfyADWpbRsiobOZJ9
        9lRq1hcAH14+Tav9WglGnJX1T503kmQVGIiYxlUXkhIYJOS/HwkHv/h7BEkSauSOgqCIkZF1bwz8Z
        z3BRxufqK0oUcdRf5j+PYuhljb0usS0yPnj3hZ2A5SUqXi9WRgXe+ou+/UwcDtA1Kw11Hd+XUN4jw
        tiw0nUc9Ja9TjxuDf9hJJ2Wrlv+BpuWt7p7DfZkfhiRwGpA0YlQhL2NjL0SZapruvehkW6SBdKzh1
        CgbuHrARCgYJwYF1yMLJSl6QGYhIIw3dEU7PbJQwRKEbiHUAWHveLEy6bZ5ZK7lRvaauQF1je5ku4
        xcRLsxtTA==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7hQ-0000lJ-GB; Wed, 29 May 2019 23:09:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7hN-0007TG-GG; Wed, 29 May 2019 20:09:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Joel Nider <joeln@il.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 00/10] Improvements to the documentation build system
Date:   Wed, 29 May 2019 20:09:22 -0300
Message-Id: <cover.1559170790.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

This series contain some improvements for the building system.

I sent already several of the patches here. They're rebased on the
top of your docs-next tree:

patch 1: gets rid of a warning since version 1.8 (I guess it starts
appearing with 1.8.6);

patches 2 to 4: improve the pre-install script;

patches 5 to 8: improve the script with checks broken doc references;

patch 9: by default, use "-jauto" with Sphinx 1.7 or upper, in order
to speed up the build.

patch 10 changes the recommended Sphinx version to 1.7.9. It keeps
the minimal supported version to 1.3.

Patch 4 contains a good description of the improvements made at
the build system. 

If you prefer, you can pull those patches (and the next series I'm
submitting you) from my development git tree:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=fix_doc_links_v2

Regards,
Mauro

-

Mauro Carvalho Chehab (10):
  docs: cdomain.py: get rid of a warning since version 1.8
  scripts/sphinx-pre-install: make activate hint smarter
  scripts/sphinx-pre-install: get rid of RHEL7 explicity check
  scripts/sphinx-pre-install: always check if version is compatible with
    build
  scripts/documentation-file-ref-check: better handle translations
  scripts/documentation-file-ref-check: exclude false-positives
  scripts/documentation-file-ref-check: improve tools ref handling
  scripts/documentation-file-ref-check: teach about .txt -> .yaml
    renames
  docs: by default, build docs a lot faster with Sphinx >= 1.7
  docs: requirements.txt: recommend Sphinx 1.7.9

 Documentation/Makefile                |  7 +++
 Documentation/doc-guide/sphinx.rst    | 17 +++---
 Documentation/sphinx/cdomain.py       |  5 +-
 Documentation/sphinx/requirements.txt |  4 +-
 scripts/documentation-file-ref-check  | 44 ++++++++++++----
 scripts/sphinx-pre-install            | 75 +++++++++++++++------------
 6 files changed, 97 insertions(+), 55 deletions(-)

-- 
2.21.0


