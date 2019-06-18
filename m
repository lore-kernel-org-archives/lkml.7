Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8678FC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91EA2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="5X3ssSVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfFRHvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:51:31 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:51:31 -0400
Received: from leknes.fjasle.eu ([92.116.119.3]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MplPf-1iOb3h2GVB-00qDy9; Tue, 18 Jun 2019 09:51:00 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id C400D423D2; Tue, 18 Jun 2019 09:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1560844258; bh=JSr5FYsreTev5jm3vVvWViVsoZetQ5kuXV8VrQDPf00=;
        h=From:To:Cc:Subject:Date:From;
        b=5X3ssSVGmS0WCLjiQo0zJx46t2uoIzfkfWiHqwk7LeBTWHDIOMk7AeRvobcgnyD74
         hlsSb1iC2uA5hyomF/STv7zFJCagIwItyDYdlp+hCcqs7Wc5+fdBVqqddiWRlgZ7nZ
         vymfXz7o4Dv8XRR/uPTTE/3uq1G3Qi9boGk0iZgY=
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolas Schier <n.schier@avm.de>
Subject: [PATCH v2] ovl: fix typo in MODULE_PARM_DESC
Date:   Tue, 18 Jun 2019 09:50:29 +0200
Message-Id: <20190618075029.3996-1-nicolas@fjasle.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Q33Sp8kmOxGQnwqbLn5Hpm/t+PNaNrsb+Lrpw4Lu6tKJbEzggEv
 Ccu2nGj+wF33t3e0g34ig6E3/wdEtNWMkM/YpMv6NkWKvHXgWvcyjGWjNtprVdiz63jsNqx
 AeKhzlvTGcHwNdFEDiZjEpTEvSbnrYloZzp3oh+TaQrt/Jma/OSYrcVgocPj/iU5jRIEx1J
 mUuSMnfF4qxSyi61WniVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ka3ClcJ244=:xT1SfDAQy4o+ojiXSPbYsu
 WCHzMq6i9OXaNqSXR6F2qWG3By8zmCBTxJeelhuxRjBl2zX4EyVsSFCo5sbQ3JzmTyefVmJlH
 yt7A+6rJm9Z1hZwPAIWcu3+dQZwH0sgXx7DcC2CnHMrYtqJX0Fa/OsXnAgQwqUa1RIovH82KV
 9YZoL/0S0Ao1KqhB2C5qnn67gBdgP55AQixt1JgXlnPmbRFHKtoqalorCMJKzq3UHUJtPN3Vp
 fw/RMRLwvdt5hAe4jUApRusv89ST/weVAiVXo4dxv8KzYG+1Njxh9hZXKTkv29QNp4J2IW4pD
 KDR+Ni3jk7O0sfYoYlVIQYSBbRVadGZTZP42woza37jlHK9EOeYik3+lavoy5IfpbLoDBAcJ3
 OVoD3mSi7DTiEq/ZgVoSpJ5YxLgo4qTsoPJP4KY0SXOUGHV5NxJ4YZkqRcug3Av4ZocnGPgIp
 me5SGRPYujMemOio5eci6pO1Qzdm4M8dSWkjC5nR3M5aY3R1GhwI0FUIoxrnmoR9uqYWKSl5S
 Cx3Y5ESx8aQLu5kowg55VBGAF7eoZqCHALpuiLTCf840snmbF0GV3jdpa5xJqBx3MoGqEbqOK
 kkVdyjFqk0Wt2A2ioYFzvBlm7IaoeJJGDLMQ1WvtTtYVJk0mEG/ziHvUqgUgT+HH7ephhQ/6g
 N+Ki0g7Pd/FzcyVCNb7ebOhZaUAXhFfjwVsm+8V9CTW86Bc3hxmWxH4+kQUzgbStuWD6+i3PI
 xntuPTVOx7vZUW5yZgOdDlIzU9liKUB4llW7cQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Schier <n.schier@avm.de>

Change first argument of MODULE_PARM_DESC() calls, such that each of
them matches the actual module parameter name.  The patch results in
changing (the 'parm' section from) the output of `modinfo overlay`:

    parm: ovl_check_copy_up:Obsolete; does nothing
    parm: redirect_max:ushort
    parm: ovl_redirect_max:Maximum length of absolute redirect xattr value
    parm: redirect_dir:bool
    parm: ovl_redirect_dir_def:Default to on or off for the redirect_ [...]
    parm: redirect_always_follow:bool
    parm: ovl_redirect_always_follow:Follow redirects even if [...]
    parm: index:bool
    parm: ovl_index_def:Default to on or off for the inodes index [...]
    parm: nfs_export:bool
    parm: ovl_nfs_export_def:Default to on or off for the NFS export [...]
    parm: xino_auto:bool
    parm: ovl_xino_auto_def:Auto enable xino feature
    parm: metacopy:bool
    parm: ovl_metacopy_def:Default to on or off for the metadata only [...]

into:

    parm: check_copy_up:Obsolete; does nothing
    parm: redirect_max:Maximum length of absolute redirect xattr [...]
    parm: redirect_dir:Default to on or off for the redirect_dir [...]
    parm: redirect_always_follow:Follow redirects even if [...]
    parm: index:Default to on or off for the inodes index feature [...]
    parm: nfs_export:Default to on or off for the NFS export feature [...]
    parm: xino_auto:Auto enable xino feature (bool)
    parm: metacopy:Default to on or off for the metadata only copy up [...]

Signed-off-by: Nicolas Schier <n.schier@avm.de>
---

Changes since v1:
 - update/fix commit message wording (now completely checkpatch
   compliant)

 fs/overlayfs/copy_up.c |  2 +-
 fs/overlayfs/dir.c     |  2 +-
 fs/overlayfs/super.c   | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 9e62dcf06fc4..e9cdc453f247 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -37,7 +37,7 @@ static int ovl_ccup_get(char *buf, const struct kernel_param *param)
 }
 
 module_param_call(check_copy_up, ovl_ccup_set, ovl_ccup_get, NULL, 0644);
