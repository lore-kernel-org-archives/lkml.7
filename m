Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37496C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C408208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561120761;
	bh=6oTArFPKLoxWO6vGPNqq+VrhkTgfRm+IpHPTI9hIThs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OiIRlwvSRLkpSWCqfUtVYaKFpcF6aSIFuzbCL5JgRP1Fg9odlZNEhtJcNcslG7p/p
	 GZcyFj+7tE5Fvb7YwCM5NatBHhzu9w186zL4D2MoR5QVN3W+An1SAd/7sMXcGQe3UC
	 zlLHdtiIwiRxuLZmvI1a35iJU3iW6e6RybanLYCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFUMjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:39:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFUMjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IPY/WjpwDduN3Te1YABfv2FDARx5WUlMHv5/S8L1c5s=; b=Aew36X9orfe9DG8f1aYCJSYs4
        5z3wAmYvJqQyL7pohcvPwIQQs+5vhmEgJaD8RJnjfTPjBoDGGF35xPEpSOENVDf9+0Ls3sOP6LkGr
        hP2Dwt40epsYPA3J/WXbBj+QFwz1BwBObeNJD568RxUSQYtG64TijkM8i/wGg3SBo/8cduLhZkIX4
        fV3DCG4BzrtDkTxZugi7ZLPKOU76OW2K9Iq1ypKDphDSXgHNXnCpvreq9HTEiFzNKesvdYtT68eJD
        VMHBSu7kwaj5OFrBfqe1i9RxdpsQA+Xr1c1irEQADsZLIkEssG5fa4GM0Mz/+YSXPFlw/aUdYZN/3
        gYOUfZvSQ==;
Received: from [177.97.20.138] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heIp4-00068L-Ug; Fri, 21 Jun 2019 12:39:19 +0000
Date:   Fri, 21 Jun 2019 09:39:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RFC 0/6] Produce ABI guide without escaping ReST source
 files
Message-ID: <20190621093915.4a466f79@coco.lan>
In-Reply-To: <cover.1561118631.git.mchehab+samsung@kernel.org>
References: <cover.1561118631.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 21 Jun 2019 09:32:00 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> Hi Greg,
> 
> As you proposed to give it a try on removing the escape code from the
> script which parses the ReST file, I changed a few things there,
> adding the capability of selectively enabling to output an ABI sub-dir
> without escaping things that would crash Sphinx.
> 
> PS.: As for now this is just a RFC, I'm not getting the ABI file
> maintainers, copying just LKML, linux-doc ML, plus you and Jon.
> 
> I also manually fixed the contents of ABI/stable, in order for it to
> pass without causing troubles.
> 
> I added all patches from ABI and features at this branch:
> 
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v4.1
> 
> The html output is at https://www.infradead.org/~mchehab/rst_features/,
> and you can see the resulting ABI guide on:
> 
> 	https://www.infradead.org/~mchehab/rst_features/admin-guide/abi.html
> 
> No Sphinx crashes/warnings happen when building it.
> 
> That's my personal notes about such work:
> 
> 1) Documentation/ABI/stable/sysfs-class-infiniband
> 
> It had some title captions inside it, like:
> 
> 	Errors info:
>                 -----------
> 
> For one of the "What:"
> 
> Sphinx is really pick with title markups. As the entire Documentation/stable is
> parsed as if it were a single document, there should be a coherency on what
> character is used to markup a level-one title. I mean, if one document uses:
> 
> foo
> ----
> 
> For the first level, all other documents should use "---...-" as well.
> 
> The alternative would be to have one entry for every single file at
> Documentation/admin-guide/abi-*.rst, with, IMHO, it would be a lot
> harder to maintain.
> 
> So, the best seems to let clear at ABI/README about how titles/subtitles
> should be used inside files, if any.
> 
> 2) Some documents there use a "Values:" tag, with is not defined as a
> valid one at ABI/README. The script handles it as part of the description,
> so no harm done;
> 
> 3) Among the 47 files under ABI/stable, 14 of them names the file
> contents, using a valid ReST markup for the document title. That is shown
> at the index at:
> 
> 	https://www.infradead.org/~mchehab/rst_features/admin-guide/abi.html
> 
> 
> - ABI stable symbols
> 
>   -  sysfs interface for Mellanox ConnectX HCA IB driver (mlx4)
>   -  sysfs interface for Intel IB driver qib
>   -  sysfs interface for Intel(R) X722 iWARP i40iw driver
>   -  sysfs interface for QLogic qedr NIC Driver
>   -  sysfs interface for NetEffect RNIC Low-Level iWARP driver (nes)
>   -  sysfs interface for Cisco VIC (usNIC) Verbs Driver
>   -  sysfs interface for Chelsio T3 RDMA Driver (cxgb3)
>   -  sysfs interface for Chelsio T4/T5 RDMA driver (cxgb4)
>   -  sysfs interface for Intel Omni-Path driver (HFI1)
>   -  sysfs interface for VMware Paravirtual RDMA driver
>   -  sysfs interface for Mellanox Connect-IB HCA driver mlx5
>   -  sysfs interface for Emulex RoCE HCA Driver
>   -  sysfs interface for Broadcom NetXtreme-E RoCE driver
>   -  sysfs interface for Mellanox IB HCA low-level driver (mthca)
> 
> I liked that, but ideally all ABI files should either use it or not.
> 
> 4) I was expecting to have troubles with asterisk characters inside the
> ABI files. That was not the case: I had to escape just one occurrence on
> a single file of the 47 ones inside ABI/stable. 
> 
> -
> 
> My conclusion from this experiment is that it is worth cleaning the ABI
> files for them to be parsed without needing to escape non-ReST compliant
> parts of the ABI file.
> 
> Perhaps we could keep rst-compliant the stable, obsolete and removed
> directories only, and gradually moving stuff from ABI/testing to ABI/stable,
> while fixing them to be rst-compliant.

Btw, adding :rst: to kernel-abi markup at abi-obsolete.rst and 
abi-removed.rst produced just two warnings:

get_abi.pl rest --dir $srctree/Documentation/ABI/obsolete --rst-source:1689: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/obsolete --rst-source:1692: WARNING: Block quote ends without a blank line; unexpected unindent.

I'll fix those too at my repository.

I suspect, however, that Documentation/ABI/testing with its 353 files will
require a lot more care.

Thanks,
Mauro

diff --git a/Documentation/admin-guide/abi-obsolete.rst b/Documentation/admin-guide/abi-obsolete.rst
index cda9168445a5..d095867899c5 100644
--- a/Documentation/admin-guide/abi-obsolete.rst
+++ b/Documentation/admin-guide/abi-obsolete.rst
@@ -8,3 +8,4 @@ The description of the interface will document the reason why it is
 obsolete and when it can be expected to be removed.
 
 .. kernel-abi:: $srctree/Documentation/ABI/obsolete
+   :rst:
diff --git a/Documentation/admin-guide/abi-removed.rst b/Documentation/admin-guide/abi-removed.rst
index 497978fc9632..f7e9e43023c1 100644
--- a/Documentation/admin-guide/abi-removed.rst
+++ b/Documentation/admin-guide/abi-removed.rst
@@ -2,3 +2,4 @@ ABI removed symbols
 ===================
 
 .. kernel-abi:: $srctree/Documentation/ABI/removed
+   :rst:


