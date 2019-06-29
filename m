Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC467C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771C42086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 12:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfF2Mof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 08:44:35 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10179 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfF2Mof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 08:44:35 -0400
X-IronPort-AV: E=Sophos;i="5.63,431,1557180000"; 
   d="scan'208";a="389687118"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2019 14:44:31 +0200
Date:   Sat, 29 Jun 2019 14:44:31 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     zyan@redhat.com, idryomov@gmail.com, linux-kernel@vger.kernel.org,
        kbuild-all@01.org
Subject: fs/ceph/export.c:459:3-12: code aligned with following code on line
 461 (fwd)
Message-ID: <alpine.DEB.2.21.1906291443070.2577@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no bug here, but some code starting on line 461 seems to be
incorrectly indented.

julia

---------- Forwarded message ----------
Date: Sat, 29 Jun 2019 19:51:04 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: fs/ceph/export.c:459:3-12: code aligned with following code on line 461

CC: kbuild-all@01.org
CC: linux-kernel@vger.kernel.org
TO: "Yan, Zheng" <zyan@redhat.com>
CC: Ilya Dryomov <idryomov@gmail.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   249155c20f9b0754bc1b932a33344cfb4e0c2101
commit: 570df4e9c23f861aa3f8f2954468c534a033bf1a ceph: snapshot nfs re-export
date:   8 weeks ago
:::::: branch date: 5 days ago
:::::: commit date: 8 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> fs/ceph/export.c:459:3-12: code aligned with following code on line 461

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=570df4e9c23f861aa3f8f2954468c534a033bf1a
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 570df4e9c23f861aa3f8f2954468c534a033bf1a
vim +459 fs/ceph/export.c