-MODULE_PARM_DESC(ovl_check_copy_up, "Obsolete; does nothing");
+MODULE_PARM_DESC(check_copy_up, "Obsolete; does nothing");
 
 int ovl_copy_xattr(struct dentry *old, struct dentry *new)
 {
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 82c129bfe58d..dbcb3ff588aa 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -21,7 +21,7 @@
 
 static unsigned short ovl_redirect_max = 256;
 module_param_named(redirect_max, ovl_redirect_max, ushort, 0644);
-MODULE_PARM_DESC(ovl_redirect_max,
+MODULE_PARM_DESC(redirect_max,
 		 "Maximum length of absolute redirect xattr value");
 
 static int ovl_set_redirect(struct dentry *dentry, bool samedir);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 0116735cc321..eb32e68f1a83 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -31,29 +31,29 @@ struct ovl_dir_cache;
 
 static bool ovl_redirect_dir_def = IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_DIR);
 module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
-MODULE_PARM_DESC(ovl_redirect_dir_def,
+MODULE_PARM_DESC(redirect_dir,
 		 "Default to on or off for the redirect_dir feature");
 
 static bool ovl_redirect_always_follow =
 	IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW);
 module_param_named(redirect_always_follow, ovl_redirect_always_follow,
 		   bool, 0644);
-MODULE_PARM_DESC(ovl_redirect_always_follow,
+MODULE_PARM_DESC(redirect_always_follow,
 		 "Follow redirects even if redirect_dir feature is turned off");
 
 static bool ovl_index_def = IS_ENABLED(CONFIG_OVERLAY_FS_INDEX);
 module_param_named(index, ovl_index_def, bool, 0644);
-MODULE_PARM_DESC(ovl_index_def,
+MODULE_PARM_DESC(index,
 		 "Default to on or off for the inodes index feature");
 
 static bool ovl_nfs_export_def = IS_ENABLED(CONFIG_OVERLAY_FS_NFS_EXPORT);
 module_param_named(nfs_export, ovl_nfs_export_def, bool, 0644);
-MODULE_PARM_DESC(ovl_nfs_export_def,
+MODULE_PARM_DESC(nfs_export,
 		 "Default to on or off for the NFS export feature");
 
 static bool ovl_xino_auto_def = IS_ENABLED(CONFIG_OVERLAY_FS_XINO_AUTO);
 module_param_named(xino_auto, ovl_xino_auto_def, bool, 0644);
-MODULE_PARM_DESC(ovl_xino_auto_def,
+MODULE_PARM_DESC(xino_auto,
 		 "Auto enable xino feature");
 
 static void ovl_entry_stack_free(struct ovl_entry *oe)
@@ -66,7 +66,7 @@ static void ovl_entry_stack_free(struct ovl_entry *oe)
 
 static bool ovl_metacopy_def = IS_ENABLED(CONFIG_OVERLAY_FS_METACOPY);
 module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
-MODULE_PARM_DESC(ovl_metacopy_def,
+MODULE_PARM_DESC(metacopy,
 		 "Default to on or off for the metadata only copy up feature");
 
 static void ovl_dentry_release(struct dentry *dentry)
-- 
2.20.1

