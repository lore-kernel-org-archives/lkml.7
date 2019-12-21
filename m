Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D593C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A508206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfLUSgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 13:36:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:54461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfLUSgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 13:36:44 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2019 10:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,340,1571727600"; 
   d="scan'208";a="213860818"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Dec 2019 10:36:43 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iijcI-000EYG-IO; Sun, 22 Dec 2019 02:36:42 +0800
Date:   Sun, 22 Dec 2019 02:36:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     kbuild-all@lists.01.org, Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: [RFC PATCH] vfs: generic_fs_parameters can be static
Message-ID: <20191221183612.pdxvwnkqouoytjvj@4978f4969bb8>
References: <20191212213604.19525-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212213604.19525-1-labbott@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: fa45c7e4862f ("vfs: Handle file systems without ->parse_params better")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 fs_context.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 8c5dc131e29ac..604f1a3d73aac 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -116,7 +116,7 @@ static const struct fs_parameter_spec generic_fs_param_specs[] = {
         {}
 };
 
-const struct fs_parameter_description generic_fs_parameters = {
+static const struct fs_parameter_description generic_fs_parameters = {
         .name           = "generic_fs",
         .specs          = generic_fs_param_specs,
 };