a8e63b7d Sage Weil  2009-10-06  401
570df4e9 Yan, Zheng 2017-11-15  402  static int __get_snap_name(struct dentry *parent, char *name,
570df4e9 Yan, Zheng 2017-11-15  403  			   struct dentry *child)
570df4e9 Yan, Zheng 2017-11-15  404  {
570df4e9 Yan, Zheng 2017-11-15  405  	struct inode *inode = d_inode(child);
570df4e9 Yan, Zheng 2017-11-15  406  	struct inode *dir = d_inode(parent);
570df4e9 Yan, Zheng 2017-11-15  407  	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
570df4e9 Yan, Zheng 2017-11-15  408  	struct ceph_mds_request *req = NULL;
570df4e9 Yan, Zheng 2017-11-15  409  	char *last_name = NULL;
570df4e9 Yan, Zheng 2017-11-15  410  	unsigned next_offset = 2;
570df4e9 Yan, Zheng 2017-11-15  411  	int err = -EINVAL;
570df4e9 Yan, Zheng 2017-11-15  412
570df4e9 Yan, Zheng 2017-11-15  413  	if (ceph_ino(inode) != ceph_ino(dir))
570df4e9 Yan, Zheng 2017-11-15  414  		goto out;
570df4e9 Yan, Zheng 2017-11-15  415  	if (ceph_snap(inode) == CEPH_SNAPDIR) {
570df4e9 Yan, Zheng 2017-11-15  416  		if (ceph_snap(dir) == CEPH_NOSNAP) {
570df4e9 Yan, Zheng 2017-11-15  417  			strcpy(name, fsc->mount_options->snapdir_name);
570df4e9 Yan, Zheng 2017-11-15  418  			err = 0;
570df4e9 Yan, Zheng 2017-11-15  419  		}
570df4e9 Yan, Zheng 2017-11-15  420  		goto out;
570df4e9 Yan, Zheng 2017-11-15  421  	}
570df4e9 Yan, Zheng 2017-11-15  422  	if (ceph_snap(dir) != CEPH_SNAPDIR)
570df4e9 Yan, Zheng 2017-11-15  423  		goto out;
570df4e9 Yan, Zheng 2017-11-15  424
570df4e9 Yan, Zheng 2017-11-15  425  	while (1) {
570df4e9 Yan, Zheng 2017-11-15  426  		struct ceph_mds_reply_info_parsed *rinfo;
570df4e9 Yan, Zheng 2017-11-15  427  		struct ceph_mds_reply_dir_entry *rde;
570df4e9 Yan, Zheng 2017-11-15  428  		int i;
570df4e9 Yan, Zheng 2017-11-15  429
570df4e9 Yan, Zheng 2017-11-15  430  		req = ceph_mdsc_create_request(fsc->mdsc, CEPH_MDS_OP_LSSNAP,
570df4e9 Yan, Zheng 2017-11-15  431  					       USE_AUTH_MDS);
570df4e9 Yan, Zheng 2017-11-15  432  		if (IS_ERR(req)) {
570df4e9 Yan, Zheng 2017-11-15  433  			err = PTR_ERR(req);
570df4e9 Yan, Zheng 2017-11-15  434  			req = NULL;
570df4e9 Yan, Zheng 2017-11-15  435  			goto out;
570df4e9 Yan, Zheng 2017-11-15  436  		}
570df4e9 Yan, Zheng 2017-11-15  437  		err = ceph_alloc_readdir_reply_buffer(req, inode);
570df4e9 Yan, Zheng 2017-11-15  438  		if (err)
570df4e9 Yan, Zheng 2017-11-15  439  			goto out;
570df4e9 Yan, Zheng 2017-11-15  440
570df4e9 Yan, Zheng 2017-11-15  441  		req->r_direct_mode = USE_AUTH_MDS;
570df4e9 Yan, Zheng 2017-11-15  442  		req->r_readdir_offset = next_offset;
570df4e9 Yan, Zheng 2017-11-15  443  		req->r_args.readdir.flags =
570df4e9 Yan, Zheng 2017-11-15  444  				cpu_to_le16(CEPH_READDIR_REPLY_BITFLAGS);
570df4e9 Yan, Zheng 2017-11-15  445  		if (last_name) {
570df4e9 Yan, Zheng 2017-11-15  446  			req->r_path2 = last_name;
570df4e9 Yan, Zheng 2017-11-15  447  			last_name = NULL;
570df4e9 Yan, Zheng 2017-11-15  448  		}
570df4e9 Yan, Zheng 2017-11-15  449
570df4e9 Yan, Zheng 2017-11-15  450  		req->r_inode = dir;
570df4e9 Yan, Zheng 2017-11-15  451  		ihold(dir);
570df4e9 Yan, Zheng 2017-11-15  452  		req->r_dentry = dget(parent);
570df4e9 Yan, Zheng 2017-11-15  453
570df4e9 Yan, Zheng 2017-11-15  454  		inode_lock(dir);
570df4e9 Yan, Zheng 2017-11-15  455  		err = ceph_mdsc_do_request(fsc->mdsc, NULL, req);
570df4e9 Yan, Zheng 2017-11-15  456  		inode_unlock(dir);
570df4e9 Yan, Zheng 2017-11-15  457
570df4e9 Yan, Zheng 2017-11-15  458  		if (err < 0)
570df4e9 Yan, Zheng 2017-11-15 @459  			goto out;
570df4e9 Yan, Zheng 2017-11-15  460
570df4e9 Yan, Zheng 2017-11-15 @461  		 rinfo = &req->r_reply_info;
570df4e9 Yan, Zheng 2017-11-15  462  		 for (i = 0; i < rinfo->dir_nr; i++) {
570df4e9 Yan, Zheng 2017-11-15  463  			 rde = rinfo->dir_entries + i;
570df4e9 Yan, Zheng 2017-11-15  464  			 BUG_ON(!rde->inode.in);
570df4e9 Yan, Zheng 2017-11-15  465  			 if (ceph_snap(inode) ==
570df4e9 Yan, Zheng 2017-11-15  466  			     le64_to_cpu(rde->inode.in->snapid)) {
570df4e9 Yan, Zheng 2017-11-15  467  				 memcpy(name, rde->name, rde->name_len);
570df4e9 Yan, Zheng 2017-11-15  468  				 name[rde->name_len] = '\0';
570df4e9 Yan, Zheng 2017-11-15  469  				 err = 0;
570df4e9 Yan, Zheng 2017-11-15  470  				 goto out;
570df4e9 Yan, Zheng 2017-11-15  471  			 }
570df4e9 Yan, Zheng 2017-11-15  472  		 }
570df4e9 Yan, Zheng 2017-11-15  473
570df4e9 Yan, Zheng 2017-11-15  474  		 if (rinfo->dir_end)
570df4e9 Yan, Zheng 2017-11-15  475  			 break;
570df4e9 Yan, Zheng 2017-11-15  476
570df4e9 Yan, Zheng 2017-11-15  477  		 BUG_ON(rinfo->dir_nr <= 0);
570df4e9 Yan, Zheng 2017-11-15  478  		 rde = rinfo->dir_entries + (rinfo->dir_nr - 1);
570df4e9 Yan, Zheng 2017-11-15  479  		 next_offset += rinfo->dir_nr;
570df4e9 Yan, Zheng 2017-11-15  480  		 last_name = kstrndup(rde->name, rde->name_len, GFP_KERNEL);
570df4e9 Yan, Zheng 2017-11-15  481  		 if (!last_name) {
570df4e9 Yan, Zheng 2017-11-15  482  			 err = -ENOMEM;
570df4e9 Yan, Zheng 2017-11-15  483  			 goto out;
570df4e9 Yan, Zheng 2017-11-15  484  		 }
570df4e9 Yan, Zheng 2017-11-15  485
570df4e9 Yan, Zheng 2017-11-15  486  		 ceph_mdsc_put_request(req);
570df4e9 Yan, Zheng 2017-11-15  487  		 req = NULL;
570df4e9 Yan, Zheng 2017-11-15  488  	}
570df4e9 Yan, Zheng 2017-11-15  489  	err = -ENOENT;
570df4e9 Yan, Zheng 2017-11-15  490  out:
570df4e9 Yan, Zheng 2017-11-15  491  	if (req)
570df4e9 Yan, Zheng 2017-11-15  492  		ceph_mdsc_put_request(req);
570df4e9 Yan, Zheng 2017-11-15  493  	kfree(last_name);
570df4e9 Yan, Zheng 2017-11-15  494  	dout("get_snap_name %p ino %llx.%llx err=%d\n",
570df4e9 Yan, Zheng 2017-11-15  495  	     child, ceph_vinop(inode), err);
570df4e9 Yan, Zheng 2017-11-15  496  	return err;
570df4e9 Yan, Zheng 2017-11-15  497  }
570df4e9 Yan, Zheng 2017-11-15  498

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
