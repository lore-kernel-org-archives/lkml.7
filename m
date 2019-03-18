Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329FAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A4B2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u4mgO0BM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfCRBqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:46:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51706 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfCRBqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 21:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=02cVkekljglMdv9XutCx6KGjpwnrK1lV4p5gvuApm1s=; b=u4mgO0BMYzCruRkMt0W48unwMC
        /L/qoukS8Ygujs5qMIWiyUKDL5iRpPnaJo41eEzL9JuC2FdJFtGxItdzSogh2II8kMD/n3chEbfJN
        JHAd8migCduhhRWV5bVlswWAT83h2d743hvng+Tsbk2ECGVfA2F8/LjsCCSXB/lSQbgUQIgXc7GpY
        9AibQmfE6vqIYXwmbiyIrsUTN5ZGWvq1nxJmRaB/h/KOd9cjaiY9jBD04TwVtG36xt6rzONBlh3kh
        xa4Y7bq5sYt1JPms+rOSKhypB/w/1EoHKT7/oXxEHeQQiogtgPPOJnMOVZxac78UunpYJY1b8B6j7
        zK6iKZEA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5hMQ-0006D3-MF; Mon, 18 Mar 2019 01:46:43 +0000
Subject: Re: [PATCH 00/13] Convert vfs.txt to vfs.rst
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190313040919.6937-1-tobin@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <821449c9-e1f7-caa1-ff18-0cc1cc625596@infradead.org>
Date:   Sun, 17 Mar 2019 18:46:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313040919.6937-1-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/19 9:09 PM, Tobin C. Harding wrote:
> Hi,
> 
> This set converts the VFS overview documentation to RST format.  I think
> I'm slowly getting better at structuring these conversions to ease
> review, if you disagree or you notice any way to further improve please
> say so.

Hi Tobin,

What does this patch set apply to?  Maybe Jon's git tree?

I applied it to 5.1-rc1 with some forceful (minor) editing and ran
'make htmldocs' successfully, so

Tested-by: Randy Dunlap <rdunlap@infradead.org>

although there is at least one new field in struct file_operations: iopoll.

cheers.

> Patch set introduces no new warnings/errors to the html docs build
> 
>       $ make htmldocs 2> ../docs-pre-vfs.stderr	
> 
> Apply patch set
> 
>       $ make cleandocs
>       $ make htmldocs 2> ../docs-post-vfs.stderr
>       $ diff ../docs-pre-vfs.stderr ../docs-post-vfs.stderr
> 
> 
> Patch 1-4 - Whitespace fixes.
> Patch 5 - Adds the document title adornments (above and below)
> Patch 6 - Adds a SPDX license identifier
> Patch 7 - Fixes some custom indentation at the top of the file that will
>     	  cause Sphinx to warn when we switch to .rst
> Patch 8 - Converts custom list format to use RST formatted lists, this
>           is in preparation for switching to .rst 
> Patch 9 - Adds '.. code-block:: c' and fixes indentation of code
> 	  blocks.  We rename the file to .rst in this patch (introducing
> 	  some new warnings).
> Patch 10 - Adds back ticks to all the list items.  This is in
> 	   preparation for fixing the indentation in the next patch.
> 	   This was found to help when reading both plain text and HTML.
> Patch 11 - Cleans up the lists, indentation and missing periods.  This
> 	   was kept separate to assist review.  This patch is benign,
> 	   the less meticulous reviewer could safely skip over this one
> 	   quickly (this was the intention of separating these changes).
> Patch 12 - Fixes a few minor grammar mistakes I notice while reading the
> 	   file, I'm taking bonus points for actually reading every word
> 	   of the file and not just trying to haphazardly do the
> 	   conversion like I have previously done :)
> Patch 13 - Fixes two remaining Sphinx warnings.
> 
> If/when this goes in perhaps I, or someone else, will update the content
> to document a newer kernel version.
> 
> 
> thanks,
> Tobin.
> 
> 
> Tobin C. Harding (13):
>   docs: filesystems: vfs: Remove space before tab
>   docs: filesystems: vfs: Use uniform space after period.
>   docs: filesystems: vfs: Use 72 character column width
>   docs: filesystems: vfs: Use uniform spacing around headings
>   docs: filesystems: vfs: Use correct initial heading
>   docs: filesystems: vfs: Use SPDX identifier
>   docs: filesystems: vfs: Fix pre-amble indentation
>   docs: filesystems: vfs: Use list character for lists
>   docs: filesystems: vfs: Add code-block and txt->RST
>   docs: filesystems: vfs: Use ticks for listed items
>   docs: filesystems: vfs: Clean up lists
>   docs: filesystems: vfs: Do minor grammar fixes
>   docs: filesystems: vfs: Use backticks to guard star
> 
>  Documentation/filesystems/index.rst |    1 +
>  Documentation/filesystems/vfs.rst   | 1279 +++++++++++++++++++++++++++
>  Documentation/filesystems/vfs.txt   | 1261 --------------------------
>  3 files changed, 1280 insertions(+), 1261 deletions(-)
>  create mode 100644 Documentation/filesystems/vfs.rst
>  delete mode 100644 Documentation/filesystems/vfs.txt
> 


-- 
~Randy
