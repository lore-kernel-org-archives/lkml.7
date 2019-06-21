Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E74DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41355206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R6ywiftK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfFUNEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:04:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFUNEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H9Xq11zOUnN/ZiKnDgQeb05c7MxZK+MA6J2mS6+kmGM=; b=R6ywiftK9RefCn15H186LB5wl
        CiU+9Vz2QG+csl8QB+oWYKQVXwACVFL3YgFkZs36eQ7YTDtMA6U/YSNQGjL8iU6qYmpbDAf5M1IAQ
        0krZE7qB4REtyTjpHR8q3sLF9siwbT+JQucJfzqpClhjdnZXnmbEh3IR+GNmfNJfZ4j4vzSjqGFPq
        iDzaJaMGuCKcA6DsrsVgWbWOI2+e6Rir+k85oPQjVxMXH9lSsY0dI4qpe2FYxMawoQAaC+/PMEAks
        saXQSHFpCm40KMSdx+Nhn9L/FWrg5BM9M78vpsFvciZLFUhchnaP/AW6HxZ8rPtNYIbEhfbr0H3yl
        nrVoxzHVQ==;
Received: from [177.97.20.138] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heJDh-0007FD-J6; Fri, 21 Jun 2019 13:04:46 +0000
Date:   Fri, 21 Jun 2019 10:04:41 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RFC 0/6] Produce ABI guide without escaping ReST source
 files
Message-ID: <20190621100441.183e7cd2@coco.lan>
In-Reply-To: <20190621093915.4a466f79@coco.lan>
References: <cover.1561118631.git.mchehab+samsung@kernel.org>
        <20190621093915.4a466f79@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 21 Jun 2019 09:39:15 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> Em Fri, 21 Jun 2019 09:32:00 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> 
> > Hi Greg,
> > 
> > As you proposed to give it a try on removing the escape code from the
> > script which parses the ReST file, I changed a few things there,
> > adding the capability of selectively enabling to output an ABI sub-dir
> > without escaping things that would crash Sphinx.
> > 
> > PS.: As for now this is just a RFC, I'm not getting the ABI file
> > maintainers, copying just LKML, linux-doc ML, plus you and Jon.
> > 
> > I also manually fixed the contents of ABI/stable, in order for it to
> > pass without causing troubles.
> > 
> > I added all patches from ABI and features at this branch:
> > 
> > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v4.1
> > 
> > The html output is at https://www.infradead.org/~mchehab/rst_features/,
> > and you can see the resulting ABI guide on:
> > 
> > 	https://www.infradead.org/~mchehab/rst_features/admin-guide/abi.html
> > 
> > No Sphinx crashes/warnings happen when building it.
> > 
> > That's my personal notes about such work:
> > 
> > 1) Documentation/ABI/stable/sysfs-class-infiniband
> > 
> > It had some title captions inside it, like:
> > 
> > 	Errors info:
> >                 -----------
> > 
> > For one of the "What:"
> > 
> > Sphinx is really pick with title markups. As the entire Documentation/stable is
> > parsed as if it were a single document, there should be a coherency on what
> > character is used to markup a level-one title. I mean, if one document uses:
> > 
> > foo
> > ----
> > 
> > For the first level, all other documents should use "---...-" as well.
> > 
> > The alternative would be to have one entry for every single file at
> > Documentation/admin-guide/abi-*.rst, with, IMHO, it would be a lot
> > harder to maintain.
> > 
> > So, the best seems to let clear at ABI/README about how titles/subtitles
> > should be used inside files, if any.
> > 
> > 2) Some documents there use a "Values:" tag, with is not defined as a
> > valid one at ABI/README. The script handles it as part of the description,
> > so no harm done;
> > 
> > 3) Among the 47 files under ABI/stable, 14 of them names the file
> > contents, using a valid ReST markup for the document title. That is shown
> > at the index at:
> > 
> > 	https://www.infradead.org/~mchehab/rst_features/admin-guide/abi.html
> > 
> > 
> > - ABI stable symbols
> > 
> >   -  sysfs interface for Mellanox ConnectX HCA IB driver (mlx4)
> >   -  sysfs interface for Intel IB driver qib
> >   -  sysfs interface for Intel(R) X722 iWARP i40iw driver
> >   -  sysfs interface for QLogic qedr NIC Driver
> >   -  sysfs interface for NetEffect RNIC Low-Level iWARP driver (nes)
> >   -  sysfs interface for Cisco VIC (usNIC) Verbs Driver
> >   -  sysfs interface for Chelsio T3 RDMA Driver (cxgb3)
> >   -  sysfs interface for Chelsio T4/T5 RDMA driver (cxgb4)
> >   -  sysfs interface for Intel Omni-Path driver (HFI1)
> >   -  sysfs interface for VMware Paravirtual RDMA driver
> >   -  sysfs interface for Mellanox Connect-IB HCA driver mlx5
> >   -  sysfs interface for Emulex RoCE HCA Driver
> >   -  sysfs interface for Broadcom NetXtreme-E RoCE driver
> >   -  sysfs interface for Mellanox IB HCA low-level driver (mthca)
> > 
> > I liked that, but ideally all ABI files should either use it or not.
> > 
> > 4) I was expecting to have troubles with asterisk characters inside the
> > ABI files. That was not the case: I had to escape just one occurrence on
> > a single file of the 47 ones inside ABI/stable. 
> > 
> > -
> > 
> > My conclusion from this experiment is that it is worth cleaning the ABI
> > files for them to be parsed without needing to escape non-ReST compliant
> > parts of the ABI file.
> > 
> > Perhaps we could keep rst-compliant the stable, obsolete and removed
> > directories only, and gradually moving stuff from ABI/testing to ABI/stable,
> > while fixing them to be rst-compliant.  
> 
> Btw, adding :rst: to kernel-abi markup at abi-obsolete.rst and 
> abi-removed.rst produced just two warnings:
> 
> get_abi.pl rest --dir $srctree/Documentation/ABI/obsolete --rst-source:1689: ERROR: Unexpected indentation.
> get_abi.pl rest --dir $srctree/Documentation/ABI/obsolete --rst-source:1692: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> I'll fix those too at my repository.
> 
> I suspect, however, that Documentation/ABI/testing with its 353 files will
> require a lot more care.

