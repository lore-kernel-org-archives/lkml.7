Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BC3C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312A9214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393756AbfIXRBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:01:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfIXRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:01:34 -0400
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iCoBw-0000q2-7w; Tue, 24 Sep 2019 17:01:32 +0000
Subject: Re: [WTF?] aafs_create_symlink() weirdness
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org
References: <20190924020348.GD26530@ZenIV.linux.org.uk>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <c2604d70-4c65-eb90-2cff-dd96f724222c@canonical.com>
Date:   Tue, 24 Sep 2019 10:01:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924020348.GD26530@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 7:03 PM, Al Viro wrote:

WTF indeed

> 
> static struct dentry *aafs_create_symlink(const char *name,
>                                           struct dentry *parent,
>                                           const char *target,
>                                           void *private,
>                                           const struct inode_operations *iops)
> {
>         struct dentry *dent;
>         char *link = NULL;
> 
>         if (target) {
>                 if (!link)
>                         return ERR_PTR(-ENOMEM);
>         }
> 
> Er...  That's an odd way to spell
> 	if (target)
> 		return ERR_PTR(-ENOMEM);
> (and an odd error value to use).  Especially since all callers are passing
> NULL as target.
> 
> Why is that code even there, why does that argument still exist and
> how many people have actually read that function?
> 

It looks like 1180b4c757aa failed to drop it as part of the patch, but it
certainly should have. I can't say why it happened but regardless its an ugly
mistake. Thank you very much for catching this Al.

A patch to drop it is below or feel free to cons up an alternate version.

---

commit 5dbc63d4a0aa819be8ecf21a67a352dd377b0221
Author: John Johansen <john.johansen@canonical.com>
Date:   Tue Sep 24 09:46:33 2019 -0700

    apparmor: remove useless aafs_create_symlink
    
    1180b4c757aa ("apparmor: fix dangling symlinks to policy rawdata after
    replacement") reworked how the rawdata symlink is handled but failed
    to remove aafs_create_symlink which was reduced to a useless stub .
    
    Fixes: 1180b4c757aa ("apparmor: fix dangling symlinks to policy rawdata after replacement")
    Reported-by: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 9c0e593e30aa..308c99ea3cf8 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -335,38 +335,6 @@ static struct dentry *aafs_create_dir(const char *name, struct dentry *parent)
 			   NULL);
 }
 
-/**
- * aafs_create_symlink - create a symlink in the apparmorfs filesystem
- * @name: name of dentry to create
- * @parent: parent directory for this dentry
- * @target: if symlink, symlink target string
- * @private: private data
- * @iops: struct of inode_operations that should be used
- *
- * If @target parameter is %NULL, then the @iops parameter needs to be
- * setup to handle .readlink and .get_link inode_operations.
- */
-static struct dentry *aafs_create_symlink(const char *name,
-					  struct dentry *parent,
-					  const char *target,
-					  void *private,
-					  const struct inode_operations *iops)
-{
-	struct dentry *dent;
-	char *link = NULL;
-
-	if (target) {
-		if (!link)
-			return ERR_PTR(-ENOMEM);
-	}
-	dent = aafs_create(name, S_IFLNK | 0444, parent, private, link, NULL,
-			   iops);
-	if (IS_ERR(dent))
-		kfree(link);
-
-	return dent;
-}
-
 /**
  * aafs_remove - removes a file or directory from the apparmorfs filesystem
  *
@@ -1757,25 +1725,25 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 	}
 
 	if (profile->rawdata) {
-		dent = aafs_create_symlink("raw_sha1", dir, NULL,
-					   profile->label.proxy,
-					   &rawdata_link_sha1_iops);
+		dent = aafs_create("raw_sha1", S_IFLNK | 0444, dir,
+				   profile->label.proxy, NULL, NULL,
+				   &rawdata_link_sha1_iops);
 		if (IS_ERR(dent))
 			goto fail;
 		aa_get_proxy(profile->label.proxy);
 		profile->dents[AAFS_PROF_RAW_HASH] = dent;
 
-		dent = aafs_create_symlink("raw_abi", dir, NULL,
-					   profile->label.proxy,
-					   &rawdata_link_abi_iops);
+		dent = aafs_create("raw_abi", S_IFLNK | 0444, dir,
+				   profile->label.proxy, NULL, NULL,
+				   &rawdata_link_abi_iops);
 		if (IS_ERR(dent))
 			goto fail;
 		aa_get_proxy(profile->label.proxy);
 		profile->dents[AAFS_PROF_RAW_ABI] = dent;
 
-		dent = aafs_create_symlink("raw_data", dir, NULL,
-					   profile->label.proxy,
-					   &rawdata_link_data_iops);
+		dent = aafs_create("raw_data", S_IFLNK | 0444, dir,
+				   profile->label.proxy, NULL, NULL,
+				   &rawdata_link_data_iops);
 		if (IS_ERR(dent))
 			goto fail;
 		aa_get_proxy(profile->label.proxy);