Disabling the escaping logic for ABI/testing won't cause crashes with Sphinx
1.4.9 (it will probably cause more harm on newer versions), but will require 
a lot care, as it introduces 248 new errors/warnings:

get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:145: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:147: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:148: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:150: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:157: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:158: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:725: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:726: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:888: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:926: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1001: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1106: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1107: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1109: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1110: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1156: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1157: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1162: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1163: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1197: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1198: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1200: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1219: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1307: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1308: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1344: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1345: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1386: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1389: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1399: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1431: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1434: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1476: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1478: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1480: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1513: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1516: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1534: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1535: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1661: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1662: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1690: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1692: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:1906: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:3634: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:3784: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:3785: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:4645: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:4654: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:5358: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:5359: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:5361: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:5362: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:8272: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:8763: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:8951: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:8952: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:8964: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:8975: WARNING: Inline emphasis start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:8981: WARNING: Inline emphasis start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:9247: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:9372: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:9375: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:9399: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:9404: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:9413: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:9415: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10137: WARNING: Inline emphasis start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10284: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10285: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10691: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10692: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10693: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10702: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10695: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10704: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10824: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10852: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10905: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10918: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10920: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12201: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12203: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12242: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12243: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12292: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12293: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12299: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12300: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12304: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12306: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:12307: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13006: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13007: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13018: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13022: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13023: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13037: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13034: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13038: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13041: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13043: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13050: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13051: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13052: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13053: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13054: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:13322: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:15110: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:17126: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:17128: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:18028: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:18029: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:18145: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:18146: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:18612: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:18613: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:18826: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:21603: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:21605: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:21607: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:22443: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:23675: WARNING: Inline emphasis start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:24253: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:24254: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:24288: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:24289: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:24290: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:25697: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:25982: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26095: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26189: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26265: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26303: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26341: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26359: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26535: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26709: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26730: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26855: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26874: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:26876: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:27863: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:27864: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:27953: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:27954: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:29105: WARNING: Inline emphasis start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:30263: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:31937: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:31941: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:31977: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:31981: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32005: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32007: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32031: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32054: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32058: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32108: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32110: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32136: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32158: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32160: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32204: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32206: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32231: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32254: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32276: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32280: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32306: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32330: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32393: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32394: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32400: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32498: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32518: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32668: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32660: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32660: WARNING: Inline interpreted text or phrase reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32660: WARNING: Inline interpreted text or phrase reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32698: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32699: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32771: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32774: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32902: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:32903: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:33035: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:33038: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:33043: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:33043: WARNING: Inline interpreted text or phrase reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:33044: WARNING: Line block ends without a blank line.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:33044: WARNING: Inline interpreted text or phrase reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:33045: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:33478: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34128: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34132: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34208: WARNING: Inline interpreted text or phrase reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34386: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34811: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34815: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34819: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34822: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34825: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34828: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34831: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34834: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:34988: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:35182: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:35538: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:35820: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:35821: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:36003: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:36005: WARNING: Bullet list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:36005: WARNING: Inline emphasis start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:36006: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:36006: WARNING: Inline emphasis start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:36546: WARNING: Inline emphasis start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:36741: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:36745: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:36746: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:37206: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38654: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38657: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38658: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38712: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38712: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38712: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38712: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38712: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38712: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38712: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38712: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38712: WARNING: Inline substitution_reference start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:38787: WARNING: Inline emphasis start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:39407: WARNING: Title underline too short.

Example:
-------
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:39407: WARNING: Title underline too short.

Example:
-------
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:39902: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:41503: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:41505: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:41574: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:41579: WARNING: Block quote ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:41581: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:41586: WARNING: Definition list ends without a blank line; unexpected unindent.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:41588: ERROR: Unexpected indentation.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:45165: WARNING: Inline emphasis start-string without end-string.
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:10695: ERROR: Undefined substitution referenced: "- / | | | |_/ | | | | | | | | irq".
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:3733: ERROR: Unknown target name: "synth_arg".
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:27492: ERROR: Unknown target name: "ptp_pf".
get_abi.pl rest --dir $srctree/Documentation/ABI/testing --rst-source:36117: ERROR: Unknown target name: "entry".




Thanks,
Mauro
